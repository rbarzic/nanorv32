//****************************************************************************/
//  Nanorv32 CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Tue Jan 19 21:01:45 2016
//
//  This program is free software; you can redistribute it and/or
//  modify it under the terms of the GNU General Public License
//  as published by the Free Software Foundation; either version 2
//  of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,MA 02110-1301,USA.
//
//
//  Filename        :  nanorv32_parameters.v
//
//  Description     :  Parameter file for the nanorv32 core
//
//
//
//****************************************************************************/



parameter NANORV32_ADDR_SIZE=16; // 64K
parameter NANORV32_ADDR_MSB = NANORV32_ADDR_SIZE-1;

parameter NANORV32_DATA_SIZE=32;
parameter NANORV32_DATA_MSB = NANORV32_DATA_SIZE-1;

// 32-bit instruction only for now
parameter NANORV32_INSTRUCTION_SIZE = 32;
parameter NANORV32_INSTRUCTION_MSB = NANORV32_INSTRUCTION_SIZE -1;



// Regidter file selector size
// 32 registers
parameter NANORV32_RF_PORTA_SIZE = 5;
parameter NANORV32_RF_PORTA_MSB = NANORV32_RF_PORTA_SIZE-1;
parameter NANORV32_RF_PORTB_SIZE = 5;
parameter NANORV32_RF_PORTB_MSB = NANORV32_RF_PORTB_SIZE-1;
parameter NANORV32_RF_PORTRD_SIZE = 5;
parameter NANORV32_RF_PORTRD_MSB = NANORV32_RF_PORTRD_SIZE-1;



//@begin[instruction_format]

// Instruction opcode1
parameter NANORV32_INST_FORMAT_OPCODE1_OFFSET = 0;
parameter NANORV32_INST_FORMAT_OPCODE1_SIZE = 7;
parameter NANORV32_INST_FORMAT_OPCODE1_MSB = 6;

// Instruction func3
parameter NANORV32_INST_FORMAT_FUNC3_OFFSET = 12;
parameter NANORV32_INST_FORMAT_FUNC3_SIZE = 3;
parameter NANORV32_INST_FORMAT_FUNC3_MSB = 2;

// Instruction func7
parameter NANORV32_INST_FORMAT_FUNC7_OFFSET = 25;
parameter NANORV32_INST_FORMAT_FUNC7_SIZE = 7;
parameter NANORV32_INST_FORMAT_FUNC7_MSB = 6;

// Instruction rd
parameter NANORV32_INST_FORMAT_RD_OFFSET = 7;
parameter NANORV32_INST_FORMAT_RD_SIZE = 5;
parameter NANORV32_INST_FORMAT_RD_MSB = 4;

// Instruction rs1
parameter NANORV32_INST_FORMAT_RS1_OFFSET = 15;
parameter NANORV32_INST_FORMAT_RS1_SIZE = 5;
parameter NANORV32_INST_FORMAT_RS1_MSB = 4;

// Instruction rs2
parameter NANORV32_INST_FORMAT_RS2_OFFSET = 20;
parameter NANORV32_INST_FORMAT_RS2_SIZE = 5;
parameter NANORV32_INST_FORMAT_RS2_MSB = 4;

// Instruction imm12
parameter NANORV32_INST_FORMAT_IMM12_OFFSET = 20;
parameter NANORV32_INST_FORMAT_IMM12_SIZE = 12;
parameter NANORV32_INST_FORMAT_IMM12_MSB = 11;

// Instruction imm12hi
parameter NANORV32_INST_FORMAT_IMM12HI_OFFSET = 25;
parameter NANORV32_INST_FORMAT_IMM12HI_SIZE = 7;
parameter NANORV32_INST_FORMAT_IMM12HI_MSB = 6;

// Instruction imm12lo
parameter NANORV32_INST_FORMAT_IMM12LO_OFFSET = 7;
parameter NANORV32_INST_FORMAT_IMM12LO_SIZE = 5;
parameter NANORV32_INST_FORMAT_IMM12LO_MSB = 4;

