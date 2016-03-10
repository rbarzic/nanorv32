#!/usr/bin/env python
import sys
import pprint as pp
import inst_decod as id
import nanorv32_simu as ns
import argparse
import ctypes as ct

class UnalignedAddressError(Exception):
    pass



def bitfield(data,offset,size):
    mask = (1<<(size))-1
    tmp = data >> offset
    return tmp & mask


def get_mask(decode_string):
    "Return a mask for the decode string (0/1 -> 1, ? -> 0)"
    return decode_string.replace('0', '1').replace('?', '0')

def get_match(decode_string):
    "Return a match string for the decode string (? -> 0)"
    return decode_string.replace('?', '0')


def zero_extend32(val,bits,xx=32):
    "Zero extend a 'bits' long number to xx  bit"

    return (val2 ^ m)-m

def sign_extend32(val,bits,xx=32):
    "Sign extend a 'bits' long number to xx  bit"
    sign_val = 0xFFFFFFFF<<(bits)
    # print "sign_val = " + hex(sign_val)
    if val & (1<<(bits- 1)):
        # msb set is set in original value
        return val | sign_val
    else:
        return val



class NanoRV32Core(object):
    """
    """

    def __init__(self):
        # Data memory
        self.datamem_size = 65536
        self.datamem_start = 0x00000000
        # Code memory
        self.codemem_size = 65536
        self.codemem_start = 0x00000000
        self.rf = [0]*32
        self.pc = 0
        # Build dictionnaries for the decoder
        self.mask_dict = {inst :  int("0b" + get_mask (id.decode[inst]),2) for inst in id.decode.keys ()}
        self.match_dict = {inst : int( "0b" + get_match(id.decode[inst]),2) for inst in id.decode.keys()}
        self.data_memory = [0]*(self.datamem_size) # byte-addressed memory
        self.code_memory = [0]*(self.codemem_size) # byte-addressed memory


    def fix_address(self,addr):
        "Wrap address to avoid accessing unexistant memory"
        return addr & 0x0000FFFF # 64K

    def decode_address(self, addr):
        "Select a memory, depending of the address"
        if addr>=0x20000000:
            return self.data_memory
        else:
            return self.code_memory


    def mem_write_byte(self,addr,data):
        mem = self.decode_address(addr)
        addr_f = self.fix_address(addr)
        mem[addr_f] = data & 0x0FF


    def mem_write_halfword(self,addr,data):
        if(addr & 0x01):
            raise UnalignedAddressError("-E- Write Half word : " + hex(addr) )
        mem = self.decode_address(addr)
        addr_f = self.fix_address(addr)
        mem[addr_f] = data & 0x0FF
        mem[addr_f+1] = (data>>8) & 0x0FF

    def mem_write_word(self,addr,data):
        if(addr & 0x03):
            raise UnalignedAddressError("-E- Write word : " + hex(addr) + " bin : " + bin(addr))
        mem = self.decode_address(addr)
        addr_f = self.fix_address(addr)
        mem[addr_f] = data & 0x0FF
        mem[addr_f+1] = (data>>8) & 0x0FF
        mem[addr_f+2] = (data>>16) & 0x0FF
        mem[addr_f+3] = (data>>24) & 0x0FF


    def mem_read_byte(self,addr):
        mem = self.decode_address(addr)
        addr_f = self.fix_address(addr)

        return sign_extend32(mem[addr_f] & 0x0FF, bits=8)


    def mem_read_byte_u(self,addr):
        mem = self.decode_address(addr)
        addr_f = self.fix_address(addr)
        return mem[addr_f] & 0x0FF


    def mem_read_halfword(self,addr):
        if(addr & 0x01):
            raise UnalignedAddressError("-E- Write Half word : " + hex(addr) )
        mem = self.decode_address(addr)
        addr_f = self.fix_address(addr)
        tmp0 = mem[addr_f] & 0x0FF
        tmp1 = mem[addr_f+1] & 0x0FF
        return sign_extend32(tmp0 + (tmp1<<8), bits=16)

    def mem_read_halfword_u(self,addr):
        if(addr & 0x01):
            raise UnalignedAddressError("-E- Write Half word : " + hex(addr) )
        mem = self.decode_address(addr)
        addr_f = self.fix_address(addr)
        tmp0 = mem[addr_f] & 0x0FF
        tmp1 = mem[addr_f+1] & 0x0FF
        return tmp0 + (tmp1<<8)


    def mem_read_word(self,addr):
        if(addr & 0x03):
            raise UnalignedAddressError("-E- Write Half word : " + hex(addr) + " bin : " + bin(addr))
        mem = self.decode_address(addr)
        addr_f = self.fix_address(addr)
        tmp0 = mem[addr_f] & 0x0FF
        tmp1 = mem[addr_f+1] & 0x0FF
        tmp2 = mem[addr_f+2] & 0x0FF
        tmp3 = mem[addr_f+3] & 0x0FF
        tmp = tmp0
        tmp += (tmp1<< 8)
        tmp += (tmp2<<16)
        tmp += (tmp3<< 24)
        return tmp



    def new_instruction(self,inst):
        #@begin[sim_instruction_fields]
        self.dec_opcode1 = bitfield(inst,offset=0,size=7)
        self.dec_func3 = bitfield(inst,offset=12,size=3)
        self.dec_func7 = bitfield(inst,offset=25,size=7)
        self.dec_rd = bitfield(inst,offset=7,size=5)
        self.dec_rs1 = bitfield(inst,offset=15,size=5)
        self.dec_rs2 = bitfield(inst,offset=20,size=5)
        self.dec_imm12 = bitfield(inst,offset=20,size=12)
        self.dec_imm12hi = bitfield(inst,offset=25,size=7)
        self.dec_imm12lo = bitfield(inst,offset=7,size=5)
        self.dec_immsb2 = bitfield(inst,offset=25,size=7)
        self.dec_immsb1 = bitfield(inst,offset=7,size=5)
        self.dec_imm20 = bitfield(inst,offset=12,size=20)

        self.dec_shamt = bitfield(inst,offset=20,size=5)
        self.dec_func4 = bitfield(inst,offset=28,size=4)
        self.dec_func12 = bitfield(inst,offset=20,size=12)

        self.dec_imm12_se = sign_extend32(self.dec_imm12,12)
        # SB type instruction immediate reconstruction
        tmp = bitfield(inst,offset=8,size=4)*2 # [4:1]
        tmp += bitfield(inst,offset=25,size=6)*(2**5) # [10:5]
        tmp += bitfield(inst,offset=7,size=1)*(2**11) # [11]
        tmp += bitfield(inst,offset=31,size=1)*(2**12) # [12]
        self.dec_sb_offset = tmp #
        self.dec_sb_offset_se =  sign_extend32(tmp,13)#
        # UJ type
        tmp = bitfield(inst,offset=21,size=10)*2 # imm[10:1]
        tmp += bitfield(inst,offset=20,size=1)*(2**11) # [11]
        tmp += bitfield(inst,offset=12,size=8)*(2**12) # [19:12]
        tmp += bitfield(inst,offset=31,size=1)*(2**20) # [19:12]
        self.dec_imm20uj =  tmp
        self.dec_imm20uj_se =  sign_extend32(tmp,20)
        # S-Type (Store) offset
        tmp = self.dec_imm12lo # [4:0]
        tmp += self.dec_imm12hi*(2**5) # [5:11]
        self.dec_store_imm12 = tmp
        self.dec_store_imm12_se = sign_extend32(tmp,12)
        #@end[sim_instruction_fields]
    def update_rf(self,idx,val):
        "Write val at index idx in the register file"
        if idx != 0:
            self.rf[idx] = (val & 0x0FFFFFFFF) # 32-bit truncation
        else:
            self.rf[0] = 0 # enforce....

        return

    def match_instruction(self,inst):
        "return the instruction that match the integer value 'inst'"
        # Stupid loop....
        for i in id.decode.keys():
            mask = self.mask_dict[i]
            match = self.match_dict[i]
            if (inst & mask) == match:
                return i

        return 'illegal_instruction'

    def execute_instruction(self,inst_str):
        "Execute the current instruction"
        if inst_str in ns.spec['nanorv32']['rv32i']['simu']['inst']:
            f = dict(ns.spec ['nanorv32']['rv32i']['simu']['inst'][inst_str])

            return f['func'](self)


    def dump_regfile(self, num_col=4):
        nb_reg = len(self.rf)
        i = 0
        while(i<nb_reg):
            for c in range(0,num_col):
                sys.stdout.write("x{:02d}=0x{:08X} ".format(i,self.rf[i]))
                i += 1
            print

    def load_code_memory(self,hex2_file):
        with open(hex2_file) as f:
            addr = 0;
            for line in f:
                word = int(line,16)
                self.code_memory[addr] = word & 0x0FF
                self.code_memory[addr+1] = (word>>8) & 0x0FF
                self.code_memory[addr+2] = (word>>16) & 0x0FF
                self.code_memory[addr+3] = (word>>24) & 0x0FF
                addr += 4

    def get_instruction(self, addr):
        addr_f = self.fix_address(addr)
        tmp0 = self.code_memory[addr_f] & 0x0FF
        tmp1 = self.code_memory[addr_f+1] & 0x0FF
        tmp2 = self.code_memory[addr_f+2] & 0x0FF
        tmp3 = self.code_memory[addr_f+3] & 0x0FF
        tmp = tmp0
        tmp += (tmp1<< 8)
        tmp += (tmp2<<16)
        tmp += (tmp3<< 24)
        return tmp


