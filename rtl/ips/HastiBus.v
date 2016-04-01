module HastiBus(input clk, input reset,
    input [31:0] io_master_haddr,
    input  io_master_hwrite,
    input [2:0] io_master_hsize,
    input [2:0] io_master_hburst,
    input [3:0] io_master_hprot,
    input [1:0] io_master_htrans,
    input  io_master_hmastlock,
    input [31:0] io_master_hwdata,
    output[31:0] io_master_hrdata,
    output io_master_hready,
    output io_master_hresp,
    output[31:0] io_slaves_2_haddr,
    output io_slaves_2_hwrite,
    output[2:0] io_slaves_2_hsize,
    output[2:0] io_slaves_2_hburst,
    output[3:0] io_slaves_2_hprot,
    output[1:0] io_slaves_2_htrans,
    output io_slaves_2_hmastlock,
    output[31:0] io_slaves_2_hwdata,
    input [31:0] io_slaves_2_hrdata,
    output io_slaves_2_hsel,
    output io_slaves_2_hreadyin,
    input  io_slaves_2_hreadyout,
    input  io_slaves_2_hresp,
    output[31:0] io_slaves_1_haddr,
    output io_slaves_1_hwrite,
    output[2:0] io_slaves_1_hsize,
    output[2:0] io_slaves_1_hburst,
    output[3:0] io_slaves_1_hprot,
    output[1:0] io_slaves_1_htrans,
    output io_slaves_1_hmastlock,
    output[31:0] io_slaves_1_hwdata,
    input [31:0] io_slaves_1_hrdata,
    output io_slaves_1_hsel,
    output io_slaves_1_hreadyin,
    input  io_slaves_1_hreadyout,
    input  io_slaves_1_hresp,
    output[31:0] io_slaves_0_haddr,
    output io_slaves_0_hwrite,
    output[2:0] io_slaves_0_hsize,
    output[2:0] io_slaves_0_hburst,
    output[3:0] io_slaves_0_hprot,
    output[1:0] io_slaves_0_htrans,
    output io_slaves_0_hmastlock,
    output[31:0] io_slaves_0_hwdata,
    input [31:0] io_slaves_0_hrdata,
    output io_slaves_0_hsel,
    output io_slaves_0_hreadyin,
    input  io_slaves_0_hreadyout,
    input  io_slaves_0_hresp
);

  wire T0;
  reg  skb_valid;
  wire T67;
  wire T1;
  wire T2;
  wire T3;
  wire T4;
  wire T5;
  wire T6;
  wire[2:0] T7;
  wire[2:0] T8;
  wire[2:0] T9;
  wire T10;
  wire T11;
  wire[1:0] master_htrans;
  reg [1:0] skb_htrans;
  wire[1:0] T12;
  wire T13;
  wire T14;
  wire[3:0] T15;
  wire[31:0] master_haddr;
  reg [31:0] skb_haddr;
  wire[31:0] T16;
  wire T17;
  wire T18;
  wire T19;
  wire[3:0] T20;
  wire T21;
  wire T22;
  wire T23;
  wire[3:0] T24;
  wire T25;
  wire T26;
  wire T27;
  wire T28;
  wire T29;
  wire T30;
  wire T31;
  wire T32;
  reg  R33;
  wire T68;
  wire T34;
  wire T35;
  reg  R36;
  wire T69;
  wire T37;
  reg  R38;
  wire T70;
  wire T39;
  wire master_hready;
  wire T40;
  wire T41;
  wire T42;
  wire T43;
  wire T44;
  wire T45;
  wire T46;
  wire T47;
  wire[31:0] master_hwdata;
  reg [31:0] skb_hwdata;
  wire master_hmastlock;
  reg  skb_hmastlock;
  wire T48;
  wire[3:0] master_hprot;
  reg [3:0] skb_hprot;
  wire[3:0] T49;
  wire[2:0] master_hburst;
  reg [2:0] skb_hburst;
  wire[2:0] T50;
  wire[2:0] master_hsize;
  reg [2:0] skb_hsize;
  wire[2:0] T51;
  wire master_hwrite;
  reg  skb_hwrite;
  wire T52;
  wire T53;
  wire T54;
  wire T55;
  wire T56;
  wire T57;
  wire T58;
  wire T59;
  wire T60;
  wire T61;
  wire[31:0] T62;
  wire[31:0] T63;
  wire[31:0] T64;
  wire[31:0] T65;
  wire[31:0] T66;

