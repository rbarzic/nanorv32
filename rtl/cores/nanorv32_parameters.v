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


parameter NANORV32_PERIPH_ADDR_SIZE=16; // 64K
parameter NANORV32_PERIPH_ADDR_MSB = NANORV32_PERIPH_ADDR_SIZE-1;


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
parameter NANORV32_INST_FORMAT_SHAMT_OFFSET = 20;
parameter NANORV32_INST_FORMAT_SHAMT_SIZE = 5;
parameter NANORV32_INST_FORMAT_SHAMT_MSB = 4;

// Instruction sys2_rs1
parameter NANORV32_INST_FORMAT_SYS2_RS1_OFFSET = 15;
parameter NANORV32_INST_FORMAT_SYS2_RS1_SIZE = 5;
parameter NANORV32_INST_FORMAT_SYS2_RS1_MSB = 4;

// Instruction sys1_rd
parameter NANORV32_INST_FORMAT_SYS1_RD_OFFSET = 7;
parameter NANORV32_INST_FORMAT_SYS1_RD_SIZE = 5;
parameter NANORV32_INST_FORMAT_SYS1_RD_MSB = 4;

// Instruction func12
parameter NANORV32_INST_FORMAT_FUNC12_OFFSET = 20;
parameter NANORV32_INST_FORMAT_FUNC12_SIZE = 12;
parameter NANORV32_INST_FORMAT_FUNC12_MSB = 11;

// Instruction opcodervc
parameter NANORV32_INST_FORMAT_OPCODERVC_OFFSET = 0;
parameter NANORV32_INST_FORMAT_OPCODERVC_SIZE = 2;
parameter NANORV32_INST_FORMAT_OPCODERVC_MSB = 1;

// Instruction hint_rvc_rd_rs1_is_two
parameter NANORV32_INST_FORMAT_HINT_RVC_RD_RS1_IS_TWO_OFFSET = 33;
parameter NANORV32_INST_FORMAT_HINT_RVC_RD_RS1_IS_TWO_SIZE = 1;
parameter NANORV32_INST_FORMAT_HINT_RVC_RD_RS1_IS_TWO_MSB = 0;

// Instruction hint_rvc_rd_rs1_is_zero
parameter NANORV32_INST_FORMAT_HINT_RVC_RD_RS1_IS_ZERO_OFFSET = 32;
parameter NANORV32_INST_FORMAT_HINT_RVC_RD_RS1_IS_ZERO_SIZE = 1;
parameter NANORV32_INST_FORMAT_HINT_RVC_RD_RS1_IS_ZERO_MSB = 0;

// Instruction c_func4
parameter NANORV32_INST_FORMAT_C_FUNC4_OFFSET = 12;
parameter NANORV32_INST_FORMAT_C_FUNC4_SIZE = 4;
parameter NANORV32_INST_FORMAT_C_FUNC4_MSB = 3;

// Instruction hint_rvc_rs2_is_zero
parameter NANORV32_INST_FORMAT_HINT_RVC_RS2_IS_ZERO_OFFSET = 34;
parameter NANORV32_INST_FORMAT_HINT_RVC_RS2_IS_ZERO_SIZE = 1;
parameter NANORV32_INST_FORMAT_HINT_RVC_RS2_IS_ZERO_MSB = 0;

// Instruction c_rs2
parameter NANORV32_INST_FORMAT_C_RS2_OFFSET = 2;
parameter NANORV32_INST_FORMAT_C_RS2_SIZE = 5;
parameter NANORV32_INST_FORMAT_C_RS2_MSB = 4;

// Instruction c_rd_rs1
parameter NANORV32_INST_FORMAT_C_RD_RS1_OFFSET = 7;
parameter NANORV32_INST_FORMAT_C_RD_RS1_SIZE = 5;
parameter NANORV32_INST_FORMAT_C_RD_RS1_MSB = 4;

// Instruction c_func3
parameter NANORV32_INST_FORMAT_C_FUNC3_OFFSET = 13;
parameter NANORV32_INST_FORMAT_C_FUNC3_SIZE = 3;
parameter NANORV32_INST_FORMAT_C_FUNC3_MSB = 2;

