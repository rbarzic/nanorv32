#!/usr/bin/env python
import sys
import pprint as pp
import inst_decod as id
import argparse
import ctypes as ct
import re
import pickle
import nanorv32_simu as ns
import nanorv32_simu_profiler as prof


#@begin[py_csr_address]
NANORV32_CSR_ADDR_CYCLEH = 0xc80
NANORV32_CSR_ADDR_INSTRETH = 0xc82
NANORV32_CSR_ADDR_TIMEH = 0xc81
NANORV32_CSR_ADDR_TIME = 0xc01
NANORV32_CSR_ADDR_INSTRET = 0xc02
NANORV32_CSR_ADDR_CYCLE = 0xc00
#@end[py_csr_address]

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
    sign_val = 0xFFFFFFFF << bits
    mask = ~(-1 << xx)
    # print "sign_val = " + hex(sign_val)
    if val & (1<<(bits- 1)):
        # msb set is set in original value
        return (val | sign_val) & mask
    else:
        return val & mask



class NanoRV32Core(object):
    """
    """

    def __init__(self):
        # Data memory
        self.datamem_size = 65536*8
        self.datamem_start = 0x00000000
        # Code memory
        self.codemem_size = 65536*8
        self.codemem_start = 0x00000000
        self.rf = [0]*32
        self.pc = 0
        # Build dictionnaries for the decoder
        self.mask_dict = {inst :  int("0b" + get_mask (id.decode[inst]),2) for inst in id.decode.keys ()}
        self.match_dict = {inst : int( "0b" + get_match(id.decode[inst]),2) for inst in id.decode.keys()}
        self.data_memory = [0x0]*(self.datamem_size) # byte-addressed memory
        self.code_memory = [0]*(self.codemem_size) # byte-addressed memory
        self.csr = [0xCAFEBABE]*0x1000
        self.init_csr()

    def fix_address(self,addr):
        "Wrap address to avoid accessing unexistant memory"
        return addr & 0x000FFFFF # 16*64K

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
            print "addr" + hex(addr)
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
            raise UnalignedAddressError("-E- Read Half word : " + hex(addr) )
        mem = self.decode_address(addr)
        addr_f = self.fix_address(addr)
        tmp0 = mem[addr_f] & 0x0FF
        tmp1 = mem[addr_f+1] & 0x0FF
        return sign_extend32(tmp0 + (tmp1<<8), bits=16)

    def mem_read_halfword_u(self,addr):
        if(addr & 0x01):
            raise UnalignedAddressError("-E- Read Half word : " + hex(addr) )
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
        self.dec_imm20uj = bitfield(inst,offset=12,size=20)
        self.dec_shamt = bitfield(inst,offset=20,size=5)
        self.dec_sys2_rs1 = bitfield(inst,offset=15,size=5)
        self.dec_sys1_rd = bitfield(inst,offset=7,size=5)
        self.dec_func12 = bitfield(inst,offset=20,size=12)
        self.dec_opcodervc = bitfield(inst,offset=0,size=2)
        self.dec_hint_rvc_rd_rs1_is_two = bitfield(inst,offset=33,size=1)
        self.dec_hint_rvc_rd_rs1_is_zero = bitfield(inst,offset=32,size=1)
        self.dec_c_func4 = bitfield(inst,offset=12,size=4)
        self.dec_hint_rvc_rs2_is_zero = bitfield(inst,offset=34,size=1)
        self.dec_c_rs2 = bitfield(inst,offset=2,size=5)
        self.dec_c_rd_rs1 = bitfield(inst,offset=7,size=5)
        self.dec_c_func3 = bitfield(inst,offset=13,size=3)
        self.dec_ci_immlo = bitfield(inst,offset=2,size=5)
        self.dec_ci_immhi = bitfield(inst,offset=12,size=1)
        self.dec_css_imm = bitfield(inst,offset=7,size=6)
        self.dec_ciw_imm = bitfield(inst,offset=5,size=8)
        self.dec_c_rd_p = bitfield(inst,offset=2,size=3)
        self.dec_c_rs1_p = bitfield(inst,offset=7,size=3)
        self.dec_cl_immlo = bitfield(inst,offset=5,size=2)
        self.dec_cl_immhi = bitfield(inst,offset=10,size=3)
        self.dec_cs_immlo = bitfield(inst,offset=5,size=2)
        self.dec_c_rs2_p = bitfield(inst,offset=2,size=3)
        self.dec_cs_immhi = bitfield(inst,offset=10,size=3)
        self.dec_cb_offset_lo = bitfield(inst,offset=2,size=5)
        self.dec_cb_offset_hi = bitfield(inst,offset=10,size=3)
        self.dec_cj_imm = bitfield(inst,offset=2,size=11)
        self.dec_cs2_func2 = bitfield(inst,offset=5,size=2)
        self.dec_c_func6 = bitfield(inst,offset=10,size=6)
        self.dec_cb2_immlo = bitfield(inst,offset=12,size=1)
        self.dec_cb2_func2 = bitfield(inst,offset=10,size=2)

        #@end[sim_instruction_fields]
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
        # LUI
        tmp =  self.dec_ci_immlo #[4:0]
        tmp += self.dec_ci_immhi*(2**5) #[5]
        self.dec_ci_cimm5_u = tmp
        self.dec_ci_cimm5 = sign_extend32(tmp,6)
        #ADDI16SP
        tmp  = bitfield(self.dec_ci_immlo,offset=4,size=1) #[4]
        tmp += bitfield(self.dec_ci_immlo,offset=0,size=1)* (2) #[0]
        tmp += bitfield(self.dec_ci_immlo,offset=3,size=1)* (2**2) #[0]
        tmp += bitfield(self.dec_ci_immlo,offset=1,size=2)* (2**3) #[0]
        tmp += bitfield(self.dec_ci_immhi,offset=0,size=1)* (2**5) #[0]
        self.dec_addi16_imm = sign_extend32(tmp,6)

        # CSS (SWSP)
        tmp = bitfield(self.dec_css_imm,offset=2,size=4)*(2**2)
        tmp += bitfield(self.dec_css_imm, offset=0, size=2)*(2**6)
        self.dec_swsp_imm = tmp
        #CI (LWSP)
        tmp = bitfield(self.dec_ci_immlo,offset=2,size=3)*(2**2)
        tmp += bitfield(self.dec_ci_immhi, offset=0, size=1)*(2**5)
        tmp += bitfield(self.dec_ci_immlo, offset=0, size=2)*(2**6)
        self.dec_lwsp_imm = tmp
        # JAL or J
        tmp = bitfield(self.dec_cj_imm,offset=1,size=3)*2
        tmp += bitfield(self.dec_cj_imm,offset=9,size=1)*(2**4)
        tmp += bitfield(self.dec_cj_imm,offset=0,size=1)*(2**5)
        tmp += bitfield(self.dec_cj_imm,offset=5,size=1)*(2**6)
        tmp += bitfield(self.dec_cj_imm,offset=4,size=1)*(2**7)
        tmp += bitfield(self.dec_cj_imm,offset=7,size=2)*(2**8)
        tmp += bitfield(self.dec_cj_imm,offset=6,size=1)*(2**10)
        tmp += bitfield(self.dec_cj_imm,offset=10,size=1)*(2**11)
        self.dec_imm11j = sign_extend32(tmp,12)
        #BEQZ BNEZ
        tmp  =  bitfield(self.dec_cb_offset_lo,offset=1,size=2)* 2
        tmp +=  bitfield(self.dec_cb_offset_hi,offset=0,size=2)*(2**3)
        tmp +=  bitfield(self.dec_cb_offset_lo,offset=0,size=1)*(2**5)
        tmp +=  bitfield(self.dec_cb_offset_lo,offset=3,size=2)*(2**6)
        tmp +=  bitfield(self.dec_cb_offset_hi,offset=2,size=1)*(2**8)
        self.dec_c_bcond_imm = sign_extend32(tmp,9)
        #CIW
        tmp  = bitfield(self.dec_ciw_imm,offset=1,size=1)*(2**2)
        tmp += bitfield(self.dec_ciw_imm,offset=0,size=1)*(2**3)
        tmp += bitfield(self.dec_ciw_imm,offset=6,size=2)*(2**4)
        tmp += bitfield(self.dec_ciw_imm,offset=2,size=4)*(2**6)
        self.dec_c_immaddi4sp = tmp
        #LS COMPRESSED
        tmp  = bitfield(self.dec_cl_immlo,offset=1,size=1)*(2**2)
        tmp  += bitfield(self.dec_cl_immhi,offset=0,size=3)*(2**3)
        tmp  += bitfield(self.dec_cl_immlo,offset=0,size=0)*(2**6)
        self.dec_c_ls_imm = tmp
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
       inst_match = inst
       for i in id.decode.keys():
           mask = self.mask_dict[i]
           match = self.match_dict[i]
           if (inst_match & mask) == match:
       	      return i

       return 'illegal_instruction'

    def execute_instruction(self,inst_str):
       "Execute the current instruction"
       if inst_str in ns.spec['nanorv32']['rv32i']['simu']['inst']:
           f = dict(ns.spec ['nanorv32']['rv32i']['simu']['inst'][inst_str])

           return f['func'](self)
       elif inst_str in ns.spec['nanorv32']['rvc_rv32']['simu']['inst']:
           f = dict(ns.spec ['nanorv32']['rvc_rv32']['simu']['inst'][inst_str])

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
               # print "addr = {}".format(addr)
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
       if bitfield(tmp,offset=7,size=5) == 0x00:
          is_rs1_eq_0 = 1
       else:
          is_rs1_eq_0 = 0
       if bitfield(tmp,offset=7,size=5) == 0x02:
          is_rs1_eq_2 = 1
       else :
          is_rs1_eq_2 = 0
       if bitfield(tmp,offset=2,size=5) == 0x00:
          is_rs2_eq_0 = 1
       else :
          is_rs2_eq_0 = 0
       tmp += (is_rs1_eq_0<<32)
       tmp += (is_rs1_eq_2<<33)
       tmp += (is_rs2_eq_0<<34)
       return tmp

    def csr_read(self, addr):
       return self.csr[addr]


    def update_csr(self):
       self.csr[NANORV32_CSR_ADDR_CYCLE] +=1
       self.csr[NANORV32_CSR_ADDR_TIME] +=1
       self.csr[NANORV32_CSR_ADDR_INSTRET] +=1
       if self.csr[NANORV32_CSR_ADDR_CYCLE] == 0x100000000:
           self.csr[NANORV32_CSR_ADDR_CYCLE] = 0
           self.csr[NANORV32_CSR_ADDR_CYCLEH] += 1

       if self.csr[NANORV32_CSR_ADDR_TIME] == 0x100000000:
           self.csr[NANORV32_CSR_ADDR_TIME] = 0
           self.csr[NANORV32_CSR_ADDR_TIMEH] += 1

       if self.csr[NANORV32_CSR_ADDR_INSTRET] == 0x100000000:
           self.csr[NANORV32_CSR_ADDR_INSTRET] = 0
           self.csr[NANORV32_CSR_ADDR_INSTRETH] += 1
       pass

    def init_csr(self):
       self.csr[NANORV32_CSR_ADDR_CYCLE] = 0
       self.csr[NANORV32_CSR_ADDR_CYCLEH] = 0
       self.csr[NANORV32_CSR_ADDR_TIME] = 0
       self.csr[NANORV32_CSR_ADDR_TIMEH] = 0
       self.csr[NANORV32_CSR_ADDR_INSTRET] = 0
       self.csr[NANORV32_CSR_ADDR_INSTRETH] = 0