// Instruction immsb2
parameter NANORV32_INST_FORMAT_IMMSB2_OFFSET = 25;
parameter NANORV32_INST_FORMAT_IMMSB2_SIZE = 7;
parameter NANORV32_INST_FORMAT_IMMSB2_MSB = 6;

// Instruction immsb1
parameter NANORV32_INST_FORMAT_IMMSB1_OFFSET = 7;
parameter NANORV32_INST_FORMAT_IMMSB1_SIZE = 5;
parameter NANORV32_INST_FORMAT_IMMSB1_MSB = 4;

// Instruction imm20
parameter NANORV32_INST_FORMAT_IMM20_OFFSET = 12;
parameter NANORV32_INST_FORMAT_IMM20_SIZE = 20;
parameter NANORV32_INST_FORMAT_IMM20_MSB = 19;

// Instruction imm20uj
parameter NANORV32_INST_FORMAT_IMM20UJ_OFFSET = 12;
parameter NANORV32_INST_FORMAT_IMM20UJ_SIZE = 20;
parameter NANORV32_INST_FORMAT_IMM20UJ_MSB = 19;

// Instruction shamt
parameter NANORV32_INST_FORMAT_SHAMT_OFFSET = 10;
parameter NANORV32_INST_FORMAT_SHAMT_SIZE = 5;
parameter NANORV32_INST_FORMAT_SHAMT_MSB = 4;

// Instruction func4
parameter NANORV32_INST_FORMAT_FUNC4_OFFSET = 28;
parameter NANORV32_INST_FORMAT_FUNC4_SIZE = 4;
parameter NANORV32_INST_FORMAT_FUNC4_MSB = 3;

// Instruction func12
parameter NANORV32_INST_FORMAT_FUNC12_OFFSET = 20;
parameter NANORV32_INST_FORMAT_FUNC12_SIZE = 12;
parameter NANORV32_INST_FORMAT_FUNC12_MSB = 11;
//@end[instruction_format]

