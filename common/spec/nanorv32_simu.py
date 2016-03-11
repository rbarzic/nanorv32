import ctypes as ct
from functools import partial
import operator
import AutoVivification as av
spec = av.AutoVivification()
#spec = dict()


#spec['addi'] = lambda c: (  c.update_rf(c.dec_rd,c.rf[c.dec_rs1] + c.dec_imm12),
#                            c.pc_next + c.imm12 )

def uint32(d):
    return ct.c_uint32(d).value
def int32(d):
    return ct.c_uint32(d).value

def comp2(a):
    return ~a +1


def r_type(c,op,op_str):
    rs1 = c.dec_rs1
    rs2 = c.dec_rs2
    rd = c.dec_rd
    rs1_val = ct.c_uint32(c.rf[rs1]).value
    rs2_val = ct.c_uint32(c.rf[rs2]).value
    rd_val = ct.c_uint32(op(rs1_val,rs2_val)).value
    pc = c.pc

    # results
    c.update_rf(rd,rd_val)
    new_pc = pc + 4
    txt = "RF[rd={:02d}] <= 0x{:08x} (RF[rs1={:02d}]=0x{:08x} {}  RF[rs2={:02d}]=0x{:08x}) ".format(rd,rd_val,rs1,rs1_val,op_str,rs2,rs2_val)

    return (None,new_pc,txt)


def i_type(c,op,op_str):
    rs1 = c.dec_rs1
    imm12_se = ct.c_uint32(c.dec_imm12_se).value
    rd = c.dec_rd
    rs1_val = ct.c_uint32(c.rf[rs1]).value
    rd_val = ct.c_uint32(op(rs1_val,imm12_se)).value
    pc = c.pc
    # results
    c.update_rf(rd,rd_val)
    new_pc = pc + 4
    txt = "RF[rd={:02d}] <= 0x{:08x} (RF[rs1={:02d}]=0x{:08x} {}  imm20 =0x{:08x}) ".format(rd,rd_val,rs1,rs1_val,op_str,imm12_se)

    return (None,new_pc,txt)


def auipc(c):
    imm20 = c.dec_imm20
    rd = c.dec_rd
    imm20_shifted = (imm20<<12)
    pc = c.pc
    rd_val = pc + imm20_shifted
    # results
    c.update_rf(rd,rd_val)
    new_pc = pc + 4
    txt = "RF[rd={:02d}] <= 0x{:08x} (pc=0x{:08x} + imm20<<12 =0x{:08x}) ".format(rd,rd_val,pc,imm20_shifted)

    return (None,new_pc,txt)

def lui(c):
    imm20 = uint32(c.dec_imm20)
    rd = c.dec_rd
    imm20_shifted = uint32(imm20<<12)
    pc = c.pc
    rd_val = imm20_shifted
    # results
    c.update_rf(rd,rd_val)
    new_pc = pc + 4
    txt = "RF[rd={:02d}] <= 0x{:08x} (pc=0x{:08x} + imm20<<12 =0x{:08x}) ".format(rd,rd_val,pc,imm20_shifted)

    return (None,new_pc,txt)


def cond_branch(c,op):
    rs1 = c.dec_rs1
    rs2 = c.dec_rs2
    rs1_val = uint32(c.rf[rs1])
    rs2_val = uint32(c.rf[rs2])
    offset = uint32(c.dec_sb_offset_se)
    pc = c.pc

    if op(rs1_val,rs2_val):
        # taken

        new_pc = uint32(pc + offset)
        txt = "RF[rs1={:02d}]=0x{:08x} RF[rs2={:02d}]=0x{:08x}  Jump to 0x{:08x}   (0x{:08x} + 0x{:08x})".format(rs1,rs1_val,rs2,rs2_val,new_pc,pc,offset)
    else:
        new_pc = uint32(pc + 4)
        txt = "RF[rs1={:02d}]=0x{:08x} RF[rs2={:02d}]=0x{:08x}  Branch not taken".format(rs1,rs1_val,rs2,rs2_val)

    return (None,new_pc,txt)

