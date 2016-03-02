//****************************************************************************/
//  J2 CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Tue Jan 19 21:12:09 2016
//
//  This program is free software; you can redistribute it and/or
//  modify it under the terms of the GNU General Public License
//  as published by the Free Software Foundation; either version 2
//  of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,MA 02110-1301,USA.
//
//
//  Filename        :  nanorv32_simple.v
//
//  Description : A simple chip based on a nanorv32 core and two
//  synchronous RAMS - suitable for FPGA
//
//
//
//****************************************************************************/




module nanorv32_simpleahb (/*AUTOARG*/
   // Outputs
   illegal_instruction, irq_ack,
   // Inouts
   P0, P1,
   // Inputs
   clk_in, rst_n, irq
   );

`include "nanorv32_parameters.v"

   parameter AW = 16; // 64K per RAM
   localparam ADDR_WIDTH = AW;

   input                clk_in;                    // To U_CPU of nanorv32.v
   input                rst_n;                  // To U_CPU of nanorv32.v


   output               illegal_instruction;    // From U_CPU of nanorv32.v

   inout  wire [15:0]   P0;
   inout  wire [15:0]   P1;

   // irq support (preliminary)
   input                irq;
   output               irq_ack;



   // Code memory port
   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [31:0]          apb_gpio_paddr;         // From U_APB_BRIDGE of Apbbridge.v
   wire                 apb_gpio_penable;       // From U_APB_BRIDGE of Apbbridge.v
   wire                 apb_gpio_psel;          // From U_APB_BRIDGE of Apbbridge.v
   wire [31:0]          apb_gpio_pwdata;        // From U_APB_BRIDGE of Apbbridge.v
   wire                 apb_gpio_pwrite;        // From U_APB_BRIDGE of Apbbridge.v
   wire [31:0]          apb_uart_paddr;         // From U_APB_BRIDGE of Apbbridge.v
   wire                 apb_uart_penable;       // From U_APB_BRIDGE of Apbbridge.v
   wire                 apb_uart_psel;          // From U_APB_BRIDGE of Apbbridge.v
   wire [31:0]          apb_uart_pwdata;        // From U_APB_BRIDGE of Apbbridge.v
   wire                 apb_uart_pwrite;        // From U_APB_BRIDGE of Apbbridge.v
   wire                 clk;                    // From U_CLK_GEN of nanorv32_clkgen.v
   wire [31:0]          gpio_apb_prdata;        // From U_GPIO of gpio_apb.v
   wire                 gpio_apb_pready;        // From U_GPIO of gpio_apb.v
   wire                 gpio_apb_pslverr;       // From U_GPIO of gpio_apb.v
   wire                 hmastlockd;             // From U_NANORV32_PIL of nanorv32_pil.v
   wire                 hmastlocki;             // From U_NANORV32_PIL of nanorv32_pil.v
   wire [31:0]          uart_apb_prdata;        // From U_USART of uart_wrapper.v
   wire                 uart_apb_pready;        // From U_USART of uart_wrapper.v
   wire                 uart_apb_pslverr;       // From U_USART of uart_wrapper.v
   // End of automatics

   wire [NANORV32_DATA_MSB:0] hrdatai;
   wire                       hrespi;
   wire                       hreadyi;
   wire [NANORV32_DATA_MSB:0] haddri;
   wire [3:0]                 hproti;
   wire [2:0]                 hsizei;
   wire                       hmasteri;
   wire                       hmasterlocki;
   wire [2:0]                 hbursti;
   wire [NANORV32_DATA_MSB:0] hwdatai;
   wire                       hwritei;
   wire                       htransi;


   wire [NANORV32_DATA_MSB:0] hrdatad;
   wire                       hrespd;
   wire                       hreadyd;
   wire [NANORV32_DATA_MSB:0] haddrd;
   wire [3:0]                 hprotd;
   wire [2:0]                 hsized;
   wire                       hmasterd;
   wire                       hmasterlockd;
   wire [2:0]                 hburstd;
   wire [NANORV32_DATA_MSB:0] hwdatad;
   wire                       hwrited;
   wire                       htransd;

   wire [31:0]  io_tcm0_haddr;
   wire         io_tcm0_hwrite;
   wire [2:0]   io_tcm0_hsize;
   wire [2:0]   io_tcm0_hburst;
   wire [3:0]   io_tcm0_hprot;
   wire [1:0]   io_tcm0_htrans;
   wire         io_tcm0_hmastlock;
   wire [31:0]  io_tcm0_hwdata;
   wire [31:0]  io_tcm0_hrdata;
   wire         io_tcm0_hsel;
   wire         io_tcm0_hreadyin;
   wire         io_tcm0_hreadyout;
   wire         io_tcm0_hresp;

   wire [31:0]  io_tcm1_haddr;
   wire         io_tcm1_hwrite;
   wire [2:0]   io_tcm1_hsize;
   wire [2:0]   io_tcm1_hburst;
   wire [3:0]   io_tcm1_hprot;
   wire [1:0]   io_tcm1_htrans;
   wire         io_tcm1_hmastlock;
   wire [31:0]  io_tcm1_hwdata;
   wire [31:0]  io_tcm1_hrdata;
   wire         io_tcm1_hsel;
   wire         io_tcm1_hreadyin;
   wire         io_tcm1_hreadyout;
   wire         io_tcm1_hresp;

   wire [31:0]  periph_haddr;
   wire         periph_hwrite;
   wire [2:0]   periph_hsize;
   wire [2:0]   periph_hburst;
   wire [3:0]   periph_hprot;
   wire [1:0]   periph_htrans;
   wire         periph_hmastlock;
   wire [31:0]  periph_hwdata;
   wire [31:0]  periph_hrdata;
   wire         periph_hsel;
   wire         periph_hreadyin;
   wire         periph_hreadyout;
   wire         periph_hresp;


   wire [31:0] pad_gpio_in;            // To U_GPIO of gpio_apb.v
   wire [31:0] gpio_pad_out;           // From U_GPIO of gpio_apb.v




    /* nanorv32_pil AUTO_TEMPLATE(
     .hmasteri            (),
     .hmasterlocki        (hmastlocki),
     .hmasterd            (),
     .hmasterlockd        (hmastlockd),
     ); */
   nanorv32_pil U_NANORV32_PIL (
                   /*AUTOINST*/
                                // Outputs
                                .haddrd         (haddrd[NANORV32_DATA_MSB:0]),
                                .hburstd        (hburstd[2:0]),
                                .hmasterlockd   (hmastlockd),    // Templated
                                .hmasterd       (),              // Templated
                                .hprotd         (hprotd[3:0]),
                                .hsized         (hsized[2:0]),
                                .htransd        (htransd),
                                .hwdatad        (hwdatad[NANORV32_DATA_MSB:0]),
                                .hwrited        (hwrited),
                                .haddri         (haddri[NANORV32_DATA_MSB:0]),
                                .hbursti        (hbursti[2:0]),
                                .hmasterlocki   (hmastlocki),    // Templated
                                .hmasteri       (),              // Templated
                                .hproti         (hproti[3:0]),
                                .hsizei         (hsizei[2:0]),
                                .htransi        (htransi),
                                .hwdatai        (hwdatai[NANORV32_DATA_MSB:0]),
                                .hwritei        (hwritei),
                                .illegal_instruction(illegal_instruction),
                                .irq_ack        (irq_ack),
                                // Inputs
                                .clk            (clk),
                                .rst_n          (rst_n),
                                .hrdatad        (hrdatad[NANORV32_DATA_MSB:0]),
                                .hreadyd        (hreadyd),
                                .hrespd         (hrespd),
                                .hrdatai        (hrdatai[NANORV32_DATA_MSB:0]),
                                .hreadyi        (hreadyi),
                                .hrespi         (hrespi),
                                .irq            (irq));






   /* cmsdk_ahb_ram AUTO_TEMPLATE(
    .HREADYOUT   (io_tcm@_hreadyout),
    .HRDATA      (io_tcm@_hrdata),
    .HRESP       (io_tcm@_hresp),
    // Inputs
    .HCLK        (clk),
    .HRESETn     (rst_n),
    .HSEL        (io_tcm@_hsel),
    .HADDR       (io_tcm@_haddr[15:0]),
    .HTRANS      (io_tcm@_htrans),
    .HSIZE       (io_tcm@_hsize),
    .HWRITE      (io_tcm@_hwrite),
    .HWDATA      (io_tcm@_hwdata),
    .HREADY      (io_tcm@_hreadyin),
    ); */

 cmsdk_ahb_ram u_tcm0(/*AUTOINST*/
                      // Outputs
                      .HREADYOUT        (io_tcm0_hreadyout),     // Templated
                      .HRDATA           (io_tcm0_hrdata),        // Templated
                      .HRESP            (io_tcm0_hresp),         // Templated
                      // Inputs
                      .HCLK             (clk),                   // Templated
                      .HRESETn          (rst_n),                 // Templated
                      .HSEL             (io_tcm0_hsel),          // Templated
                      .HADDR            (io_tcm0_haddr[15:0]),   // Templated
                      .HTRANS           (io_tcm0_htrans),        // Templated
                      .HSIZE            (io_tcm0_hsize),         // Templated
                      .HWRITE           (io_tcm0_hwrite),        // Templated
                      .HWDATA           (io_tcm0_hwdata),        // Templated
                      .HREADY           (io_tcm0_hreadyin));      // Templated


 cmsdk_ahb_ram u_tcm1(/*AUTOINST*/
                      // Outputs
                      .HREADYOUT        (io_tcm1_hreadyout),     // Templated
                      .HRDATA           (io_tcm1_hrdata),        // Templated
                      .HRESP            (io_tcm1_hresp),         // Templated
                      // Inputs
                      .HCLK             (clk),                   // Templated
                      .HRESETn          (rst_n),                 // Templated
                      .HSEL             (io_tcm1_hsel),          // Templated
                      .HADDR            (io_tcm1_haddr[15:0]),   // Templated
                      .HTRANS           (io_tcm1_htrans),        // Templated
                      .HSIZE            (io_tcm1_hsize),         // Templated
                      .HWRITE           (io_tcm1_hwrite),        // Templated
                      .HWDATA           (io_tcm1_hwdata),        // Templated
                      .HREADY           (io_tcm1_hreadyin));      // Templated

     /* Ahbmli AUTO_TEMPLATE(
      .io_iside_htrans      ({htransi,1'b0}),
      .io_dside_htrans      ({htransd,1'b0}),
      .io_iside_\([a-z]+\)       (\1i),
      .io_dside_\([a-z]+\)       (\1d),
      .io_periph_\([a-z]+\)       (periph_\1),
     ); */
   Ahbmli   u_ahbmatrix(
                        .clk         (clk),
                        .reset       (~rst_n),
                        .io_tcm0_hprot  (),
                        .io_tcm1_hprot  (),
                        .io_tcm0_hmastlock(),
                        .io_tcm1_hmastlock(),
                        .io_tcm0_hburst(),
                        .io_tcm1_hburst(),
                        /*AUTOINST*/
                        // Outputs
                        .io_dside_hrdata(hrdatad),               // Templated
                        .io_dside_hready(hreadyd),               // Templated
                        .io_dside_hresp (hrespd),                // Templated
                        .io_iside_hrdata(hrdatai),               // Templated
                        .io_iside_hready(hreadyi),               // Templated
                        .io_iside_hresp (hrespi),                // Templated
                        .io_periph_haddr(periph_haddr),          // Templated
                        .io_periph_hwrite(periph_hwrite),        // Templated
                        .io_periph_hsize(periph_hsize),          // Templated
                        .io_periph_hburst(periph_hburst),        // Templated
                        .io_periph_hprot(periph_hprot),          // Templated
                        .io_periph_htrans(periph_htrans),        // Templated
                        .io_periph_hmastlock(periph_hmastlock),  // Templated
                        .io_periph_hwdata(periph_hwdata),        // Templated
                        .io_periph_hsel (periph_hsel),           // Templated
                        .io_periph_hreadyin(periph_hreadyin),    // Templated
                        .io_tcm0_haddr  (io_tcm0_haddr[31:0]),
                        .io_tcm0_hwrite (io_tcm0_hwrite),
                        .io_tcm0_hsize  (io_tcm0_hsize[2:0]),
                        .io_tcm0_htrans (io_tcm0_htrans[1:0]),
                        .io_tcm0_hwdata (io_tcm0_hwdata[31:0]),
                        .io_tcm0_hsel   (io_tcm0_hsel),
                        .io_tcm0_hreadyin(io_tcm0_hreadyin),
                        .io_tcm1_haddr  (io_tcm1_haddr[31:0]),
                        .io_tcm1_hwrite (io_tcm1_hwrite),
                        .io_tcm1_hsize  (io_tcm1_hsize[2:0]),
                        .io_tcm1_htrans (io_tcm1_htrans[1:0]),
                        .io_tcm1_hwdata (io_tcm1_hwdata[31:0]),
                        .io_tcm1_hsel   (io_tcm1_hsel),
                        .io_tcm1_hreadyin(io_tcm1_hreadyin),
                        // Inputs
                        .io_dside_haddr (haddrd),                // Templated
                        .io_dside_hwrite(hwrited),               // Templated
                        .io_dside_hsize (hsized),                // Templated
                        .io_dside_hburst(hburstd),               // Templated
                        .io_dside_hprot (hprotd),                // Templated
                        .io_dside_htrans({htransd,1'b0}),        // Templated
                        .io_dside_hmastlock(hmastlockd),         // Templated
                        .io_dside_hwdata(hwdatad),               // Templated
                        .io_iside_haddr (haddri),                // Templated
                        .io_iside_hwrite(hwritei),               // Templated
                        .io_iside_hsize (hsizei),                // Templated
                        .io_iside_hburst(hbursti),               // Templated
                        .io_iside_hprot (hproti),                // Templated
                        .io_iside_htrans({htransi,1'b0}),        // Templated
                        .io_iside_hmastlock(hmastlocki),         // Templated
                        .io_iside_hwdata(hwdatai),               // Templated
                        .io_periph_hrdata(periph_hrdata),        // Templated
                        .io_periph_hreadyout(periph_hreadyout),  // Templated
                        .io_periph_hresp(periph_hresp),          // Templated
                        .io_tcm0_hrdata (io_tcm0_hrdata[31:0]),
                        .io_tcm0_hreadyout(io_tcm0_hreadyout),
                        .io_tcm0_hresp  (io_tcm0_hresp),
                        .io_tcm1_hrdata (io_tcm1_hrdata[31:0]),
                        .io_tcm1_hreadyout(io_tcm1_hreadyout),
                        .io_tcm1_hresp  (io_tcm1_hresp));




     /* Apbbridge AUTO_TEMPLATE(
      .io_ahbport_\([a-z]+\)       (periph_\1),
      .reset               (~rst_n),
      .io_\([a-z]+\)_prdata      (\1_apb_prdata[31:0]),
      .io_\([a-z]+\)_pready      (\1_apb_pready),
      .io_\([a-z]+\)_pslverr      (\1_apb_pslverr),
      .io_\([a-z]+\)_paddr       (apb_\1_paddr[31:0]),
      .io_\([a-z]+\)_pwrite      (apb_\1_pwrite),
      .io_\([a-z]+\)_psel        (apb_\1_psel),
      .io_\([a-z]+\)_penable     (apb_\1_penable),
      .io_\([a-z]+\)_pwdata      (apb_\1_pwdata[31:0]),


     ); */
   Apbbridge U_APB_BRIDGE (
                           /*AUTOINST*/
                           // Outputs
                           .io_ahbport_hrdata   (periph_hrdata), // Templated
                           .io_ahbport_hreadyout(periph_hreadyout), // Templated
                           .io_ahbport_hresp    (periph_hresp),  // Templated
                           .io_uart_paddr       (apb_uart_paddr[31:0]), // Templated
                           .io_uart_pwrite      (apb_uart_pwrite), // Templated
                           .io_uart_psel        (apb_uart_psel), // Templated
                           .io_uart_penable     (apb_uart_penable), // Templated
                           .io_uart_pwdata      (apb_uart_pwdata[31:0]), // Templated
                           .io_gpio_paddr       (apb_gpio_paddr[31:0]), // Templated
                           .io_gpio_pwrite      (apb_gpio_pwrite), // Templated
                           .io_gpio_psel        (apb_gpio_psel), // Templated
                           .io_gpio_penable     (apb_gpio_penable), // Templated
                           .io_gpio_pwdata      (apb_gpio_pwdata[31:0]), // Templated
                           // Inputs
                           .clk                 (clk),
                           .reset               (~rst_n),        // Templated
                           .io_ahbport_haddr    (periph_haddr),  // Templated
                           .io_ahbport_hwrite   (periph_hwrite), // Templated
                           .io_ahbport_hsize    (periph_hsize),  // Templated
                           .io_ahbport_hburst   (periph_hburst), // Templated
                           .io_ahbport_hprot    (periph_hprot),  // Templated
                           .io_ahbport_htrans   (periph_htrans), // Templated
                           .io_ahbport_hmastlock(periph_hmastlock), // Templated
                           .io_ahbport_hwdata   (periph_hwdata), // Templated
                           .io_ahbport_hsel     (periph_hsel),   // Templated
                           .io_ahbport_hreadyin (periph_hreadyin), // Templated
                           .io_uart_prdata      (uart_apb_prdata[31:0]), // Templated
                           .io_uart_pready      (uart_apb_pready), // Templated
                           .io_uart_pslverr     (uart_apb_pslverr), // Templated
                           .io_gpio_prdata      (gpio_apb_prdata[31:0]), // Templated
                           .io_gpio_pready      (gpio_apb_pready), // Templated
                           .io_gpio_pslverr     (gpio_apb_pslverr)); // Templated



 /* gpio_apb AUTO_TEMPLATE(
  .clk_apb            (clk),
  .rst_apb_n          (rst_n),
  ); */
   gpio_apb U_GPIO (
                    .pad_gpio_in        (pad_gpio_in[31:0]),
                    .gpio_pad_out       (gpio_pad_out[31:0]),

                           /*AUTOINST*/
                    // Outputs
                    .gpio_apb_prdata    (gpio_apb_prdata[31:0]),
                    .gpio_apb_pready    (gpio_apb_pready),
                    .gpio_apb_pslverr   (gpio_apb_pslverr),
                    // Inputs
                    .apb_gpio_psel      (apb_gpio_psel),
                    .apb_gpio_paddr     (apb_gpio_paddr[11:0]),
                    .apb_gpio_penable   (apb_gpio_penable),
                    .apb_gpio_pwrite    (apb_gpio_pwrite),
                    .apb_gpio_pwdata    (apb_gpio_pwdata[31:0]),
                    .clk_apb            (clk),                   // Templated
                    .rst_apb_n          (rst_n));                 // Templated


    /* uart_warpper AUTO_TEMPLATE(
     ); */
   uart_wrapper U_USART (
                         .uart_irq              (),
                         .uart_pad_tx           (), // Fixme
                         .pad_uart_rx           (),
                           /*AUTOINST*/
                         // Outputs
                         .uart_apb_prdata       (uart_apb_prdata[31:0]),
                         .uart_apb_pready       (uart_apb_pready),
                         .uart_apb_pslverr      (uart_apb_pslverr),
                         // Inputs
                         .apb_uart_psel         (apb_uart_psel),
                         .apb_uart_paddr        (apb_uart_paddr[11:0]),
                         .apb_uart_penable      (apb_uart_penable),
                         .apb_uart_pwrite       (apb_uart_pwrite),
                         .apb_uart_pwdata       (apb_uart_pwdata[31:0]),
                         .clk                   (clk),
                         .rst_n                 (rst_n));






//--    /* nanorv32_periph_mux AUTO_TEMPLATE(
//--     ); */
//--   nanorv32_periph_mux_ahb U_PERIPH_MUX (
//--                           /*AUTOINST*/
//--                                         // Outputs
//--                                         .periph_hrdata         (periph_hrdata[31:0]),
//--                                         .periph_hreadyout      (periph_hreadyout),
//--                                         .periph_hresp          (periph_hresp),
//--                                         .bus_gpio_addr         (bus_gpio_addr[NANORV32_PERIPH_ADDR_MSB:0]),
//--                                         .bus_gpio_bytesel      (bus_gpio_bytesel[3:0]),
//--                                         .bus_gpio_din          (bus_gpio_din[NANORV32_DATA_MSB:0]),
//--                                         .bus_gpio_en           (bus_gpio_en),
//--                                         // Inputs
//--                                         .clk_in                (clk_in),
//--                                         .rst_n                 (rst_n),
//--                                         .periph_haddr          (periph_haddr[31:0]),
//--                                         .periph_hwrite         (periph_hwrite),
//--                                         .periph_hsize          (periph_hsize[2:0]),
//--                                         .periph_hburst         (periph_hburst[2:0]),
//--                                         .periph_hprot          (periph_hprot[3:0]),
//--                                         .periph_htrans         (periph_htrans[1:0]),
//--                                         .periph_hmastlock      (periph_hmastlock),
//--                                         .periph_hwdata         (periph_hwdata[31:0]),
//--                                         .periph_hsel           (periph_hsel),
//--                                         .periph_hreadyin       (periph_hreadyin),
//--                                         .gpio_bus_dout         (gpio_bus_dout[NANORV32_DATA_MSB:0]),
//--                                         .gpio_bus_ready_nxt    (gpio_bus_ready_nxt));
//--
//--
//--
//--   wire [31:0]                       gpio_pad_out;
//--   wire [31:0]                       pad_gpio_in;
//--
//--    /* nanorv32_gpio_ctrl AUTO_TEMPLATE(
//--
//--     ); */
//--   nanorv32_gpio_ctrl U_GPIO_CTRL (
//--                                   .gpio_pad_out        (gpio_pad_out[31:0]),
//--                                   .pad_gpio_in         (pad_gpio_in[31:0]),
//--                           /*AUTOINST*/
//--                                   // Outputs
//--                                   .gpio_bus_dout       (gpio_bus_dout[31:0]),
//--                                   .gpio_bus_ready_nxt  (gpio_bus_ready_nxt),
//--                                   // Inputs
//--                                   .bus_gpio_addr       (bus_gpio_addr[NANORV32_PERIPH_ADDR_MSB:0]),
//--                                   .bus_gpio_bytesel    (bus_gpio_bytesel[3:0]),
//--                                   .bus_gpio_din        (bus_gpio_din[31:0]),
//--                                   .bus_gpio_en         (bus_gpio_en),
//--                                   .clk                 (clk),
//--                                   .rst_n               (rst_n));
//--
//--



    /* nanorv32_clkgen  AUTO_TEMPLATE(
     .clk_out         (clk),
     .locked          (),
    ); */
    nanorv32_clkgen U_CLK_GEN (

                               /*AUTOINST*/
                               // Outputs
                               .clk_out         (clk),           // Templated
                               .locked          (),              // Templated
                               // Inputs
                               .clk_in          (clk_in),
                               .rst_n           (rst_n));




   assign P0 = gpio_pad_out[15:0];
   assign pad_gpio_in[15:0] = P1;

endmodule // nanorv32_simple
/*
 Local Variables:
 verilog-library-directories:(
 "."
 "../cores"
 "../ips"
 "../chips"
 )
 End:
 */
