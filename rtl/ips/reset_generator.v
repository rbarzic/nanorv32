// Generate a synchronous reset
// Reset signal (active low) is released on falling edge of the
// clock, to generate timing violation on rising edges on the clock
module reset_generator (/*AUTOARG*/
  // Outputs
  rst_n,
  // Inputs
  clk, rst_async_n
  );

  input clk;
  input rst_async_n; // asynchronous reset
  output rst_n;    // synchronous reset

  /*AUTOINPUT*/
  /*AUTOOUTPUT*/

  /*AUTOREG*/
  /*AUTOWIRE*/

  reg                   rst_async_n_m; // can be metastable
  reg                   rst_async_n_r; // can be metastable

  always @(negedge clk or negedge rst_async_n) begin
    if(rst_async_n == 1'b0) begin
      /*AUTORESET*/
      // Beginning of autoreset for uninitialized flops
      rst_async_n_m <= 1'h0;
      rst_async_n_r <= 1'h0;
      // End of automatics
    end
    else begin
      rst_async_n_m <= 1'b1; // Can be metastable
      rst_async_n_r <= rst_async_n_m;
    end
  end

  // renaming
  assign rst_n = rst_async_n_r;




endmodule // reset_generator
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