def sim_jal(c):

    rd  = c.dec_rd

    offset = uint32(c.dec_imm20uj_se)
    pc = uint32(c.pc)
    rd_val = uint32(pc +4)
    new_pc = uint32(pc + offset ) & 0xFFFFFFFE # lsb must be zero
    c.update_rf(rd,rd_val)
    txt = "RF[rs1={:02d}] <= 0x{:08x}   Jump to 0x{:08x}   (0x{:08x} + 0x{:08x})".format(rd,rd_val,new_pc,pc,offset)

    return (None,new_pc,txt)

def sim_jalr(c):
    rs1 = c.dec_rs1
    rd  = c.dec_rd
    rs1_val = uint32(c.rf[rs1])

    offset = uint32(c.dec_imm12_se)
    pc = uint32(c.pc)
    rd_val = uint32(pc +4)
    new_pc = uint32(rs1_val + offset ) & 0xFFFFFFFE # lsb must be zero
    c.update_rf(rd,rd_val)
    txt = "RF[rs1={:02d}] <= 0x{:08x}   Jump to 0x{:08x}   (0x{:08x} + 0x{:08x})".format(rd,rd_val,new_pc,rs1_val,offset)

    return (None,new_pc,txt)

def load(c, mem_access_fn):
    rs1 = c.dec_rs1
    rd  = c.dec_rd
    rs1_val = uint32(c.rf[rs1])
    offset = uint32(c.dec_imm12_se)
    pc = uint32(c.pc)
    addr = rs1_val + offset
    # Mem access (using a function passed as a parameter)
    rd_val = mem_access_fn(c,addr)
    new_pc = uint32(pc + 4)
    c.update_rf(rd,rd_val)
    txt = "RF[rd={:02d}] <= 0x{:08x} MEM[0x{:08x}] (RF[rs1={:02d}]=0x{:08x} +   offset=0x{:08x}) ".format(rd,rd_val,addr,rs1,rs1_val,offset)
    return (None,new_pc,txt)


def store(c, mem_access_fn):
    rs1 = c.dec_rs1
    rs2 = c.dec_rs2

    rs1_val = uint32(c.rf[rs1])
    rs2_val = uint32(c.rf[rs2])
    offset = uint32(c.dec_store_imm12_se)
    pc = uint32(c.pc)
    addr = rs1_val + offset
    # Mem access (using a function passed as a parameter)
    mem_access_fn(c,addr,rs2_val)
    new_pc = uint32(pc + 4)
    txt = " MEM[0x{:08x}] <= RF[rs2={:02d}] : 0x{:08x} (RF[rs1={:02d}]=0x{:08x} +   offset=0x{:08x}) ".format(addr,rs2,rs2_val,rs1,rs1_val,offset)
    return (None,new_pc,txt)

def lw_fn(c,addr):
    return c.mem_read_word(addr)

def lh_fn(c,addr):
    return c.mem_read_halfword(addr)

def lhu_fn(c,addr):
    return c.mem_read_halfword_u(addr)

def lb_fn(c,addr):
    return c.mem_read_byte(addr)


def lbu_fn(c,addr):
    return c.mem_read_byte_u(addr)


def sw_fn(c,addr,data):
    return c.mem_write_word(addr,data)
def sh_fn(c,addr,data):
    return c.mem_write_halfword(addr,data)
def sb_fn(c,addr,data):
    return c.mem_write_byte(addr,data)



sim_lw = partial(load,mem_access_fn=lw_fn)
sim_lh = partial(load,mem_access_fn=lh_fn)
sim_lhu = partial(load,mem_access_fn=lhu_fn)
sim_lb = partial(load,mem_access_fn=lb_fn)
sim_lbu = partial(load,mem_access_fn=lbu_fn)

sim_sw = partial(store,mem_access_fn=sw_fn)
sim_sh = partial(store,mem_access_fn=sh_fn)
sim_sb = partial(store,mem_access_fn=sb_fn)


