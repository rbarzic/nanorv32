`timescale 1ns/1ps
module irq_test_basic;

   reg irq;
   integer i;

   initial begin
      $display("Hello from irq_test_basic !");
      #10;
      `TB.irq <= 0;
      @(posedge `TB.rst_n);
      for(i=0;i<20;i=i+1) begin
         @(posedge `TB.clk);
      end
      @(posedge `TB.clk);
      #5;
      tb_nanorv32.irq <= 1;
      for(i=0;i<3;i=i+1) begin
         @(posedge `TB.clk);
      end
      @(posedge `TB.clk);
      #5;

      tb_nanorv32.irq <= 0;

   end


   /*AUTOREG*/
   /*AUTOWIRE*/

endmodule // irq_test_basic
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
