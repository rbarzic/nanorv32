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
   alu_porta, alu_portb, alu_op_sel
   );

   `include "nanorv32_parameters.v"
   input [NANORV32_DATA_MSB:0] alu_porta;
   input [NANORV32_DATA_MSB:0] alu_portb;
   input [NANORV32_MUX_SEL_ALU_OP_MSB:0] alu_op_sel;
   //input [NANORV32_MUX_SEL_ALU_COND_MSB:0] alu_cond_sel;

   output [NANORV32_DATA_MSB:0]            alu_res;
   output                                  alu_cond;




   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [NANORV32_DATA_MSB:0] alu_res;
   // End of automatics
   /*AUTOWIRE*/
   // port a is tos most of the time, port b is nos
   always@* begin
      case(alu_op_sel)
        NANORV32_MUX_SEL_ALU_OP_NOP: begin
           alu_res = alu_porta;
        end
        NANORV32_MUX_SEL_ALU_OP_OR: begin
           alu_res = alu_porta |  alu_portb;
        end
        NANORV32_MUX_SEL_ALU_OP_AND: begin
           alu_res = alu_porta & alu_portb;
        end
        NANORV32_MUX_SEL_ALU_OP_XOR: begin
           alu_res = alu_porta ^  alu_portb;
        end
        NANORV32_MUX_SEL_ALU_OP_SUB: begin
           alu_res = alu_porta -  alu_portb;
        end
        NANORV32_MUX_SEL_ALU_OP_ADD: begin
           alu_res = alu_porta +  alu_portb;
        end
        NANORV32_MUX_SEL_ALU_OP_LSHIFT: begin
           alu_res = alu_porta << alu_portb[4:0]; // TODO : max shift amount should be a parameter
        end

        NANORV32_MUX_SEL_ALU_OP_RSHIFT: begin
           alu_res = alu_porta >> alu_portb[4:0]; // TODO : max shift amount should be a parameter
        end
        NANORV32_MUX_SEL_ALU_OP_ARSHIFT: begin
           alu_res = $signed(alu_porta) >>> alu_portb[4:0]; // TODO : max shift amount should be a parameter
        end
        NANORV32_MUX_SEL_ALU_OP_LT_SIGNED: begin // "Less than"
           alu_res = {{NANORV32_DATA_MSB{1'b0}},($signed(alu_porta) < $signed(alu_portb))};
        end

        NANORV32_MUX_SEL_ALU_OP_LT_UNSIGNED: begin // "Less than"
           alu_res = {{NANORV32_DATA_MSB{1'b0}},(alu_porta < alu_portb)};
        end
        // It is faster/more compact to swap the operands and drop GE code ?
        NANORV32_MUX_SEL_ALU_OP_GE_SIGNED: begin // "Greater or equal"
           alu_res = {{NANORV32_DATA_MSB{1'b0}},($signed(alu_porta) < $signed(alu_portb))};
        end

        NANORV32_MUX_SEL_ALU_OP_GE_UNSIGNED: begin // "Greater or equal"
           alu_res = {{NANORV32_DATA_MSB{1'b0}},(alu_porta < alu_portb)};
        end

        // This also could probably optimized
        NANORV32_MUX_SEL_ALU_OP_EQ: begin // "Less than"
           alu_res = {{NANORV32_DATA_MSB{1'b0}},(alu_porta == alu_portb)};
        end
        NANORV32_MUX_SEL_ALU_OP_NEQ: begin // "Less than"
           alu_res = {{NANORV32_DATA_MSB{1'b0}},(alu_porta != alu_portb)};
        end

      endcase // case (alu_op_sel)
   end // always@ *
   assign alu_cond = (|alu_res);

endmodule // nanorv32_alu
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