`ifndef AHBMLI_SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    skb_valid = {1{$random}};
    skb_htrans = {1{$random}};
    skb_haddr = {1{$random}};
    R33 = {1{$random}};
    R36 = {1{$random}};
    R38 = {1{$random}};
    skb_hwdata = {1{$random}};
    skb_hmastlock = {1{$random}};
    skb_hprot = {1{$random}};
    skb_hburst = {1{$random}};
    skb_hsize = {1{$random}};
    skb_hwrite = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_slaves_0_hreadyin = T0;
  assign T0 = skb_valid | io_master_hready;
  assign T67 = reset ? 1'h0 : T1;
  assign T1 = master_hready ? T2 : skb_valid;
  assign T2 = T32 & T3;
  assign T3 = T25 | T4;
  assign T4 = T6 & T5;
  assign T5 = io_slaves_2_hreadyout ^ 1'h1;
  assign T6 = T7[2'h2];
  assign T7 = T21 ? 3'h1 : T8;
  assign T8 = T17 ? 3'h2 : T9;
  assign T9 = T10 ? 3'h4 : 3'h0;
  assign T10 = T14 & T11;
  assign T11 = master_htrans != 2'h0;
  assign master_htrans = skb_valid ? skb_htrans : io_master_htrans;
  assign T12 = T13 ? io_master_htrans : skb_htrans;
  assign T13 = master_hready & T2;
  assign T14 = T15 == 4'h2;
  assign T15 = master_haddr[5'h1f:5'h1c];
  assign master_haddr = skb_valid ? skb_haddr : io_master_haddr;
  assign T16 = T13 ? io_master_haddr : skb_haddr;
  assign T17 = T19 & T18;
  assign T18 = master_htrans != 2'h0;
  assign T19 = T20 == 4'h0;
  assign T20 = master_haddr[5'h1f:5'h1c];
  assign T21 = T23 & T22;
  assign T22 = master_htrans != 2'h0;
  assign T23 = T24 == 4'hf;
  assign T24 = master_haddr[5'h1f:5'h1c];
  assign T25 = T29 | T26;
  assign T26 = T28 & T27;
  assign T27 = io_slaves_1_hreadyout ^ 1'h1;
  assign T28 = T7[1'h1];
  assign T29 = T31 & T30;
  assign T30 = io_slaves_0_hreadyout ^ 1'h1;
  assign T31 = T7[1'h0];
  assign T32 = T35 | R33;
  assign T68 = reset ? 1'h0 : T34;
  assign T34 = master_hready ? T6 : R33;
  assign T35 = R38 | R36;
  assign T69 = reset ? 1'h0 : T37;
  assign T37 = master_hready ? T28 : R36;
  assign T70 = reset ? 1'h0 : T39;
  assign T39 = master_hready ? T31 : R38;
  assign master_hready = T45 | T40;
  assign T40 = T42 | T41;
  assign T41 = R33 ? io_slaves_2_hreadyout : 1'h0;
  assign T42 = T44 | T43;
  assign T43 = R36 ? io_slaves_1_hreadyout : 1'h0;
  assign T44 = R38 ? io_slaves_0_hreadyout : 1'h0;
  assign T45 = T46 == 1'h0;
  assign T46 = T47 | R33;
  assign T47 = R38 | R36;
  assign io_slaves_0_hsel = T31;
  assign io_slaves_0_hwdata = master_hwdata;
  assign master_hwdata = skb_valid ? skb_hwdata : io_master_hwdata;
  assign io_slaves_0_hmastlock = master_hmastlock;
  assign master_hmastlock = skb_valid ? skb_hmastlock : io_master_hmastlock;
  assign T48 = T13 ? io_master_hmastlock : skb_hmastlock;
  assign io_slaves_0_htrans = master_htrans;
  assign io_slaves_0_hprot = master_hprot;
  assign master_hprot = skb_valid ? skb_hprot : io_master_hprot;
  assign T49 = T13 ? io_master_hprot : skb_hprot;
  assign io_slaves_0_hburst = master_hburst;
  assign master_hburst = skb_valid ? skb_hburst : io_master_hburst;
  assign T50 = T13 ? io_master_hburst : skb_hburst;
  assign io_slaves_0_hsize = master_hsize;
  assign master_hsize = skb_valid ? skb_hsize : io_master_hsize;
  assign T51 = T13 ? io_master_hsize : skb_hsize;
  assign io_slaves_0_hwrite = master_hwrite;
  assign master_hwrite = skb_valid ? skb_hwrite : io_master_hwrite;
  assign T52 = T13 ? io_master_hwrite : skb_hwrite;
  assign io_slaves_0_haddr = master_haddr;
  assign io_slaves_1_hreadyin = T53;
  assign T53 = skb_valid | io_master_hready;
  assign io_slaves_1_hsel = T28;
  assign io_slaves_1_hwdata = master_hwdata;
  assign io_slaves_1_hmastlock = master_hmastlock;
  assign io_slaves_1_htrans = master_htrans;
  assign io_slaves_1_hprot = master_hprot;
  assign io_slaves_1_hburst = master_hburst;
  assign io_slaves_1_hsize = master_hsize;
  assign io_slaves_1_hwrite = master_hwrite;
  assign io_slaves_1_haddr = master_haddr;
  assign io_slaves_2_hreadyin = T54;
  assign T54 = skb_valid | io_master_hready;
  assign io_slaves_2_hsel = T6;
  assign io_slaves_2_hwdata = master_hwdata;
  assign io_slaves_2_hmastlock = master_hmastlock;
  assign io_slaves_2_htrans = master_htrans;
  assign io_slaves_2_hprot = master_hprot;
  assign io_slaves_2_hburst = master_hburst;
  assign io_slaves_2_hsize = master_hsize;
  assign io_slaves_2_hwrite = master_hwrite;
  assign io_slaves_2_haddr = master_haddr;
  assign io_master_hresp = T55;
  assign T55 = T57 | T56;
  assign T56 = R33 ? io_slaves_2_hresp : 1'h0;
  assign T57 = T59 | T58;
  assign T58 = R36 ? io_slaves_1_hresp : 1'h0;
  assign T59 = R38 ? io_slaves_0_hresp : 1'h0;
  assign io_master_hready = T60;
  assign T60 = T61 & master_hready;
  assign T61 = skb_valid ^ 1'h1;
  assign io_master_hrdata = T62;
  assign T62 = T64 | T63;
  assign T63 = R33 ? io_slaves_2_hrdata : 32'h0;
  assign T64 = T66 | T65;
  assign T65 = R36 ? io_slaves_1_hrdata : 32'h0;
  assign T66 = R38 ? io_slaves_0_hrdata : 32'h0;

  always @(posedge clk) begin
    if(reset) begin
      skb_valid <= 1'h0;
    end else if(master_hready) begin
      skb_valid <= T2;
    end
    if(T13) begin
      skb_htrans <= io_master_htrans;
    end
    if(T13) begin
      skb_haddr <= io_master_haddr;
    end
    if(reset) begin
      R33 <= 1'h0;
    end else if(master_hready) begin
      R33 <= T6;
    end
    if(reset) begin
      R36 <= 1'h0;
    end else if(master_hready) begin
      R36 <= T28;
    end
    if(reset) begin
      R38 <= 1'h0;
    end else if(master_hready) begin
      R38 <= T31;
    end
    skb_hwdata <= skb_hwdata;
    if(T13) begin
      skb_hmastlock <= io_master_hmastlock;
    end
    if(T13) begin
      skb_hprot <= io_master_hprot;
    end
    if(T13) begin
      skb_hburst <= io_master_hburst;
    end
    if(T13) begin
      skb_hsize <= io_master_hsize;
    end
    if(T13) begin
      skb_hwrite <= io_master_hwrite;
    end
  end
endmodule
