#!/usr/bin/env python
import argparse
import re
import string
import pprint as pp

opcodes_args = ['rd', 'rs1', 'rs2', 'rs3', 'imm20', 'imm12', 'imm12lo', 'imm12hi', 'shamtw', 'shamt', 'rm', 'bimm12lo', 'bimm12hi']



inst_types_rv32i = {
    'R-type' : ['add','sub','sll','slt','sltu','xor','srl','sra','or','and'],
    'I-type' : ['jalr','addi','ssli','slti','sltiu','xori','srli','srai','ori','andi',
                'lb','lu','lw','ld','lbu','lwu','lhu'],
    'S-type' : ['sb','sh','sw','sd'],
    'SB-type' : ['beq','bne','blt','bge','bltu','bgeu'],
    'U-type' : ['lui','auipc'],
    'UJ-type' : ['jal'],
    'SYS-type': ['scall','sbreak'],
    'F-type': ['fence','fence.i'],
    'AS-type': ['slli','slti','srli','srai'],
}


tpl_r_type = """
spec['nanorv32']['rv32i']['{inst_name}']['desc'] = {{
    'inst_type' : 'R-type',
    'decode' : {{
        'opcode1' : '{opcode1}',
        'func3'   : '{func3}',
        'func7'   : '{func7}'
    }}
}}"""

tpl_i_type = """
spec['nanorv32']['rv32i']['{inst_name}']['desc'] = {{
    'inst_type' : 'I-type',
    'decode' : {{
        'opcode1' : '{opcode1}',
        'func3'   : '{func3}'
    }}
}}"""


tpl_u_type = """
spec['nanorv32']['rv32i']['{inst_name}']['desc'] = {{
    'inst_type' : 'U-type',
    'decode' : {{
        'opcode1' : '{opcode1}'
    }}
}}"""

tpl_uj_type = """
spec['nanorv32']['rv32i']['{inst_name}']['desc'] = {{
    'inst_type' : 'UJ-type',
    'decode' : {{
        'opcode1' : '{opcode1}'
    }}
}}"""

tpl_s_type = """
spec['nanorv32']['rv32i']['{inst_name}']['desc'] = {{
    'inst_type' : 'S-type',
    'decode' : {{
        'opcode1' : '{opcode1}',
        'func3'   : '{func3}'
    }}
}}"""

tpl_sb_type = """
spec['nanorv32']['rv32i']['{inst_name}']['desc'] = {{
    'inst_type' : 'SB-type',
    'decode' : {{
        'opcode1' : '{opcode1}',
        'func3'   : '{func3}'
    }}
}}"""


def revert_inst_dic(d):
    """Return a dictionary indexed by instruction"""
    r = dict()
    for k,v in d.items():
        for i in v:
            r[i] = k
    return r

def r_type_opcode(line):
    r_type = re.compile(r'(\S+)\s+rd\s+rs1\s+rs2\s+31\.\.25=(\S+)\s+14\.\.12=(\S+)\s+6\.\.2=(\S+)\s+1\.\.0=(\S+)')
    matchObj = r_type.match(line)
    return matchObj

def r_type_opcode_parse(matchObj):
    d = dict()
    if matchObj:
        print "# -I-       R-type match found " + matchObj.group(1) + " " + matchObj.group(2) + " " + matchObj.group(3) + " " + matchObj.group(4) + " " + matchObj.group(5) + " "
        opcode1 = int(matchObj.group(4),0)*4 + int(matchObj.group(5),0)
        func3   = int(matchObj.group(3),0)
        func7   = int(matchObj.group(2),0)
        d['opcode1'] = bin(opcode1)
        d['func3'] = bin(func3)
        d['func7'] = bin(func7)
        d['inst_name'] = matchObj.group(1)
        # pp.pprint(d)
        return d
    else:
        return None

def i_type_opcode(line):

    i_type = re.compile(r'(\S+)\s+rd\s+rs1\s+imm12\s+14\.\.12=(\S+)\s+6\.\.2=(\S+)\s+1\.\.0=(\S+)')
    matchObj = i_type.match(line)
    return matchObj

def i_type_opcode_parse(matchObj):
    d = dict()
    if matchObj:
        print "# -I-        I-type  match found " + matchObj.group(1) + " " + matchObj.group(2) + " " + matchObj.group(3) + " " + matchObj.group(4)
        opcode1 = int(matchObj.group(3),0)*4 + int(matchObj.group(4),0)
        func3   = int(matchObj.group(2),0)
        d['opcode1'] = bin(opcode1)
        d['func3'] = bin(func3)
        d['inst_name'] = matchObj.group(1)
        # pp.pprint(d)
        return d
    else:
        return None


def s_type_opcode(line):

    s_type = re.compile(r'(\S+)\s+imm12hi\s+rs1\s+rs2\s+imm12lo\s+14\.\.12=(\S+)\s+6\.\.2=(\S+)\s+1\.\.0=(\S+)')
    matchObj = s_type.match(line)
    return matchObj

def s_type_opcode_parse(matchObj):
    d = dict()
    if matchObj:
        print "# -I-        S-type  match found " + matchObj.group(1) + " " + matchObj.group(2) + " " + matchObj.group(3) + " " + matchObj.group(4)
        opcode1 = int(matchObj.group(3),0)*4 + int(matchObj.group(4),0)
        func3   = int(matchObj.group(2),0)
        d['opcode1'] = bin(opcode1)
        d['func3'] = bin(func3)
        d['inst_name'] = matchObj.group(1)
        # pp.pprint(d)
        return d
    else:
        return None



