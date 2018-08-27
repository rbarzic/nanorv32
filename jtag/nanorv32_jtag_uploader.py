#!/usr/bin/env python3
# coding: utf-8

from pyftdi.ftdi import Ftdi
from pyftdi.jtag import JtagEngine, JtagTool
from pyftdi.bits import BitSequence
from intelhex import IntelHex

from collections import OrderedDict
import argparse






# From IEEE 1149.1 Test Access Port (jtag.pdf) in adv_debug_sys
#
JTAG_INSTR = {'EXTEST':  BitSequence('0000', msb=True, length=4),
              'PRELOAD': BitSequence('0001', msb=True, length=4),
              'IDCODE':  BitSequence('0010', msb=True, length=4),
              'DEBUG':   BitSequence('1000', msb=True, length=4),
              'MBIST':   BitSequence('1001', msb=True, length=4),
              'BYPASS':  BitSequence('1111', msb=True, length=4)}







# 0x0 = WishBone module
# 0x1 = CPU0 module
# 0x2 = CPU1 module (optional)
# 0b3 = JSP module (optional)

ADV_DBG_IF_MODULE_WISHBONE = 0
ADV_DBG_IF_MODULE_CPU0     = 1
ADV_DBG_IF_MODULE_CPU1     = 2
ADV_DBG_IF_MODULE_JSP      = 3

# Same as nrv32_chip.h
NRV32_UART0_BASE = (0xF1000000)
NRV32_INTC_BASE  = (0xF2000000)
NRV32_TIMER_BASE =  (0xF3000000)
NRV32_CPUCTRL_BASE  = (0xF4000000)



# From
# 3.2 WishBone Commands, page 20
# 0x0 NOP
# 0x1 Burst Setup Write, 8-bit words
# 0x2 Burst Setup Write, 16-bit words
# 0x3 Burst Setup Write, 32-bit words
# 0x5 Burst Setup Read, 8-bit words
# 0x6 Burst Setup Read, 16-bit words
# 0x7 Burst Setup Read, 32-bit words
# 0x9 Internal register write
# 0xD Internal register select


ADV_DBG_IF_WB_CMD_NOP  = 0
ADV_DBG_IF_WB_CMD_BURST_WRITE_8  = 0x1
ADV_DBG_IF_WB_CMD_BURST_WRITE_16 = 0x2
ADV_DBG_IF_WB_CMD_BURST_WRITE_32 = 0x3
ADV_DBG_IF_WB_CMD_BURST_READ_8   = 0x5
ADV_DBG_IF_WB_CMD_BURST_READ_16  = 0x6
ADV_DBG_IF_WB_CMD_BURST_READ_32  = 0x7
ADV_DBG_IF_WB_CMD_INTREG_WRITE   = 0x9
ADV_DBG_IF_WB_CMD_INTREG_SELECT    = 0xD


def get_args():
    """
    Get command line arguments
    """

    parser = argparse.ArgumentParser(description="""
    Create directory and files for a Nanorv32 test program
                   """)

    parser.add_argument('ihex', action='store',
                        help='Intel HEX file to upload')

    parser.add_argument('-v', '--verbosity', action="count", help='Increase output verbosity')
    parser.add_argument('-r', '--reset', action="store_true",default=False,
                        help='Increase output verbosity')
    parser.add_argument('--version', action='version', version='%(prog)s 0.1')

    return parser.parse_args()


# Using
# https://github.com/eblot/pyftdi/blob/master/pyftdi/tests/jtag.py
# as example