def get_args():
    """
    Get command line arguments
    """

    parser = argparse.ArgumentParser(description="""
Put description of application here
                   """)
    parser.add_argument('--hex2', action='store', dest='hex2',
                        help='hex2 file to be load in the memory', default="")

    parser.add_argument('--trace', action='store_true', dest='trace',
                        help='hex2 file to be load in the memory', default=False)





    parser.add_argument('--version', action='version', version='%(prog)s 0.1')

    return parser.parse_args()


if __name__ == '__main__':

    args= get_args()

    nrv = NanoRV32Core()

    if args.hex2 != "":
        print("-I- Loading " + args.hex2)
        nrv.load_code_memory(args.hex2)
    else:
        sys.exit("No hex2 file specified (use --hex2=<file name>)")

    nrv.pc = 0;
    while True:
        inst = nrv.get_instruction(nrv.pc)
        if args.trace:
            sys.stdout.write("PC : 0x{:08X} I : 0x{:08X} ".format(nrv.pc,inst))
        if nrv.pc == 0x00000100:
            if nrv.rf[10] == 0xCAFFE000: #x10/a0
                print
                print "\n-I- TEST OK\n"
                sys.exit()
            elif nrv.rf[10] == 0xDEADD000: #x10/a0
                print
                nrv.dump_regfile()
                print "\n-I- TEST FAILED\n"
                sys.exit()
            else:
                print
                nrv.dump_regfile()
                print "\n-I- TEST FAILED (unknown reason)\n"
                sys.exit()


        nrv.new_instruction(inst)

        inst_str =  nrv.match_instruction(inst)
        if args.trace:
            sys.stdout.write(inst_str.ljust(8))
        if inst_str != 'illegal_instruction':
            _, new_pc,txt  = nrv.execute_instruction(inst_str)
            if args.trace:
                sys.stdout.write(" - " + txt)
                print
            nrv.pc = new_pc

        else:
            sys.exit("-E- Illegall instruction found !")

    #print nrv.match_instruction(addi)
    #print nrv.match_instruction(auipc)
    #
    #
    #nrv.new_instruction(addi) # update internal field used for decoding
    #inst_str =  nrv.match_instruction(addi)
    #_, new_pc = nrv.execute_instruction(inst_str)
    #print "New PC = " + str(new_pc)
    #nrv.dump_regfile()
    #
    #a = 255
    #print "a = " + hex(a)
    #b = sign_extend32(a,8)
    #print "b = " + hex(b)