def get_args():
    """
    Get command line arguments
    """
    parser = argparse.ArgumentParser(description="""
    A simulator for the Nanorv32 CPU
                   """)
    parser.add_argument('--hex2', action='store', dest='hex2',
                        help='hex2 file to be load in the memory', default="")
    parser.add_argument('--trace', action='store', dest='trace',
                        help='trace file', default=None)
    parser.add_argument('--start_address', action='store', dest='start_address',
                        help='PC start address', default=0)
    parser.add_argument('--compare', action='store', dest='compare',
                        help='trace file to compare', default=None)
    parser.add_argument('--map', action='store', dest='mapdata',
                        help='map file from objdump -t, needed for profiling', default=None)

    parser.add_argument('--profile', action='store', dest='profile',
                        help='File to store profiling data', default=None)
    parser.add_argument('--version', action='version', version='%(prog)s 0.1')
    return parser.parse_args()

def close_profiling(profile_info,f):
    pp.pprint(profile_info)
    pickle.dump( profile_info, f)
    pass

if __name__ == '__main__':
    profiling = False
    prof_file = None
    line_num = 0
    profile_info = dict()
    args= get_args()
    nrv = NanoRV32Core()
    if args.hex2 != "":
        print("-I- Loading " + args.hex2)
        nrv.load_code_memory(args.hex2)
    else:
        sys.exit("No hex2 file specified (use --hex2=<file name>)")

    if args.trace is not None:
        trace = open(args.trace,'w')
    else:
        trace = None
    if args.compare is not None:
        compare = open(args.compare,'r')
        compare_line =compare.readlines()
    else:
        compare = None


    if args.mapdata:
        mapdata = prof.read_objdump_map_file(args.mapdata)
        func_addr_array   = mapdata.keys()
        func_addr_array_l = len(func_addr_array)
    else:
        mapdata = None
        func_addr_array   = []
        func_addr_array_l = 0


    if args.profile:
        profiling = True
        prof_file = open(args.profile,'w')








    previous_func = "" # for trace with profiling
    caller = ""
    short_inst = 0
    nrv.pc = args.start_address;
    func = "undefined"
    call_stack = ['s','init_code']
    call_stack_main_found = False
    while True:
        previous_short_inst = short_inst
        inst = nrv.get_instruction(nrv.pc)
        short_inst = bitfield(inst,offset=0,size=32)
        if trace:
            trace.write("PC : 0x{:08x} I : 0x{:08x} : ".format(nrv.pc,short_inst))
        if profiling:
            previous_func = func
            func= prof.get_function_at(mapdata, func_addr_array, func_addr_array_l, nrv.pc )
        else:
            func = "undefined"

        if compare:
           line = compare_line[line_num]
           extracted = line.split(':', 4)
           rtl_pc = extracted[1].replace(" ","").replace("I","")
           rtl_inst_tmp = extracted[2].replace(" ","").replace("0x","")
           if (bitfield(inst,offset=0,size=2) != 3):
              model_inst = '0x%08x' % bitfield(short_inst,offset=0,size=16)
              rtl_inst =  "0x0000" + rtl_inst_tmp[-4:]
           else :
              model_inst = '0x%08x' % short_inst
              rtl_inst = "0x" + rtl_inst_tmp
           model_pc = '0x%08x' % nrv.pc
           if rtl_pc != model_pc:
                print "\n-I- TEST FAILED (pc compare fail) : RTL PC : ", rtl_pc, ", Model PC " ,model_pc,", line", line_num
                print "\n"
                if trace:
                    trace.close()
                if profiling:
                    close_profiling(profile_info,prof_file)

                sys.exit()
           if model_inst != rtl_inst:
                print "\n-I- TEST FAILED (inst compare fail) : RTL INSTR : 0x{:08x}, Model INSTR :0x{:08x}, line {} \n", rtl_inst,model_inst,line_num
                if trace:
                    trace.close()
                if profiling:
                    close_profiling(profile_info,prof_file)
                sys.exit()
        if nrv.pc == 0x00000100:
            if nrv.rf[10] == 0xCAFFE000: #x10/a0
                print
                print "\n-I- TEST OK\n"
                if trace:
                    trace.close()
                if profiling:
                    close_profiling(profile_info,prof_file)
                sys.exit()
            elif nrv.rf[10] == 0xDEADD000: #x10/a0
                print
                nrv.dump_regfile()
                print "\n-I- TEST FAILED\n"
                if trace:
                    trace.close()
                if profiling:
                    close_profiling(profile_info,prof_file)
                sys.exit()
            else:
                print
                nrv.dump_regfile()
                print "\n-I- TEST FAILED (unknown reason)\n"
                if trace:
                    trace.close()
                if profiling:
                    close_profiling(profile_info,prof_file)
                sys.exit()

        if nrv.pc == 0x0088:
            c = chr(nrv.rf[10] & 0x0FF)
            sys.stdout.write(c)
            if c == 10:
                print

        nrv.new_instruction(inst)
        inst_str =  nrv.match_instruction(inst)
        inst_str2 = inst_str.replace('c.', '')
        if args.trace:
            trace.write(inst_str.ljust(8))
            #trace.write(inst_str2.ljust(8))
        if inst_str != 'illegal_instruction':
            _, new_pc,txt  = nrv.execute_instruction(inst_str)
            if func == "main":
                call_stack_main_found = True
            if profiling :
                if call_stack_main_found :
                    if (func != previous_func):
                        # something has changed
                        if func in call_stack:
                            # this was one the previous call frame (because there are some optimization)
                            # if a function calls another function and return straight away
                            while(call_stack[-1] != func):
                                call_stack.pop()
                        else:
                            # we go deeper in call stack
                            call_stack.append(func)
                txt += " func : " + func + " $" + '->'.join(call_stack)
            if trace:
                trace.write(" : " + txt + '\n')
            nrv.pc = new_pc
            nrv.update_csr()
        else:
            if trace:
                trace.close()
            if profiling:
                close_profiling(profile_info,prof_file)
            sys.exit("-E- Illegall instruction found !")
        if profiling:
            if func in profile_info:
                profile_info[func]['__count__'] += 1
            else:
                profile_info[func] = dict()
                profile_info[func]['__count__'] = 1

            if inst_str in profile_info[func]:
                profile_info[func][inst_str] += 1
            else:
                profile_info[func][inst_str] = 1


        if (compare) :
           test = re.search(r"RF\[(\S+)(\s+)\] <=", txt)
           test2 = re.search(r"RF\[(\S+)(\s+)\] <=", line)
           test3 = re.search(r"<= 0x(\S+) ", txt)
           test4 = re.search(r"<= 0x(\S+) ", line)
           if not test or not test2:
             if test[1] != test2[1]:
                 print "\n-I- TEST FAILED (reg_dest) : RTL RD :" + test[1] + ", Model RD : " + test2[1] + " line " + line_num, " \n"
                 if trace:
                     trace.close()
                 if profiling:
                     close_profiling(profile_info,prof_file)

                 sys.exit()
           if not test3 or not test4:
             if test3 != test4:
                 print "\n-I- TEST FAILED (reg_update) : RTL RD val : " + test3 + " Model RD val: " + test4 + " line " + line_num + ", \n"
                 if trace:
                     trace.close()
                 if profiling:
                     close_profiling(profile_info,prof_file)
                 sys.exit()
           line_num = line_num +1