class JtagUpload(object):
    def setUp(self):
        self.jtag = JtagEngine(trst=True, frequency=3E6)
        # New API - example is not compatible with lastest version
        self.jtag.configure("ftdi://ftdi:232h/1")
        self.jtag.reset()
        self.tool = JtagTool(self.jtag)

    def test_idcode_reset(self):
        """Read the IDCODE right after a JTAG reset"""
        self.jtag.reset()
        idcode = self.jtag.read_dr(32)
        self.jtag.go_idle()
        print("IDCODE (reset): 0x%x" % int(idcode))

    def get_idcode(self):
        self.jtag.write_ir(JTAG_INSTR['IDCODE'])
        idcode = self.jtag.read_dr(32)
        self.jtag.go_idle()
        return idcode

    def use_debug_inst(self):
        # Use debug instruction
        self.jtag.write_ir(JTAG_INSTR['DEBUG'])

    # Writing to the Module Select Register
    # The top-level module is the simplest of the modules. It does not have a bus
    # interface, and has only a single register. This register is called the “module select
    # register”, and is used to select the active sub-module. The top module does not use
    # command opcodes the way the sub-modules do. Instead, a single bit in the input shift
    # register (the MSB) indicates whether the command is a write to the select register, or a
    # command to a sub-module (in which case the command is ignored by the top-level). The
    # value in the select register cannot be read back.
    # The top-level module provides enable signals to all sub-modules, based on the
    # value in the module select register. The value of the input shift register is also provided
    # to all modules. Finally, the serial TDO output of the ADI is selected from the sub-
    # module TDO outputs, based on the module select register. A block diagram of the top-
    # level module is shown in Figure 3.
    def select_debug_module(self,module):
        print("-D- Selecting module {}".format(module))
        module = (module & 0x3) | 0x04  # Set MSB (bit 2) to 1
        bs = BitSequence(module, msb=True,length=3)
        self.jtag.write_dr(bs)
        self.jtag.go_idle()



    # |  Bit# | Access | Description                                                                     |
    # |    52 | W      | Top-Level Select - Set to '0' for all sub-module commands                       |
    # | 51:48 | W      | Operation code                                                                  |
    # | 47:16 | W      | Address The first WishBone address which will be read from or written to        |
    # |  15:0 | W      | Count     Total number of words to be transferred. Must be greater than 0.    - |
    def read_access(self,address):
        error = False
        bs = BitSequence(1, msb=False, length=16) # Bits 15:0 -> Count=1
        bs.append(BitSequence(address,msb=False,length=32)) # bits 47:16 -> 32-bit Address
        bs.append(BitSequence(ADV_DBG_IF_WB_CMD_BURST_READ_32,msb=False,length=4)) # Command
        bs.append(BitSequence(0,msb=True,length=1)) # Bit 52

        self.jtag.write_dr(bs)

        # Now shift outputs
        self.jtag.change_state('shift_dr')

        # Read status bit
        seq = self.jtag.read(2)
        status = 0
        while status == 0:
            status = self.jtag.read(1)[0]


        data = int(self.jtag.read (32))
        crc  = int(self.jtag.read (32))
        # first word of a burst : crc_in = 0xFFFFFFFF
        expected_crc = self.compute_crc(data_in=data,length_bits=32,crc_in = 0xFFFFFFFF)
        if crc != expected_crc:
            print("-E- CRC error detected Data : {0:#010x}, CRC : {1:#010x}  Computed CRC : {2:#010x}".format(data,crc,expected_crc))
            error = True
        self.jtag.go_idle()

        return data,error



    def write_access(self,address,data):
        bs = BitSequence(1, msb=False, length=16) # Bits 15:0 -> Count=1
        bs.append(BitSequence(address,msb=False,length=32)) # bits 47:16 -> 32-bit Address
        bs.append(BitSequence(ADV_DBG_IF_WB_CMD_BURST_WRITE_32,msb=False,length=4)) # Command
        bs.append(BitSequence(0,msb=True,length=1)) # Bit 52

        self.jtag.write_dr(bs)

        # High-speed mode - no status bit
        # Start bit
        bs = BitSequence(1, msb=False, length=1)
        bs.append(BitSequence(data,msb=False,length=32)) # Data
        # first word of a burst : crc_in = 0xFFFFFFFF
        crc = self.compute_crc(data_in=data,crc_in=0xFFFFFFFF,length_bits=32)
        bs.append(BitSequence(crc,msb=False,length=32)) # CRC

        self.jtag.change_state('shift_dr')
        self.jtag.write(bs)

        match = self.jtag.read(1)
        self.jtag.go_idle()

        return int(match) == 1




    def _do_crc(self, data_in=0, length=0x20):
        crc_init = 0xFFFFFFFF
        crc_out = 0x0
        crc_poly = 0xedb88320

        crc_out = crc_init
        for i in range(0, length):
            if (data_in & (1 << i)) != 0:
                d = 0xFFFFFFFF
            else:
                d = 0x0
            if (crc_out & 0x01) != 0:
                c = 0xFFFFFFFF
            else:
                c = 0x0
            crc_out = crc_out >> 1
            crc_out = crc_out ^ ((d ^ c) & crc_poly)

        #print("      crc_out:", hex(crc_out))

        return crc_out

    def _set_cpuctrl_reg(self,val):
        self.write_access(NRV32_CPUCTRL_BASE,val)

    def reset_cpu(self):
        self._set_cpuctrl_reg(0x1)

    def release_cpu(self):
        self._set_cpuctrl_reg(0x0)

    #define CRC_POLY 0xEDB88320
    #uint32_t compute_crc(uint32_t crc_in, uint32_t data_in,int length_bits) {
    #  uint32_t crc_out, c, d;
    #  int i;
    #  crc_out = crc_in;
    #  for(i = 0; i < length_bits; i++) {
    #     d = ((data_in >> i) & 0x1) ? 0xffffffff : 0x0;
    #     c = (crc_out & 0x1) ? 0xffffffff : 0x0;
    #     crc_out = crc_out >> 1;
    #     crc_out = crc_out ^ ((d ^ c) & CRC_POLY);
    #  }
    #  return crc_out
    #}

    def compute_crc(self,data_in,length_bits,crc_in):
        crc_poly = 0xEDB88320
        crc_out = crc_in
        for i in range(0,length_bits):
            if ((data_in >> i) & 0x1):
                d = 0xFFFFFFFF
            else:
                d = 0

            if (crc_out & 0x1):
                c = 0xFFFFFFFF
            else:
                c = 0
            crc_out = crc_out >> 1
            crc_out = crc_out ^ ((d ^ c) & crc_poly)
        return crc_out