// Instruction ci_immlo
parameter NANORV32_INST_FORMAT_CI_IMMLO_OFFSET = 2;
parameter NANORV32_INST_FORMAT_CI_IMMLO_SIZE = 5;
parameter NANORV32_INST_FORMAT_CI_IMMLO_MSB = 4;

// Instruction ci_immhi
parameter NANORV32_INST_FORMAT_CI_IMMHI_OFFSET = 12;
parameter NANORV32_INST_FORMAT_CI_IMMHI_SIZE = 1;
parameter NANORV32_INST_FORMAT_CI_IMMHI_MSB = 0;

// Instruction css_imm
parameter NANORV32_INST_FORMAT_CSS_IMM_OFFSET = 7;
parameter NANORV32_INST_FORMAT_CSS_IMM_SIZE = 6;
parameter NANORV32_INST_FORMAT_CSS_IMM_MSB = 5;

// Instruction ciw_imm
parameter NANORV32_INST_FORMAT_CIW_IMM_OFFSET = 5;
parameter NANORV32_INST_FORMAT_CIW_IMM_SIZE = 8;
parameter NANORV32_INST_FORMAT_CIW_IMM_MSB = 7;

// Instruction c_rd_p
parameter NANORV32_INST_FORMAT_C_RD_P_OFFSET = 2;
parameter NANORV32_INST_FORMAT_C_RD_P_SIZE = 3;
parameter NANORV32_INST_FORMAT_C_RD_P_MSB = 2;

// Instruction c_rs1_p
parameter NANORV32_INST_FORMAT_C_RS1_P_OFFSET = 7;
parameter NANORV32_INST_FORMAT_C_RS1_P_SIZE = 3;
parameter NANORV32_INST_FORMAT_C_RS1_P_MSB = 2;

// Instruction cl_immlo
parameter NANORV32_INST_FORMAT_CL_IMMLO_OFFSET = 5;
parameter NANORV32_INST_FORMAT_CL_IMMLO_SIZE = 2;
parameter NANORV32_INST_FORMAT_CL_IMMLO_MSB = 1;

// Instruction cl_immhi
parameter NANORV32_INST_FORMAT_CL_IMMHI_OFFSET = 10;
parameter NANORV32_INST_FORMAT_CL_IMMHI_SIZE = 3;
parameter NANORV32_INST_FORMAT_CL_IMMHI_MSB = 2;

// Instruction cs_immlo
parameter NANORV32_INST_FORMAT_CS_IMMLO_OFFSET = 5;
parameter NANORV32_INST_FORMAT_CS_IMMLO_SIZE = 2;
parameter NANORV32_INST_FORMAT_CS_IMMLO_MSB = 1;

// Instruction c_rs2_p
parameter NANORV32_INST_FORMAT_C_RS2_P_OFFSET = 2;
parameter NANORV32_INST_FORMAT_C_RS2_P_SIZE = 3;
parameter NANORV32_INST_FORMAT_C_RS2_P_MSB = 2;

// Instruction cs_immhi
parameter NANORV32_INST_FORMAT_CS_IMMHI_OFFSET = 10;
parameter NANORV32_INST_FORMAT_CS_IMMHI_SIZE = 3;
parameter NANORV32_INST_FORMAT_CS_IMMHI_MSB = 2;

// Instruction cb_offset_lo
parameter NANORV32_INST_FORMAT_CB_OFFSET_LO_OFFSET = 2;
parameter NANORV32_INST_FORMAT_CB_OFFSET_LO_SIZE = 5;
parameter NANORV32_INST_FORMAT_CB_OFFSET_LO_MSB = 4;

// Instruction cb_offset_hi
parameter NANORV32_INST_FORMAT_CB_OFFSET_HI_OFFSET = 10;
parameter NANORV32_INST_FORMAT_CB_OFFSET_HI_SIZE = 3;
parameter NANORV32_INST_FORMAT_CB_OFFSET_HI_MSB = 2;

// Instruction cj_imm
parameter NANORV32_INST_FORMAT_CJ_IMM_OFFSET = 2;
parameter NANORV32_INST_FORMAT_CJ_IMM_SIZE = 11;
parameter NANORV32_INST_FORMAT_CJ_IMM_MSB = 10;

