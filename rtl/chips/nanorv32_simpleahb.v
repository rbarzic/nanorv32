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

// Todo : memory mapping & arbitration (ROM : 0->32K - RAM 32K->64K)


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
   wire [NANORV32_PERIPH_ADDR_MSB:0] bus_gpio_addr;// From U_PERIPH_MUX of nanorv32_periph_mux_ahb.v
   wire [3:0]           bus_gpio_bytesel;       // From U_PERIPH_MUX of nanorv32_periph_mux_ahb.v
   wire [NANORV32_DATA_MSB:0] bus_gpio_din;     // From U_PERIPH_MUX of nanorv32_periph_mux_ahb.v
   wire                 bus_gpio_en;            // From U_PERIPH_MUX of nanorv32_periph_mux_ahb.v
   wire                 clk;                    // From U_CLK_GEN of nanorv32_clkgen.v
   wire [31:0]          gpio_bus_dout;          // From U_GPIO_CTRL of nanorv32_gpio_ctrl.v
   wire                 gpio_bus_ready_nxt;     // From U_GPIO_CTRL of nanorv32_gpio_ctrl.v
   wire                 hmastlockd;             // From U_CPU of nanorv32.v
   wire                 hmastlocki;             // From U_CPU of nanorv32.v
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

    /* nanorv32 AUTO_TEMPLATE(
     .hmasteri            (),
     .hmasterlocki        (hmastlocki),
     .hmasterd            (),
     .hmasterlockd        (hmastlockd),
     ); */
   nanorv32_pil U_NANORV32_PIL (
                   /*AUTOINST*/
                   // Outputs
                   .illegal_instruction (illegal_instruction),
                   .haddri              (haddri[NANORV32_DATA_MSB:0]),
                   .hproti              (hproti[3:0]),
                   .hsizei              (hsizei[2:0]),
                   .hmasteri            (),                      // Templated
                   .hmasterlocki        (hmastlocki),            // Templated
                   .hbursti             (hbursti[2:0]),
                   .hwdatai             (hwdatai[NANORV32_DATA_MSB:0]),
                   .hwritei             (hwritei),
                   .htransi             (htransi),
                   .haddrd              (haddrd[NANORV32_DATA_MSB:0]),
                   .hprotd              (hprotd[3:0]),
                   .hsized              (hsized[2:0]),
                   .hmasterd            (),                      // Templated
                   .hmasterlockd        (hmastlockd),            // Templated
                   .hburstd             (hburstd[2:0]),
                   .hwdatad             (hwdatad[NANORV32_DATA_MSB:0]),
                   .hwrited             (hwrited),
                   .htransd             (htransd),
                   .irq_ack             (irq_ack),
                   // Inputs
                   .rst_n               (rst_n),
                   .clk                 (clk),
                   .hrdatai             (hrdatai[NANORV32_DATA_MSB:0]),
                   .hrespi              (hrespi),
                   .hreadyi             (hreadyi),
                   .hrdatad             (hrdatad[NANORV32_DATA_MSB:0]),
                   .hrespd              (hrespd),
                   .hreadyd             (hreadyd),
                   .irq                 (irq));






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


    /* nanorv32_periph_mux AUTO_TEMPLATE(
     ); */
   nanorv32_periph_mux_ahb U_PERIPH_MUX (
                           /*AUTOINST*/
                                         // Outputs
                                         .periph_hrdata         (periph_hrdata[31:0]),
                                         .periph_hreadyout      (periph_hreadyout),
                                         .periph_hresp          (periph_hresp),
                                         .bus_gpio_addr         (bus_gpio_addr[NANORV32_PERIPH_ADDR_MSB:0]),
                                         .bus_gpio_bytesel      (bus_gpio_bytesel[3:0]),
                                         .bus_gpio_din          (bus_gpio_din[NANORV32_DATA_MSB:0]),
                                         .bus_gpio_en           (bus_gpio_en),
                                         // Inputs
                                         .clk_in                (clk_in),
                                         .rst_n                 (rst_n),
                                         .periph_haddr          (periph_haddr[31:0]),
                                         .periph_hwrite         (periph_hwrite),
                                         .periph_hsize          (periph_hsize[2:0]),
                                         .periph_hburst         (periph_hburst[2:0]),
                                         .periph_hprot          (periph_hprot[3:0]),
                                         .periph_htrans         (periph_htrans[1:0]),
                                         .periph_hmastlock      (periph_hmastlock),
                                         .periph_hwdata         (periph_hwdata[31:0]),
                                         .periph_hsel           (periph_hsel),
                                         .periph_hreadyin       (periph_hreadyin),
                                         .gpio_bus_dout         (gpio_bus_dout[NANORV32_DATA_MSB:0]),
                                         .gpio_bus_ready_nxt    (gpio_bus_ready_nxt));



   wire [31:0]                       gpio_pad_out;
   wire [31:0]                       pad_gpio_in;

    /* nanorv32_gpio_ctrl AUTO_TEMPLATE(

     ); */
   nanorv32_gpio_ctrl U_GPIO_CTRL (
                                   .gpio_pad_out        (gpio_pad_out[31:0]),
                                   .pad_gpio_in         (pad_gpio_in[31:0]),
                           /*AUTOINST*/
                                   // Outputs
                                   .gpio_bus_dout       (gpio_bus_dout[31:0]),
                                   .gpio_bus_ready_nxt  (gpio_bus_ready_nxt),
                                   // Inputs
                                   .bus_gpio_addr       (bus_gpio_addr[NANORV32_PERIPH_ADDR_MSB:0]),
                                   .bus_gpio_bytesel    (bus_gpio_bytesel[3:0]),
                                   .bus_gpio_din        (bus_gpio_din[31:0]),
                                   .bus_gpio_en         (bus_gpio_en),
                                   .clk                 (clk),
                                   .rst_n               (rst_n));





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
