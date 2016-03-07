// Little difference with code from adv_debug_sys :
// we name the pin according to the target,
// not according to the "virtual" JTAG master
`define JTAG_TMS 0
`define JTAG_TCK 1
`define JTAG_TDI 2 // TDO in adv_debug_sys testbench

`define JTAG_TMS_bit 3'h1
`define JTAG_TCK_bit 3'h2
`define JTAG_TDI_bit 3'h4

`define wait_jtag_period #50


task jtag_out;
   input   [2:0]   bitvals;
   begin

      `TCK <= bitvals[`JTAG_TCK];
      `TMS <= bitvals[`JTAG_TMS];
      `TDI <= bitvals[`JTAG_TDI];
   end
endtask


task jtag_inout;
   input   [2:0]   bitvals;
   output          l_tdo_val;
   begin

      `TCK <= bitvals[`JTAG_TCK];
      `TMS <= bitvals[`JTAG_TMS];
      `TDI <= bitvals[`JTAG_TDI];

      l_tdo_val <= `TDO;
   end
endtask


task write_bit;
   input [2:0] bitvals;
   begin

      // Set data
      jtag_out(bitvals & ~(`JTAG_TCK_bit));
      `wait_jtag_period;

      // Raise clock
      jtag_out(bitvals | `JTAG_TCK_bit);
      `wait_jtag_period;

      // drop clock (making output available in the SHIFT_xR states)
      jtag_out(bitvals & ~(`JTAG_TCK_bit));
      `wait_jtag_period;
   end
endtask

task read_write_bit;
   input [2:0] bitvals;
   output      l_tdi_val;
   begin

      // read bit state
      l_tdi_val <= `TDO;

      // Set data
      jtag_out(bitvals & ~(`JTAG_TCK_bit));
      `wait_jtag_period;

      // Raise clock
      jtag_out(bitvals | `JTAG_TCK_bit);
      `wait_jtag_period;

      // drop clock (making output available in the SHIFT_xR states)
      jtag_out(bitvals & ~(`JTAG_TCK_bit));
      `wait_jtag_period;
   end
endtask




task reset_jtag;
   integer i;
   begin
      for(i = 0; i < 8; i=i+1) begin
         write_bit(`JTAG_TMS_bit);  // 5 TMS should put us in test_logic_reset mode
      end
      write_bit(3'h0);              // idle
   end
endtask


task jtag_write_stream;
   input [63:0] stream;
   input [7:0]  len;
   input        set_last_bit;
   integer      i;
   integer      databit;
   reg [2:0]    bits;
   begin
      for(i = 0; i < (len-1); i=i+1) begin
         databit = (stream >> i) & 1'h1;
         bits = databit << `JTAG_TDI;
         write_bit(bits);
      end

      databit = (stream >> i) & 1'h1;
      bits = databit << `JTAG_TDI;
      if(set_last_bit) bits = (bits | `JTAG_TMS_bit);
      write_bit(bits);

   end
endtask // for


task jtag_read_write_stream;
   input [63:0] stream;
   input [7:0]  len;
   input        set_last_bit;
   output [63:0] instream;
   integer       i;
   integer       databit;
   reg [2:0]     bits;
   reg           inbit;
   begin
      instream = 64'h0;
      for(i = 0; i < (len-1); i=i+1) begin
         databit = (stream >> i) & 1'h1;
         bits = databit << `JTAG_TDI;
         read_write_bit(bits, inbit);
         instream = (instream | (inbit << i));
      end

      databit = (stream >> i) & 1'h1;
      bits = databit << `JTAG_TDI;
      if(set_last_bit) bits = (bits | `JTAG_TMS_bit);
      read_write_bit(bits, inbit);
      instream = (instream | (inbit << (len-1)));
   end
endtask



// Puts a value in the TAP IR, assuming we start in IDLE state.
// Returns to IDLE state when finished
task set_ir;
   input [3:0] irval;
   begin
      write_bit(`JTAG_TMS_bit);  // select_dr_scan
      write_bit(`JTAG_TMS_bit);  // select_ir_scan
      write_bit(3'h0);           // capture_ir
      write_bit(3'h0);           // shift_ir
      jtag_write_stream({60'h0,irval}, 8'h4, 1);  // write data, exit_1
      write_bit(`JTAG_TMS_bit);  // update_ir
      write_bit(3'h0);           // idle
   end
endtask // write_bit





task check_idcode;
   reg [63:0] readdata;
   reg [31:0] idcode;
   begin
      set_ir(`IDCODE);

      // Read the IDCODE in the DR
      write_bit(`JTAG_TMS_bit);  // select_dr_scan
      write_bit(3'h0);           // capture_ir
      write_bit(3'h0);           // shift_ir
      jtag_read_write_stream(64'h0, 8'd32, 1, readdata);  // write data, exit_1
      write_bit(`JTAG_TMS_bit);  // update_ir
      write_bit(3'h0);           // idle
      idcode = readdata[31:0];
      $display("Got TAP IDCODE 0x%x, expected 0x%x", idcode, `IDCODE_VALUE);
   end
endtask
