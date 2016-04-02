//****************************************************************************/
//  Nanorv32 CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Tue Mar  1 08:19:03 2016
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
//  Filename        :  nanorv32_decoder.v
//
//  Description     :   Instruction decoder for the Nanorv32 core
//                      Note : most of the code is generated
//
//
//
//****************************************************************************/


module nanorv32_decoder (/*AUTOARG*/
   // Outputs
   illegal_instruction, pc_next_sel, pc_branch_sel, alu_op_sel,
   alu_portb_sel, alu_porta_sel, datamem_size_read_sel,
   datamem_write_sel, datamem_size_write_sel, datamem_read_sel,
   regfile_portw_sel, regfile_source_sel, regfile_write_sel,
   regfile_port1_sel, regfile_port2_sel,
   // Inputs
   instruction_r, dec_c_rd_rs1, dec_c_rs2
   );


`include "nanorv32_parameters.v"


   output illegal_instruction;
   input  [NANORV32_INSTRUCTION_MSB:0]instruction_r;

   // For RVC 'hint' decoding
   input [NANORV32_INST_FORMAT_C_RD_RS1_MSB:0] dec_c_rd_rs1;
   input [NANORV32_INST_FORMAT_C_RS2_MSB:0]     dec_c_rs2;


   //@begin[mux_select_declarations_as_output]

    output  [NANORV32_MUX_SEL_PC_NEXT_MSB:0] pc_next_sel;
    output  [NANORV32_MUX_SEL_PC_BRANCH_MSB:0] pc_branch_sel;
    output  [NANORV32_MUX_SEL_ALU_OP_MSB:0] alu_op_sel;
    output  [NANORV32_MUX_SEL_ALU_PORTB_MSB:0] alu_portb_sel;
    output  [NANORV32_MUX_SEL_ALU_PORTA_MSB:0] alu_porta_sel;
    output  [NANORV32_MUX_SEL_DATAMEM_SIZE_READ_MSB:0] datamem_size_read_sel;
    output  [NANORV32_MUX_SEL_DATAMEM_WRITE_MSB:0] datamem_write_sel;
    output  [NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_MSB:0] datamem_size_write_sel;
    output  [NANORV32_MUX_SEL_DATAMEM_READ_MSB:0] datamem_read_sel;
    output  [NANORV32_MUX_SEL_REGFILE_PORTW_MSB:0] regfile_portw_sel;
    output  [NANORV32_MUX_SEL_REGFILE_SOURCE_MSB:0] regfile_source_sel;
    output  [NANORV32_MUX_SEL_REGFILE_WRITE_MSB:0] regfile_write_sel;
    output  [NANORV32_MUX_SEL_REGFILE_PORT1_MSB:0] regfile_port1_sel;
    output  [NANORV32_MUX_SEL_REGFILE_PORT2_MSB:0] regfile_port2_sel;
   //@end[mux_select_declarations_as_output]

   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			illegal_instruction;
   // End of automatics
   /*AUTOWIRE*/

   //@begin[mux_select_declarations]

    reg  [NANORV32_MUX_SEL_PC_NEXT_MSB:0] pc_next_sel;
    reg  [NANORV32_MUX_SEL_PC_BRANCH_MSB:0] pc_branch_sel;
    reg  [NANORV32_MUX_SEL_ALU_OP_MSB:0] alu_op_sel;
    reg  [NANORV32_MUX_SEL_ALU_PORTB_MSB:0] alu_portb_sel;
    reg  [NANORV32_MUX_SEL_ALU_PORTA_MSB:0] alu_porta_sel;
    reg  [NANORV32_MUX_SEL_DATAMEM_SIZE_READ_MSB:0] datamem_size_read_sel;
    reg  [NANORV32_MUX_SEL_DATAMEM_WRITE_MSB:0] datamem_write_sel;
    reg  [NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_MSB:0] datamem_size_write_sel;
    reg  [NANORV32_MUX_SEL_DATAMEM_READ_MSB:0] datamem_read_sel;
    reg  [NANORV32_MUX_SEL_REGFILE_PORTW_MSB:0] regfile_portw_sel;
    reg  [NANORV32_MUX_SEL_REGFILE_SOURCE_MSB:0] regfile_source_sel;
    reg  [NANORV32_MUX_SEL_REGFILE_WRITE_MSB:0] regfile_write_sel;
    reg  [NANORV32_MUX_SEL_REGFILE_PORT1_MSB:0] regfile_port1_sel;
    reg  [NANORV32_MUX_SEL_REGFILE_PORT2_MSB:0] regfile_port2_sel;
   //@end[mux_select_declarations]


   // We are using 3 extra wires ('hints') for RVC decoding ('hints')
   wire [NANORV32_DATA_MSB+3:0]                 instruction_for_decode_unit;

   wire                                         hint_rvc_rd_rs1_is_zero;
   wire                                         hint_rvc_rd_rs1_is_two;
   wire                                         hint_rvc_rs2_is_zero;



   assign hint_rvc_rd_rs1_is_zero = (dec_c_rd_rs1 == 5'd0);
   assign hint_rvc_rd_rs1_is_two = (dec_c_rd_rs1 == 5'd2);
   assign hint_rvc_rs2_is_zero   = (dec_c_rs2 == 5'd0);

   assign instruction_for_decode_unit = {
                                         hint_rvc_rs2_is_zero,    // Offset 34
                                         hint_rvc_rd_rs1_is_two,  // Offset 33
                                         hint_rvc_rd_rs1_is_zero, // Offset 32
                                         instruction_r
                                         };

   always @* begin
      illegal_instruction = 0;
      casez(instruction_for_decode_unit[34:0])
        //@begin[instruction_decoder]
    NANORV32_DECODE_AND: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_AND;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_SWSP: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5_SWSP;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_YES;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_C_X2;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_C_LWSP: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5_LWSP;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_YES;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_DATAMEM;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_C_X2;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_LBU: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_BYTE_UNSIGNED;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_YES;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_DATAMEM;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_FENCE: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_SW: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12HILO;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_YES;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_ADDI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_RDCYCLEH: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_CSR_RDATA;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_SBREAK: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_BLTU: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_YES;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_LT_UNSIGNED;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_LW: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5_CL;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_YES;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C_P;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_DATAMEM;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C_P;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_XOR: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_XOR;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_OR: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_OR;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RS1_C_P;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C_P;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C_P;
    end
    NANORV32_DECODE_LUI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM20U;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_WORD;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_MV: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_C_JALR: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_ALU_RES;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_C_X1;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_PC_EXE_PLUS_2;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_C_SUB: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_SUB;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RS1_C_P;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C_P;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C_P;
    end
    NANORV32_DECODE_SLTU: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_LT_UNSIGNED;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_MULHU: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_MULHU;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_RDTIME: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_CSR_RDATA;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_LB: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_BYTE;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_YES;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_DATAMEM;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_JALR: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_ALU_RES;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_PC_EXE_PLUS_4;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_ADD4SPN: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM8_CIW;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C_P;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_C_X2;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_BLT: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_YES;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_LT_SIGNED;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_SCALL: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_FENCE_I: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_JAL: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_ALU_RES;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_YES;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM20UJ;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_PC_EXE;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_PC_EXE_PLUS_4;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_LH: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_HALFWORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_YES;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_DATAMEM;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_BEQZ: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB_C;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_YES;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_EQ;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C_P;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_X0;
    end
    NANORV32_DECODE_C_BNEZ: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB_C;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_YES;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NEQ;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C_P;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_X0;
    end
    NANORV32_DECODE_LW: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_YES;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_DATAMEM;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_ADD: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_JAL: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_ALU_RES;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_YES;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM10CJ;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_PC_EXE;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_C_X1;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_PC_EXE_PLUS_2;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_AUIPC: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM20U;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_PC_EXE;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_WORD;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_REM: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_REM;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_MUL: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_MUL;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_ADDI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_RDCYCLE: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_CSR_RDATA;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_RDTIMEH: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_CSR_RDATA;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_SW: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5_CL;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_YES;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C_P;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C_P;
    end
    NANORV32_DECODE_MULH: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_MULH;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_BGEU: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_YES;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_GE_UNSIGNED;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_LI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_RDINSTRETH: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_CSR_RDATA;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_SLTIU: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_LT_UNSIGNED;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_ADD: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_C_JR: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_ALU_RES;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_C_SRAI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ARSHIFT;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RS1_C_P;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C_P;
    end
    NANORV32_DECODE_SRAI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ARSHIFT;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_SHAMT;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_EBREAK: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_MULHSU: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_MULHSU;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_ORI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_OR;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_XORI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_XOR;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_ANDI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_AND;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_DIVU: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_DIVU;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_XOR: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_XOR;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RS1_C_P;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C_P;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C_P;
    end
    NANORV32_DECODE_C_ANDI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_AND;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RS1_C_P;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C_P;
    end
    NANORV32_DECODE_SUB: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_SUB;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_SRLI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_RSHIFT;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RS1_C_P;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C_P;
    end
    NANORV32_DECODE_SRA: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ARSHIFT;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_BGE: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_YES;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_GE_SIGNED;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_SLT: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_LT_SIGNED;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_AND: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_AND;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RS1_C_P;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C_P;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C_P;
    end
    NANORV32_DECODE_SRLI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_RSHIFT;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_SHAMT;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_SLLI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_LSHIFT;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_SLTI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_LT_SIGNED;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_REMU: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_REMU;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_SRL: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_RSHIFT;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_NOP: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_SLL: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_LSHIFT;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_LHU: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_HALFWORD_UNSIGNED;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_YES;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_DATAMEM;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_SH: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12HILO;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_YES;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_HALFWORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_SLLI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_LSHIFT;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_SHAMT;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_BNE: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_YES;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NEQ;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_LUI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5_LUI;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_C_ADDI16SP: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5_16SP;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_SB: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12HILO;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_YES;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_BYTE;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_DIV: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_DIV;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_BEQ: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_YES;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_EQ;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_J: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_ALU_RES;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_YES;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM10CJ;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_PC_EXE;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_OR: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_OR;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_RDINSTRET: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_CSR_RDATA;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
        //@end[instruction_decoder]
        default begin
           illegal_instruction = 1;

           pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
           alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOP;
           alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
           alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
           datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
           datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
           datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
           regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
           regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
           datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
           pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;


        end
      endcase // casez (instruction[NANORV32_INSTRUCTION_MSB:0])
   end







endmodule // nanorv32_decoder
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