sim_add = partial(r_type,op=operator.add,op_str='+')
sim_sub = partial(r_type,op=operator.sub,op_str='-')
sim_and = partial(r_type,op=operator.and_,op_str='&')
sim_or = partial(r_type,op=operator.or_,op_str='|')
sim_xor = partial(r_type,op=operator.xor,op_str='^')


def mulh(a,b):
    a32 = uint32(a)
    b32 = uint32(b)
    #print "Mulh 0x{:08x} * 0x{:08x} ".format(a32,b32)

    s_a = ((a32>>31) & 0x01) == 1
    s_b = ((b32>>31) & 0x01) == 1
    #print "s_a = {} s_b = {} ".format(s_a, s_b)

    if (not s_a)  and  (not s_b):
        # both positive
        return uint32((a32*b32)>>32)
    elif (s_a and  s_b):
        a32_pos = uint32(~a32 +1)
        b32_pos = uint32(~b32 +1)
        return uint32((a32_pos*b32_pos)>>32)
    elif s_a and  (not s_b):
        # a negative, b positive
        a32_pos = uint32(~a32 +1)
        b32_pos = b32
        # result is negative
        return uint32 (comp2(a32_pos*b32_pos)>>32)
    else:
        # a positive, b negative
        a32_pos = a32
        b32_pos = uint32(~b32+1)
        # result is negative
        return uint32 (comp2(a32_pos*b32_pos)>>32)

def mulhu(a,b):
    a32 = uint32(a)
    b32 = uint32(b)
    return (a32*b32)>>32


def mulhsu(a,b):
    a32 = uint32(a)
    b32_pos = uint32(b)

    s_a = ((a32>>31) & 0x01) == 1
    if s_a:
        # one negative, one positive
        a32_pos = uint32(comp2(a32))
        # result is negative
        return uint32 (comp2(a32_pos*b32_pos)>>32)
    else:
        a32_pos = a32
        # result is positive
        return uint32((a32_pos*b32_pos)>>32)


def div(a,b):
    a32 = uint32(a)
    b32 = uint32(b)
    #print "Div 0x{:08x} * 0x{:08x} ".format(a32,b32)

    s_a = ((a32>>31) & 0x01) == 1
    s_b = ((b32>>31) & 0x01) == 1
    #print "s_a = {} s_b = {} ".format(s_a, s_b)
    if(b32==0):
        return uint32(-1)

    if (not s_a)  and  (not s_b):
        # both positive
        return uint32(a32/b32)
    elif (s_a and  s_b):
        a32_pos = uint32(~a32 +1)
        b32_pos = uint32(~b32 +1)
        return uint32(a32_pos/b32_pos)
    elif s_a and  (not s_b):
        # a negative, b positive
        a32_pos = uint32(~a32 +1)
        b32_pos = b32
        # result is negative
        return uint32 (comp2(a32_pos/b32_pos))
    else:
        # a positive, b negative
        a32_pos = a32
        b32_pos = uint32(~b32+1)
        # result is negative
        return uint32 (comp2(a32_pos/b32_pos))


def rem(a,b):
    a32 = uint32(a)
    b32 = uint32(b)
    #print "Rem 0x{:08x} / 0x{:08x} ".format(a32,b32)

    s_a = ((a32>>31) & 0x01) == 1
    s_b = ((b32>>31) & 0x01) == 1
    #print "s_a = {} s_b = {} ".format(s_a, s_b)
    if(b32==0):
        return a32

    if (not s_a)  and  (not s_b):
        # both positive
        return uint32(a32%b32)
    elif (s_a and  s_b):
        a32_pos = uint32(~a32 +1)
        b32_pos = uint32(~b32 +1)
        # result is negative !
        return uint32(comp2(a32_pos%b32_pos))
    elif s_a and  (not s_b):
        # a negative, b positive
        a32_pos = uint32(~a32 +1)
        b32_pos = b32
        # result is negative
        return uint32 (comp2(a32_pos%b32_pos))
    else:
        # a positive, b negative
        a32_pos = a32
        b32_pos = uint32(~b32+1)
       #print "a32_pos = {:d} b32_pos = {:d}".format(a32_pos,b32_pos)
        # result is positive !
        return uint32 (a32_pos%b32_pos)




