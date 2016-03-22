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
   illegal_instruction, pc_next_sel, pc_size_sel, pc_branch_sel,
   alu_op_sel, alu_portb_sel, alu_porta_sel, datamem_size_read_sel,
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
   //@end[mux_select_declarations_as_output]

   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			illegal_instruction;
   // End of automatics
   /*AUTOWIRE*/

   //@begin[mux_select_declarations]
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
      casez(instruction_for_decode_unit[NANORV32_INSTRUCTION_MSB:0])
        //@begin[instruction_decoder]
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