// Instruction c_func2
parameter NANORV32_INST_FORMAT_C_FUNC2_OFFSET = 10;
parameter NANORV32_INST_FORMAT_C_FUNC2_SIZE = 2;
parameter NANORV32_INST_FORMAT_C_FUNC2_MSB = 1;

// Instruction cb2_immlo
parameter NANORV32_INST_FORMAT_CB2_IMMLO_OFFSET = 12;
parameter NANORV32_INST_FORMAT_CB2_IMMLO_SIZE = 1;
parameter NANORV32_INST_FORMAT_CB2_IMMLO_MSB = 0;
//@end[instruction_format]

//@begin[inst_decode_definitions]
parameter NANORV32_DECODE_AND = 35'b???0000000??????????111?????0110011;
parameter NANORV32_DECODE_C_SWSP = 35'b???????????????????110???????????10;
parameter NANORV32_DECODE_C_LWSP = 35'b??0????????????????010???????????10;
parameter NANORV32_DECODE_LBU = 35'b????????????????????100?????0000011;
parameter NANORV32_DECODE_FENCE = 35'b???000000000000?????000000000001111;
parameter NANORV32_DECODE_SLTI = 35'b????????????????????010?????0010011;
parameter NANORV32_DECODE_C_ADDI = 35'b??0????????????????000???????????01;
parameter NANORV32_DECODE_C_ADD4SPN = 35'b???????????????????000???????????00;
parameter NANORV32_DECODE_C_SLLI = 35'b??0????????????????000???????????10;
parameter NANORV32_DECODE_BLTU = 35'b????????????????????110?????1100011;
parameter NANORV32_DECODE_OR = 35'b???0000000??????????110?????0110011;
parameter NANORV32_DECODE_XORI = 35'b????????????????????100?????0010011;
parameter NANORV32_DECODE_XOR = 35'b???0000000??????????100?????0110011;
parameter NANORV32_DECODE_SLLI = 35'b???0000000??????????001?????0010011;
parameter NANORV32_DECODE_C_OR = 35'b?????????????????????????????????10;
parameter NANORV32_DECODE_C_MV = 35'b1?0????????????????1000??????????10;
parameter NANORV32_DECODE_C_JALR = 35'b1?0????????????????1001??????????10;
parameter NANORV32_DECODE_SLL = 35'b???0000000??????????001?????0110011;
parameter NANORV32_DECODE_MULHU = 35'b???0000001??????????011?????0110011;
parameter NANORV32_DECODE_RDTIME = 35'b???11000000000100000010?????1110011;
parameter NANORV32_DECODE_ANDI = 35'b????????????????????111?????0010011;
parameter NANORV32_DECODE_JALR = 35'b????????????????????000?????1100111;
parameter NANORV32_DECODE_BLT = 35'b????????????????????100?????1100011;
parameter NANORV32_DECODE_SCALL = 35'b???000000000000?????000000001110011;
parameter NANORV32_DECODE_FENCE_I = 35'b???000000000000?????001000000001111;
parameter NANORV32_DECODE_JAL = 35'b????????????????????????????1101111;
parameter NANORV32_DECODE_LH = 35'b????????????????????001?????0000011;
parameter NANORV32_DECODE_LWU = 35'b????????????????????110?????0000011;
parameter NANORV32_DECODE_LW = 35'b????????????????????010?????0000011;
parameter NANORV32_DECODE_ADD = 35'b???0000000??????????000?????0110011;
parameter NANORV32_DECODE_AUIPC = 35'b????????????????????????????0010111;
parameter NANORV32_DECODE_REM = 35'b???0000001??????????110?????0110011;
parameter NANORV32_DECODE_LUI = 35'b????????????????????????????0110111;
parameter NANORV32_DECODE_BNE = 35'b????????????????????001?????1100011;
parameter NANORV32_DECODE_RDCYCLE = 35'b???11000000000000000010?????1110011;
parameter NANORV32_DECODE_RDTIMEH = 35'b???11001000000100000010?????1110011;
parameter NANORV32_DECODE_C_SW = 35'b???????????????????110???????????00;
parameter NANORV32_DECODE_MULH = 35'b???0000001??????????001?????0110011;
parameter NANORV32_DECODE_BGEU = 35'b????????????????????111?????1100011;
parameter NANORV32_DECODE_C_LI = 35'b?00????????????????010???????????01;
parameter NANORV32_DECODE_RDINSTRETH = 35'b???11001000001000000010?????1110011;
parameter NANORV32_DECODE_SLTIU = 35'b????????????????????011?????0010011;
parameter NANORV32_DECODE_C_ADD = 35'b0?0????????????????1001??????????10;
parameter NANORV32_DECODE_C_JR = 35'b1?0????????????????1000??????????10;
parameter NANORV32_DECODE_C_SRAI = 35'b???????????????????100???????????10;
parameter NANORV32_DECODE_SRAI = 35'b???0100000??????????101?????0010011;
parameter NANORV32_DECODE_C_XOR = 35'b?????????????????????????????????10;
parameter NANORV32_DECODE_MULHSU = 35'b???0000001??????????010?????0110011;
parameter NANORV32_DECODE_LD = 35'b????????????????????011?????0000011;
parameter NANORV32_DECODE_SD = 35'b????????????????????011?????0100011;
parameter NANORV32_DECODE_ORI = 35'b????????????????????110?????0010011;
parameter NANORV32_DECODE_C_LW = 35'b???????????????????010???????????00;
parameter NANORV32_DECODE_LB = 35'b????????????????????000?????0000011;
parameter NANORV32_DECODE_DIVU = 35'b???0000001??????????101?????0110011;
parameter NANORV32_DECODE_SUB = 35'b???0100000??????????000?????0110011;
parameter NANORV32_DECODE_RDCYCLEH = 35'b???11001000000000000010?????1110011;
parameter NANORV32_DECODE_SRA = 35'b???0100000??????????101?????0110011;
parameter NANORV32_DECODE_C_EBREAK = 35'b1?1????????????????1001??????????10;
parameter NANORV32_DECODE_BGE = 35'b????????????????????101?????1100011;
parameter NANORV32_DECODE_SLT = 35'b???0000000??????????010?????0110011;
parameter NANORV32_DECODE_SRLI = 35'b???0000000??????????101?????0010011;
parameter NANORV32_DECODE_C_SRLI = 35'b???????????????????100???????????10;
parameter NANORV32_DECODE_SW = 35'b????????????????????010?????0100011;
parameter NANORV32_DECODE_REMU = 35'b???0000001??????????111?????0110011;
parameter NANORV32_DECODE_SRL = 35'b???0000000??????????101?????0110011;
parameter NANORV32_DECODE_C_NOP = 35'b1?1????????????????000???????????01;
parameter NANORV32_DECODE_SLTU = 35'b???0000000??????????011?????0110011;
parameter NANORV32_DECODE_LHU = 35'b????????????????????101?????0000011;
parameter NANORV32_DECODE_C_SUB = 35'b?????????????????????????????????10;
parameter NANORV32_DECODE_SH = 35'b????????????????????001?????0100011;
parameter NANORV32_DECODE_MUL = 35'b???0000001??????????000?????0110011;
parameter NANORV32_DECODE_ADDI = 35'b????????????????????000?????0010011;
parameter NANORV32_DECODE_C_LUI = 35'b?00????????????????011???????????01;
parameter NANORV32_DECODE_C_AND = 35'b?????????????????????????????????10;
parameter NANORV32_DECODE_SBREAK = 35'b???000000000001?????000000001110011;
parameter NANORV32_DECODE_SB = 35'b????????????????????000?????0100011;
parameter NANORV32_DECODE_DIV = 35'b???0000001??????????100?????0110011;
parameter NANORV32_DECODE_BEQ = 35'b????????????????????000?????1100011;
parameter NANORV32_DECODE_C_J = 35'b???????????????????101???????????01;
parameter NANORV32_DECODE_C_JAL = 35'b???????????????????001???????????10;
parameter NANORV32_DECODE_RDINSTRET = 35'b???11000000001000000010?????1110011;
parameter NANORV32_DECODE_C_ADDI16SP = 35'b?1?????????????????011???????????10;
//@end[inst_decode_definitions]

