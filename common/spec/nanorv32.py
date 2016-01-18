#!/usr/bin/python
# -*- coding: utf-8 -*-
import AutoVivification as av
spec = av.AutoVivification()

spec['nanorv32']['cpu']['num_std_regs'] = 32

spec['nanorv32']['cpu']['special_regs'] = 'npc'
spec['nanorv32']['cpu']['endianess'] = 'little'
spec['nanorv32']['cpu']['wordsize'] = '32'

# {{{ Instruction format

spec['nanorv32']['inst_type']['R-type']['format'] = {
    'opcode1': {'size': 7, 'offset': 0, 'decode': True},
    'rd': {'size': 5, 'offset': 7},
    'rs1': {'size': 5, 'offset': 15},
    'rs2': {'size': 5, 'offset': 10},
    'func3': {'size': 12, 'offset': 3, 'decode': True},
    'func7': {'size': 7, 'offset': 25, 'decode': True},
    }

spec['nanorv32']['inst_type']['I-type']['format'] = {

    'opcode1': {'size': 7, 'offset': 0, 'decode': True},
    'rd': {'size': 5, 'offset': 7},
    'rs1': {'size': 5, 'offset': 15},
    'imm12': {'size': 12, 'offset': 25},
    'func3': {'size': 12, 'offset': 3, 'decode': True},
    }

spec['nanorv32']['inst_type']['S-type']['format'] = {

    'opcode1': {'size': 7, 'offset': 0, 'decode': True},
    'imm12lo': {'size': 5, 'offset': 7},
    'rs1': {'size': 5, 'offset': 15},
    'rs2': {'size': 5, 'offset': 10},
    'func3': {'size': 12, 'offset': 3, 'decode': True},
    'imm12hi': {'size': 7, 'offset': 25},
    }

spec['nanorv32']['inst_type']['SB-type']['format'] = {

    'opcode1': {'size': 7, 'offset': 0, 'decode': True},
    'immsb1': {'size': 5, 'offset': 7},
    'rs1': {'size': 5, 'offset': 15},
    'rs2': {'size': 5, 'offset': 10},
    'func3': {'size': 12, 'offset': 3, 'decode': True},
    'immsb2': {'size': 7, 'offset': 25},
    }

spec['nanorv32']['inst_type']['U-type']['format'] = \
    {'opcode1': {'size': 7, 'offset': 0, 'decode': True},
     'rd': {'size': 5, 'offset': 7},
     'imm20': {'size': 20,
               'offset': 12}}  # Field is used for decoding

spec['nanorv32']['inst_type']['UJ-type']['format'] = \
    {'opcode1': {'size': 7, 'offset': 0, 'decode': True},
     'rd': {'size': 5, 'offset': 7},
     'imm2uj': {'size': 20,
                'offset': 12}}  # Field is used for decoding

# ALU shift format

spec['nanorv32']['inst_type']['AS-type']['format'] = {
    'opcode1': {'size': 7, 'offset': 0, 'decode': True},
    'rd': {'size': 5, 'offset': 7},
    'rs1': {'size': 5, 'offset': 15},
    'shamt': {'size': 5, 'offset': 10},
    'func3': {'size': 12, 'offset': 3, 'decode': True},
    'func7': {'size': 7, 'offset': 25, 'decode': True},
    }


# Fence-format

spec['nanorv32']['inst_type']['F-type']['format'] = {
    'opcode1': {'size': 7, 'offset': 0, 'decode': True},
    'rd': {'size': 5, 'offset': 7},
    'rs1': {'size': 5, 'offset': 15},
    'shamt': {'size': 5, 'offset': 10},
    'func3': {'size': 12, 'offset': 3, 'decode': True},
    'func7': {'size': 7, 'offset': 25, 'decode': True},
    }

# System format

spec['nanorv32']['inst_type']['SYS-type']['format'] = {
    'opcode1': {'size': 7, 'offset': 0, 'decode': True},
    'rd': {'size': 5, 'offset': 7},
    'rs1': {'size': 5, 'offset': 15},
    'func3': {'size': 12, 'offset': 3, 'decode': True},
    'func12': {'size': 12, 'offset': 20, 'decode': True},
    }


spec['nanorv32']['rv32i']['lui']['spec'] = {
    'inst_type' : 'U-type',
    'description' : "",
    'syntax' : "LUI rd,imm"
    'decode' : {
        'opcode1' : '0b0110111'
    }
}

spec['nanorv32']['rv32i']['auipc']['spec'] = {
    'inst_type' : 'U-type',
    'description' : "",
    'syntax' : "AUIPC rd,imm"
    'decode' : {
        'opcode10b' : '0010111'
    }
}

spec['nanorv32']['rv32i']['']['spec'] = {
    'inst_type' : '-type',
    'description' : "",
    'syntax' : ""
    'decode' : {
        'opcode1' : '0010111'
    }
}