def sb_type_opcode(line):
    sb_type = re.compile(r'(\S+)\s+bimm12hi\s+rs1\s+rs2\s+bimm12lo\s+14\.\.12=(\S+)\s+6\.\.2=(\S+)\s+1\.\.0=(\S+)')
    matchObj = sb_type.match(line)
    return matchObj

def sb_type_opcode_parse(matchObj):
    d = dict()
    if matchObj:
        print "# -I-        SB-type  match found " + matchObj.group(1) + " " + matchObj.group(2) + " " + matchObj.group(3) + " " + matchObj.group(4)
        opcode1 = int(matchObj.group(3),0)*4 + int(matchObj.group(4),0)
        func3   = int(matchObj.group(2),0)
        d['opcode1'] = bin(opcode1)
        d['func3'] = bin(func3)
        d['inst_name'] = matchObj.group(1)
        # pp.pprint(d)
        return d
    else:
        return None


def u_type_opcode(line):
    u_type = re.compile(r'(\S+)\s+rd\s+imm20\s+6\.\.2=(\S+)\s+1\.\.0=(\S+)')
    matchObj = u_type.match(line)
    return matchObj

def u_type_opcode_parse(matchObj):
    d = dict()
    if matchObj:
        print "# -I-        U-type  match found " + matchObj.group(1) + " " + matchObj.group(2) + " " + matchObj.group(3)
        opcode1 = int(matchObj.group(2),0)*4 + int(matchObj.group(3),0)
        d['opcode1'] = bin(opcode1)
        d['inst_name'] = matchObj.group(1)
        # pp.pprint(d)
        return d
    else:
        return None


def uj_type_opcode(line):

    uj_type = re.compile(r'(\S+)\s+rd\s+jimm20\s+6\.\.2=(\S+)\s+1\.\.0=(\S+)')
    matchObj = uj_type.match(line)
    return matchObj

def uj_type_opcode_parse(matchObj):
    d = dict()
    if matchObj:
        print "# -I-        UJ-type  match found " + matchObj.group(1) + " " + matchObj.group(2) + " " + matchObj.group(3)
        opcode1 = int(matchObj.group(2),0)*4 + int(matchObj.group(3),0)
        d['opcode1'] = bin(opcode1)
        d['inst_name'] = matchObj.group(1)
        # pp.pprint(d)
        return d
    else:
        return None

def as_type_opcode(line):

    as_type = re.compile(r'(\S+)\s+rd\s+rs1\s+31\.\.26=(\S+)\s+shamt\s+14\.\.12=(\S+)\s+6\.\.2=(\S+)\s+1\.\.0=(\S+)')
    matchObj = as_type.match(line)
    return matchObj

def as_type_opcode_parse(matchObj):
    d = dict()
    if matchObj:
        print "# -I-        AS-type  match found " + matchObj.group(1) + " " + matchObj.group(2) + " " + matchObj.group(3) + " " + matchObj.group(4) + " " + matchObj.group(5)




def get_args():
    """
    Get command line arguments
    """

    parser = argparse.ArgumentParser(description="""
    Parse opcodes for Risc-V intructions, output python data structure
                   """)
    parser.add_argument('--opcodes', action='store', dest='opcodes',
                        help='opcode file')

    parser.add_argument('--version', action='version', version='%(prog)s 0.1')

    return parser.parse_args()


if __name__ == '__main__':
    p = re.compile(r'\s*(?P<parameter>parameter)\s*(?P<name>\S+)\s*=\s*(?P<value>\S+)')
    args = get_args()
    insts = dict()
    type_inst_d  = revert_inst_dic(inst_types_rv32i)

    with open(args.opcodes) as f:
        lines = filter(None, (line.rstrip() for line in f))
        for line in lines:
            if line[0] != '#':

                # print ">" + line.strip('\n') + "<"
                items = string.split(line)
                # print items
                inst_name = items[0]
                type_inst = type_inst_d.get(inst_name,None)
                if type_inst is None:
                    # print "-E Unrecognized instruction : " +  inst_name
                    pass
                else:
                    print "#-I inst : " + inst_name + " of type " + type_inst
                    # R-Type instructions
                    m = r_type_opcode(line)
                    if m:
                        d = r_type_opcode_parse(m)
                        txt = tpl_r_type.format(**d)
                        print(txt)
                    # I-Type instructions
                    m = i_type_opcode(line)
                    if m:
                        d = i_type_opcode_parse(m)
                        txt = tpl_i_type.format(**d)
                        print(txt)
                    # S-Type instructions
                    m = s_type_opcode(line)
                    if m:
                        d = s_type_opcode_parse(m)
                        txt = tpl_s_type.format(**d)
                        print(txt)
                    # SB-Type instructions
                    m = sb_type_opcode(line)
                    if m:
                        d = sb_type_opcode_parse(m)
                        txt = tpl_sb_type.format(**d)
                        print(txt)
                    # U-Type instructions
                    m = u_type_opcode(line)
                    if m:
                        d = u_type_opcode_parse(m)
                        txt = tpl_u_type.format(**d)
                        print(txt)
                    # UJ-Type instructions
                    m = uj_type_opcode(line)
                    if m:
                        d = uj_type_opcode_parse(m)
                        txt = tpl_uj_type.format(**d)
                        print(txt)
                    m = as_type_opcode(line)
                    if m:
                        as_type_opcode_parse(m)



                #fields = []
                #i = 1
                #while items[i] in opcodes_args:
                #    d = dict()
                #    d['args'] = items[i]
                #    fields.append(d)
                #    i += 1
                #insts[inst_name] = fields


    pp.pprint(insts)

    pp.pprint(type_inst)
            #m = p.search(line.strip('\n'))
            #if m is not None:
            #    d = dict()
            #    d['name'] = m.group('name')
            #    d['value'] = m.group('value')
            #    print parameter_tpl.format(**d)
