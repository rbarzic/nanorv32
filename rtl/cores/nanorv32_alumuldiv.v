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
module nanorv32_alumuldiv (/*AUTOARG*/
   // Outputs
   alu_res, alu_cond, div_ready,
   // Inputs
   alu_porta, alu_portb, alu_op_sel, clk, rst_n
   );

   `include "nanorv32_parameters.v"
   input [NANORV32_DATA_MSB:0] alu_porta;
   input [NANORV32_DATA_MSB:0] alu_portb;
   input [NANORV32_MUX_SEL_ALU_OP_MSB:0] alu_op_sel;
   input                       clk;
   input                       rst_n;
   //input [NANORV32_MUX_SEL_ALU_COND_MSB:0] alu_cond_sel;

   output [NANORV32_DATA_MSB:0]            alu_res;
   output                                  alu_cond;
   output                                  div_ready;




   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   reg  sign_a, sign_b, div_sign;
   wire [NANORV32_DATA_MSB:0] mul_a = (alu_porta ^ {32{alu_porta[31] & sign_a}}) + {{31{1'b0}},alu_porta[31] & sign_a};
   wire [NANORV32_DATA_MSB:0] mul_b = (alu_portb ^ {32{alu_portb[31] & sign_b}}) + {{31{1'b0}},alu_portb[31] & sign_b};
   wire [63:0] mul_res_tmp = mul_a[NANORV32_DATA_MSB:0] * mul_b[NANORV32_DATA_MSB:0];
   wire [63:0] mul_res = (mul_res_tmp ^ {64{alu_porta[31] & sign_a ^ alu_portb[31] & sign_b}}) + {{31{1'b0}},alu_porta[31] & sign_a ^alu_portb[31] & sign_b}; 
   wire [31:0] div_res; 
   wire        div_ready_tmp, div_valid;
  
   assign      div_ready    = div_occuring ? div_valid : div_ready_tmp;
   wire        mul_occuring = alu_op_sel == NANORV32_MUX_SEL_ALU_OP_MUL |
                              alu_op_sel == NANORV32_MUX_SEL_ALU_OP_MULH |
                              alu_op_sel == NANORV32_MUX_SEL_ALU_OP_MULHU |
                              alu_op_sel == NANORV32_MUX_SEL_ALU_OP_MULHSU;
   wire        div_occuring = alu_op_sel == NANORV32_MUX_SEL_ALU_OP_DIV  |
                              alu_op_sel == NANORV32_MUX_SEL_ALU_OP_DIVU |
                              alu_op_sel == NANORV32_MUX_SEL_ALU_OP_REM  |
                              alu_op_sel == NANORV32_MUX_SEL_ALU_OP_REMU;
   wire        div_rem      = alu_op_sel == NANORV32_MUX_SEL_ALU_OP_REM  |
                              alu_op_sel == NANORV32_MUX_SEL_ALU_OP_REMU;
//   assign div_ready = div_occuring ? div_ready_tmp :1'b1;
   nanorv32_divide u_div(
     .clk (clk),
     .rst_n (rst_n),
     .req_valid (div_occuring),
     .req_in_1_signed (div_sign),
     .req_in_2_signed (div_sign),
     .rem_op_sel (div_rem),
     .req_in_1 (alu_porta),
     .req_in_2 (alu_portb),
     .resp_valid  (div_valid),
     .resp_result (div_res),
     .req_ready   (div_ready_tmp)
  );
 
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [NANORV32_DATA_MSB:0] alu_res;
   // End of automatics
   /*AUTOWIRE*/
   // port a is tos most of the time, port b is nos
   always@* begin
      case(alu_op_sel)
        NANORV32_MUX_SEL_ALU_OP_NOP: begin
           alu_res = alu_portb;
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
           alu_res = {{NANORV32_DATA_MSB{1'b0}},($signed(alu_porta) >= $signed(alu_portb))};
        end

        NANORV32_MUX_SEL_ALU_OP_GE_UNSIGNED: begin // "Greater or equal"
           alu_res = {{NANORV32_DATA_MSB{1'b0}},(alu_porta >= alu_portb)};
        end

        // This also could probably optimized
        NANORV32_MUX_SEL_ALU_OP_EQ: begin // "Less than"
           alu_res = {{NANORV32_DATA_MSB{1'b0}},(alu_porta == alu_portb)};
        end
        NANORV32_MUX_SEL_ALU_OP_NEQ: begin // "Less than"
           alu_res = {{NANORV32_DATA_MSB{1'b0}},(alu_porta != alu_portb)};
        end
        NANORV32_MUX_SEL_ALU_OP_MUL: begin // "Less than"
           sign_a  = 1'b0;
           sign_b  = 1'b0;
           alu_res = mul_res[31:0];
        end
        NANORV32_MUX_SEL_ALU_OP_MULH: begin // "Less than"
           sign_a  = 1'b1;
           sign_b  = 1'b1;
           alu_res = mul_res[63:32];
        end
        NANORV32_MUX_SEL_ALU_OP_MULHU: begin // "Less than"
           sign_a  = 1'b0;
           sign_b  = 1'b0;
           alu_res = mul_res[63:32];
        end
        NANORV32_MUX_SEL_ALU_OP_MULHSU: begin // "Less than"
           sign_a  = 1'b1;
           sign_b  = 1'b0;
           alu_res = mul_res[63:32];
        end
        NANORV32_MUX_SEL_ALU_OP_DIV: begin // "Less than"
           div_sign = 1'b1;
           alu_res = div_res;
        end
        NANORV32_MUX_SEL_ALU_OP_DIVU: begin // "Less than"
           div_sign = 1'b0;
           alu_res = div_res;
        end
        NANORV32_MUX_SEL_ALU_OP_REM: begin // "Less than"
           div_sign = 1'b1;
           alu_res = div_res;
        end
        NANORV32_MUX_SEL_ALU_OP_REMU: begin // "Less than"
           div_sign = 1'b0;
           alu_res = div_res;
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
