module HastiToPociBridge(input clk, input reset,
    input [31:0] io_in_haddr,
    input  io_in_hwrite,
    input [2:0] io_in_hsize,
    input [2:0] io_in_hburst,
    input [3:0] io_in_hprot,
    input [1:0] io_in_htrans,
    input  io_in_hmastlock,
    input [31:0] io_in_hwdata,
    output[31:0] io_in_hrdata,
    input  io_in_hsel,
    input  io_in_hreadyin,
    output io_in_hreadyout,
    output io_in_hresp,
    output[31:0] io_out_paddr,
    output io_out_pwrite,
    output io_out_psel,
    output io_out_penable,
    output[31:0] io_out_pwdata,
    input [31:0] io_out_prdata,
    input  io_out_pready,
    input  io_out_pslverr
);

  wire T0;
  reg [1:0] state;
  wire[1:0] T26;
  wire[1:0] T1;
  wire[1:0] T2;
  wire[1:0] T3;
  wire[1:0] T4;
  wire[1:0] T5;
  wire T6;
  wire transfer;
  wire T7;
  wire T8;
  wire T9;
  wire T10;
  wire T11;
  wire T12;
  wire T13;
  wire T14;
  wire T15;
  wire T16;
  wire T17;
  wire T18;
  wire T19;
  reg  hwrite_reg;
  wire T20;
  reg [31:0] haddr_reg;
  wire[31:0] T21;
  wire T22;
  wire T23;
  wire T24;
  wire T25;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    state = {1{$random}};
    hwrite_reg = {1{$random}};
    haddr_reg = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_out_pwdata = io_in_hwdata;
  assign io_out_penable = T0;
  assign T0 = state == 2'h2;
  assign T26 = reset ? 2'h0 : T1;
  assign T1 = T17 ? 2'h2 : T2;
  assign T2 = T15 ? 2'h1 : T3;
  assign T3 = T11 ? 2'h0 : T4;
  assign T4 = T10 ? 2'h2 : T5;
  assign T5 = T6 ? 2'h1 : state;
  assign T6 = T9 & transfer;
  assign transfer = T8 & T7;
  assign T7 = io_in_htrans[1'h1];
  assign T8 = io_in_hsel & io_in_hreadyin;
  assign T9 = 2'h0 == state;
  assign T10 = 2'h1 == state;
  assign T11 = T14 & T12;
  assign T12 = io_out_pready & T13;
  assign T13 = ~ transfer;
  assign T14 = 2'h2 == state;
  assign T15 = T14 & T16;
  assign T16 = io_out_pready & transfer;
  assign T17 = T14 & T18;
  assign T18 = ~ io_out_pready;
  assign io_out_psel = T19;
  assign T19 = state != 2'h0;
  assign io_out_pwrite = hwrite_reg;
  assign T20 = transfer ? io_in_hwrite : hwrite_reg;
  assign io_out_paddr = haddr_reg;
  assign T21 = transfer ? io_in_haddr : haddr_reg;
  assign io_in_hresp = io_out_pslverr;
  assign io_in_hreadyout = T22;
  assign T22 = T24 | T23;
  assign T23 = state == 2'h0;
  assign T24 = T25 & io_out_pready;
  assign T25 = state == 2'h2;
  assign io_in_hrdata = io_out_prdata;

  always @(posedge clk) begin
    if(reset) begin
      state <= 2'h0;
    end else if(T17) begin
      state <= 2'h2;
    end else if(T15) begin
      state <= 2'h1;
    end else if(T11) begin
      state <= 2'h0;
    end else if(T10) begin
      state <= 2'h2;
    end else if(T6) begin
      state <= 2'h1;
    end
    if(transfer) begin
      hwrite_reg <= io_in_hwrite;
    end
    if(transfer) begin
      haddr_reg <= io_in_haddr;
    end
  end
endmodule

module PociBus(
    input [31:0] io_master_paddr,
    input  io_master_pwrite,
    input  io_master_psel,
    input  io_master_penable,
    input [31:0] io_master_pwdata,
    output[31:0] io_master_prdata,
    output io_master_pready,
    output io_master_pslverr,
    output[31:0] io_slaves_1_paddr,
    output io_slaves_1_pwrite,
    output io_slaves_1_psel,
    output io_slaves_1_penable,
    output[31:0] io_slaves_1_pwdata,
    input [31:0] io_slaves_1_prdata,
    input  io_slaves_1_pready,
    input  io_slaves_1_pslverr,
    output[31:0] io_slaves_0_paddr,
    output io_slaves_0_pwrite,
    output io_slaves_0_psel,
    output io_slaves_0_penable,
    output[31:0] io_slaves_0_pwdata,
    input [31:0] io_slaves_0_prdata,
    input  io_slaves_0_pready,
    input  io_slaves_0_pslverr
);

  wire T0;
  wire T1;
  wire[1:0] T2;
  wire[1:0] T3;
  wire T4;
  wire T5;
  wire[7:0] T6;
  wire T7;
  wire T8;
  wire[7:0] T9;
  wire T10;
  wire T11;
  wire T12;
  wire T13;
  wire T14;
  wire T15;
  wire T16;
  wire T17;
  wire[31:0] T18;
  wire[31:0] T19;
  wire[31:0] T20;


  assign io_slaves_0_pwdata = io_master_pwdata;
  assign io_slaves_0_penable = T0;
  assign T0 = io_master_penable & T1;
  assign T1 = T2[1'h0];
  assign T2 = T7 ? 2'h1 : T3;
  assign T3 = T4 ? 2'h2 : 2'h0;
  assign T4 = T5 & io_master_psel;
  assign T5 = T6 == 8'hf1;
  assign T6 = io_master_paddr[5'h1f:5'h18];
  assign T7 = T8 & io_master_psel;
  assign T8 = T9 == 8'hf0;
  assign T9 = io_master_paddr[5'h1f:5'h18];
  assign io_slaves_0_psel = T1;
  assign io_slaves_0_pwrite = io_master_pwrite;
  assign io_slaves_0_paddr = io_master_paddr;
  assign io_slaves_1_pwdata = io_master_pwdata;
  assign io_slaves_1_penable = T10;
  assign T10 = io_master_penable & T11;
  assign T11 = T2[1'h1];
  assign io_slaves_1_psel = T11;
  assign io_slaves_1_pwrite = io_master_pwrite;
  assign io_slaves_1_paddr = io_master_paddr;
  assign io_master_pslverr = T12;
  assign T12 = T14 | T13;
  assign T13 = T11 ? io_slaves_1_pslverr : 1'h0;
  assign T14 = T1 ? io_slaves_0_pslverr : 1'h0;
  assign io_master_pready = T15;
  assign T15 = T17 | T16;
  assign T16 = T11 ? io_slaves_1_pready : 1'h0;
  assign T17 = T1 ? io_slaves_0_pready : 1'h0;
  assign io_master_prdata = T18;
  assign T18 = T20 | T19;
  assign T19 = T11 ? io_slaves_1_prdata : 32'h0;
  assign T20 = T1 ? io_slaves_0_prdata : 32'h0;
endmodule

module Apbbridge(input clk, input reset,
    input [31:0] io_ahbport_haddr,
    input  io_ahbport_hwrite,
    input [2:0] io_ahbport_hsize,
    input [2:0] io_ahbport_hburst,
    input [3:0] io_ahbport_hprot,
    input [1:0] io_ahbport_htrans,
    input  io_ahbport_hmastlock,
    input [31:0] io_ahbport_hwdata,
    output[31:0] io_ahbport_hrdata,
    input  io_ahbport_hsel,
    input  io_ahbport_hreadyin,
    output io_ahbport_hreadyout,
    output io_ahbport_hresp,
    output[31:0] io_uart_paddr,
    output io_uart_pwrite,
    output io_uart_psel,
    output io_uart_penable,
    output[31:0] io_uart_pwdata,
    input [31:0] io_uart_prdata,
    input  io_uart_pready,
    input  io_uart_pslverr,
    output[31:0] io_gpio_paddr,
    output io_gpio_pwrite,
    output io_gpio_psel,
    output io_gpio_penable,
    output[31:0] io_gpio_pwdata,
    input [31:0] io_gpio_prdata,
    input  io_gpio_pready,
    input  io_gpio_pslverr
);

  wire[31:0] bridge_io_in_hrdata;
  wire bridge_io_in_hreadyout;
  wire bridge_io_in_hresp;
  wire[31:0] bridge_io_out_paddr;
  wire bridge_io_out_pwrite;
  wire bridge_io_out_psel;
  wire bridge_io_out_penable;
  wire[31:0] bridge_io_out_pwdata;
  wire[31:0] apbbus_io_master_prdata;
  wire apbbus_io_master_pready;
  wire apbbus_io_master_pslverr;
  wire[31:0] apbbus_io_slaves_1_paddr;
  wire apbbus_io_slaves_1_pwrite;
  wire apbbus_io_slaves_1_psel;
  wire apbbus_io_slaves_1_penable;
  wire[31:0] apbbus_io_slaves_1_pwdata;
  wire[31:0] apbbus_io_slaves_0_paddr;
  wire apbbus_io_slaves_0_pwrite;
  wire apbbus_io_slaves_0_psel;
  wire apbbus_io_slaves_0_penable;
  wire[31:0] apbbus_io_slaves_0_pwdata;


  assign io_gpio_pwdata = apbbus_io_slaves_0_pwdata;
  assign io_gpio_penable = apbbus_io_slaves_0_penable;
  assign io_gpio_psel = apbbus_io_slaves_0_psel;
  assign io_gpio_pwrite = apbbus_io_slaves_0_pwrite;
  assign io_gpio_paddr = apbbus_io_slaves_0_paddr;
  assign io_uart_pwdata = apbbus_io_slaves_1_pwdata;
  assign io_uart_penable = apbbus_io_slaves_1_penable;
  assign io_uart_psel = apbbus_io_slaves_1_psel;
  assign io_uart_pwrite = apbbus_io_slaves_1_pwrite;
  assign io_uart_paddr = apbbus_io_slaves_1_paddr;
  assign io_ahbport_hresp = bridge_io_in_hresp;
  assign io_ahbport_hreadyout = bridge_io_in_hreadyout;
  assign io_ahbport_hrdata = bridge_io_in_hrdata;
  HastiToPociBridge bridge(.clk(clk), .reset(reset),
       .io_in_haddr( io_ahbport_haddr ),
       .io_in_hwrite( io_ahbport_hwrite ),
       .io_in_hsize( io_ahbport_hsize ),
       .io_in_hburst( io_ahbport_hburst ),
       .io_in_hprot( io_ahbport_hprot ),
       .io_in_htrans( io_ahbport_htrans ),
       .io_in_hmastlock( io_ahbport_hmastlock ),
       .io_in_hwdata( io_ahbport_hwdata ),
       .io_in_hrdata( bridge_io_in_hrdata ),
       .io_in_hsel( io_ahbport_hsel ),
       .io_in_hreadyin( io_ahbport_hreadyin ),
       .io_in_hreadyout( bridge_io_in_hreadyout ),
       .io_in_hresp( bridge_io_in_hresp ),
       .io_out_paddr( bridge_io_out_paddr ),
       .io_out_pwrite( bridge_io_out_pwrite ),
       .io_out_psel( bridge_io_out_psel ),
       .io_out_penable( bridge_io_out_penable ),
       .io_out_pwdata( bridge_io_out_pwdata ),
       .io_out_prdata( apbbus_io_master_prdata ),
       .io_out_pready( apbbus_io_master_pready ),
       .io_out_pslverr( apbbus_io_master_pslverr )
  );
  PociBus apbbus(
       .io_master_paddr( bridge_io_out_paddr ),
       .io_master_pwrite( bridge_io_out_pwrite ),
       .io_master_psel( bridge_io_out_psel ),
       .io_master_penable( bridge_io_out_penable ),
       .io_master_pwdata( bridge_io_out_pwdata ),
       .io_master_prdata( apbbus_io_master_prdata ),
       .io_master_pready( apbbus_io_master_pready ),
       .io_master_pslverr( apbbus_io_master_pslverr ),
       .io_slaves_1_paddr( apbbus_io_slaves_1_paddr ),
       .io_slaves_1_pwrite( apbbus_io_slaves_1_pwrite ),
       .io_slaves_1_psel( apbbus_io_slaves_1_psel ),
       .io_slaves_1_penable( apbbus_io_slaves_1_penable ),
       .io_slaves_1_pwdata( apbbus_io_slaves_1_pwdata ),
       .io_slaves_1_prdata( io_uart_prdata ),
       .io_slaves_1_pready( io_uart_pready ),
       .io_slaves_1_pslverr( io_uart_pslverr ),
       .io_slaves_0_paddr( apbbus_io_slaves_0_paddr ),
       .io_slaves_0_pwrite( apbbus_io_slaves_0_pwrite ),
       .io_slaves_0_psel( apbbus_io_slaves_0_psel ),
       .io_slaves_0_penable( apbbus_io_slaves_0_penable ),
       .io_slaves_0_pwdata( apbbus_io_slaves_0_pwdata ),
       .io_slaves_0_prdata( io_gpio_prdata ),
       .io_slaves_0_pready( io_gpio_pready ),
       .io_slaves_0_pslverr( io_gpio_pslverr )
  );
endmodule