//@begin[mux_select_definitions]
// Mux definitions for pc

//  pc_next

parameter NANORV32_MUX_SEL_PC_NEXT_SIZE = 2;
parameter NANORV32_MUX_SEL_PC_NEXT_MSB = 1;
 
parameter NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB = 0;
parameter NANORV32_MUX_SEL_PC_NEXT_PLUS4 = 1;
parameter NANORV32_MUX_SEL_PC_NEXT_ALU_RES = 2;
parameter NANORV32_MUX_SEL_PC_NEXT_PLUS2 = 3;
//  pc_size

parameter NANORV32_MUX_SEL_PC_SIZE_SIZE = 1;
parameter NANORV32_MUX_SEL_PC_SIZE_MSB = 0;
 
parameter NANORV32_MUX_SEL_PC_SIZE_32BITS = 0;
parameter NANORV32_MUX_SEL_PC_SIZE_16BITS = 1;
//  pc_branch

parameter NANORV32_MUX_SEL_PC_BRANCH_SIZE = 1;
parameter NANORV32_MUX_SEL_PC_BRANCH_MSB = 0;
 
parameter NANORV32_MUX_SEL_PC_BRANCH_YES = 0;
parameter NANORV32_MUX_SEL_PC_BRANCH_NO = 1;
// Mux definitions for alu

