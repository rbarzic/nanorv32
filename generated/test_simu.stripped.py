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





class NanoRV32Core(object):
    """
    """

    def __init__(self):
        self.rf = [0]*32
        self.pc = 0
        # Build dictionnaries for the decoder
        self.mask_dict = {inst :  int("0b" + get_mask (id.decode[inst]),2) for inst in id.decode.keys ()}
        self.match_dict = {inst : int( "0b" + get_match(id.decode[inst]),2) for inst in id.decode.keys()}




    def new_instruction(self,inst):
        #@begin[sim_instruction_fields]
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
            f = ns.spec['nanorv32']['rv32i']['simu']['inst']['func']
            return f(self)




#if __name__ == '__main__':
if True:

    nrv = NanoRV32Core()

    g = lambda x: (x+1,x)

    h = lambda c : (c.r,c)

    b = g(2)
    c = 0xCAFEBABE
    d = bitfield(c,offset=4,size=4)
    e = bitfield(c,offset=16,size=4)

    print hex(d)
    print hex(e)
    print id.decode['and']
    print get_mask(id.decode['and'])
    print get_match(id.decode['and'])
    mask_dict = {inst :  int("0b" + get_mask (id.decode[inst]),2) for inst in id.decode.keys ()}
    match_dict = {inst : int( "0b" + get_match(id.decode[inst]),2) for inst in id.decode.keys()}
    #pp.pprint(mask_dict)
    #pp.pprint(match_dict)

    addi=0xff030313 # addi	t1,t1,-16
    auipc=0x20000297

    print nrv.match_instruction(addi)
    print nrv.match_instruction(auipc)


    nrv.new_instruction(addi) # update internal field used for decoding
    inst_str =  nrv.match_instruction(addi)
    _, new_pc = nrv.execute_instruction(inst_str)
    print "New PC = " + str(new_pc)
    pass
