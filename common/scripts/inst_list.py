import string
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


inst_tpl= """
spec['nanorv32']['rv32i']['impl']['inst']['{inst_name}'] = {{

}}

"""

txt = ""
for k,v in inst_types_rv32i.items():
    for inst in v:
        d = dict()
        d['inst_name'] = inst
        txt += inst_tpl.format(**d)
print(txt)
