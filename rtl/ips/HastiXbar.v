
module HastiXbar(input clk, input reset,
    input [31:0] io_masters_2_haddr,
    input  io_masters_2_hwrite,
    input [2:0] io_masters_2_hsize,
    input [2:0] io_masters_2_hburst,
    input [3:0] io_masters_2_hprot,
    input [1:0] io_masters_2_htrans,
    input  io_masters_2_hmastlock,
    input [31:0] io_masters_2_hwdata,
    output[31:0] io_masters_2_hrdata,
    output io_masters_2_hready,
    output io_masters_2_hresp,
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
  wire[31:0] HastiBus_2_io_master_hrdata;
  wire HastiBus_2_io_master_hready;
  wire HastiBus_2_io_master_hresp;
  wire[31:0] HastiBus_2_io_slaves_2_haddr;
  wire HastiBus_2_io_slaves_2_hwrite;
  wire[2:0] HastiBus_2_io_slaves_2_hsize;
  wire[2:0] HastiBus_2_io_slaves_2_hburst;
  wire[3:0] HastiBus_2_io_slaves_2_hprot;
  wire[1:0] HastiBus_2_io_slaves_2_htrans;
  wire HastiBus_2_io_slaves_2_hmastlock;
  wire[31:0] HastiBus_2_io_slaves_2_hwdata;
  wire HastiBus_2_io_slaves_2_hsel;
  wire HastiBus_2_io_slaves_2_hreadyin;
  wire[31:0] HastiBus_2_io_slaves_1_haddr;
  wire HastiBus_2_io_slaves_1_hwrite;
  wire[2:0] HastiBus_2_io_slaves_1_hsize;
  wire[2:0] HastiBus_2_io_slaves_1_hburst;
  wire[3:0] HastiBus_2_io_slaves_1_hprot;
  wire[1:0] HastiBus_2_io_slaves_1_htrans;
  wire HastiBus_2_io_slaves_1_hmastlock;
  wire[31:0] HastiBus_2_io_slaves_1_hwdata;
  wire HastiBus_2_io_slaves_1_hsel;
  wire HastiBus_2_io_slaves_1_hreadyin;
  wire[31:0] HastiBus_2_io_slaves_0_haddr;
  wire HastiBus_2_io_slaves_0_hwrite;
  wire[2:0] HastiBus_2_io_slaves_0_hsize;
  wire[2:0] HastiBus_2_io_slaves_0_hburst;
  wire[3:0] HastiBus_2_io_slaves_0_hprot;
  wire[1:0] HastiBus_2_io_slaves_0_htrans;
  wire HastiBus_2_io_slaves_0_hmastlock;
  wire[31:0] HastiBus_2_io_slaves_0_hwdata;
  wire HastiBus_2_io_slaves_0_hsel;
  wire HastiBus_2_io_slaves_0_hreadyin;
  wire[31:0] HastiSlaveMux_io_ins_2_hrdata;
  wire HastiSlaveMux_io_ins_2_hreadyout;
  wire HastiSlaveMux_io_ins_2_hresp;
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
  wire[31:0] HastiSlaveMux_1_io_ins_2_hrdata;
  wire HastiSlaveMux_1_io_ins_2_hreadyout;
  wire HastiSlaveMux_1_io_ins_2_hresp;
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
  wire[31:0] HastiSlaveMux_2_io_ins_2_hrdata;
  wire HastiSlaveMux_2_io_ins_2_hreadyout;
  wire HastiSlaveMux_2_io_ins_2_hresp;
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
  assign io_masters_2_hresp = HastiBus_2_io_master_hresp;
  assign io_masters_2_hready = HastiBus_2_io_master_hready;
  assign io_masters_2_hrdata = HastiBus_2_io_master_hrdata;
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
  HastiBus HastiBus_2(.clk(clk), .reset(reset),
       .io_master_haddr( io_masters_2_haddr ),
       .io_master_hwrite( io_masters_2_hwrite ),
       .io_master_hsize( io_masters_2_hsize ),
       .io_master_hburst( io_masters_2_hburst ),
       .io_master_hprot( io_masters_2_hprot ),
       .io_master_htrans( io_masters_2_htrans ),
       .io_master_hmastlock( io_masters_2_hmastlock ),
       .io_master_hwdata( io_masters_2_hwdata ),
       .io_master_hrdata( HastiBus_2_io_master_hrdata ),
       .io_master_hready( HastiBus_2_io_master_hready ),
       .io_master_hresp( HastiBus_2_io_master_hresp ),
       .io_slaves_2_haddr( HastiBus_2_io_slaves_2_haddr ),
       .io_slaves_2_hwrite( HastiBus_2_io_slaves_2_hwrite ),
       .io_slaves_2_hsize( HastiBus_2_io_slaves_2_hsize ),
       .io_slaves_2_hburst( HastiBus_2_io_slaves_2_hburst ),
       .io_slaves_2_hprot( HastiBus_2_io_slaves_2_hprot ),
       .io_slaves_2_htrans( HastiBus_2_io_slaves_2_htrans ),
       .io_slaves_2_hmastlock( HastiBus_2_io_slaves_2_hmastlock ),
       .io_slaves_2_hwdata( HastiBus_2_io_slaves_2_hwdata ),
       .io_slaves_2_hrdata( HastiSlaveMux_2_io_ins_2_hrdata ),
       .io_slaves_2_hsel( HastiBus_2_io_slaves_2_hsel ),
       .io_slaves_2_hreadyin( HastiBus_2_io_slaves_2_hreadyin ),
       .io_slaves_2_hreadyout( HastiSlaveMux_2_io_ins_2_hreadyout ),
       .io_slaves_2_hresp( HastiSlaveMux_2_io_ins_2_hresp ),
       .io_slaves_1_haddr( HastiBus_2_io_slaves_1_haddr ),
       .io_slaves_1_hwrite( HastiBus_2_io_slaves_1_hwrite ),
       .io_slaves_1_hsize( HastiBus_2_io_slaves_1_hsize ),
       .io_slaves_1_hburst( HastiBus_2_io_slaves_1_hburst ),
       .io_slaves_1_hprot( HastiBus_2_io_slaves_1_hprot ),
       .io_slaves_1_htrans( HastiBus_2_io_slaves_1_htrans ),
       .io_slaves_1_hmastlock( HastiBus_2_io_slaves_1_hmastlock ),
       .io_slaves_1_hwdata( HastiBus_2_io_slaves_1_hwdata ),
       .io_slaves_1_hrdata( HastiSlaveMux_1_io_ins_2_hrdata ),
       .io_slaves_1_hsel( HastiBus_2_io_slaves_1_hsel ),
       .io_slaves_1_hreadyin( HastiBus_2_io_slaves_1_hreadyin ),
       .io_slaves_1_hreadyout( HastiSlaveMux_1_io_ins_2_hreadyout ),
       .io_slaves_1_hresp( HastiSlaveMux_1_io_ins_2_hresp ),
       .io_slaves_0_haddr( HastiBus_2_io_slaves_0_haddr ),
       .io_slaves_0_hwrite( HastiBus_2_io_slaves_0_hwrite ),
       .io_slaves_0_hsize( HastiBus_2_io_slaves_0_hsize ),
       .io_slaves_0_hburst( HastiBus_2_io_slaves_0_hburst ),
       .io_slaves_0_hprot( HastiBus_2_io_slaves_0_hprot ),
       .io_slaves_0_htrans( HastiBus_2_io_slaves_0_htrans ),
       .io_slaves_0_hmastlock( HastiBus_2_io_slaves_0_hmastlock ),
       .io_slaves_0_hwdata( HastiBus_2_io_slaves_0_hwdata ),
       .io_slaves_0_hrdata( HastiSlaveMux_io_ins_2_hrdata ),
       .io_slaves_0_hsel( HastiBus_2_io_slaves_0_hsel ),
       .io_slaves_0_hreadyin( HastiBus_2_io_slaves_0_hreadyin ),
       .io_slaves_0_hreadyout( HastiSlaveMux_io_ins_2_hreadyout ),
       .io_slaves_0_hresp( HastiSlaveMux_io_ins_2_hresp )
  );
  HastiSlaveMux HastiSlaveMux(.clk(clk), .reset(reset),
       .io_ins_2_haddr( HastiBus_2_io_slaves_0_haddr ),
       .io_ins_2_hwrite( HastiBus_2_io_slaves_0_hwrite ),
       .io_ins_2_hsize( HastiBus_2_io_slaves_0_hsize ),
       .io_ins_2_hburst( HastiBus_2_io_slaves_0_hburst ),
       .io_ins_2_hprot( HastiBus_2_io_slaves_0_hprot ),
       .io_ins_2_htrans( HastiBus_2_io_slaves_0_htrans ),
       .io_ins_2_hmastlock( HastiBus_2_io_slaves_0_hmastlock ),
       .io_ins_2_hwdata( HastiBus_2_io_slaves_0_hwdata ),
       .io_ins_2_hrdata( HastiSlaveMux_io_ins_2_hrdata ),
       .io_ins_2_hsel( HastiBus_2_io_slaves_0_hsel ),
       .io_ins_2_hreadyin( HastiBus_2_io_slaves_0_hreadyin ),
       .io_ins_2_hreadyout( HastiSlaveMux_io_ins_2_hreadyout ),
       .io_ins_2_hresp( HastiSlaveMux_io_ins_2_hresp ),
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
       .io_ins_2_haddr( HastiBus_2_io_slaves_1_haddr ),
       .io_ins_2_hwrite( HastiBus_2_io_slaves_1_hwrite ),
       .io_ins_2_hsize( HastiBus_2_io_slaves_1_hsize ),
       .io_ins_2_hburst( HastiBus_2_io_slaves_1_hburst ),
       .io_ins_2_hprot( HastiBus_2_io_slaves_1_hprot ),
       .io_ins_2_htrans( HastiBus_2_io_slaves_1_htrans ),
       .io_ins_2_hmastlock( HastiBus_2_io_slaves_1_hmastlock ),
       .io_ins_2_hwdata( HastiBus_2_io_slaves_1_hwdata ),
       .io_ins_2_hrdata( HastiSlaveMux_1_io_ins_2_hrdata ),
       .io_ins_2_hsel( HastiBus_2_io_slaves_1_hsel ),
       .io_ins_2_hreadyin( HastiBus_2_io_slaves_1_hreadyin ),
       .io_ins_2_hreadyout( HastiSlaveMux_1_io_ins_2_hreadyout ),
       .io_ins_2_hresp( HastiSlaveMux_1_io_ins_2_hresp ),
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
       .io_ins_2_haddr( HastiBus_2_io_slaves_2_haddr ),
       .io_ins_2_hwrite( HastiBus_2_io_slaves_2_hwrite ),
       .io_ins_2_hsize( HastiBus_2_io_slaves_2_hsize ),
       .io_ins_2_hburst( HastiBus_2_io_slaves_2_hburst ),
       .io_ins_2_hprot( HastiBus_2_io_slaves_2_hprot ),
       .io_ins_2_htrans( HastiBus_2_io_slaves_2_htrans ),
       .io_ins_2_hmastlock( HastiBus_2_io_slaves_2_hmastlock ),
       .io_ins_2_hwdata( HastiBus_2_io_slaves_2_hwdata ),
       .io_ins_2_hrdata( HastiSlaveMux_2_io_ins_2_hrdata ),
       .io_ins_2_hsel( HastiBus_2_io_slaves_2_hsel ),
       .io_ins_2_hreadyin( HastiBus_2_io_slaves_2_hreadyin ),
       .io_ins_2_hreadyout( HastiSlaveMux_2_io_ins_2_hreadyout ),
       .io_ins_2_hresp( HastiSlaveMux_2_io_ins_2_hresp ),
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
