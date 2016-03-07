`timescale 1ns/1ps
module jtag_simple;
   /*AUTOREG*/
   /*AUTOWIRE*/

`include "tap_defines.v"
`include "tb_defines.v"
`include "jtag_tasks.v"

   initial begin

      `TCK <= 1'b0;
      `TMS <= 1'b0;
      `TDI <= 1'b0;
      $display("-I- jtag_simple test started !");
      reset_jtag;
      #100;
      check_idcode;
      #100;
   end

endmodule // jtag_simple
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
