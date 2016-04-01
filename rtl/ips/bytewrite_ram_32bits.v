// Single-Port BRAM with Byte-wide Write Enable
//	Read-First mode
//	Single-process description
//	Compact description of the write with a generate-for
//   statement
//	Column width and number of columns easily configurable
//
// bytewrite_ram_32bits.v
//
// `timescale 1ns/1ps

module bytewrite_ram_32bits (clk, we, addr, din, dout);

parameter SIZE = 1024;
parameter ADDR_WIDTH = 12;

parameter filename = "code.hex";

localparam COL_WIDTH = 8;
localparam NB_COL = 4;




input	clk;
input	[NB_COL-1:0]	we;
input	[ADDR_WIDTH-1:0]	addr;
input	[NB_COL*COL_WIDTH-1:0] din;
output  [NB_COL*COL_WIDTH-1:0] dout;

reg	[NB_COL*COL_WIDTH-1:0] RAM [SIZE-1:0];

   integer                     _i;

   wire [ADDR_WIDTH-1:0]      addr_dly;
   reg  [NB_COL*COL_WIDTH-1:0] dout_int;
initial begin
`ifndef NO_RAM_INIT
   $readmemh(filename,RAM);
`endif
//   #10;
//   // Just for debugging readmemh in case it does not work as expected
//   for(_i=0;_i<6;_i=_i+1) begin
//      $display("idx : %d data : %x",_i,RAM[_i]);
//   end
//   $display("======================");
end



always @(posedge clk)
  begin
    dout_int <= RAM[addr];
     // $display("%t -D- reading code rom : addr %x ",$realtime,addr);
end

   // assign #60 dout = dout_int;
   assign dout = dout_int;


// Remove the original generate statement to ease Xilinx memory bitstream patching
always @(posedge clk) begin
   if (we[0]) begin
      // $display("-I Write to address %x , data %x (%t)",addr,din,$realtime);
     RAM[addr][(0+1)*COL_WIDTH-1:0*COL_WIDTH] <= din[(0+1)*COL_WIDTH-1:0*COL_WIDTH];



   end
end


always @(posedge clk) begin
   if (we[1])
     RAM[addr][(1+1)*COL_WIDTH-1:1*COL_WIDTH] <= din[(1+1)*COL_WIDTH-1:1*COL_WIDTH];
end

always @(posedge clk) begin
   if (we[2])
     RAM[addr][(2+1)*COL_WIDTH-1:2*COL_WIDTH] <= din[(2+1)*COL_WIDTH-1:2*COL_WIDTH];
end


always @(posedge clk) begin
   if (we[3])
     RAM[addr][(3+1)*COL_WIDTH-1:3*COL_WIDTH] <= din[(3+1)*COL_WIDTH-1:3*COL_WIDTH];
end





endmodule