if __name__ == '__main__':

    args = get_args()
    ih = IntelHex()
    ih.padding = 0x00
    print("-I Reading file {}...".format(args.ihex))
    ih.fromfile(args.ihex,format='hex') # fromfile is the recommended way
    print("-I- Done")
    min_addr = ih.minaddr ()
    max_addr = ih.maxaddr ()
    print("-I- Start address : {}".format (min_addr))
    print("-I- End address : {}".format (max_addr))

    # See http://python-intelhex.readthedocs.io/en/latest/part2-5.html

    mem_array = OrderedDict()

    # Not sure if we need a +1 on the max_addr
    for i  in range(min_addr, max_addr,4):
          data  = ih.tobinarray(start=i, size=4)
          mem_array[i] = (data[3] << 24) +  (data[2] << 16) +  (data[1] << 8) + (data[0] << 0)

    # Just for debugging
    #for k,v in mem_array.items():
    #      print("-D {0:#010x} : {1:#010x}".format(k,v))


    jtag = JtagUpload()
    jtag.setUp()
    idcode = jtag.get_idcode()
    print("-D- IDCODE : 0x%x" % int(idcode))

    # Activate debug module and select wishbone interface
    jtag.use_debug_inst()
    jtag.select_debug_module(ADV_DBG_IF_MODULE_WISHBONE);
    #jtag.select_debug_module2(ADV_DBG_IF_MODULE_WISHBONE);

    for addr,data in mem_array.items():
        jtag.write_access(addr,data)

    for i in range(min_addr,max_addr,4):
        data,crc_error = jtag.read_access(i)
        print("-D @: {0:#010x}  Data read  {1:#010x} - Error : {2}".format(i,data,crc_error))

    if args.reset:
        print("-D Resetting CPU !")
        jtag.reset_cpu()
        jtag.release_cpu()

    # jtag.write_access(0x0,0xCAFEBABE)
    # jtag.write_access(0x4,0xDEADBEEF)
    #
    # #jtag.write32(0x0,0xCAFEBABE)
    # #jtag.write32(0x4,0xDEADBEEF)
    #
    #
    # data,crc_error = jtag.read_access(0x0)
    # print("-D  Data read {0:#010x} - Error : {1}".format(data,crc_error))
    #
    # #data,crc = jtag.read_access(0x0)
    # #print("-D  Data read {0:#010x}".format(data))
    # #
    # data,crc_error = jtag.read_access(0x4)
    # print("-D  Data read {0:#010x} - Error : {1}".format(data,crc_error))
