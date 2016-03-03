//****************************************************************************/
//  Nanorv32 CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Tue Jan 19 21:06:58 2016
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
//  Filename        :  tb_nanorv32.v
//
//  Description     :  Testbench for the nanorv32 core
//
//
//
//****************************************************************************/
`timescale 1ns/1ps
`define AHB_IF

`ifndef VCD_EXTRA_MODULE
`define VCD_EXTRA_MODULE
`endif

module tb_nanorv32;

   `include "nanorv32_parameters.v"
   `include "tb_defines.v"

   parameter ROM_ADDRESS_SIZE  = NANORV32_ADDR_SIZE-1; // Rom is half of the address space


   /*AUTOREG*/
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [15:0]          P0;                     // To/From U_DUT of nanorv32_simpleahb.v
   wire [15:0]          P1;                     // To/From U_DUT of nanorv32_simpleahb.v
   wire                 clk;                    // From U_CLOCK_GEN of clock_gen.v
   wire                 illegal_instruction;    // From U_DUT of nanorv32_simpleahb.v
   wire                 rst_n;                  // From U_RESET_GEN of reset_gen.v
   // End of automatics

   reg                  reset_a_n;

   reg [15:0]          P1reg;                     // To/From U_DUT of nanorv32_simple.v
   reg                 irq_ext;

   /* nanorv32_simpleahb AUTO_TEMPLATE(
     .clk_in                  (clk),
     ); */
   nanorv32_simpleahb U_DUT (

                           /*AUTOINST*/
                             // Outputs
                             .illegal_instruction(illegal_instruction),
                             // Inouts
                             .P0                (P0[15:0]),
                             .P1                (P1[15:0]),
                             // Inputs
                             .clk_in            (clk),           // Templated
                             .rst_n             (rst_n),
                             .irq_ext           (irq_ext));









    /* reset_gen AUTO_TEMPLATE(
     .reset_n              (rst_n));
     ); */
   reset_gen U_RESET_GEN (
                          /*AUTOINST*/
                          // Outputs
                          .reset_n              (rst_n),         // Templated
                          // Inputs
                          .reset_a_n            (reset_a_n),
                          .clk                  (clk));


    /* clock_gen AUTO_TEMPLATE(
     ); */
   clock_gen U_CLOCK_GEN (
                          /*AUTOINST*/
                          // Outputs
                          .clk                  (clk));



   task load_program_memory;
      reg [1024:0] filename;
      reg [7:0]    memory [1<<ROM_ADDRESS_SIZE:0]; // byte type memory
      integer      i;
      reg [31:0]   tmp;
      integer      dummy;

      begin

         filename = 0;
         dummy = $value$plusargs("program_memory=%s", filename);
         if(filename ==0) begin
            $display("WARNING! No content specified for program memory");
         end
         else begin
            $display("-I- Loading <%s>",filename);
            $readmemh (filename, memory);
            for(i=0; i<((1<<ROM_ADDRESS_SIZE)/4); i=i+1) begin
               tmp[7:0] = memory[i*4+0];
               tmp[15:8] = memory[i*4+1];
               tmp[23:16] = memory[i*4+2];
               tmp[31:24] = memory[i*4+3];

               `CODE_RAM.RAM[i]  = tmp;

            end
         end
      end
   endtask // load_program_memory

   task vcd_dump;
      begin
         if ($test$plusargs("vcd")) begin
	    $dumpfile("tb_nanorv32.vcd");
	    $dumpvars(0, tb_nanorv32 `VCD_EXTRA_MODULE);
	 end
      end
   endtask // if

   initial begin
      #1;
      load_program_memory();
      vcd_dump();
      #200000;
      $display("-I- TEST FAILED Timeout !");
      $finish(2);

   end


   // PC monitoring
   wire [NANORV32_DATA_MSB:0] pc;
   wire [NANORV32_DATA_MSB:0] x10_a0; // return value register

   assign pc = `CPU.pc_exe_r;
   assign illegal_instruction  = `CPU.illegal_instruction;

   assign x10_a0 = `RF.regfile[10];

   always @(posedge clk) begin
      if(rst_n) begin
         if(illegal_instruction) begin
            $display("-I- TEST FAILED (Illegal instruction)");
            $finish(2);
         end
      else
        if(pc === 32'h00000100) begin
           if(x10_a0 === 32'hCAFFE000) begin
              $display("-I- TEST OK");
              $finish(0);
           end
         else
           if(x10_a0 === 32'hDEAD0000) begin
              $display("-I- TEST FAILED");
              $finish(1);
           end
           else begin
              $display("-I- TEST FAILED (unknown reason)");
              $finish(2);
           end
      end // if (pc === 32'h00000100)
      else if (pc === 32'hxxxxxxxx) begin
         $display("-I- TEST FAILED (PC is X)");
         $finish(2);
      end
         end
   end
   // printf support
   event dbg_printf;
   event dbg_printf_flush;
   always @(posedge clk) begin
      if (rst_n) begin
         if(pc === 32'h00000088) begin
            -> dbg_printf;
            $write("%c",x10_a0);
            if(x10_a0 == 10) begin
               $fflush(32'h8000_0001);
               -> dbg_printf_flush;
            end
         end
      end
   end


   initial begin
      #0;
      irq_ext = 0;

      P1reg = 16'h0;
      reset_a_n = 0;
      #10;
      reset_a_n = 1;
   end
   assign P1[15:0] = P1reg[15:0];
endmodule // tb_nanorv32
/*
 Local Variables:
 verilog-library-directories:(
 "."
 "../../rtl/cores"
 "../../rtl/chips"
 )
 End:
 */
