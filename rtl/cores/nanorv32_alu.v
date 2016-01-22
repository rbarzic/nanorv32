//****************************************************************************/
//  NANORV32 CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Sat Jun  6 15:29:53 2015
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
//  Filename        :  nanorv32_alu.v
//
//  Description     :  ALU file for NANORV32 CPU
//
//
//
//****************************************************************************/

module nanorv32_alu (/*AUTOARG*/
   // Outputs
   alu_res, alu_cond,
   // Inputs
   alu_porta, alu_portb, alu_op_sel, alu_cond_sel
   );

   `include "nanorv32_parameters.v"
   input [NANORV32_WORD_MSB:0] alu_porta;
   input [NANORV32_WORD_MSB:0] alu_portb;
   input [NANORV32_MUX_SEL_ALU_OP_MSB:0] alu_op_sel;
   input [NANORV32_MUX_SEL_ALU_COND_MSB:0] alu_cond_sel;

   output [NANORV32_WORD_MSB:0]            alu_res;
   output                          alu_cond;




   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg                  alu_cond;
   reg [NANORV32_WORD_MSB:0]  alu_res;
   // End of automatics
   /*AUTOWIRE*/
   // port a is tos most of the time, port b is nos
   always@* begin
      case(alu_op_sel)
        NANORV32_MUX_SEL_ALU_OP_AND: begin
           alu_res <= alu_porta & alu_portb;
        end
        NANORV32_MUX_SEL_ALU_OP_XOR: begin
           alu_res <= alu_porta ^  alu_portb;
        end
        NANORV32_MUX_SEL_ALU_OP_SUB: begin
           alu_res <= alu_portb -  alu_porta;
        end
        NANORV32_MUX_SEL_ALU_OP_ADD: begin
           alu_res <= alu_porta +  alu_portb;
        end
        NANORV32_MUX_SEL_ALU_OP_LSHIFT: begin
           alu_res <= alu_portb << alu_porta[4:0]; // TODO : max shift amount should be a parameter
        end
        NANORV32_MUX_SEL_ALU_OP_NOT: begin
           alu_res <= ~alu_porta;
        end
        NANORV32_MUX_SEL_ALU_OP_RSHIFT: begin
           alu_res <= alu_portb >> alu_porta[4:0]; // TODO : max shift amount should be a parameter
        end
        NANORV32_MUX_SEL_ALU_OP_NOP: begin
           alu_res <= alu_porta;
        end
        NANORV32_MUX_SEL_ALU_OP_OR: begin
           alu_res <= alu_porta |  alu_portb;
        end
        NANORV32_MUX_SEL_ALU_OP_INFERIOR: begin
           alu_res <= {NANORV32_WORD_SIZE{(alu_portb < alu_porta)}};
        end
        NANORV32_MUX_SEL_ALU_OP_INFERIOR_UNSIGNED: begin
           alu_res <= {NANORV32_WORD_SIZE{($signed(alu_portb) < $signed(alu_porta))}};
        end
        NANORV32_MUX_SEL_ALU_OP_EQUAL: begin
           alu_res <= {NANORV32_WORD_SIZE{(alu_portb == alu_porta)}};
        end
      endcase // case (alu_op_sel)
   end // always@ *




endmodule // nanorv32_alu
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
