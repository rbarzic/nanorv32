
module Ahbmli(input clk, input reset,
    input [31:0] io_dbg_haddr,
    input  io_dbg_hwrite,
    input [2:0] io_dbg_hsize,
    input [2:0] io_dbg_hburst,
    input [3:0] io_dbg_hprot,
    input [1:0] io_dbg_htrans,
    input  io_dbg_hmastlock,
    input [31:0] io_dbg_hwdata,
    output[31:0] io_dbg_hrdata,
    output io_dbg_hready,
    output io_dbg_hresp,
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

  wire[31:0] xbar_io_masters_2_hrdata;
  wire xbar_io_masters_2_hready;
  wire xbar_io_masters_2_hresp;
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
  assign io_iside_hresp = xbar_io_masters_2_hresp;
  assign io_iside_hready = xbar_io_masters_2_hready;
  assign io_iside_hrdata = xbar_io_masters_2_hrdata;
  assign io_dside_hresp = xbar_io_masters_1_hresp;
  assign io_dside_hready = xbar_io_masters_1_hready;
  assign io_dside_hrdata = xbar_io_masters_1_hrdata;
  assign io_dbg_hresp = xbar_io_masters_0_hresp;
  assign io_dbg_hready = xbar_io_masters_0_hready;
  assign io_dbg_hrdata = xbar_io_masters_0_hrdata;
  HastiXbar xbar(.clk(clk), .reset(reset),
       .io_masters_2_haddr( io_iside_haddr ),
       .io_masters_2_hwrite( io_iside_hwrite ),
       .io_masters_2_hsize( io_iside_hsize ),
       .io_masters_2_hburst( io_iside_hburst ),
       .io_masters_2_hprot( io_iside_hprot ),
       .io_masters_2_htrans( io_iside_htrans ),
       .io_masters_2_hmastlock( io_iside_hmastlock ),
       .io_masters_2_hwdata( io_iside_hwdata ),
       .io_masters_2_hrdata( xbar_io_masters_2_hrdata ),
       .io_masters_2_hready( xbar_io_masters_2_hready ),
       .io_masters_2_hresp( xbar_io_masters_2_hresp ),
       .io_masters_1_haddr( io_dside_haddr ),
       .io_masters_1_hwrite( io_dside_hwrite ),
       .io_masters_1_hsize( io_dside_hsize ),
       .io_masters_1_hburst( io_dside_hburst ),
       .io_masters_1_hprot( io_dside_hprot ),
       .io_masters_1_htrans( io_dside_htrans ),
       .io_masters_1_hmastlock( io_dside_hmastlock ),
       .io_masters_1_hwdata( io_dside_hwdata ),
       .io_masters_1_hrdata( xbar_io_masters_1_hrdata ),
       .io_masters_1_hready( xbar_io_masters_1_hready ),
       .io_masters_1_hresp( xbar_io_masters_1_hresp ),
       .io_masters_0_haddr( io_dbg_haddr ),
       .io_masters_0_hwrite( io_dbg_hwrite ),
       .io_masters_0_hsize( io_dbg_hsize ),
       .io_masters_0_hburst( io_dbg_hburst ),
       .io_masters_0_hprot( io_dbg_hprot ),
       .io_masters_0_htrans( io_dbg_htrans ),
       .io_masters_0_hmastlock( io_dbg_hmastlock ),
       .io_masters_0_hwdata( io_dbg_hwdata ),
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