//  alu_op

parameter NANORV32_MUX_SEL_ALU_OP_SIZE = 5;
parameter NANORV32_MUX_SEL_ALU_OP_MSB = 4;
 
parameter NANORV32_MUX_SEL_ALU_OP_AND = 0;
parameter NANORV32_MUX_SEL_ALU_OP_LSHIFT = 1;
parameter NANORV32_MUX_SEL_ALU_OP_EQ = 2;
parameter NANORV32_MUX_SEL_ALU_OP_MULHU = 3;
parameter NANORV32_MUX_SEL_ALU_OP_XOR = 4;
parameter NANORV32_MUX_SEL_ALU_OP_SUB = 5;
parameter NANORV32_MUX_SEL_ALU_OP_LT_SIGNED = 6;
parameter NANORV32_MUX_SEL_ALU_OP_LT_UNSIGNED = 7;
parameter NANORV32_MUX_SEL_ALU_OP_ADD = 8;
parameter NANORV32_MUX_SEL_ALU_OP_NOOP = 9;
parameter NANORV32_MUX_SEL_ALU_OP_REM = 10;
parameter NANORV32_MUX_SEL_ALU_OP_MUL = 11;
parameter NANORV32_MUX_SEL_ALU_OP_NEQ = 12;
parameter NANORV32_MUX_SEL_ALU_OP_MULH = 13;
parameter NANORV32_MUX_SEL_ALU_OP_RSHIFT = 14;
parameter NANORV32_MUX_SEL_ALU_OP_GE_SIGNED = 15;
parameter NANORV32_MUX_SEL_ALU_OP_ARSHIFT = 16;
parameter NANORV32_MUX_SEL_ALU_OP_MULHSU = 17;
parameter NANORV32_MUX_SEL_ALU_OP_GE_UNSIGNED = 18;
parameter NANORV32_MUX_SEL_ALU_OP_DIVU = 19;
parameter NANORV32_MUX_SEL_ALU_OP_NOP = 20;
parameter NANORV32_MUX_SEL_ALU_OP_REMU = 21;
parameter NANORV32_MUX_SEL_ALU_OP_DIV = 22;
parameter NANORV32_MUX_SEL_ALU_OP_OR = 23;
//  alu_portb

parameter NANORV32_MUX_SEL_ALU_PORTB_SIZE = 4;
parameter NANORV32_MUX_SEL_ALU_PORTB_MSB = 3;
 
