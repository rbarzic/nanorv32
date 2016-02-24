//********************************************************************
//
//  nanorv32_regfile.v
//
//  This file is part of the NANORV32 project
//  http://
//
//  Description     :  Register file for NANORV32 processor
//
//
//  Author          :  rbarzic@gmail.com
//  Date            :  Mon Jan 10 22:19:54 2011
//
//********************************************************************
//
// Copyright (C) 2010 Ronan Barzic
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//********************************************************************


module nanorv32_regfile (/*AUTOARG*/
   // Outputs
   porta, portb,
   // Inputs
   sel_porta, sel_portb, sel_rd, sel_rd2, rd, write_rd, rd2, write_rd2,   clk, rst_n
   );

   parameter NUM_REGS=32;
`include "nanorv32_parameters.v"

  // Selection
   input  [NANORV32_RF_PORTA_MSB:0] sel_porta;
   input [NANORV32_RF_PORTB_MSB:0]  sel_portb;
   input [NANORV32_RF_PORTRD_MSB:0] sel_rd;
   input [NANORV32_RF_PORTRD_MSB:0] sel_rd2;
   // Data ports
   output [NANORV32_DATA_MSB:0]     porta;
   output [NANORV32_DATA_MSB:0]     portb;
   input [NANORV32_DATA_MSB:0]      rd;
   input                            write_rd;
   input [NANORV32_DATA_MSB:0]      rd2;
   input                            write_rd2;
   input                            clk;
   input                            rst_n;

   /*AUTOINPUT*/

  /*AUTOOUTPUT*/

  /*AUTOREG*/
  // Beginning of automatic regs (for this module's undeclared outputs)
  reg [NANORV32_DATA_MSB:0] porta;
  reg [NANORV32_DATA_MSB:0] portb;
  // End of automatics

  /*AUTOWIRE*/




  reg [NANORV32_DATA_MSB:0] regfile [0:NUM_REGS-1];

  always @(sel_porta or regfile[sel_porta])  begin
    if(sel_porta != 0) begin
      porta <= regfile[sel_porta];
    end
    else begin
      porta <= 0;
    end
  end


  always @(sel_portb or regfile[sel_portb])  begin
    if(sel_portb != 0) begin
      portb <= regfile[sel_portb];
    end
    else begin
      portb <= 0;
    end
  end

  always @(posedge clk) begin
    if((sel_rd != 0) && write_rd) begin
      regfile[sel_rd] <= rd;
    end
  end

  always @(posedge clk) begin
    if((sel_rd2 != 0) && write_rd2) begin
      regfile[sel_rd2] <= rd2;
    end
  end


  // For debugging

// synthesis translate_off


wire  [31:0] x0 ;
wire  [31:0] x1 ;
wire  [31:0] x2 ;
wire  [31:0] x3 ;
wire  [31:0] x4 ;
wire  [31:0] x5 ;
wire  [31:0] x6 ;
wire  [31:0] x7 ;
wire  [31:0] x8 ;
wire  [31:0] x9 ;
wire  [31:0] x10;
wire  [31:0] x11;
wire  [31:0] x12;
wire  [31:0] x13;
wire  [31:0] x14;
wire  [31:0] x15;
wire  [31:0] x16;
wire  [31:0] x17;
wire  [31:0] x18;
wire  [31:0] x19;
wire  [31:0] x20;
wire  [31:0] x21;
wire  [31:0] x22;
wire  [31:0] x23;
wire  [31:0] x24;
wire  [31:0] x25;
wire  [31:0] x26;
wire  [31:0] x27;
wire  [31:0] x28;
wire  [31:0] x29;
wire  [31:0] x30;
wire  [31:0] x31;


   wire [31:0] ra ;
   wire [31:0] s0 ;
   wire [31:0] fp ;
   wire [31:0] s1 ;
   wire [31:0] s2 ;
   wire [31:0] s3 ;
   wire [31:0] s4 ;
   wire [31:0] s5 ;
   wire [31:0] s6 ;
   wire [31:0] s7;
   wire [31:0] s8;
   wire [31:0] s9;
   wire [31:0] s10;
   wire [31:0] s11;
   wire [31:0] sp;
   wire [31:0] v0;
   wire [31:0] v1;
   wire [31:0] a0;
   wire [31:0] a1;
   wire [31:0] a2;
   wire [31:0] a3;
   wire [31:0] a4;
   wire [31:0] a5;
   wire [31:0] a6;
   wire [31:0] a7;
   wire [31:0] t0;
   wire [31:0] t1;
   wire [31:0] t2;
   wire [31:0] t3;
   wire [31:0] t4;
   wire [31:0] t5;
   wire [31:0] t6;
   wire [31:0] tp;
   wire [31:0] gp;







assign     x0 = 	regfile[0];
assign     x1 = 	regfile[1];
assign     x2 = 	regfile[2];
assign     x3 = 	regfile[3];
assign     x4 = 	regfile[4];
assign     x5 = 	regfile[5];
assign     x6 = 	regfile[6];
assign     x7 = 	regfile[7];
assign     x8 = 	regfile[8];
assign     x9 = 	regfile[9];
assign     x10 = 	regfile[10];
assign     x11 = 	regfile[11];
assign     x12 = 	regfile[12];
assign     x13 = 	regfile[13];
assign     x14 = 	regfile[14];
assign     x15 = 	regfile[15];
assign     x16 = 	regfile[16];
assign     x17 = 	regfile[17];
assign     x18 = 	regfile[18];
assign     x19 = 	regfile[19];
assign     x20 = 	regfile[20];
assign     x21 = 	regfile[21];
assign     x22 = 	regfile[22];
assign     x23 = 	regfile[23];
assign     x24 = 	regfile[24];
assign     x25 = 	regfile[25];
assign     x26 = 	regfile[26];
assign     x27 = 	regfile[27];
assign     x28 = 	regfile[28];
assign     x29 = 	regfile[29];
assign     x30 = 	regfile[30];
assign     x31 = 	regfile[31];


   assign     ra = 	regfile[1];
   assign     sp = 	regfile[2];
   assign     gp = 	regfile[3];
   assign     tp = 	regfile[4];
   assign     t0 = 	regfile[5];
   assign     t1 = 	regfile[6];
   assign     t2 = 	regfile[7];
   assign     s0 = 	regfile[8];
   assign     fp = 	regfile[8];
   assign     s1 = 	regfile[9];
   assign     a0 = 	regfile[10];
   assign     a1 = 	regfile[11];
   assign     a2 = 	regfile[12];
   assign     a3 = 	regfile[13];
   assign     a4 = 	regfile[14];
   assign     a5 = 	regfile[15];
   assign     a6 = 	regfile[16];
   assign     a7 = 	regfile[17];
   assign     s2 = 	regfile[18];
   assign     s3 = 	regfile[19];
   assign     s4 = 	regfile[20];
   assign     s5 = 	regfile[21];
   assign     s6 = 	regfile[22];
   assign     s7 = 	regfile[23];
   assign     s8 = 	regfile[24];
   assign     s9 = 	regfile[25];
   assign     s10 = 	regfile[26];
   assign     s11= 	regfile[27];
   assign     t3 = 	regfile[28];
   assign     t4 = 	regfile[29];
   assign     t5 = 	regfile[30];
   assign     t6 = 	regfile[31];





// synthesis translate_on





endmodule // nanorv32_regfile
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
