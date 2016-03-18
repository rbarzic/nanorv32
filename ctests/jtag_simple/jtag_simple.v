`timescale 1ns/1ps
module jtag_simple;
   /*AUTOREG*/
   /*AUTOWIRE*/

`include "tap_defines.v"
`include "tb_defines.v"
`include "jtag_tasks.v"

   reg [32:0] err_data;  // holds the contents of the error register from the various modules

   // Data which will b|e written to the WB interface
   reg [31:0] static_data32 [0:15];
   reg [15:0] static_data16 [0:15];
   reg [7:0]  static_data8 [0:15];

   // Arrays to hold data read back from the WB interface, for comparison
   reg [31:0] input_data32 [0:15];
   reg [15:0] input_data16 [0:15];
   reg [7:0]  input_data8 [0:15];

   reg        failed;
   integer    i;


   event      dbg_cpu0_access0;
   event      dbg_cpu0_access1;


   initial begin

      initialize_memory(32'h0,32'h16);

      `TCK <= 1'b0;
      `TMS <= 1'b0;
      `TDI <= 1'b0;
      $display("-I- jtag_simple test started !");
      reset_jtag;
      #100;
      check_idcode;
      #100;
      set_ir(`DEBUG);


      #1000;
      $display("Selecting CPU0 module at time %t", $time);
      select_debug_module(`DBG_TOP_CPU0_DEBUG_MODULE);

      // Test reset, stall bits
      #1000;
      $display("Testing CPU0 intreg select at time %t", $time);
      select_module_internal_register(32'h1, 1);  // Really just a read, with discarded data
      #1000;
      select_module_internal_register(32'h0, 1);  // Really just a read, with discarded data
      #1000;
      // Read the stall and reset bits
      $display("Testing reset and stall bits at time %t", $time);
      read_module_internal_register(8'd2, err_data);  // We assume the register is already selected
      $display("Reset and stall bits are %x", err_data);
      #1000;

      //  Set rst/stall bits
      $display("Setting reset and stall bits at time %t", $time);
      write_module_internal_register(32'h0, 8'h1, 32'h3, 8'h2);  // idx, idxlen, data, datalen
      #1000;

      // Read the bits again
      $display("Testing reset and stall bits again at time %t", $time);
      read_module_internal_register(8'd2, err_data);  // We assume the register is already selected
      $display("Reset and stall bits are %x", err_data);
      #1000;

      // Clear the bits
      $display("Clearing reset and stall bits at time %t", $time);
      write_module_internal_register(32'h0, 8'h1, 32'h0, 8'h2);  // idx, idxlen, data, datalen
      #1000;

      // Test SPR bus access
      $display("Testing CPU0 32-bit burst write at time %t", $time);
      -> dbg_cpu0_access0;

      do_module_burst_write(3'h4, 16'd16, 32'h10);  // 3-bit word size (bytes), 16-bit word count, 32-bit start address
      -> dbg_cpu0_access1;
      #1000;
      $display("Selecting Wishbone module at time %t", $time);
      select_debug_module(`DBG_TOP_WISHBONE_DEBUG_MODULE);
      #1000;


      failed = 0;
      $display("Testing WB 32-bit burst write at time %t", $time);
      do_module_burst_write(3'h4, 16'd16, 32'h0);  // 3-bit word size (bytes), 16-bit word count, 32-bit start address
      #1000;
      $display("Testing WB 32-bit burst read at time %t", $time);
      do_module_burst_read(3'h4, 16'd16, 32'h0);
      #1000;
      for(i = 0; i < 16; i = i+1) begin
         if(static_data32[i] != input_data32[i]) begin
            failed = 1;
            $display("32-bit data mismatch at index %d, wrote 0x%x, read 0x%x", i, static_data32[i], input_data32[i]);
         end
      end
      if(!failed) $display("32-bit read/write OK!");


      $display("-I- Jtag_simple testbench finished");
      $finish(0);


   end

   task initialize_memory;
      input [31:0] start_addr;
      input [31:0] length;
      integer      i;
      reg [31:0]   addr;
      begin

         for (i=0; i<length; i=i+1)
           begin
              static_data32[i] <= {i[7:0], i[7:0]+2'd1, i[7:0]+2'd2, i[7:0]+2'd3};
              static_data16[i] <= {i[7:0], i[7:0]+ 2'd1};
              static_data8[i] <= i[7:0];
           end
      end
   endtask



endmodule // jtag_simple
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