parameter NANORV32_MUX_SEL_ALU_PORTB_SHAMT = 0;
parameter NANORV32_MUX_SEL_ALU_PORTB_RS2 = 1;
parameter NANORV32_MUX_SEL_ALU_PORTB_IMM12 = 2;
parameter NANORV32_MUX_SEL_ALU_PORTB_CIMM5_LUI = 3;
parameter NANORV32_MUX_SEL_ALU_PORTB_IMM12HILO = 4;
parameter NANORV32_MUX_SEL_ALU_PORTB_CIMM5 = 5;
parameter NANORV32_MUX_SEL_ALU_PORTB_IMM20U = 6;
parameter NANORV32_MUX_SEL_ALU_PORTB_CIMM10CJ = 7;
parameter NANORV32_MUX_SEL_ALU_PORTB_IMM20UJ = 8;
parameter NANORV32_MUX_SEL_ALU_PORTB_RS2_C = 9;
//  alu_porta

parameter NANORV32_MUX_SEL_ALU_PORTA_SIZE = 2;
parameter NANORV32_MUX_SEL_ALU_PORTA_MSB = 1;
 
parameter NANORV32_MUX_SEL_ALU_PORTA_RS1_C = 0;
parameter NANORV32_MUX_SEL_ALU_PORTA_PC_EXE = 1;
parameter NANORV32_MUX_SEL_ALU_PORTA_RS1 = 2;
// Mux definitions for datamem

//  datamem_size_read

parameter NANORV32_MUX_SEL_DATAMEM_SIZE_READ_SIZE = 3;
parameter NANORV32_MUX_SEL_DATAMEM_SIZE_READ_MSB = 2;
 
parameter NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD = 0;
parameter NANORV32_MUX_SEL_DATAMEM_SIZE_READ_BYTE_UNSIGNED = 1;
parameter NANORV32_MUX_SEL_DATAMEM_SIZE_READ_HALFWORD_UNSIGNED = 2;
parameter NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C = 3;
parameter NANORV32_MUX_SEL_DATAMEM_SIZE_READ_BYTE = 4;
parameter NANORV32_MUX_SEL_DATAMEM_SIZE_READ_HALFWORD = 5;
//  datamem_write

parameter NANORV32_MUX_SEL_DATAMEM_WRITE_SIZE = 2;
parameter NANORV32_MUX_SEL_DATAMEM_WRITE_MSB = 1;
 
parameter NANORV32_MUX_SEL_DATAMEM_WRITE_YES = 0;
parameter NANORV32_MUX_SEL_DATAMEM_WRITE_WORD = 1;
parameter NANORV32_MUX_SEL_DATAMEM_WRITE_NO = 2;
//  datamem_size_write

parameter NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_SIZE = 2;
parameter NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_MSB = 1;
 
parameter NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C = 0;
parameter NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_BYTE = 1;
parameter NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_HALFWORD = 2;
parameter NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD = 3;
//  datamem_read

parameter NANORV32_MUX_SEL_DATAMEM_READ_SIZE = 1;
parameter NANORV32_MUX_SEL_DATAMEM_READ_MSB = 0;
 
parameter NANORV32_MUX_SEL_DATAMEM_READ_YES = 0;
parameter NANORV32_MUX_SEL_DATAMEM_READ_NO = 1;
// Mux definitions for regfile

//  regfile_portw

parameter NANORV32_MUX_SEL_REGFILE_PORTW_SIZE = 2;
parameter NANORV32_MUX_SEL_REGFILE_PORTW_MSB = 1;
 
parameter NANORV32_MUX_SEL_REGFILE_PORTW_RD = 0;
parameter NANORV32_MUX_SEL_REGFILE_PORTW_C_X1 = 1;
parameter NANORV32_MUX_SEL_REGFILE_PORTW_RD_C = 2;
//  regfile_source

parameter NANORV32_MUX_SEL_REGFILE_SOURCE_SIZE = 3;
parameter NANORV32_MUX_SEL_REGFILE_SOURCE_MSB = 2;
 
parameter NANORV32_MUX_SEL_REGFILE_SOURCE_PC_EXE_PLUS_4 = 0;
parameter NANORV32_MUX_SEL_REGFILE_SOURCE_CSR_RDATA = 1;
parameter NANORV32_MUX_SEL_REGFILE_SOURCE_ALU = 2;
parameter NANORV32_MUX_SEL_REGFILE_SOURCE_DATAMEM = 3;
parameter NANORV32_MUX_SEL_REGFILE_SOURCE_PC_EXE_PLUS_2 = 4;
//  regfile_write