def divu(a,b):
    a32 = uint32(a)
    b32 = uint32(b)

    if(b32==0):
        return uint32(-1)
    else:
        return uint32(a32/b32)

def remu(a,b):
    a32 = uint32(a)
    b32 = uint32(b)

    if(b32==0):
        return uint32(a32)
    else:
        return uint32(a32%b32)




sim_mul = partial(r_type,op=operator.mul,op_str='*')
sim_mulh = partial(r_type,op=mulh,op_str='*')
sim_mulhu = partial(r_type,op=mulhu,op_str='*')
sim_mulhsu = partial(r_type,op=mulhsu,op_str='*')

sim_div = partial(r_type,op=div,op_str='/')
sim_divu = partial(r_type,op=divu,op_str='/')

sim_rem = partial(r_type,op=rem,op_str='%')
sim_remu = partial(r_type,op=remu,op_str='%')

sim_addi = partial(i_type,op=operator.add,op_str='+')
sim_andi = partial(i_type,op=operator.and_,op_str='&')
sim_ori = partial(i_type,op=operator.or_,op_str='|')
sim_xori = partial(i_type,op=operator.xor,op_str='^')

def lt_comp_signed(a,b):
    a32 = uint32(a)
    b32 = uint32(b)
    #print "Compare 0x{:08x} < 0x{:08x} ".format(a32,b32)

    s_a = ((a32>>31) & 0x01) == 1
    s_b = ((b32>>31) & 0x01) == 1
    #print "s_a = {} s_b = {} ".format(s_a, s_b)

    if (not s_a)  and  (not s_b):
        # both positive
        return 1 if a32 < b32 else 0
    elif (s_a and  s_b):
        # both negative
        return 1 if a32 < b32 else 0
    elif s_a and  (not s_b):
        # a negative, b positive
        return 1
    else:
        # b positive, a negative
        return 0



def ge_comp_signed(a,b):
    a32 = uint32(a)
    b32 = uint32(b)
    #print "Compare 0x{:08x} < 0x{:08x} ".format(a32,b32)

    s_a = ((a32>>31) & 0x01) == 1
    s_b = ((b32>>31) & 0x01) == 1
    #print "s_a = {} s_b = {} ".format(s_a, s_b)

    if (not s_a)  and  (not s_b):
        # both positive
        return 1 if a32 >= b32 else 0
    elif (s_a and  s_b):
        # both negative
        return 1 if a32 >= b32 else 0
    elif s_a and  (not s_b):
        # a negative, b positive
        return 0
    else:
        # b positive, a negative
        return 1





sim_slt = partial(r_type,
                  op=lt_comp_signed,
                  op_str='<')
sim_sltu = partial(r_type,
                  op=operator.lt,
                  op_str='<')

sim_slti = partial(i_type,
                  op=lt_comp_signed,
                  op_str='<')

sim_sltiu = partial(i_type,
                  op=operator.lt,
                  op_str='<')

sim_bne = partial(cond_branch,op=operator.ne)
sim_beq = partial(cond_branch,op=operator.eq)
sim_blt = partial(cond_branch,op=lt_comp_signed)
sim_bltu = partial(cond_branch,op=operator.lt)
sim_bge = partial(cond_branch,op=ge_comp_signed)
sim_bgeu = partial(cond_branch,op=operator.ge)



# Shift (R-type)

def sra_32(a,b):
    if(a & 0x80000000):
        # msb is set
        tmp = (a>>(b & 0x1F))
        mask = 0xFFFFFFFF<<(32-(b & 0x1F))
        return (tmp | mask) & 0x0FFFFFFFF
    else:
        # msb not set
        return (a>>(b & 0x1F)) & 0x0FFFFFFFF

sim_sra = partial(r_type,op=sra_32,op_str='>>') # FIXME
sim_sll = partial(r_type,
                  op=lambda x,y: x<<(y & 0x1F),
                  op_str='<<')
sim_srl = partial(r_type,
                  op=lambda x,y: x>>(y & 0x1F),
                  op_str='>>')

