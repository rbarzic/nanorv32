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

module tb_nanorv32;

   `include "nanorv32_parameters.v"
   parameter ROM_ADDRESS_SIZE  = NANORV32_ADDR_SIZE-1; // Rom is half of the address space


   /*AUTOREG*/
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire                 clk;                    // From U_CLOCK_GEN of clock_gen.v
   wire                 rst_n;                  // From U_RESET_GEN of reset_gen.v
   // End of automatics


    /* nanorv32 AUTO_TEMPLATE(
     ); */
   nanorv32_simple U_DUT (
                           /*AUTOINST*/
                          // Inputs
                          .clk                  (clk),
                          .rst_n                (rst_n));






    /* reset_gen AUTO_TEMPLATE(
     .reset_n              (rst_n));
     ); */
   reset_gen U_RESET_GEN (
                          /*AUTOINST*/
                          // Outputs
                          .reset_n              (rst_n));         // Templated


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

               U_DUT.U_CODE_MEM.RAM[i]  = tmp;

            end
         end
      end
   endtask // load_program_memory

   task vcd_dump;
      begin
         if ($test$plusargs("vcd")) begin
	    $dumpfile("tb_nanorv32.vcd");
	    $dumpvars(0, tb_nanorv32);
	 end
      end
   endtask // if

   initial begin
      #1;
      load_program_memory();
      vcd_dump();
      #1000000;
      $display("-E- Timeout !");
      $finish(3);

   end


   // PC monitoring
   wire [NANORV32_DATA_MSB:0] pc;
   wire [NANORV32_DATA_MSB:0] x10_a0; // return value register

   assign pc = U_DUT.U_CPU.pc_exe_r;
   assign x10_a0 = U_DUT.U_CPU.U_REG_FILE.regfile[10];

   always @(posedge clk) begin
      if(pc === 32'h00000100) begin
         if(x10_a0 === 32'hCAFFE000) begin
            $display("-I- TEST OK");
            $finish(0);
         end
         else
           if(x10_a0 === 32'h0DEAD0000) begin
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
