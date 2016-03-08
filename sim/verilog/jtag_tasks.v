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

event dbg_jtag_tdo_capture;


task read_write_bit;
   input [2:0] bitvals;
   output      l_tdi_val;
   begin

      // read bit state

      -> dbg_jtag_tdo_capture;

      l_tdi_val <= `TDO;
      // Set data
      jtag_out(bitvals & ~(`JTAG_TCK_bit));
      `wait_jtag_period;

      // Raise clock
      jtag_out(bitvals | `JTAG_TCK_bit);
      `wait_jtag_period;

      // drop clock (making output available in the SHIFT_xR states)
      jtag_out(bitvals & ~(`JTAG_TCK_bit));
      #1;


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


task select_debug_module;
   input [1:0] moduleid;
   reg         validid;
   begin
      write_bit(`JTAG_TMS_bit);  // select_dr_scan
      write_bit(3'h0);           // capture_ir
      write_bit(3'h0);           // shift_ir
      jtag_write_stream({1'b1,moduleid}, 8'h3, 1);  // write data, exit_1
      write_bit(`JTAG_TMS_bit);  // update_dr
      write_bit(3'h0);           // idle

      $display("Selecting module (%0x)", moduleid);

      // Read back the status to make sure a valid chain is selected
      /* Pointless, the newly selected module would respond instead...
       write_bit(`JTAG_TMS_bit);  // select_dr_scan
       write_bit(3'h0);           // capture_ir
       write_bit(3'h0);           // shift_ir
       read_write_bit(`JTAG_TMS_bit, validid);  // get data, exit_1
       write_bit(`JTAG_TMS_bit);  // update_dr
       write_bit(3'h0);           // idle

       if(validid)   $display("Selected valid module (%0x)", moduleid);
       else          $display("Failed to select module (%0x)", moduleid);
       */
   end

endtask // write_bit

task select_module_internal_register;  // Really just a read, with discarded data
      input [31:0] regidx;
      input [7:0]  len;  // the length of the register index data, we assume not more than 32
      reg [63:0]   streamdata;
      begin
         streamdata = 64'h0;
         streamdata = streamdata | regidx;
         streamdata = streamdata | (`DBG_WB_CMD_IREG_SEL << len);
         write_bit(`JTAG_TMS_bit);  // select_dr_scan
         write_bit(3'h0);           // capture_ir
         write_bit(3'h0);           // shift_ir
         jtag_write_stream(streamdata, (len+5), 1);  // write data, exit_1
         write_bit(`JTAG_TMS_bit);  // update_dr
         write_bit(3'h0);           // idle
      end
   endtask



task read_module_internal_register;  // We assume the register is already selected
    //input [31:0] regidx;
    input [7:0] len;  // the length of the data desired, we assume a max of 64 bits
    output [63:0] instream;
    reg [63:0] bitmask;
begin
    instream = 64'h0;
    // We shift out all 0's, which is a NOP to the debug unit
    write_bit(`JTAG_TMS_bit);  // select_dr_scan
    write_bit(3'h0);           // capture_ir
    write_bit(3'h0);           // shift_ir
    // Shift at least 5 bits, as this is the min, for a valid NOP
    jtag_read_write_stream(64'h0, len+4,1,instream);  // exit_1
    write_bit(`JTAG_TMS_bit);  // update_dr
    write_bit(3'h0);           // idle
    bitmask = 64'hffffffffffffffff;
    bitmask = bitmask << len;
    bitmask = ~bitmask;
    instream = instream & bitmask;  // Cut off any unwanted excess bits
end
endtask

task write_module_internal_register;
    input [31:0] regidx; // the length of the register index data
    input [7:0] idxlen;
    input [63:0] writedata;
    input [7:0] datalen;  // the length of the data to write.  We assume the two length combined are 59 or less.
    reg[63:0] streamdata;
begin
    streamdata = 64'h0;  // This will 0 the toplevel/module select bit
    streamdata = streamdata | writedata;
    streamdata = streamdata | (regidx << datalen);
    streamdata = streamdata | (`DBG_WB_CMD_IREG_WR << (idxlen+datalen));

    write_bit(`JTAG_TMS_bit);  // select_dr_scan
    write_bit(3'h0);           // capture_ir
    write_bit(3'h0);           // shift_ir
    jtag_write_stream(streamdata, (idxlen+datalen+5), 1);  // write data, exit_1
    write_bit(`JTAG_TMS_bit);  // update_dr
    write_bit(3'h0);           // idle
end
endtask



task send_module_burst_command;
input [3:0] opcode;
input [31:0] address;
input [15:0] burstlength;
reg [63:0] streamdata;
begin
    streamdata = {11'h0,1'b0,opcode,address,burstlength};
    write_bit(`JTAG_TMS_bit);  // select_dr_scan
    write_bit(3'h0);           // capture_ir
    write_bit(3'h0);           // shift_ir
    jtag_write_stream(streamdata, 8'd53, 1);  // write data, exit_1
    write_bit(`JTAG_TMS_bit);  // update_dr
    write_bit(3'h0);           // idle
end
endtask

`define DBG_CRC_POLY 32'hedb88320

task compute_crc;
   input [31:0] crc_in;
   input [31:0] data_in;
   input [5:0]  length_bits;
   output [31:0] crc_out;
   integer       i;
   reg [31:0]    d;
   reg [31:0]    c;
   begin
      crc_out = crc_in;
      for(i = 0; i < length_bits; i = i+1) begin
         d = (data_in[i]) ? 32'hffffffff : 32'h0;
         c = (crc_out[0]) ? 32'hffffffff : 32'h0;
         //crc_out = {crc_out[30:0], 1'b0};  // original
         crc_out = crc_out >> 1;
         crc_out = crc_out ^ ((d ^ c) & `DBG_CRC_POLY);
         //$display("CRC Itr %d, inbit = %d, crc = 0x%x", i, data_in[i], crc_out);
      end
   end
endtask


task do_module_burst_write;
input [5:0] word_size_bytes;
input [15:0] word_count;
input [31:0] start_address;
reg [3:0] opcode;
reg status;
reg [63:0] dataword;
integer i;
integer j;
reg [31:0] crc_calc_i;
reg [31:0] crc_calc_o;
reg crc_match;
reg [5:0] word_size_bits;
begin
    $display("Doing burst write, word size %d, word count %d, start address 0x%x", word_size_bytes, word_count, start_address);
    word_size_bits = word_size_bytes << 3;
    crc_calc_i = 32'hffffffff;

    // Send the command
    case (word_size_bytes)
       3'h1: opcode = `DBG_WB_CMD_BWRITE8;
       3'h2: opcode = `DBG_WB_CMD_BWRITE16;
       3'h4: opcode = `DBG_WB_CMD_BWRITE32;
       default:
          begin
           $display("Tried burst write with invalid word size (%0x), defaulting to 4-byte words", word_size_bytes);
           opcode = `DBG_WB_CMD_BWRITE32;
          end
   endcase

   send_module_burst_command(opcode, start_address, word_count);  // returns to state idle

   // Get us back to shift_dr mode to write a burst
   write_bit(`JTAG_TMS_bit);  // select_dr_scan
   write_bit(3'h0);           // capture_ir
   write_bit(3'h0);           // shift_ir


   // Write a start bit (a 1) so it knows when to start counting
   write_bit(`JTAG_TDI_bit);

   // Now, repeat...
   for(i = 0; i < word_count; i=i+1) begin
      // Write word_size_bytes*8 bits, then get 1 status bit
      if(word_size_bytes == 4)      dataword = {32'h0, static_data32[i]};
      else if(word_size_bytes == 2) dataword = {48'h0, static_data16[i]};
      else                          dataword = {56'h0, static_data8[i]};


      jtag_write_stream(dataword, {2'h0,(word_size_bytes<<3)},0);
      compute_crc(crc_calc_i, dataword[31:0], word_size_bits, crc_calc_o);
      crc_calc_i = crc_calc_o;


`ifndef ADBG_USE_HISPEED
      // Check if WB bus is ready
      // *** THIS WILL NOT WORK IF THERE IS MORE THAN 1 DEVICE IN THE JTAG CHAIN!!!
      status = 1'b0;
      read_write_bit(3'h0, status);

      if(!status) begin
         $display("Bad status bit during burst write, index %d", i);
      end
`endif

     $display("Wrote 0x%0x", dataword);
   end
   $display("Done writing %d word",word_count);
   // Send the CRC we computed
   jtag_write_stream(crc_calc_o, 6'd32,0);

   // Read the 'CRC match' bit, and go to exit1_dr
   read_write_bit(`JTAG_TMS_bit, crc_match);
   if(!crc_match) $display("CRC ERROR! match bit after write is %d (computed CRC 0x%x)", crc_match, crc_calc_o);
   else $display("CRC OK!");

   // Finally, shift out 5 0's, to make the next command a NOP
   // Not necessary, module will not latch new opcode during burst
   //jtag_write_stream(64'h0, 8'h5, 1);
   write_bit(`JTAG_TMS_bit);  // update_ir
   write_bit(3'h0);           // idle
end

endtask

task do_module_burst_read;
input [5:0] word_size_bytes;
input [15:0] word_count;
input [31:0] start_address;
reg [3:0] opcode;
reg status;
reg [63:0] instream;
integer i;
integer j;
reg [31:0] crc_calc_i;
reg [31:0] crc_calc_o;  // temp signal...
reg [31:0] crc_read;
reg [5:0] word_size_bits;
begin
    $display("Doing burst read, word size %d, word count %d, start address 0x%x", word_size_bytes, word_count, start_address);
    instream = 64'h0;
    word_size_bits = word_size_bytes << 3;
    crc_calc_i = 32'hffffffff;

    // Send the command
    case (word_size_bytes)
       3'h1: opcode = `DBG_WB_CMD_BREAD8;
       3'h2: opcode = `DBG_WB_CMD_BREAD16;
       3'h4: opcode = `DBG_WB_CMD_BREAD32;
       default:
          begin
           $display("Tried burst read with invalid word size (%0x), defaulting to 4-byte words", word_size_bytes);
           opcode = `DBG_WB_CMD_BREAD32;
          end
   endcase

   send_module_burst_command(opcode,start_address, word_count);  // returns to state idle

   // Get us back to shift_dr mode to read a burst
   write_bit(`JTAG_TMS_bit);  // select_dr_scan
   write_bit(3'h0);           // capture_ir
   write_bit(3'h0);           // shift_ir

`ifdef ADBG_USE_HISPEED
      // Get 1 status bit, then word_size_bytes*8 bits
      status = 1'b0;
      j = 0;
      while(!status) begin
         read_write_bit(3'h0, status);
         j = j + 1;
      end

      if(j > 1) begin
         $display("Took %0d tries before good status bit during burst read", j);
      end
`endif

   // Now, repeat...
   for(i = 0; i < word_count; i=i+1) begin

`ifndef ADBG_USE_HISPEED
      // Get 1 status bit, then word_size_bytes*8 bits
      status = 1'b0;
      j = 0;
      while(!status) begin
         read_write_bit(3'h0, status);
         j = j + 1;
      end

      if(j > 1) begin
         $display("Took %0d tries before good status bit during burst read", j);
      end
`endif

     jtag_read_write_stream(64'h0, {2'h0,(word_size_bytes<<3)},0,instream);
     //$display("Read 0x%0x", instream[31:0]);
     compute_crc(crc_calc_i, instream[31:0], word_size_bits, crc_calc_o);
     crc_calc_i = crc_calc_o;
     if(word_size_bytes == 1) input_data8[i] = instream[7:0];
     else if(word_size_bytes == 2) input_data16[i] = instream[15:0];
     else input_data32[i] = instream[31:0];
   end

   // Read the data CRC from the debug module.
   jtag_read_write_stream(64'h0, 6'd32, 1, crc_read);
   if(crc_calc_o != crc_read) $display("CRC ERROR! Computed 0x%x, read CRC 0x%x", crc_calc_o, crc_read);
   else $display("CRC OK!");

   // Finally, shift out 5 0's, to make the next command a NOP
   // Not necessary, debug unit won't latch a new opcode at the end of a burst
   //jtag_write_stream(64'h0, 8'h5, 1);
   write_bit(`JTAG_TMS_bit);  // update_ir
   write_bit(3'h0);           // idle
end
endtask
