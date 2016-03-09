import sys
import pprint as pp
import inst_decod as id
import nanorv32_simu as ns

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


def sign_extend32(val,bits,xx=32):
    "Sign extend a 'bits' long number to xx  bit"
    # FIXME
    return val

def zero_extend32(val,bits,xx=32):
    "Zero extend a 'bits' long number to xx  bit"
    # FIXME
    return val


class NanoRV32Core(object):
    """
    """

    def __init__(self):
        self.codemem_size = 65536
        self.datamem_size = 65536
        self.datamem_start = 0x20000000
        self.codemem_start = 0x00000000
        self.rf = [0]*32
        self.pc = 0
        # Build dictionnaries for the decoder
        self.mask_dict = {inst :  int("0b" + get_mask (id.decode[inst]),2) for inst in id.decode.keys ()}
        self.match_dict = {inst : int( "0b" + get_match(id.decode[inst]),2) for inst in id.decode.keys()}
        self.code_memory = [0]*(self.codemem_size/4)
        self.data_memory = [0]*(self.datamem_size/4)


    def mem_write_byte(self,addr,data):
        pass

    def mem_write_halfword(self,addr,data):
        pass

    def mem_write_word(self,addr,data):
        pass

    def mem_read_byte(self,addr):
        pass

    def mem_read_byte_u(self,addr):
        pass

    def mem_read_halfword(self,addr):
        pass

    def mem_read_halfword_u(self,addr):
        pass

    def mem_read_halfword(self,addr):
        pass


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
        self.dec_func4 = bitfield(inst,offset=28,size=4)
        self.dec_func12 = bitfield(inst,offset=20,size=12)

        self.dec_imm12_se = sign_extend32(self.dec_imm12,12)
        self.dec_sb_offset = 0 # FIXME - Offset for SB instruction

        #@end[sim_instruction_fields]
    def update_rf(self,idx,val):
        "Write val at index idx in the register file"
        self.rf[idx] = (val & 0x0FFFFFFFF) # 32-bit truncation

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
            #tmp = dict()
            #tmp['func'] = lambda(ns.spec ['nanorv32'] ['rv32i'] ['simu'] ['inst'] ['func'])

            print "Type of f : " + str(type(f))
            print "Type of f[] : " + str(type(f['func']))
            #print "Type of t[] : " + str(type(tmp['func']))

            return f['func'](self)


    def dump_regfile(self, num_col=4):
        nb_reg = len(self.rf)
        i = 0
        while(i<nb_reg):
            for c in range(0,num_col):
                sys.stdout.write("x{:02d}=0x{:08X} ".format(i,self.rf[i]))
                i += 1
            print


#if __name__ == '__main__':
if True:

    nrv = NanoRV32Core()



    addi=0xff030313 # addi	t1,t1,-16
    auipc=0x20000297

    print nrv.match_instruction(addi)
    print nrv.match_instruction(auipc)


    nrv.new_instruction(addi) # update internal field used for decoding
    inst_str =  nrv.match_instruction(addi)
    _, new_pc = nrv.execute_instruction(inst_str)
    print "New PC = " + str(new_pc)
    nrv.dump_regfile()
    pass