parameter NANORV32_MUX_SEL_REGFILE_WRITE_SIZE = 1;
parameter NANORV32_MUX_SEL_REGFILE_WRITE_MSB = 0;
 
parameter NANORV32_MUX_SEL_REGFILE_WRITE_YES = 0;
parameter NANORV32_MUX_SEL_REGFILE_WRITE_NO = 1;
//  regfile_port1

parameter NANORV32_MUX_SEL_REGFILE_PORT1_SIZE = 1;
parameter NANORV32_MUX_SEL_REGFILE_PORT1_MSB = 0;
 
parameter NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C = 0;
parameter NANORV32_MUX_SEL_REGFILE_PORT1_RS1 = 1;
//  regfile_port2

parameter NANORV32_MUX_SEL_REGFILE_PORT2_SIZE = 1;
parameter NANORV32_MUX_SEL_REGFILE_PORT2_MSB = 0;
 
parameter NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C = 0;
parameter NANORV32_MUX_SEL_REGFILE_PORT2_RS2 = 1;
//@end[mux_select_definitions]

//@begin[micro_rom_param]
parameter  NANORV32_RESET_SEQ_START_ADDR= 32'h00000000;
parameter  NANORV32_RESET_SEQ_STOP_ADDR= 32'h00000008;
parameter  NANORV32_INT_ENTRY_CODE_START_ADDR= 32'h00000008;
parameter  NANORV32_INT_ENTRY_CODE_STOP_ADDR= 32'h0000004c;
parameter  NANORV32_INT_EXIT_CODE_START_ADDR= 32'h0000004c;
parameter  NANORV32_INT_EXIT_CODE_STOP_ADDR= 32'h00000080;
//@end[micro_rom_param]


// For the ALU shift amount (inputed on ALU port B)
parameter NANORV32_SHAMT_FILL = NANORV32_DATA_SIZE-NANORV32_INST_FORMAT_SHAMT_SIZE;



// state machine for the "pipeline" (fetch + executuion stages)

parameter NANORV32_PSTATE_BITS = 2;
parameter NANORV32_PSTATE_MSB = NANORV32_PSTATE_BITS - 1;

parameter NANORV32_PSTATE_RESET=0;
parameter NANORV32_PSTATE_CONT=1;
parameter NANORV32_PSTATE_BRANCH=2;
parameter NANORV32_PSTATE_WAITLD=3;


// "jump to address 0" (reset value for instruction register)
parameter NANORV32_J0_INSTRUCTION = 32'b00000000_00000000_00000000_01101111;



parameter NANORV32_CODE_BASE_ADDRESS = 32'h00000000;
parameter NANORV32_RAM_BASE_ADDRESS = 32'h20000000;
parameter NANORV32_PERIPH_BASE_ADDRESS = 32'hF0000000;


// Micro-rom related parameters
parameter NANORV32_UROM_ADDR_BITS=6;
parameter NANORV32_UROM_ADDR_MSB=NANORV32_UROM_ADDR_BITS-1;


// "Ret" instruction as generated for GCC
// 000000000000  00001 000 00000 1100111
//   imm       x1/ra  -    x0    JALR
parameter NANORV32_RET_INSTRUCTION = 32'h00008067;
parameter NANORV32_X1_RA_RETI_MAGIC_VALUE = 32'hFFFFFFFF;


// CSR implementation

//@begin[csr_address]
parameter NANORV32_CSR_ADDR_CYCLEH = 12'hc80;
parameter NANORV32_CSR_ADDR_INSTRETH = 12'hc82;
parameter NANORV32_CSR_ADDR_TIMEH = 12'hc81;
parameter NANORV32_CSR_ADDR_TIME = 12'hc01;
parameter NANORV32_CSR_ADDR_INSTRET = 12'hc02;
parameter NANORV32_CSR_ADDR_CYCLE = 12'hc00;
//@end[csr_address]

parameter NANORV32_CSR_ADDR_BITS=12;
parameter NANORV32_CSR_ADDR_MSB = NANORV32_CSR_ADDR_BITS-1;