//@begin[inst_decode_definitions]
parameter NANORV32_DECODE_AND = 32'b0000000??????????111?????0110011;
parameter NANORV32_DECODE_LBU = 32'b?????????????????100?????0000011;
parameter NANORV32_DECODE_FENCE = 32'b0000????????00000000?????0001111;
parameter NANORV32_DECODE_SLTI = 32'b?????????????????010?????0010011;
parameter NANORV32_DECODE_BLTU = 32'b?????????????????110?????1100011;
parameter NANORV32_DECODE_XOR = 32'b0000000??????????100?????0110011;
parameter NANORV32_DECODE_SLL = 32'b0000000??????????001?????0110011;
parameter NANORV32_DECODE_LD = 32'b?????????????????011?????0000011;
parameter NANORV32_DECODE_ANDI = 32'b?????????????????111?????0010011;
parameter NANORV32_DECODE_JALR = 32'b?????????????????000?????1100111;
parameter NANORV32_DECODE_BLT = 32'b?????????????????100?????1100011;
parameter NANORV32_DECODE_SCALL = 32'b00000000000000000000?????1110011;
parameter NANORV32_DECODE_FENCE_I = 32'b0000????????00000001?????0001111;
parameter NANORV32_DECODE_ADD = 32'b0000000??????????000?????0110011;
parameter NANORV32_DECODE_LWU = 32'b?????????????????110?????0000011;
parameter NANORV32_DECODE_LW = 32'b?????????????????010?????0000011;
parameter NANORV32_DECODE_JAL = 32'b?????????????????????????1101111;
parameter NANORV32_DECODE_AUIPC = 32'b?????????????????????????0010111;
parameter NANORV32_DECODE_LUI = 32'b?????????????????????????0110111;
parameter NANORV32_DECODE_ADDI = 32'b?????????????????000?????0010011;
parameter NANORV32_DECODE_SBREAK = 32'b00000000000100000000?????1110011;
parameter NANORV32_DECODE_BGEU = 32'b?????????????????111?????1100011;
parameter NANORV32_DECODE_SLTIU = 32'b?????????????????011?????0010011;
parameter NANORV32_DECODE_SRAI = 32'b0010000??????????101?????0010011;
parameter NANORV32_DECODE_ORI = 32'b?????????????????110?????0010011;
parameter NANORV32_DECODE_XORI = 32'b?????????????????100?????0010011;
parameter NANORV32_DECODE_LB = 32'b?????????????????000?????0000011;
parameter NANORV32_DECODE_SUB = 32'b0100000??????????000?????0110011;
parameter NANORV32_DECODE_SRA = 32'b0100000??????????101?????0110011;
parameter NANORV32_DECODE_BGE = 32'b?????????????????101?????1100011;
parameter NANORV32_DECODE_SLT = 32'b0000000??????????010?????0110011;
parameter NANORV32_DECODE_SRLI = 32'b0000000??????????101?????0010011;
parameter NANORV32_DECODE_SW = 32'b?????????????????010?????0100011;
parameter NANORV32_DECODE_SRL = 32'b0000000??????????101?????0110011;
parameter NANORV32_DECODE_SLTU = 32'b0000000??????????011?????0110011;
parameter NANORV32_DECODE_LHU = 32'b?????????????????101?????0000011;
parameter NANORV32_DECODE_SH = 32'b?????????????????001?????0100011;
parameter NANORV32_DECODE_SLLI = 32'b0000000??????????001?????0010011;
parameter NANORV32_DECODE_BNE = 32'b?????????????????001?????1100011;
parameter NANORV32_DECODE_SB = 32'b?????????????????000?????0100011;
parameter NANORV32_DECODE_BEQ = 32'b?????????????????000?????1100011;
parameter NANORV32_DECODE_OR = 32'b0000000??????????110?????0110011;
parameter NANORV32_DECODE_SD = 32'b?????????????????011?????0100011;
//@end[inst_decode_definitions]

//@begin[mux_select_definitions]
// Mux definitions for pc

//  pc_next

parameter NANORV32_MUX_SEL_PC_NEXT_SIZE = 2;
parameter NANORV32_MUX_SEL_PC_NEXT_MSB = 1;
 
parameter NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB = 0;
parameter NANORV32_MUX_SEL_PC_NEXT_PLUS4 = 1;
parameter NANORV32_MUX_SEL_PC_NEXT_ALU_RES = 2;
// Mux definitions for alu

//  alu_op

parameter NANORV32_MUX_SEL_ALU_OP_SIZE = 4;
parameter NANORV32_MUX_SEL_ALU_OP_MSB = 3;
 
parameter NANORV32_MUX_SEL_ALU_OP_AND = 0;
parameter NANORV32_MUX_SEL_ALU_OP_XOR = 1;
parameter NANORV32_MUX_SEL_ALU_OP_SUB = 2;
parameter NANORV32_MUX_SEL_ALU_OP_LT_SIGNED = 3;
parameter NANORV32_MUX_SEL_ALU_OP_GE_UNSIGNED = 4;
parameter NANORV32_MUX_SEL_ALU_OP_NOP = 5;
parameter NANORV32_MUX_SEL_ALU_OP_ARSHIFT = 6;
parameter NANORV32_MUX_SEL_ALU_OP_GE_SIGNED = 7;
parameter NANORV32_MUX_SEL_ALU_OP_LT_UNSIGNED = 8;
parameter NANORV32_MUX_SEL_ALU_OP_ADD = 9;
parameter NANORV32_MUX_SEL_ALU_OP_NOOP = 10;
parameter NANORV32_MUX_SEL_ALU_OP_LSHIFT = 11;
parameter NANORV32_MUX_SEL_ALU_OP_RSHIFT = 12;
parameter NANORV32_MUX_SEL_ALU_OP_EQ = 13;
parameter NANORV32_MUX_SEL_ALU_OP_OR = 14;
parameter NANORV32_MUX_SEL_ALU_OP_NEQ = 15;
//  alu_portb

