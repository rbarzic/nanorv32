// Mux definitions for pc

//  pc_next

parameter NANORV32_MUX_SEL_PC_NEXT_SIZE = 3;
parameter NANORV32_MUX_SEL_PC_NEXT_MSB = 2;
 
parameter NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB = 0;
parameter NANORV32_MUX_SEL_PC_NEXT_PLUS4 = 1;
parameter NANORV32_MUX_SEL_PC_NEXT_ALU_RES = 2;
parameter NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB_C = 3;
parameter NANORV32_MUX_SEL_PC_NEXT_PLUS2 = 4;
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
parameter NANORV32_MUX_SEL_ALU_PORTB_IMM12 = 1;
parameter NANORV32_MUX_SEL_ALU_PORTB_CIMM5_SWSP = 2;
parameter NANORV32_MUX_SEL_ALU_PORTB_CIMM5_LUI = 3;
parameter NANORV32_MUX_SEL_ALU_PORTB_IMM12HILO = 4;
parameter NANORV32_MUX_SEL_ALU_PORTB_CIMM5 = 5;
parameter NANORV32_MUX_SEL_ALU_PORTB_CIMM5_CL = 6;
parameter NANORV32_MUX_SEL_ALU_PORTB_CIMM8_CIW = 7;
parameter NANORV32_MUX_SEL_ALU_PORTB_IMM20U = 8;
parameter NANORV32_MUX_SEL_ALU_PORTB_CIMM10CJ = 9;
parameter NANORV32_MUX_SEL_ALU_PORTB_CIMM5_16SP = 10;
parameter NANORV32_MUX_SEL_ALU_PORTB_IMM20UJ = 11;
parameter NANORV32_MUX_SEL_ALU_PORTB_RS2 = 12;
parameter NANORV32_MUX_SEL_ALU_PORTB_CIMM5_LWSP = 13;
//  alu_porta

parameter NANORV32_MUX_SEL_ALU_PORTA_SIZE = 1;
parameter NANORV32_MUX_SEL_ALU_PORTA_MSB = 0;
 
parameter NANORV32_MUX_SEL_ALU_PORTA_PC_EXE = 0;
parameter NANORV32_MUX_SEL_ALU_PORTA_RS1 = 1;
// Mux definitions for datamem

//  datamem_size_read

parameter NANORV32_MUX_SEL_DATAMEM_SIZE_READ_SIZE = 3;
parameter NANORV32_MUX_SEL_DATAMEM_SIZE_READ_MSB = 2;
 
parameter NANORV32_MUX_SEL_DATAMEM_SIZE_READ_HALFWORD_UNSIGNED = 0;
parameter NANORV32_MUX_SEL_DATAMEM_SIZE_READ_HALFWORD = 1;
parameter NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD = 2;
parameter NANORV32_MUX_SEL_DATAMEM_SIZE_READ_BYTE = 3;
parameter NANORV32_MUX_SEL_DATAMEM_SIZE_READ_BYTE_UNSIGNED = 4;
//  datamem_write

parameter NANORV32_MUX_SEL_DATAMEM_WRITE_SIZE = 2;
parameter NANORV32_MUX_SEL_DATAMEM_WRITE_MSB = 1;
 
parameter NANORV32_MUX_SEL_DATAMEM_WRITE_YES = 0;
parameter NANORV32_MUX_SEL_DATAMEM_WRITE_WORD = 1;
parameter NANORV32_MUX_SEL_DATAMEM_WRITE_NO = 2;
//  datamem_size_write

parameter NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_SIZE = 2;
parameter NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_MSB = 1;
 
parameter NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_BYTE = 0;
parameter NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_HALFWORD = 1;
parameter NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD = 2;
//  datamem_read

parameter NANORV32_MUX_SEL_DATAMEM_READ_SIZE = 1;
parameter NANORV32_MUX_SEL_DATAMEM_READ_MSB = 0;
 
parameter NANORV32_MUX_SEL_DATAMEM_READ_YES = 0;
parameter NANORV32_MUX_SEL_DATAMEM_READ_NO = 1;
// Mux definitions for regfile

//  regfile_portw

parameter NANORV32_MUX_SEL_REGFILE_PORTW_SIZE = 3;
parameter NANORV32_MUX_SEL_REGFILE_PORTW_MSB = 2;
 
parameter NANORV32_MUX_SEL_REGFILE_PORTW_RD = 0;
parameter NANORV32_MUX_SEL_REGFILE_PORTW_RD_C_P = 1;
parameter NANORV32_MUX_SEL_REGFILE_PORTW_RD_C = 2;
parameter NANORV32_MUX_SEL_REGFILE_PORTW_C_X1 = 3;
parameter NANORV32_MUX_SEL_REGFILE_PORTW_RS1_C_P = 4;
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

parameter NANORV32_MUX_SEL_REGFILE_PORT1_SIZE = 2;
parameter NANORV32_MUX_SEL_REGFILE_PORT1_MSB = 1;
 
parameter NANORV32_MUX_SEL_REGFILE_PORT1_C_X2 = 0;
parameter NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C = 1;
parameter NANORV32_MUX_SEL_REGFILE_PORT1_RS1 = 2;
parameter NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C_P = 3;
//  regfile_port2

parameter NANORV32_MUX_SEL_REGFILE_PORT2_SIZE = 2;
parameter NANORV32_MUX_SEL_REGFILE_PORT2_MSB = 1;
 
parameter NANORV32_MUX_SEL_REGFILE_PORT2_X0 = 0;
parameter NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C = 1;
parameter NANORV32_MUX_SEL_REGFILE_PORT2_RS2 = 2;
parameter NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C_P = 3;
