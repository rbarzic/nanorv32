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

`ifndef SYNTHESIS
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

module HastiSlaveMux(input clk, input reset,
    input [31:0] io_ins_1_haddr,
    input  io_ins_1_hwrite,
    input [2:0] io_ins_1_hsize,
    input [2:0] io_ins_1_hburst,
    input [3:0] io_ins_1_hprot,
    input [1:0] io_ins_1_htrans,
    input  io_ins_1_hmastlock,
    input [31:0] io_ins_1_hwdata,
    output[31:0] io_ins_1_hrdata,
    input  io_ins_1_hsel,
    input  io_ins_1_hreadyin,
    output io_ins_1_hreadyout,
    output io_ins_1_hresp,
    input [31:0] io_ins_0_haddr,
    input  io_ins_0_hwrite,
    input [2:0] io_ins_0_hsize,
    input [2:0] io_ins_0_hburst,
    input [3:0] io_ins_0_hprot,
    input [1:0] io_ins_0_htrans,
    input  io_ins_0_hmastlock,
    input [31:0] io_ins_0_hwdata,
    output[31:0] io_ins_0_hrdata,
    input  io_ins_0_hsel,
    input  io_ins_0_hreadyin,
    output io_ins_0_hreadyout,
    output io_ins_0_hresp,
    output[31:0] io_out_haddr,
    output io_out_hwrite,
    output[2:0] io_out_hsize,
    output[2:0] io_out_hburst,
    output[3:0] io_out_hprot,
    output[1:0] io_out_htrans,
    output io_out_hmastlock,
    output[31:0] io_out_hwdata,
    input [31:0] io_out_hrdata,
    output io_out_hsel,
    output io_out_hreadyin,
    input  io_out_hreadyout,
    input  io_out_hresp
);

  wire T0;
  wire T1;
  wire[1:0] T2;
  wire[1:0] T3;
  wire requests_1;
  reg  R4;
  wire T109;
  wire T5;
  wire T6;
  wire T7;
  wire T8;
  wire T9;
  wire T10;
  wire T11;
  wire T12;
  wire T13;
  wire requests_0;
  reg  R14;
  wire T110;
  wire T15;
  wire T16;
  wire T17;
  wire T18;
  wire T19;
  wire T20;
  wire T21;
  wire T22;
  wire T23;
  wire T24;
  wire[31:0] T25;
  wire[31:0] T26;
  reg  R27;
  wire T111;
  wire T28;
  wire[31:0] T29;
  reg  R30;
  wire T112;
  wire T31;
  wire T32;
  wire T33;
  wire T34;
  reg  R35;
  wire T36;
  wire T37;
  wire T38;
  wire T39;
  reg  R40;
  wire T41;
  wire T42;
  wire[1:0] T43;
  wire[1:0] T44;
  wire[1:0] T45;
  reg [1:0] R46;
  wire[1:0] T47;
  wire[1:0] T48;
  wire[1:0] T49;
  reg [1:0] R50;
  wire[1:0] T51;
  wire[3:0] T52;
  wire[3:0] T53;
  wire[3:0] T54;
  reg [3:0] R55;
  wire[3:0] T56;
  wire[3:0] T57;
  wire[3:0] T58;
  reg [3:0] R59;
  wire[3:0] T60;
  wire[2:0] T61;
  wire[2:0] T62;
  wire[2:0] T63;
  reg [2:0] R64;
  wire[2:0] T65;
  wire[2:0] T66;
  wire[2:0] T67;
  reg [2:0] R68;
  wire[2:0] T69;
  wire[2:0] T70;
  wire[2:0] T71;
  wire[2:0] T72;
  reg [2:0] R73;
  wire[2:0] T74;
  wire[2:0] T75;
  wire[2:0] T76;
  reg [2:0] R77;
  wire[2:0] T78;
  wire T79;
  wire T80;
  wire T81;
  reg  R82;
  wire T83;
  wire T84;
  wire T85;
  reg  R86;
  wire T87;
  wire[31:0] T88;
  wire[31:0] T89;
  wire[31:0] T90;
  reg [31:0] R91;
  wire[31:0] T92;
  wire[31:0] T93;
  wire[31:0] T94;
  reg [31:0] R95;
  wire[31:0] T96;
  wire T97;
  wire T98;
  wire T99;
  wire T100;
  wire[31:0] T101;
  wire[31:0] T102;
  wire[31:0] T113;
  wire T103;
  wire T104;
  wire T105;
  wire T106;
  wire[31:0] T107;
  wire[31:0] T108;
  wire[31:0] T114;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    R4 = {1{$random}};
    R14 = {1{$random}};
    R27 = {1{$random}};
    R30 = {1{$random}};
    R35 = {1{$random}};
    R40 = {1{$random}};
    R46 = {1{$random}};
    R50 = {1{$random}};
    R55 = {1{$random}};
    R59 = {1{$random}};
    R64 = {1{$random}};
    R68 = {1{$random}};
    R73 = {1{$random}};
    R77 = {1{$random}};
    R82 = {1{$random}};
    R86 = {1{$random}};
    R91 = {1{$random}};
    R95 = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_out_hreadyin = io_out_hreadyout;
  assign io_out_hsel = T0;
  assign T0 = T24 | T1;
  assign T1 = T2[1'h1];
  assign T2 = requests_0 ? 2'h1 : T3;
  assign T3 = requests_1 ? 2'h2 : 2'h0;
  assign requests_1 = T13 | R4;
  assign T109 = reset ? 1'h0 : T5;
  assign T5 = T9 ? T8 : T6;
  assign T6 = T7 ? 1'h0 : R4;
  assign T7 = io_out_hreadyout & T1;
  assign T8 = io_ins_1_hsel & io_ins_1_hreadyin;
  assign T9 = io_out_hreadyout & T10;
  assign T10 = T12 & T11;
  assign T11 = R4 ^ 1'h1;
  assign T12 = T1 ^ 1'h1;
  assign T13 = io_ins_1_hsel & io_ins_1_hreadyin;
  assign requests_0 = T23 | R14;
  assign T110 = reset ? 1'h0 : T15;
  assign T15 = T19 ? T18 : T16;
  assign T16 = T17 ? 1'h0 : R14;
  assign T17 = io_out_hreadyout & T24;
  assign T18 = io_ins_0_hsel & io_ins_0_hreadyin;
  assign T19 = io_out_hreadyout & T20;
  assign T20 = T22 & T21;
  assign T21 = R14 ^ 1'h1;
  assign T22 = T24 ^ 1'h1;
  assign T23 = io_ins_0_hsel & io_ins_0_hreadyin;
  assign T24 = T2[1'h0];
  assign io_out_hwdata = T25;
  assign T25 = T29 | T26;
  assign T26 = R27 ? io_ins_1_hwdata : 32'h0;
  assign T111 = reset ? 1'h1 : T28;
  assign T28 = io_out_hreadyout ? T1 : R27;
  assign T29 = R30 ? io_ins_0_hwdata : 32'h0;
  assign T112 = reset ? 1'h1 : T31;
  assign T31 = io_out_hreadyout ? T24 : R30;
  assign io_out_hmastlock = T32;
  assign T32 = T38 | T33;
  assign T33 = T1 ? T34 : 1'h0;
  assign T34 = R4 ? R35 : io_ins_1_hmastlock;
  assign T36 = T37 ? io_ins_1_hmastlock : R35;
  assign T37 = T9 & T8;
  assign T38 = T24 ? T39 : 1'h0;
  assign T39 = R14 ? R40 : io_ins_0_hmastlock;
  assign T41 = T42 ? io_ins_0_hmastlock : R40;
  assign T42 = T19 & T18;
  assign io_out_htrans = T43;
  assign T43 = T48 | T44;
  assign T44 = T1 ? T45 : 2'h0;
  assign T45 = R4 ? R46 : io_ins_1_htrans;
  assign T47 = T37 ? io_ins_1_htrans : R46;
  assign T48 = T24 ? T49 : 2'h0;
  assign T49 = R14 ? R50 : io_ins_0_htrans;
  assign T51 = T42 ? io_ins_0_htrans : R50;
  assign io_out_hprot = T52;
  assign T52 = T57 | T53;
  assign T53 = T1 ? T54 : 4'h0;
  assign T54 = R4 ? R55 : io_ins_1_hprot;
  assign T56 = T37 ? io_ins_1_hprot : R55;
  assign T57 = T24 ? T58 : 4'h0;
  assign T58 = R14 ? R59 : io_ins_0_hprot;
  assign T60 = T42 ? io_ins_0_hprot : R59;
  assign io_out_hburst = T61;
  assign T61 = T66 | T62;
  assign T62 = T1 ? T63 : 3'h0;
  assign T63 = R4 ? R64 : io_ins_1_hburst;
  assign T65 = T37 ? io_ins_1_hburst : R64;
  assign T66 = T24 ? T67 : 3'h0;
  assign T67 = R14 ? R68 : io_ins_0_hburst;
  assign T69 = T42 ? io_ins_0_hburst : R68;
  assign io_out_hsize = T70;
  assign T70 = T75 | T71;
  assign T71 = T1 ? T72 : 3'h0;
  assign T72 = R4 ? R73 : io_ins_1_hsize;
  assign T74 = T37 ? io_ins_1_hsize : R73;
  assign T75 = T24 ? T76 : 3'h0;
  assign T76 = R14 ? R77 : io_ins_0_hsize;
  assign T78 = T42 ? io_ins_0_hsize : R77;
  assign io_out_hwrite = T79;
  assign T79 = T84 | T80;
  assign T80 = T1 ? T81 : 1'h0;
  assign T81 = R4 ? R82 : io_ins_1_hwrite;
  assign T83 = T37 ? io_ins_1_hwrite : R82;
  assign T84 = T24 ? T85 : 1'h0;
  assign T85 = R14 ? R86 : io_ins_0_hwrite;
  assign T87 = T42 ? io_ins_0_hwrite : R86;
  assign io_out_haddr = T88;
  assign T88 = T93 | T89;
  assign T89 = T1 ? T90 : 32'h0;
  assign T90 = R4 ? R91 : io_ins_1_haddr;
  assign T92 = T37 ? io_ins_1_haddr : R91;
  assign T93 = T24 ? T94 : 32'h0;
  assign T94 = R14 ? R95 : io_ins_0_haddr;
  assign T96 = T42 ? io_ins_0_haddr : R95;
  assign io_ins_0_hresp = T97;
  assign T97 = R30 & io_out_hresp;
  assign io_ins_0_hreadyout = T98;
  assign T98 = io_out_hreadyout & T99;
  assign T99 = T100 | R30;
  assign T100 = R14 ^ 1'h1;
  assign io_ins_0_hrdata = T101;
  assign T101 = T102 & io_out_hrdata;
  assign T102 = 32'h0 - T113;
  assign T113 = {31'h0, R30};
  assign io_ins_1_hresp = T103;
  assign T103 = R27 & io_out_hresp;
  assign io_ins_1_hreadyout = T104;
  assign T104 = io_out_hreadyout & T105;
  assign T105 = T106 | R27;
  assign T106 = R4 ^ 1'h1;
  assign io_ins_1_hrdata = T107;
  assign T107 = T108 & io_out_hrdata;
  assign T108 = 32'h0 - T114;
  assign T114 = {31'h0, R27};

  always @(posedge clk) begin
    if(reset) begin
      R4 <= 1'h0;
    end else if(T9) begin
      R4 <= T8;
    end else if(T7) begin
      R4 <= 1'h0;
    end
    if(reset) begin
      R14 <= 1'h0;
    end else if(T19) begin
      R14 <= T18;
    end else if(T17) begin
      R14 <= 1'h0;
    end
    if(reset) begin
      R27 <= 1'h1;
    end else if(io_out_hreadyout) begin
      R27 <= T1;
    end
    if(reset) begin
      R30 <= 1'h1;
    end else if(io_out_hreadyout) begin
      R30 <= T24;
    end
    if(T37) begin
      R35 <= io_ins_1_hmastlock;
    end
    if(T42) begin
      R40 <= io_ins_0_hmastlock;
    end
    if(T37) begin
      R46 <= io_ins_1_htrans;
    end
    if(T42) begin
      R50 <= io_ins_0_htrans;
    end
    if(T37) begin
      R55 <= io_ins_1_hprot;
    end
    if(T42) begin
      R59 <= io_ins_0_hprot;
    end
    if(T37) begin
      R64 <= io_ins_1_hburst;
    end
    if(T42) begin
      R68 <= io_ins_0_hburst;
    end
    if(T37) begin
      R73 <= io_ins_1_hsize;
    end
    if(T42) begin
      R77 <= io_ins_0_hsize;
    end
    if(T37) begin
      R82 <= io_ins_1_hwrite;
    end
    if(T42) begin
      R86 <= io_ins_0_hwrite;
    end
    if(T37) begin
      R91 <= io_ins_1_haddr;
    end
    if(T42) begin
      R95 <= io_ins_0_haddr;
    end
  end
endmodule

module HastiXbar(input clk, input reset,
    input [31:0] io_masters_1_haddr,
    input  io_masters_1_hwrite,
    input [2:0] io_masters_1_hsize,
    input [2:0] io_masters_1_hburst,
    input [3:0] io_masters_1_hprot,
    input [1:0] io_masters_1_htrans,
    input  io_masters_1_hmastlock,
    input [31:0] io_masters_1_hwdata,
    output[31:0] io_masters_1_hrdata,
    output io_masters_1_hready,
    output io_masters_1_hresp,
    input [31:0] io_masters_0_haddr,
    input  io_masters_0_hwrite,
    input [2:0] io_masters_0_hsize,
    input [2:0] io_masters_0_hburst,
    input [3:0] io_masters_0_hprot,
    input [1:0] io_masters_0_htrans,
    input  io_masters_0_hmastlock,
    input [31:0] io_masters_0_hwdata,
    output[31:0] io_masters_0_hrdata,
    output io_masters_0_hready,
    output io_masters_0_hresp,
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

  wire[31:0] HastiBus_io_master_hrdata;
  wire HastiBus_io_master_hready;
  wire HastiBus_io_master_hresp;
  wire[31:0] HastiBus_io_slaves_2_haddr;
  wire HastiBus_io_slaves_2_hwrite;
  wire[2:0] HastiBus_io_slaves_2_hsize;
  wire[2:0] HastiBus_io_slaves_2_hburst;
  wire[3:0] HastiBus_io_slaves_2_hprot;
  wire[1:0] HastiBus_io_slaves_2_htrans;
  wire HastiBus_io_slaves_2_hmastlock;
  wire[31:0] HastiBus_io_slaves_2_hwdata;
  wire HastiBus_io_slaves_2_hsel;
  wire HastiBus_io_slaves_2_hreadyin;
  wire[31:0] HastiBus_io_slaves_1_haddr;
  wire HastiBus_io_slaves_1_hwrite;
  wire[2:0] HastiBus_io_slaves_1_hsize;
  wire[2:0] HastiBus_io_slaves_1_hburst;
  wire[3:0] HastiBus_io_slaves_1_hprot;
  wire[1:0] HastiBus_io_slaves_1_htrans;
  wire HastiBus_io_slaves_1_hmastlock;
  wire[31:0] HastiBus_io_slaves_1_hwdata;
  wire HastiBus_io_slaves_1_hsel;
  wire HastiBus_io_slaves_1_hreadyin;
  wire[31:0] HastiBus_io_slaves_0_haddr;
  wire HastiBus_io_slaves_0_hwrite;
  wire[2:0] HastiBus_io_slaves_0_hsize;
  wire[2:0] HastiBus_io_slaves_0_hburst;
  wire[3:0] HastiBus_io_slaves_0_hprot;
  wire[1:0] HastiBus_io_slaves_0_htrans;
  wire HastiBus_io_slaves_0_hmastlock;
  wire[31:0] HastiBus_io_slaves_0_hwdata;
  wire HastiBus_io_slaves_0_hsel;
  wire HastiBus_io_slaves_0_hreadyin;
  wire[31:0] HastiBus_1_io_master_hrdata;
  wire HastiBus_1_io_master_hready;
  wire HastiBus_1_io_master_hresp;
  wire[31:0] HastiBus_1_io_slaves_2_haddr;
  wire HastiBus_1_io_slaves_2_hwrite;
  wire[2:0] HastiBus_1_io_slaves_2_hsize;
  wire[2:0] HastiBus_1_io_slaves_2_hburst;
  wire[3:0] HastiBus_1_io_slaves_2_hprot;
  wire[1:0] HastiBus_1_io_slaves_2_htrans;
  wire HastiBus_1_io_slaves_2_hmastlock;
  wire[31:0] HastiBus_1_io_slaves_2_hwdata;
  wire HastiBus_1_io_slaves_2_hsel;
  wire HastiBus_1_io_slaves_2_hreadyin;
  wire[31:0] HastiBus_1_io_slaves_1_haddr;
  wire HastiBus_1_io_slaves_1_hwrite;
  wire[2:0] HastiBus_1_io_slaves_1_hsize;
  wire[2:0] HastiBus_1_io_slaves_1_hburst;
  wire[3:0] HastiBus_1_io_slaves_1_hprot;
  wire[1:0] HastiBus_1_io_slaves_1_htrans;
  wire HastiBus_1_io_slaves_1_hmastlock;
  wire[31:0] HastiBus_1_io_slaves_1_hwdata;
  wire HastiBus_1_io_slaves_1_hsel;
  wire HastiBus_1_io_slaves_1_hreadyin;
  wire[31:0] HastiBus_1_io_slaves_0_haddr;
  wire HastiBus_1_io_slaves_0_hwrite;
  wire[2:0] HastiBus_1_io_slaves_0_hsize;
  wire[2:0] HastiBus_1_io_slaves_0_hburst;
  wire[3:0] HastiBus_1_io_slaves_0_hprot;
  wire[1:0] HastiBus_1_io_slaves_0_htrans;
  wire HastiBus_1_io_slaves_0_hmastlock;
  wire[31:0] HastiBus_1_io_slaves_0_hwdata;
  wire HastiBus_1_io_slaves_0_hsel;
  wire HastiBus_1_io_slaves_0_hreadyin;
  wire[31:0] HastiSlaveMux_io_ins_1_hrdata;
  wire HastiSlaveMux_io_ins_1_hreadyout;
  wire HastiSlaveMux_io_ins_1_hresp;
  wire[31:0] HastiSlaveMux_io_ins_0_hrdata;
  wire HastiSlaveMux_io_ins_0_hreadyout;
  wire HastiSlaveMux_io_ins_0_hresp;
  wire[31:0] HastiSlaveMux_io_out_haddr;
  wire HastiSlaveMux_io_out_hwrite;
  wire[2:0] HastiSlaveMux_io_out_hsize;
  wire[2:0] HastiSlaveMux_io_out_hburst;
  wire[3:0] HastiSlaveMux_io_out_hprot;
  wire[1:0] HastiSlaveMux_io_out_htrans;
  wire HastiSlaveMux_io_out_hmastlock;
  wire[31:0] HastiSlaveMux_io_out_hwdata;
  wire HastiSlaveMux_io_out_hsel;
  wire HastiSlaveMux_io_out_hreadyin;
  wire[31:0] HastiSlaveMux_1_io_ins_1_hrdata;
  wire HastiSlaveMux_1_io_ins_1_hreadyout;
  wire HastiSlaveMux_1_io_ins_1_hresp;
  wire[31:0] HastiSlaveMux_1_io_ins_0_hrdata;
  wire HastiSlaveMux_1_io_ins_0_hreadyout;
  wire HastiSlaveMux_1_io_ins_0_hresp;
  wire[31:0] HastiSlaveMux_1_io_out_haddr;
  wire HastiSlaveMux_1_io_out_hwrite;
  wire[2:0] HastiSlaveMux_1_io_out_hsize;
  wire[2:0] HastiSlaveMux_1_io_out_hburst;
  wire[3:0] HastiSlaveMux_1_io_out_hprot;
  wire[1:0] HastiSlaveMux_1_io_out_htrans;
  wire HastiSlaveMux_1_io_out_hmastlock;
  wire[31:0] HastiSlaveMux_1_io_out_hwdata;
  wire HastiSlaveMux_1_io_out_hsel;
  wire HastiSlaveMux_1_io_out_hreadyin;
  wire[31:0] HastiSlaveMux_2_io_ins_1_hrdata;
  wire HastiSlaveMux_2_io_ins_1_hreadyout;
  wire HastiSlaveMux_2_io_ins_1_hresp;
  wire[31:0] HastiSlaveMux_2_io_ins_0_hrdata;
  wire HastiSlaveMux_2_io_ins_0_hreadyout;
  wire HastiSlaveMux_2_io_ins_0_hresp;
  wire[31:0] HastiSlaveMux_2_io_out_haddr;
  wire HastiSlaveMux_2_io_out_hwrite;
  wire[2:0] HastiSlaveMux_2_io_out_hsize;
  wire[2:0] HastiSlaveMux_2_io_out_hburst;
  wire[3:0] HastiSlaveMux_2_io_out_hprot;
  wire[1:0] HastiSlaveMux_2_io_out_htrans;
  wire HastiSlaveMux_2_io_out_hmastlock;
  wire[31:0] HastiSlaveMux_2_io_out_hwdata;
  wire HastiSlaveMux_2_io_out_hsel;
  wire HastiSlaveMux_2_io_out_hreadyin;


  assign io_slaves_0_hreadyin = HastiSlaveMux_io_out_hreadyin;
  assign io_slaves_0_hsel = HastiSlaveMux_io_out_hsel;
  assign io_slaves_0_hwdata = HastiSlaveMux_io_out_hwdata;
  assign io_slaves_0_hmastlock = HastiSlaveMux_io_out_hmastlock;
  assign io_slaves_0_htrans = HastiSlaveMux_io_out_htrans;
  assign io_slaves_0_hprot = HastiSlaveMux_io_out_hprot;
  assign io_slaves_0_hburst = HastiSlaveMux_io_out_hburst;
  assign io_slaves_0_hsize = HastiSlaveMux_io_out_hsize;
  assign io_slaves_0_hwrite = HastiSlaveMux_io_out_hwrite;
  assign io_slaves_0_haddr = HastiSlaveMux_io_out_haddr;
  assign io_slaves_1_hreadyin = HastiSlaveMux_1_io_out_hreadyin;
  assign io_slaves_1_hsel = HastiSlaveMux_1_io_out_hsel;
  assign io_slaves_1_hwdata = HastiSlaveMux_1_io_out_hwdata;
  assign io_slaves_1_hmastlock = HastiSlaveMux_1_io_out_hmastlock;
  assign io_slaves_1_htrans = HastiSlaveMux_1_io_out_htrans;
  assign io_slaves_1_hprot = HastiSlaveMux_1_io_out_hprot;
  assign io_slaves_1_hburst = HastiSlaveMux_1_io_out_hburst;
  assign io_slaves_1_hsize = HastiSlaveMux_1_io_out_hsize;
  assign io_slaves_1_hwrite = HastiSlaveMux_1_io_out_hwrite;
  assign io_slaves_1_haddr = HastiSlaveMux_1_io_out_haddr;
  assign io_slaves_2_hreadyin = HastiSlaveMux_2_io_out_hreadyin;
  assign io_slaves_2_hsel = HastiSlaveMux_2_io_out_hsel;
  assign io_slaves_2_hwdata = HastiSlaveMux_2_io_out_hwdata;
  assign io_slaves_2_hmastlock = HastiSlaveMux_2_io_out_hmastlock;
  assign io_slaves_2_htrans = HastiSlaveMux_2_io_out_htrans;
  assign io_slaves_2_hprot = HastiSlaveMux_2_io_out_hprot;
  assign io_slaves_2_hburst = HastiSlaveMux_2_io_out_hburst;
  assign io_slaves_2_hsize = HastiSlaveMux_2_io_out_hsize;
  assign io_slaves_2_hwrite = HastiSlaveMux_2_io_out_hwrite;
  assign io_slaves_2_haddr = HastiSlaveMux_2_io_out_haddr;
  assign io_masters_0_hresp = HastiBus_io_master_hresp;
  assign io_masters_0_hready = HastiBus_io_master_hready;
  assign io_masters_0_hrdata = HastiBus_io_master_hrdata;
  assign io_masters_1_hresp = HastiBus_1_io_master_hresp;
  assign io_masters_1_hready = HastiBus_1_io_master_hready;
  assign io_masters_1_hrdata = HastiBus_1_io_master_hrdata;
  HastiBus HastiBus(.clk(clk), .reset(reset),
       .io_master_haddr( io_masters_0_haddr ),
       .io_master_hwrite( io_masters_0_hwrite ),
       .io_master_hsize( io_masters_0_hsize ),
       .io_master_hburst( io_masters_0_hburst ),
       .io_master_hprot( io_masters_0_hprot ),
       .io_master_htrans( io_masters_0_htrans ),
       .io_master_hmastlock( io_masters_0_hmastlock ),
       .io_master_hwdata( io_masters_0_hwdata ),
       .io_master_hrdata( HastiBus_io_master_hrdata ),
       .io_master_hready( HastiBus_io_master_hready ),
       .io_master_hresp( HastiBus_io_master_hresp ),
       .io_slaves_2_haddr( HastiBus_io_slaves_2_haddr ),
       .io_slaves_2_hwrite( HastiBus_io_slaves_2_hwrite ),
       .io_slaves_2_hsize( HastiBus_io_slaves_2_hsize ),
       .io_slaves_2_hburst( HastiBus_io_slaves_2_hburst ),
       .io_slaves_2_hprot( HastiBus_io_slaves_2_hprot ),
       .io_slaves_2_htrans( HastiBus_io_slaves_2_htrans ),
       .io_slaves_2_hmastlock( HastiBus_io_slaves_2_hmastlock ),
       .io_slaves_2_hwdata( HastiBus_io_slaves_2_hwdata ),
       .io_slaves_2_hrdata( HastiSlaveMux_2_io_ins_0_hrdata ),
       .io_slaves_2_hsel( HastiBus_io_slaves_2_hsel ),
       .io_slaves_2_hreadyin( HastiBus_io_slaves_2_hreadyin ),
       .io_slaves_2_hreadyout( HastiSlaveMux_2_io_ins_0_hreadyout ),
       .io_slaves_2_hresp( HastiSlaveMux_2_io_ins_0_hresp ),
       .io_slaves_1_haddr( HastiBus_io_slaves_1_haddr ),
       .io_slaves_1_hwrite( HastiBus_io_slaves_1_hwrite ),
       .io_slaves_1_hsize( HastiBus_io_slaves_1_hsize ),
       .io_slaves_1_hburst( HastiBus_io_slaves_1_hburst ),
       .io_slaves_1_hprot( HastiBus_io_slaves_1_hprot ),
       .io_slaves_1_htrans( HastiBus_io_slaves_1_htrans ),
       .io_slaves_1_hmastlock( HastiBus_io_slaves_1_hmastlock ),
       .io_slaves_1_hwdata( HastiBus_io_slaves_1_hwdata ),
       .io_slaves_1_hrdata( HastiSlaveMux_1_io_ins_0_hrdata ),
       .io_slaves_1_hsel( HastiBus_io_slaves_1_hsel ),
       .io_slaves_1_hreadyin( HastiBus_io_slaves_1_hreadyin ),
       .io_slaves_1_hreadyout( HastiSlaveMux_1_io_ins_0_hreadyout ),
       .io_slaves_1_hresp( HastiSlaveMux_1_io_ins_0_hresp ),
       .io_slaves_0_haddr( HastiBus_io_slaves_0_haddr ),
       .io_slaves_0_hwrite( HastiBus_io_slaves_0_hwrite ),
       .io_slaves_0_hsize( HastiBus_io_slaves_0_hsize ),
       .io_slaves_0_hburst( HastiBus_io_slaves_0_hburst ),
       .io_slaves_0_hprot( HastiBus_io_slaves_0_hprot ),
       .io_slaves_0_htrans( HastiBus_io_slaves_0_htrans ),
       .io_slaves_0_hmastlock( HastiBus_io_slaves_0_hmastlock ),
       .io_slaves_0_hwdata( HastiBus_io_slaves_0_hwdata ),
       .io_slaves_0_hrdata( HastiSlaveMux_io_ins_0_hrdata ),
       .io_slaves_0_hsel( HastiBus_io_slaves_0_hsel ),
       .io_slaves_0_hreadyin( HastiBus_io_slaves_0_hreadyin ),
       .io_slaves_0_hreadyout( HastiSlaveMux_io_ins_0_hreadyout ),
       .io_slaves_0_hresp( HastiSlaveMux_io_ins_0_hresp )
  );
  HastiBus HastiBus_1(.clk(clk), .reset(reset),
       .io_master_haddr( io_masters_1_haddr ),
       .io_master_hwrite( io_masters_1_hwrite ),
       .io_master_hsize( io_masters_1_hsize ),
       .io_master_hburst( io_masters_1_hburst ),
       .io_master_hprot( io_masters_1_hprot ),
       .io_master_htrans( io_masters_1_htrans ),
       .io_master_hmastlock( io_masters_1_hmastlock ),
       .io_master_hwdata( io_masters_1_hwdata ),
       .io_master_hrdata( HastiBus_1_io_master_hrdata ),
       .io_master_hready( HastiBus_1_io_master_hready ),
       .io_master_hresp( HastiBus_1_io_master_hresp ),
       .io_slaves_2_haddr( HastiBus_1_io_slaves_2_haddr ),
       .io_slaves_2_hwrite( HastiBus_1_io_slaves_2_hwrite ),
       .io_slaves_2_hsize( HastiBus_1_io_slaves_2_hsize ),
       .io_slaves_2_hburst( HastiBus_1_io_slaves_2_hburst ),
       .io_slaves_2_hprot( HastiBus_1_io_slaves_2_hprot ),
       .io_slaves_2_htrans( HastiBus_1_io_slaves_2_htrans ),
       .io_slaves_2_hmastlock( HastiBus_1_io_slaves_2_hmastlock ),
       .io_slaves_2_hwdata( HastiBus_1_io_slaves_2_hwdata ),
       .io_slaves_2_hrdata( HastiSlaveMux_2_io_ins_1_hrdata ),
       .io_slaves_2_hsel( HastiBus_1_io_slaves_2_hsel ),
       .io_slaves_2_hreadyin( HastiBus_1_io_slaves_2_hreadyin ),
       .io_slaves_2_hreadyout( HastiSlaveMux_2_io_ins_1_hreadyout ),
       .io_slaves_2_hresp( HastiSlaveMux_2_io_ins_1_hresp ),
       .io_slaves_1_haddr( HastiBus_1_io_slaves_1_haddr ),
       .io_slaves_1_hwrite( HastiBus_1_io_slaves_1_hwrite ),
       .io_slaves_1_hsize( HastiBus_1_io_slaves_1_hsize ),
       .io_slaves_1_hburst( HastiBus_1_io_slaves_1_hburst ),
       .io_slaves_1_hprot( HastiBus_1_io_slaves_1_hprot ),
       .io_slaves_1_htrans( HastiBus_1_io_slaves_1_htrans ),
       .io_slaves_1_hmastlock( HastiBus_1_io_slaves_1_hmastlock ),
       .io_slaves_1_hwdata( HastiBus_1_io_slaves_1_hwdata ),
       .io_slaves_1_hrdata( HastiSlaveMux_1_io_ins_1_hrdata ),
       .io_slaves_1_hsel( HastiBus_1_io_slaves_1_hsel ),
       .io_slaves_1_hreadyin( HastiBus_1_io_slaves_1_hreadyin ),
       .io_slaves_1_hreadyout( HastiSlaveMux_1_io_ins_1_hreadyout ),
       .io_slaves_1_hresp( HastiSlaveMux_1_io_ins_1_hresp ),
       .io_slaves_0_haddr( HastiBus_1_io_slaves_0_haddr ),
       .io_slaves_0_hwrite( HastiBus_1_io_slaves_0_hwrite ),
       .io_slaves_0_hsize( HastiBus_1_io_slaves_0_hsize ),
       .io_slaves_0_hburst( HastiBus_1_io_slaves_0_hburst ),
       .io_slaves_0_hprot( HastiBus_1_io_slaves_0_hprot ),
       .io_slaves_0_htrans( HastiBus_1_io_slaves_0_htrans ),
       .io_slaves_0_hmastlock( HastiBus_1_io_slaves_0_hmastlock ),
       .io_slaves_0_hwdata( HastiBus_1_io_slaves_0_hwdata ),
       .io_slaves_0_hrdata( HastiSlaveMux_io_ins_1_hrdata ),
       .io_slaves_0_hsel( HastiBus_1_io_slaves_0_hsel ),
       .io_slaves_0_hreadyin( HastiBus_1_io_slaves_0_hreadyin ),
       .io_slaves_0_hreadyout( HastiSlaveMux_io_ins_1_hreadyout ),
       .io_slaves_0_hresp( HastiSlaveMux_io_ins_1_hresp )
  );
  HastiSlaveMux HastiSlaveMux(.clk(clk), .reset(reset),
       .io_ins_1_haddr( HastiBus_1_io_slaves_0_haddr ),
       .io_ins_1_hwrite( HastiBus_1_io_slaves_0_hwrite ),
       .io_ins_1_hsize( HastiBus_1_io_slaves_0_hsize ),
       .io_ins_1_hburst( HastiBus_1_io_slaves_0_hburst ),
       .io_ins_1_hprot( HastiBus_1_io_slaves_0_hprot ),
       .io_ins_1_htrans( HastiBus_1_io_slaves_0_htrans ),
       .io_ins_1_hmastlock( HastiBus_1_io_slaves_0_hmastlock ),
       .io_ins_1_hwdata( HastiBus_1_io_slaves_0_hwdata ),
       .io_ins_1_hrdata( HastiSlaveMux_io_ins_1_hrdata ),
       .io_ins_1_hsel( HastiBus_1_io_slaves_0_hsel ),
       .io_ins_1_hreadyin( HastiBus_1_io_slaves_0_hreadyin ),
       .io_ins_1_hreadyout( HastiSlaveMux_io_ins_1_hreadyout ),
       .io_ins_1_hresp( HastiSlaveMux_io_ins_1_hresp ),
       .io_ins_0_haddr( HastiBus_io_slaves_0_haddr ),
       .io_ins_0_hwrite( HastiBus_io_slaves_0_hwrite ),
       .io_ins_0_hsize( HastiBus_io_slaves_0_hsize ),
       .io_ins_0_hburst( HastiBus_io_slaves_0_hburst ),
       .io_ins_0_hprot( HastiBus_io_slaves_0_hprot ),
       .io_ins_0_htrans( HastiBus_io_slaves_0_htrans ),
       .io_ins_0_hmastlock( HastiBus_io_slaves_0_hmastlock ),
       .io_ins_0_hwdata( HastiBus_io_slaves_0_hwdata ),
       .io_ins_0_hrdata( HastiSlaveMux_io_ins_0_hrdata ),
       .io_ins_0_hsel( HastiBus_io_slaves_0_hsel ),
       .io_ins_0_hreadyin( HastiBus_io_slaves_0_hreadyin ),
       .io_ins_0_hreadyout( HastiSlaveMux_io_ins_0_hreadyout ),
       .io_ins_0_hresp( HastiSlaveMux_io_ins_0_hresp ),
       .io_out_haddr( HastiSlaveMux_io_out_haddr ),
       .io_out_hwrite( HastiSlaveMux_io_out_hwrite ),
       .io_out_hsize( HastiSlaveMux_io_out_hsize ),
       .io_out_hburst( HastiSlaveMux_io_out_hburst ),
       .io_out_hprot( HastiSlaveMux_io_out_hprot ),
       .io_out_htrans( HastiSlaveMux_io_out_htrans ),
       .io_out_hmastlock( HastiSlaveMux_io_out_hmastlock ),
       .io_out_hwdata( HastiSlaveMux_io_out_hwdata ),
       .io_out_hrdata( io_slaves_0_hrdata ),
       .io_out_hsel( HastiSlaveMux_io_out_hsel ),
       .io_out_hreadyin( HastiSlaveMux_io_out_hreadyin ),
       .io_out_hreadyout( io_slaves_0_hreadyout ),
       .io_out_hresp( io_slaves_0_hresp )
  );
  HastiSlaveMux HastiSlaveMux_1(.clk(clk), .reset(reset),
       .io_ins_1_haddr( HastiBus_1_io_slaves_1_haddr ),
       .io_ins_1_hwrite( HastiBus_1_io_slaves_1_hwrite ),
       .io_ins_1_hsize( HastiBus_1_io_slaves_1_hsize ),
       .io_ins_1_hburst( HastiBus_1_io_slaves_1_hburst ),
       .io_ins_1_hprot( HastiBus_1_io_slaves_1_hprot ),
       .io_ins_1_htrans( HastiBus_1_io_slaves_1_htrans ),
       .io_ins_1_hmastlock( HastiBus_1_io_slaves_1_hmastlock ),
       .io_ins_1_hwdata( HastiBus_1_io_slaves_1_hwdata ),
       .io_ins_1_hrdata( HastiSlaveMux_1_io_ins_1_hrdata ),
       .io_ins_1_hsel( HastiBus_1_io_slaves_1_hsel ),
       .io_ins_1_hreadyin( HastiBus_1_io_slaves_1_hreadyin ),
       .io_ins_1_hreadyout( HastiSlaveMux_1_io_ins_1_hreadyout ),
       .io_ins_1_hresp( HastiSlaveMux_1_io_ins_1_hresp ),
       .io_ins_0_haddr( HastiBus_io_slaves_1_haddr ),
       .io_ins_0_hwrite( HastiBus_io_slaves_1_hwrite ),
       .io_ins_0_hsize( HastiBus_io_slaves_1_hsize ),
       .io_ins_0_hburst( HastiBus_io_slaves_1_hburst ),
       .io_ins_0_hprot( HastiBus_io_slaves_1_hprot ),
       .io_ins_0_htrans( HastiBus_io_slaves_1_htrans ),
       .io_ins_0_hmastlock( HastiBus_io_slaves_1_hmastlock ),
       .io_ins_0_hwdata( HastiBus_io_slaves_1_hwdata ),
       .io_ins_0_hrdata( HastiSlaveMux_1_io_ins_0_hrdata ),
       .io_ins_0_hsel( HastiBus_io_slaves_1_hsel ),
       .io_ins_0_hreadyin( HastiBus_io_slaves_1_hreadyin ),
       .io_ins_0_hreadyout( HastiSlaveMux_1_io_ins_0_hreadyout ),
       .io_ins_0_hresp( HastiSlaveMux_1_io_ins_0_hresp ),
       .io_out_haddr( HastiSlaveMux_1_io_out_haddr ),
       .io_out_hwrite( HastiSlaveMux_1_io_out_hwrite ),
       .io_out_hsize( HastiSlaveMux_1_io_out_hsize ),
       .io_out_hburst( HastiSlaveMux_1_io_out_hburst ),
       .io_out_hprot( HastiSlaveMux_1_io_out_hprot ),
       .io_out_htrans( HastiSlaveMux_1_io_out_htrans ),
       .io_out_hmastlock( HastiSlaveMux_1_io_out_hmastlock ),
       .io_out_hwdata( HastiSlaveMux_1_io_out_hwdata ),
       .io_out_hrdata( io_slaves_1_hrdata ),
       .io_out_hsel( HastiSlaveMux_1_io_out_hsel ),
       .io_out_hreadyin( HastiSlaveMux_1_io_out_hreadyin ),
       .io_out_hreadyout( io_slaves_1_hreadyout ),
       .io_out_hresp( io_slaves_1_hresp )
  );
  HastiSlaveMux HastiSlaveMux_2(.clk(clk), .reset(reset),
       .io_ins_1_haddr( HastiBus_1_io_slaves_2_haddr ),
       .io_ins_1_hwrite( HastiBus_1_io_slaves_2_hwrite ),
       .io_ins_1_hsize( HastiBus_1_io_slaves_2_hsize ),
       .io_ins_1_hburst( HastiBus_1_io_slaves_2_hburst ),
       .io_ins_1_hprot( HastiBus_1_io_slaves_2_hprot ),
       .io_ins_1_htrans( HastiBus_1_io_slaves_2_htrans ),
       .io_ins_1_hmastlock( HastiBus_1_io_slaves_2_hmastlock ),
       .io_ins_1_hwdata( HastiBus_1_io_slaves_2_hwdata ),
       .io_ins_1_hrdata( HastiSlaveMux_2_io_ins_1_hrdata ),
       .io_ins_1_hsel( HastiBus_1_io_slaves_2_hsel ),
       .io_ins_1_hreadyin( HastiBus_1_io_slaves_2_hreadyin ),
       .io_ins_1_hreadyout( HastiSlaveMux_2_io_ins_1_hreadyout ),
       .io_ins_1_hresp( HastiSlaveMux_2_io_ins_1_hresp ),
       .io_ins_0_haddr( HastiBus_io_slaves_2_haddr ),
       .io_ins_0_hwrite( HastiBus_io_slaves_2_hwrite ),
       .io_ins_0_hsize( HastiBus_io_slaves_2_hsize ),
       .io_ins_0_hburst( HastiBus_io_slaves_2_hburst ),
       .io_ins_0_hprot( HastiBus_io_slaves_2_hprot ),
       .io_ins_0_htrans( HastiBus_io_slaves_2_htrans ),
       .io_ins_0_hmastlock( HastiBus_io_slaves_2_hmastlock ),
       .io_ins_0_hwdata( HastiBus_io_slaves_2_hwdata ),
       .io_ins_0_hrdata( HastiSlaveMux_2_io_ins_0_hrdata ),
       .io_ins_0_hsel( HastiBus_io_slaves_2_hsel ),
       .io_ins_0_hreadyin( HastiBus_io_slaves_2_hreadyin ),
       .io_ins_0_hreadyout( HastiSlaveMux_2_io_ins_0_hreadyout ),
       .io_ins_0_hresp( HastiSlaveMux_2_io_ins_0_hresp ),
       .io_out_haddr( HastiSlaveMux_2_io_out_haddr ),
       .io_out_hwrite( HastiSlaveMux_2_io_out_hwrite ),
       .io_out_hsize( HastiSlaveMux_2_io_out_hsize ),
       .io_out_hburst( HastiSlaveMux_2_io_out_hburst ),
       .io_out_hprot( HastiSlaveMux_2_io_out_hprot ),
       .io_out_htrans( HastiSlaveMux_2_io_out_htrans ),
       .io_out_hmastlock( HastiSlaveMux_2_io_out_hmastlock ),
       .io_out_hwdata( HastiSlaveMux_2_io_out_hwdata ),
       .io_out_hrdata( io_slaves_2_hrdata ),
       .io_out_hsel( HastiSlaveMux_2_io_out_hsel ),
       .io_out_hreadyin( HastiSlaveMux_2_io_out_hreadyin ),
       .io_out_hreadyout( io_slaves_2_hreadyout ),
       .io_out_hresp( io_slaves_2_hresp )
  );
endmodule

module Ahbmli(input clk, input reset,
    input [31:0] io_dside_haddr,
    input  io_dside_hwrite,
    input [2:0] io_dside_hsize,
    input [2:0] io_dside_hburst,
    input [3:0] io_dside_hprot,
    input [1:0] io_dside_htrans,
    input  io_dside_hmastlock,
    input [31:0] io_dside_hwdata,
    output[31:0] io_dside_hrdata,
    output io_dside_hready,
    output io_dside_hresp,
    input [31:0] io_iside_haddr,
    input  io_iside_hwrite,
    input [2:0] io_iside_hsize,
    input [2:0] io_iside_hburst,
    input [3:0] io_iside_hprot,
    input [1:0] io_iside_htrans,
    input  io_iside_hmastlock,
    input [31:0] io_iside_hwdata,
    output[31:0] io_iside_hrdata,
    output io_iside_hready,
    output io_iside_hresp,
    output[31:0] io_periph_haddr,
    output io_periph_hwrite,
    output[2:0] io_periph_hsize,
    output[2:0] io_periph_hburst,
    output[3:0] io_periph_hprot,
    output[1:0] io_periph_htrans,
    output io_periph_hmastlock,
    output[31:0] io_periph_hwdata,
    input [31:0] io_periph_hrdata,
    output io_periph_hsel,
    output io_periph_hreadyin,
    input  io_periph_hreadyout,
    input  io_periph_hresp,
    output[31:0] io_tcm0_haddr,
    output io_tcm0_hwrite,
    output[2:0] io_tcm0_hsize,
    output[2:0] io_tcm0_hburst,
    output[3:0] io_tcm0_hprot,
    output[1:0] io_tcm0_htrans,
    output io_tcm0_hmastlock,
    output[31:0] io_tcm0_hwdata,
    input [31:0] io_tcm0_hrdata,
    output io_tcm0_hsel,
    output io_tcm0_hreadyin,
    input  io_tcm0_hreadyout,
    input  io_tcm0_hresp,
    output[31:0] io_tcm1_haddr,
    output io_tcm1_hwrite,
    output[2:0] io_tcm1_hsize,
    output[2:0] io_tcm1_hburst,
    output[3:0] io_tcm1_hprot,
    output[1:0] io_tcm1_htrans,
    output io_tcm1_hmastlock,
    output[31:0] io_tcm1_hwdata,
    input [31:0] io_tcm1_hrdata,
    output io_tcm1_hsel,
    output io_tcm1_hreadyin,
    input  io_tcm1_hreadyout,
    input  io_tcm1_hresp
);

  wire[31:0] xbar_io_masters_1_hrdata;
  wire xbar_io_masters_1_hready;
  wire xbar_io_masters_1_hresp;
  wire[31:0] xbar_io_masters_0_hrdata;
  wire xbar_io_masters_0_hready;
  wire xbar_io_masters_0_hresp;
  wire[31:0] xbar_io_slaves_2_haddr;
  wire xbar_io_slaves_2_hwrite;
  wire[2:0] xbar_io_slaves_2_hsize;
  wire[2:0] xbar_io_slaves_2_hburst;
  wire[3:0] xbar_io_slaves_2_hprot;
  wire[1:0] xbar_io_slaves_2_htrans;
  wire xbar_io_slaves_2_hmastlock;
  wire[31:0] xbar_io_slaves_2_hwdata;
  wire xbar_io_slaves_2_hsel;
  wire xbar_io_slaves_2_hreadyin;
  wire[31:0] xbar_io_slaves_1_haddr;
  wire xbar_io_slaves_1_hwrite;
  wire[2:0] xbar_io_slaves_1_hsize;
  wire[2:0] xbar_io_slaves_1_hburst;
  wire[3:0] xbar_io_slaves_1_hprot;
  wire[1:0] xbar_io_slaves_1_htrans;
  wire xbar_io_slaves_1_hmastlock;
  wire[31:0] xbar_io_slaves_1_hwdata;
  wire xbar_io_slaves_1_hsel;
  wire xbar_io_slaves_1_hreadyin;
  wire[31:0] xbar_io_slaves_0_haddr;
  wire xbar_io_slaves_0_hwrite;
  wire[2:0] xbar_io_slaves_0_hsize;
  wire[2:0] xbar_io_slaves_0_hburst;
  wire[3:0] xbar_io_slaves_0_hprot;
  wire[1:0] xbar_io_slaves_0_htrans;
  wire xbar_io_slaves_0_hmastlock;
  wire[31:0] xbar_io_slaves_0_hwdata;
  wire xbar_io_slaves_0_hsel;
  wire xbar_io_slaves_0_hreadyin;


  assign io_tcm1_hreadyin = xbar_io_slaves_2_hreadyin;
  assign io_tcm1_hsel = xbar_io_slaves_2_hsel;
  assign io_tcm1_hwdata = xbar_io_slaves_2_hwdata;
  assign io_tcm1_hmastlock = xbar_io_slaves_2_hmastlock;
  assign io_tcm1_htrans = xbar_io_slaves_2_htrans;
  assign io_tcm1_hprot = xbar_io_slaves_2_hprot;
  assign io_tcm1_hburst = xbar_io_slaves_2_hburst;
  assign io_tcm1_hsize = xbar_io_slaves_2_hsize;
  assign io_tcm1_hwrite = xbar_io_slaves_2_hwrite;
  assign io_tcm1_haddr = xbar_io_slaves_2_haddr;
  assign io_tcm0_hreadyin = xbar_io_slaves_1_hreadyin;
  assign io_tcm0_hsel = xbar_io_slaves_1_hsel;
  assign io_tcm0_hwdata = xbar_io_slaves_1_hwdata;
  assign io_tcm0_hmastlock = xbar_io_slaves_1_hmastlock;
  assign io_tcm0_htrans = xbar_io_slaves_1_htrans;
  assign io_tcm0_hprot = xbar_io_slaves_1_hprot;
  assign io_tcm0_hburst = xbar_io_slaves_1_hburst;
  assign io_tcm0_hsize = xbar_io_slaves_1_hsize;
  assign io_tcm0_hwrite = xbar_io_slaves_1_hwrite;
  assign io_tcm0_haddr = xbar_io_slaves_1_haddr;
  assign io_periph_hreadyin = xbar_io_slaves_0_hreadyin;
  assign io_periph_hsel = xbar_io_slaves_0_hsel;
  assign io_periph_hwdata = xbar_io_slaves_0_hwdata;
  assign io_periph_hmastlock = xbar_io_slaves_0_hmastlock;
  assign io_periph_htrans = xbar_io_slaves_0_htrans;
  assign io_periph_hprot = xbar_io_slaves_0_hprot;
  assign io_periph_hburst = xbar_io_slaves_0_hburst;
  assign io_periph_hsize = xbar_io_slaves_0_hsize;
  assign io_periph_hwrite = xbar_io_slaves_0_hwrite;
  assign io_periph_haddr = xbar_io_slaves_0_haddr;
  assign io_iside_hresp = xbar_io_masters_1_hresp;
  assign io_iside_hready = xbar_io_masters_1_hready;
  assign io_iside_hrdata = xbar_io_masters_1_hrdata;
  assign io_dside_hresp = xbar_io_masters_0_hresp;
  assign io_dside_hready = xbar_io_masters_0_hready;
  assign io_dside_hrdata = xbar_io_masters_0_hrdata;
  HastiXbar xbar(.clk(clk), .reset(reset),
       .io_masters_1_haddr( io_iside_haddr ),
       .io_masters_1_hwrite( io_iside_hwrite ),
       .io_masters_1_hsize( io_iside_hsize ),
       .io_masters_1_hburst( io_iside_hburst ),
       .io_masters_1_hprot( io_iside_hprot ),
       .io_masters_1_htrans( io_iside_htrans ),
       .io_masters_1_hmastlock( io_iside_hmastlock ),
       .io_masters_1_hwdata( io_iside_hwdata ),
       .io_masters_1_hrdata( xbar_io_masters_1_hrdata ),
       .io_masters_1_hready( xbar_io_masters_1_hready ),
       .io_masters_1_hresp( xbar_io_masters_1_hresp ),
       .io_masters_0_haddr( io_dside_haddr ),
       .io_masters_0_hwrite( io_dside_hwrite ),
       .io_masters_0_hsize( io_dside_hsize ),
       .io_masters_0_hburst( io_dside_hburst ),
       .io_masters_0_hprot( io_dside_hprot ),
       .io_masters_0_htrans( io_dside_htrans ),
       .io_masters_0_hmastlock( io_dside_hmastlock ),
       .io_masters_0_hwdata( io_dside_hwdata ),
       .io_masters_0_hrdata( xbar_io_masters_0_hrdata ),
       .io_masters_0_hready( xbar_io_masters_0_hready ),
       .io_masters_0_hresp( xbar_io_masters_0_hresp ),
       .io_slaves_2_haddr( xbar_io_slaves_2_haddr ),
       .io_slaves_2_hwrite( xbar_io_slaves_2_hwrite ),
       .io_slaves_2_hsize( xbar_io_slaves_2_hsize ),
       .io_slaves_2_hburst( xbar_io_slaves_2_hburst ),
       .io_slaves_2_hprot( xbar_io_slaves_2_hprot ),
       .io_slaves_2_htrans( xbar_io_slaves_2_htrans ),
       .io_slaves_2_hmastlock( xbar_io_slaves_2_hmastlock ),
       .io_slaves_2_hwdata( xbar_io_slaves_2_hwdata ),
       .io_slaves_2_hrdata( io_tcm1_hrdata ),
       .io_slaves_2_hsel( xbar_io_slaves_2_hsel ),
       .io_slaves_2_hreadyin( xbar_io_slaves_2_hreadyin ),
       .io_slaves_2_hreadyout( io_tcm1_hreadyout ),
       .io_slaves_2_hresp( io_tcm1_hresp ),
       .io_slaves_1_haddr( xbar_io_slaves_1_haddr ),
       .io_slaves_1_hwrite( xbar_io_slaves_1_hwrite ),
       .io_slaves_1_hsize( xbar_io_slaves_1_hsize ),
       .io_slaves_1_hburst( xbar_io_slaves_1_hburst ),
       .io_slaves_1_hprot( xbar_io_slaves_1_hprot ),
       .io_slaves_1_htrans( xbar_io_slaves_1_htrans ),
       .io_slaves_1_hmastlock( xbar_io_slaves_1_hmastlock ),
       .io_slaves_1_hwdata( xbar_io_slaves_1_hwdata ),
       .io_slaves_1_hrdata( io_tcm0_hrdata ),
       .io_slaves_1_hsel( xbar_io_slaves_1_hsel ),
       .io_slaves_1_hreadyin( xbar_io_slaves_1_hreadyin ),
       .io_slaves_1_hreadyout( io_tcm0_hreadyout ),
       .io_slaves_1_hresp( io_tcm0_hresp ),
       .io_slaves_0_haddr( xbar_io_slaves_0_haddr ),
       .io_slaves_0_hwrite( xbar_io_slaves_0_hwrite ),
       .io_slaves_0_hsize( xbar_io_slaves_0_hsize ),
       .io_slaves_0_hburst( xbar_io_slaves_0_hburst ),
       .io_slaves_0_hprot( xbar_io_slaves_0_hprot ),
       .io_slaves_0_htrans( xbar_io_slaves_0_htrans ),
       .io_slaves_0_hmastlock( xbar_io_slaves_0_hmastlock ),
       .io_slaves_0_hwdata( xbar_io_slaves_0_hwdata ),
       .io_slaves_0_hrdata( io_periph_hrdata ),
       .io_slaves_0_hsel( xbar_io_slaves_0_hsel ),
       .io_slaves_0_hreadyin( xbar_io_slaves_0_hreadyin ),
       .io_slaves_0_hreadyout( io_periph_hreadyout ),
       .io_slaves_0_hresp( io_periph_hresp )
  );
endmodule