parameter NANORV32_MUX_SEL_ALU_PORTB_SIZE = 3;
parameter NANORV32_MUX_SEL_ALU_PORTB_MSB = 2;
 
parameter NANORV32_MUX_SEL_ALU_PORTB_SHAMT = 0;
parameter NANORV32_MUX_SEL_ALU_PORTB_IMM12 = 1;
parameter NANORV32_MUX_SEL_ALU_PORTB_IMM12HILO = 2;
parameter NANORV32_MUX_SEL_ALU_PORTB_IMM20U = 3;
parameter NANORV32_MUX_SEL_ALU_PORTB_IMM20UJ = 4;
parameter NANORV32_MUX_SEL_ALU_PORTB_RS2 = 5;
//  alu_porta

parameter NANORV32_MUX_SEL_ALU_PORTA_SIZE = 1;
parameter NANORV32_MUX_SEL_ALU_PORTA_MSB = 0;
 
parameter NANORV32_MUX_SEL_ALU_PORTA_PC_EXE = 0;
parameter NANORV32_MUX_SEL_ALU_PORTA_RS1 = 1;
// Mux definitions for datamem

//  datamem_write

parameter NANORV32_MUX_SEL_DATAMEM_WRITE_SIZE = 2;
parameter NANORV32_MUX_SEL_DATAMEM_WRITE_MSB = 1;
 
parameter NANORV32_MUX_SEL_DATAMEM_WRITE_YES = 0;
parameter NANORV32_MUX_SEL_DATAMEM_WRITE_WORD = 1;
parameter NANORV32_MUX_SEL_DATAMEM_WRITE_NO = 2;
//  datamem_read

parameter NANORV32_MUX_SEL_DATAMEM_READ_SIZE = 1;
parameter NANORV32_MUX_SEL_DATAMEM_READ_MSB = 0;
 
parameter NANORV32_MUX_SEL_DATAMEM_READ_YES = 0;
parameter NANORV32_MUX_SEL_DATAMEM_READ_NO = 1;
// Mux definitions for regfile

//  regfile_source

parameter NANORV32_MUX_SEL_REGFILE_SOURCE_SIZE = 1;
parameter NANORV32_MUX_SEL_REGFILE_SOURCE_MSB = 0;
 
parameter NANORV32_MUX_SEL_REGFILE_SOURCE_PC_NEXT = 0;
parameter NANORV32_MUX_SEL_REGFILE_SOURCE_ALU = 1;
//  regfile_write

parameter NANORV32_MUX_SEL_REGFILE_WRITE_SIZE = 1;
parameter NANORV32_MUX_SEL_REGFILE_WRITE_MSB = 0;
 
parameter NANORV32_MUX_SEL_REGFILE_WRITE_YES = 0;
parameter NANORV32_MUX_SEL_REGFILE_WRITE_NO = 1;
//@end[mux_select_definitions]

// For the ALU shift amount (inputed on ALU port B)
parameter NANORV32_SHAMT_FILL = NANORV32_DATA_SIZE-NANORV32_INST_FORMAT_SHAMT_SIZE;



// state machine for the "pipeline" (fetch + executuion stages)

parameter NANORV32_PSTATE_BITS = 2;
parameter NANORV32_PSTATE_MSB = NANORV32_PSTATE_BITS - 1;

parameter NANORV32_PSTATE_RESET=0;
parameter NANORV32_PSTATE_CONT=1;
parameter NANORV32_PSTATE_BRANCH=2;

parameter NANORV32_J0_INSTRUCTION = 32'b00000000_00000000_00000000_01101111;