# SHift (I-type)
sim_srai = partial(i_type,op=sra_32,op_str='>>') # FIXME
sim_slli = partial(i_type,
                  op=lambda x,y: x<<(y & 0x1F),
                  op_str='<<')
sim_srli = partial(i_type,
                  op=lambda x,y: x>>(y & 0x1F),
                  op_str='>>')


# CSR
def csr_read(c,addr,csr=""):
    addr = uint32(c.dec_imm12)
    rd  = c.dec_rd
    rd_val = c.csr_read(addr)
    pc = uint32(c.pc)
    # results
    c.update_rf(rd,rd_val)
    new_pc = uint32(pc + 4)
    txt = "RF[rd={:02d}] <= 0x{:08x} (CSR : {:s} 0x{:08x}  ) ".format(rd,rd_val,csr,addr)

    return (None,new_pc,txt)



sim_rdcycle = partial(csr_read,addr=0xC00,csr="Cycle")
sim_rdcycleh = partial(csr_read,addr=0xC80,csr="CycleH")
sim_rdtime = partial(csr_read,addr=0xC01,csr="Time")
sim_rdtimeh = partial(csr_read,addr=0xC81,csr="TimeH")
sim_rdinstret = partial(csr_read,addr=0xC02,csr="InstRet")
sim_rdinstreth = partial(csr_read,addr=0xC82,csr="InstRetH")



spec['nanorv32']['rv32i']['simu']['inst']['jalr'] = {
    'func' : sim_jalr
}




spec['nanorv32']['rv32i']['simu']['inst']['addi'] = {
   'func' :  sim_addi
}

spec['nanorv32']['rv32i']['simu']['inst']['mul'] = {
    'func' : sim_mul
}

spec['nanorv32']['rv32i']['simu']['inst']['mulh'] = {
    'func' : sim_mulh
}
spec['nanorv32']['rv32i']['simu']['inst']['mulhsu'] = {
    'func' :  sim_mulhsu
}
spec['nanorv32']['rv32i']['simu']['inst']['mulhu'] = {
    'func' : sim_mulhu
}

spec['nanorv32']['rv32i']['simu']['inst']['div'] = {
    'func' : sim_div
}

spec['nanorv32']['rv32i']['simu']['inst']['divu'] = {
    'func' :  sim_divu

}
spec['nanorv32']['rv32i']['simu']['inst']['rem'] = {
     'func' :  sim_rem
}
spec['nanorv32']['rv32i']['simu']['inst']['remu'] = {
    'func' : sim_remu
}


spec['nanorv32']['rv32i']['simu']['inst']['slli'] = {
    'func' :  sim_slli
}


spec['nanorv32']['rv32i']['simu']['inst']['slti'] = {
    'func' :  sim_slti
}


spec['nanorv32']['rv32i']['simu']['inst']['sltiu'] = {
    'func' :  sim_sltiu
}


spec['nanorv32']['rv32i']['simu']['inst']['xori'] = {
    'func' : sim_xori
}


spec['nanorv32']['rv32i']['simu']['inst']['srli'] = {
    'func' : sim_srli
}


spec['nanorv32']['rv32i']['simu']['inst']['srai'] = {
    'func' : sim_srai
}


spec['nanorv32']['rv32i']['simu']['inst']['ori'] = {
    'func' :  lambda c: (
        c.update_rf( c.dec_rd, c.rf[c.dec_rs1] | c.dec_imm12_se) ,
        c.pc + 4,
        ""
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['andi'] = {
    'func' : sim_andi
}




spec['nanorv32']['rv32i']['simu']['inst']['lw'] = {
    'func' :  sim_lw
}


spec['nanorv32']['rv32i']['simu']['inst']['lbu'] = {
    'func' :  sim_lbu
}

spec['nanorv32']['rv32i']['simu']['inst']['lb'] = {
    'func' :  sim_lb
}


spec['nanorv32']['rv32i']['simu']['inst']['lhu'] = {
    'func' :  sim_lhu
}

spec['nanorv32']['rv32i']['simu']['inst']['lh'] = {
    'func' :  sim_lh
}


spec['nanorv32']['rv32i']['simu']['inst']['fence'] = {

}


spec['nanorv32']['rv32i']['simu']['inst']['fence_i'] = {

}



spec['nanorv32']['rv32i']['simu']['inst']['beq'] = {
    'func' :  sim_beq
}





spec['nanorv32']['rv32i']['simu']['inst']['bne'] = {
    'func' : sim_bne
    #lambda c: (
    #    None,
    #    c.pc + c.dec_sb_offset if c.rf[c.dec_rs1] != c.rf[c.dec_rs2] else c.pc + 4,
    #    ""
    #
    #)
}


spec['nanorv32']['rv32i']['simu']['inst']['blt'] = {
    'func' :  sim_blt
}


spec['nanorv32']['rv32i']['simu']['inst']['bge'] = {
    'func' : sim_bge
}


spec['nanorv32']['rv32i']['simu']['inst']['bltu'] = {
     'func' :  sim_bltu
}


spec['nanorv32']['rv32i']['simu']['inst']['bgeu'] = {
   'func' :  sim_bgeu
}


spec['nanorv32']['rv32i']['simu']['inst']['lui'] = {
    'func' :  lui
}


spec['nanorv32']['rv32i']['simu']['inst']['auipc'] = {
    'func' :  auipc
}


# {{{ add

spec['nanorv32']['rv32i']['simu']['inst']['add'] = {
    'func' : sim_add
}

# }}}

# {{{ sub

spec['nanorv32']['rv32i']['simu']['inst']['sub'] = {
    'func' : sim_sub
}

# }}}



spec['nanorv32']['rv32i']['simu']['inst']['sll'] = {
    'func' :  sim_sll
}


spec['nanorv32']['rv32i']['simu']['inst']['slt'] = {
    'func' :  sim_slt
}


spec['nanorv32']['rv32i']['simu']['inst']['sltu'] = {
    'func' :sim_sltu

}


spec['nanorv32']['rv32i']['simu']['inst']['xor'] = {
    'func' : sim_xor
}


spec['nanorv32']['rv32i']['simu']['inst']['srl'] = {
    'func' :  sim_srl
}


spec['nanorv32']['rv32i']['simu']['inst']['sra'] = {
     'func' :  sim_sra
}


spec['nanorv32']['rv32i']['simu']['inst']['or'] = {
    'func' : sim_or
}


spec['nanorv32']['rv32i']['simu']['inst']['and'] = {
    'func' : sim_and
}


spec['nanorv32']['rv32i']['simu']['inst']['scall'] = {

}


spec['nanorv32']['rv32i']['simu']['inst']['sbreak'] = {

}


spec['nanorv32']['rv32i']['simu']['inst']['sb'] = {
    'func' :  sim_sb

}


spec['nanorv32']['rv32i']['simu']['inst']['sh'] = {
    'func' :  sim_sh
}


spec['nanorv32']['rv32i']['simu']['inst']['sw'] = {
    'func' :  sim_sw
}


#spec['nanorv32']['rv32i']['simu']['inst']['sd'] = {
#
#}


spec['nanorv32']['rv32i']['simu']['inst']['jal'] = {
     'func' :  sim_jal
}


spec['nanorv32']['rv32i']['simu']['inst']['rdtime'] = {
     'func' :  sim_rdtime
}
spec['nanorv32']['rv32i']['simu']['inst']['rdtimeh'] = {
     'func' :  sim_rdtimeh
}
spec['nanorv32']['rv32i']['simu']['inst']['rdcycle'] = {
     'func' :  sim_rdcycle
}
spec['nanorv32']['rv32i']['simu']['inst']['rdcycleh'] = {
     'func' :  sim_rdcycleh
}
spec['nanorv32']['rv32i']['simu']['inst']['rdinstret'] = {
     'func' :  sim_rdinstret
}
spec['nanorv32']['rv32i']['simu']['inst']['rdinstreth'] = {
     'func' :  sim_rdinstreth
}
