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
   pad_gpio_in, adbg_w2ahb_cab, illegal_instruction, TDO,
   // Inouts
   P0, P1,
   // Inputs
   clk_in, rst_n, irq_ext, TMS, TCK, TDI
   );

`include "nanorv32_parameters.v"
`include "chip_params.v"


   parameter AW = 16; // 64K per RAM
   localparam ADDR_WIDTH = AW;

   input                clk_in;                    // To U_CPU of nanorv32.v
   input                rst_n;                  // To U_CPU of nanorv32.v


   output               illegal_instruction;    // From U_CPU of nanorv32.v

   inout  wire [15:0]   P0;
   inout  wire [15:0]   P1;

   // irq support (preliminary)

   input                irq_ext;

   input                TMS;
   input                TCK;
   input                TDI;
   output               TDO;


   // Code memory port
   /*AUTOINPUT*/
   /*AUTOOUTPUT*/
   // Beginning of automatic outputs (from unused autoinst outputs)
   output               adbg_w2ahb_cab;         // From U_ADBG_TOP of adbg_top.v
   output [CHIP_PORT_A_WIDTH-1:0] pad_gpio_in;  // From U_PORT_MUX of port_mux.v
   // End of automatics

   /*AUTOREG*/
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [CHIP_PORT_A_WIDTH-1:0] PA;             // To/From U_TOP_IO of top_io.v
   wire                 adbg_w2ahb_cyc;         // From U_ADBG_TOP of adbg_top.v
   wire                 adbg_w2ahb_stb;         // From U_ADBG_TOP of adbg_top.v
   wire                 adbg_w2ahb_we;          // From U_ADBG_TOP of adbg_top.v
   wire [NANORV32_DATA_MSB:0] ahb_w2ahb_hrdata; // From u_ahbmatrix of Ahbmli.v
   wire                 ahb_w2ahb_hready;       // From u_ahbmatrix of Ahbmli.v
   wire [31:0]          apb_gpio_paddr;         // From U_APB_BRIDGE of Apbbridge.v
   wire                 apb_gpio_penable;       // From U_APB_BRIDGE of Apbbridge.v
   wire                 apb_gpio_psel;          // From U_APB_BRIDGE of Apbbridge.v
   wire [31:0]          apb_gpio_pwdata;        // From U_APB_BRIDGE of Apbbridge.v
   wire                 apb_gpio_pwrite;        // From U_APB_BRIDGE of Apbbridge.v
   wire [31:0]          apb_intc_paddr;         // From U_APB_BRIDGE of Apbbridge.v
   wire                 apb_intc_penable;       // From U_APB_BRIDGE of Apbbridge.v
   wire                 apb_intc_psel;          // From U_APB_BRIDGE of Apbbridge.v
   wire [31:0]          apb_intc_pwdata;        // From U_APB_BRIDGE of Apbbridge.v
   wire                 apb_intc_pwrite;        // From U_APB_BRIDGE of Apbbridge.v
   wire [31:0]          apb_timer_paddr;        // From U_APB_BRIDGE of Apbbridge.v
   wire                 apb_timer_penable;      // From U_APB_BRIDGE of Apbbridge.v
   wire                 apb_timer_psel;         // From U_APB_BRIDGE of Apbbridge.v
   wire [31:0]          apb_timer_pwdata;       // From U_APB_BRIDGE of Apbbridge.v
   wire                 apb_timer_pwrite;       // From U_APB_BRIDGE of Apbbridge.v
   wire [31:0]          apb_uart_paddr;         // From U_APB_BRIDGE of Apbbridge.v
   wire                 apb_uart_penable;       // From U_APB_BRIDGE of Apbbridge.v
   wire                 apb_uart_psel;          // From U_APB_BRIDGE of Apbbridge.v
   wire [31:0]          apb_uart_pwdata;        // From U_APB_BRIDGE of Apbbridge.v
   wire                 apb_uart_pwrite;        // From U_APB_BRIDGE of Apbbridge.v
   wire                 clk;                    // From U_CLK_GEN of nanorv32_clkgen.v
   wire                 debug_tap_tdo;          // From U_ADBG_TOP of adbg_top.v
   wire [31:0]          gpio_apb_prdata;        // From U_GPIO of gpio_apb.v
   wire                 gpio_apb_pready;        // From U_GPIO of gpio_apb.v
   wire                 gpio_apb_pslverr;       // From U_GPIO of gpio_apb.v
   wire                 gpio_irq;               // From U_GPIO of gpio_apb.v
   wire                 hmastlockd;             // From U_NANORV32_PIL of nanorv32_pil.v
   wire                 hmastlocki;             // From U_NANORV32_PIL of nanorv32_pil.v
   wire [31:0]          intc_apb_prdata;        // From U_INTC of nanorv32_intc.v
   wire                 intc_apb_pready;        // From U_INTC of nanorv32_intc.v
   wire                 intc_apb_pslverr;       // From U_INTC of nanorv32_intc.v
   wire                 intc_cpu_irq;           // From U_INTC of nanorv32_intc.v
   wire                 irq_ack;                // From U_NANORV32_PIL of nanorv32_pil.v
   wire [7:0]           irqs;                   // From U_IRQ_MAPPER of nanorv32_irq_mapper.v
   wire [CHIP_PORT_A_WIDTH-1:0] pad_pmux_din;   // From U_TOP_IO of top_io.v
   wire                 pad_tap_tck;            // From U_TOP_IO of top_io.v
   wire                 pad_tap_tdi;            // From U_TOP_IO of top_io.v
   wire                 pad_tap_tms;            // From U_TOP_IO of top_io.v
   wire                 pad_uart_rx;            // From U_PORT_MUX of port_mux.v
   wire [CHIP_PORT_A_WIDTH-1:0] pmux_pad_dout;  // From U_PORT_MUX of port_mux.v
   wire [CHIP_PORT_A_WIDTH-1:0] pmux_pad_ie;    // From U_PORT_MUX of port_mux.v
   wire [CHIP_PORT_A_WIDTH-1:0] pmux_pad_oe;    // From U_PORT_MUX of port_mux.v
   wire                 tap_debug_capture_dr;   // From U_TAP_TOP of tap_top.v
   wire                 tap_debug_debug_select; // From U_TAP_TOP of tap_top.v
   wire                 tap_debug_pause_dr;     // From U_TAP_TOP of tap_top.v
   wire                 tap_debug_rst;          // From U_TAP_TOP of tap_top.v
   wire                 tap_debug_shift_dr;     // From U_TAP_TOP of tap_top.v
   wire                 tap_debug_tdi;          // From U_TAP_TOP of tap_top.v
   wire                 tap_debug_update_dr;    // From U_TAP_TOP of tap_top.v
   wire                 tap_pad_tdo;            // From U_TAP_TOP of tap_top.v
   wire                 tap_pad_tdo_oe;         // From U_TAP_TOP of tap_top.v
   wire [31:0]          timer_apb_prdata;       // From U_TIMER of timer_wrapper.v
   wire                 timer_apb_pready;       // From U_TIMER of timer_wrapper.v
   wire                 timer_apb_pslverr;      // From U_TIMER of timer_wrapper.v
   wire                 timer_hires_irq;        // From U_TIMER of timer_wrapper.v
   wire                 timer_systick_irq;      // From U_TIMER of timer_wrapper.v
   wire [31:0]          uart_apb_prdata;        // From U_USART of uart_wrapper.v
   wire                 uart_apb_pready;        // From U_USART of uart_wrapper.v
   wire                 uart_apb_pslverr;       // From U_USART of uart_wrapper.v
   wire                 uart_irq;               // From U_USART of uart_wrapper.v
   wire                 uart_pad_tx;            // From U_USART of uart_wrapper.v
   // End of automatics

   wire                           w2ahb_adbg_ack;         // From U_INSTANCE of ahbmas_wbslv_top.v
   wire [NANORV32_DATA_MSB:0]     w2ahb_ahb_haddr;        // From U_INSTANCE of ahbmas_wbslv_top.v
   wire [2:0]                     w2ahb_ahb_hburst;       // From U_INSTANCE of ahbmas_wbslv_top.v
   wire [2:0]                     w2ahb_ahb_hsize;        // From U_INSTANCE of ahbmas_wbslv_top.v
   wire [1:0]                     w2ahb_ahb_htrans;       // From U_INSTANCE of ahbmas_wbslv_top.v
   wire [31:0]                    w2ahb_ahb_hwdata;       // From U_INSTANCE of ahbmas_wbslv_top.v
   wire                           w2ahb_ahb_hwrite;       // From U_INSTANCE of ahbmas_wbslv_top.v

   wire                           ahb_w2ahb_hresp;        // From u_ahbmatrix of Ahbmli.v
   wire [NANORV32_DATA_MSB:0]     adbg_w2ahb_adr;         // From U_ADBG_TOP of adbg_top.v

   wire [NANORV32_DATA_MSB:0]     adbg_w2ahb_dat;         // From U_ADBG_TOP of adbg_top.v
   wire [NANORV32_DATA_MSB:0]     w2ahb_adbg_dat;
   wire [3:0]                     adbg_w2ahb_sel;         // From U_ADBG_TOP of adbg_top.v
   wire [2:0]                     adbg_w2ahb_cti;


   wire [NANORV32_DATA_MSB:0]     hrdatai;
   wire                           hrespi;
   wire                           hreadyi;
   wire [NANORV32_DATA_MSB:0]     haddri;
   wire [3:0]                     hproti;
   wire [2:0]                     hsizei;
   wire                           hmasteri;
   wire                           hmasterlocki;
   wire [2:0]                     hbursti;
   wire [NANORV32_DATA_MSB:0]     hwdatai;
   wire                           hwritei;
   wire                           htransi;


   wire [NANORV32_DATA_MSB:0]     hrdatad;
   wire                           hrespd;
   wire                           hreadyd;
   wire [NANORV32_DATA_MSB:0]     haddrd;
   wire [3:0]                     hprotd;
   wire [2:0]                     hsized;
   wire                           hmasterd;
   wire                           hmasterlockd;
   wire [2:0]                     hburstd;
   wire [NANORV32_DATA_MSB:0]     hwdatad;
   wire                           hwrited;
   wire                           htransd;

   wire [31:0]                    io_tcm0_haddr;
   wire                           io_tcm0_hwrite;
   wire [2:0]                     io_tcm0_hsize;
   wire [2:0]                     io_tcm0_hburst;
   wire [3:0]                     io_tcm0_hprot;
   wire [1:0]                     io_tcm0_htrans;
   wire                           io_tcm0_hmastlock;
   wire [31:0]                    io_tcm0_hwdata;
   wire [31:0]                    io_tcm0_hrdata;
   wire                           io_tcm0_hsel;
   wire                           io_tcm0_hreadyin;
   wire                           io_tcm0_hreadyout;
   wire                           io_tcm0_hresp;

   wire [31:0]                    io_tcm1_haddr;
   wire                           io_tcm1_hwrite;
   wire [2:0]                     io_tcm1_hsize;
   wire [2:0]                     io_tcm1_hburst;
   wire [3:0]                     io_tcm1_hprot;
   wire [1:0]                     io_tcm1_htrans;
   wire                           io_tcm1_hmastlock;
   wire [31:0]                    io_tcm1_hwdata;
   wire [31:0]                    io_tcm1_hrdata;
   wire                           io_tcm1_hsel;
   wire                           io_tcm1_hreadyin;
   wire                           io_tcm1_hreadyout;
   wire                           io_tcm1_hresp;

   wire [31:0]                    periph_haddr;
   wire                           periph_hwrite;
   wire [2:0]                     periph_hsize;
   wire [2:0]                     periph_hburst;
   wire [3:0]                     periph_hprot;
   wire [1:0]                     periph_htrans;
   wire                           periph_hmastlock;
   wire [31:0]                    periph_hwdata;
   wire [31:0]                    periph_hrdata;
   wire                           periph_hsel;
   wire                           periph_hreadyin;
   wire                           periph_hreadyout;
   wire                           periph_hresp;


   wire [15:0]                    pad_gpio_in;            // To U_GPIO of gpio_apb.v
   wire [31:0]                    gpio_pad_out;           // From U_GPIO of gpio_apb.v

   wire                           irq_ext;


   /* nanorv32_pil AUTO_TEMPLATE(
    .hmasteri            (),
    .hmasterlocki        (hmastlocki),
    .hmasterd            (),
    .hmasterlockd        (hmastlockd),
    .irq            (intc_cpu_irq),
    ); */
   nanorv32_pil
     U_NANORV32_PIL (
                     /*AUTOINST*/
                     // Outputs
                     .haddrd            (haddrd[NANORV32_DATA_MSB:0]),
                     .hburstd           (hburstd[2:0]),
                     .hmasterlockd      (hmastlockd),            // Templated
                     .hmasterd          (),                      // Templated
                     .hprotd            (hprotd[3:0]),
                     .hsized            (hsized[2:0]),
                     .htransd           (htransd),
                     .hwdatad           (hwdatad[NANORV32_DATA_MSB:0]),
                     .hwrited           (hwrited),
                     .haddri            (haddri[NANORV32_DATA_MSB:0]),
                     .hbursti           (hbursti[2:0]),
                     .hmasterlocki      (hmastlocki),            // Templated
                     .hmasteri          (),                      // Templated
                     .hproti            (hproti[3:0]),
                     .hsizei            (hsizei[2:0]),
                     .htransi           (htransi),
                     .hwdatai           (hwdatai[NANORV32_DATA_MSB:0]),
                     .hwritei           (hwritei),
                     .illegal_instruction(illegal_instruction),
                     .irq_ack           (irq_ack),
                     // Inputs
                     .clk               (clk),
                     .rst_n             (rst_n),
                     .hrdatad           (hrdatad[NANORV32_DATA_MSB:0]),
                     .hreadyd           (hreadyd),
                     .hrespd            (hrespd),
                     .hrdatai           (hrdatai[NANORV32_DATA_MSB:0]),
                     .hreadyi           (hreadyi),
                     .hrespi            (hrespi),
                     .irq               (intc_cpu_irq));          // Templated






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
                        .HREADYOUT      (io_tcm0_hreadyout),     // Templated
                        .HRDATA         (io_tcm0_hrdata),        // Templated
                        .HRESP          (io_tcm0_hresp),         // Templated
                        // Inputs
                        .HCLK           (clk),                   // Templated
                        .HRESETn        (rst_n),                 // Templated
                        .HSEL           (io_tcm0_hsel),          // Templated
                        .HADDR          (io_tcm0_haddr[15:0]),   // Templated
                        .HTRANS         (io_tcm0_htrans),        // Templated
                        .HSIZE          (io_tcm0_hsize),         // Templated
                        .HWRITE         (io_tcm0_hwrite),        // Templated
                        .HWDATA         (io_tcm0_hwdata),        // Templated
                        .HREADY         (io_tcm0_hreadyin));      // Templated


   cmsdk_ahb_ram u_tcm1(/*AUTOINST*/
                        // Outputs
                        .HREADYOUT      (io_tcm1_hreadyout),     // Templated
                        .HRDATA         (io_tcm1_hrdata),        // Templated
                        .HRESP          (io_tcm1_hresp),         // Templated
                        // Inputs
                        .HCLK           (clk),                   // Templated
                        .HRESETn        (rst_n),                 // Templated
                        .HSEL           (io_tcm1_hsel),          // Templated
                        .HADDR          (io_tcm1_haddr[15:0]),   // Templated
                        .HTRANS         (io_tcm1_htrans),        // Templated
                        .HSIZE          (io_tcm1_hsize),         // Templated
                        .HWRITE         (io_tcm1_hwrite),        // Templated
                        .HWDATA         (io_tcm1_hwdata),        // Templated
                        .HREADY         (io_tcm1_hreadyin));      // Templated

   /* Ahbmli AUTO_TEMPLATE(
    .io_iside_htrans      ({htransi,1'b0}),
    .io_dside_htrans      ({htransd,1'b0}),
    .io_iside_\([a-z]+\)       (\1i),
    .io_dside_\([a-z]+\)       (\1d),
    .io_periph_\([a-z]+\)       (periph_\1),



    .io_dbg_\(hready\|hresp\|hrdata\)         (ahb_w2ahb_\1),
    .io_dbg_hrdata         (ahb_w2ahb_hrdata[NANORV32_DATA_MSB:0]),
    .io_dbg_\(haddr\|hwrite\|hsize\|hburst\|hwdata\|htrans\)         (w2ahb_ahb_\1),

    .hresp          (ahb_w2ahb_hresp),
    .hready         (ahb_w2ahb_hready),

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

                        .io_dbg_hprot   (4'b0), // Not provided by the wishbone->ahb bridge
                        .io_dbg_hmastlock(1'b0),

                        /*AUTOINST*/
                        // Outputs
                        .io_dbg_hrdata  (ahb_w2ahb_hrdata[NANORV32_DATA_MSB:0]), // Templated
                        .io_dbg_hready  (ahb_w2ahb_hready),      // Templated
                        .io_dbg_hresp   (ahb_w2ahb_hresp),       // Templated
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
                        .io_dbg_haddr   (w2ahb_ahb_haddr),       // Templated
                        .io_dbg_hwrite  (w2ahb_ahb_hwrite),      // Templated
                        .io_dbg_hsize   (w2ahb_ahb_hsize),       // Templated
                        .io_dbg_hburst  (w2ahb_ahb_hburst),      // Templated
                        .io_dbg_htrans  (w2ahb_ahb_htrans),      // Templated
                        .io_dbg_hwdata  (w2ahb_ahb_hwdata),      // Templated
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
                           .io_intc_paddr       (apb_intc_paddr[31:0]), // Templated
                           .io_intc_pwrite      (apb_intc_pwrite), // Templated
                           .io_intc_psel        (apb_intc_psel), // Templated
                           .io_intc_penable     (apb_intc_penable), // Templated
                           .io_intc_pwdata      (apb_intc_pwdata[31:0]), // Templated
                           .io_timer_paddr      (apb_timer_paddr[31:0]), // Templated
                           .io_timer_pwrite     (apb_timer_pwrite), // Templated
                           .io_timer_psel       (apb_timer_psel), // Templated
                           .io_timer_penable    (apb_timer_penable), // Templated
                           .io_timer_pwdata     (apb_timer_pwdata[31:0]), // Templated
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
                           .io_gpio_pslverr     (gpio_apb_pslverr), // Templated
                           .io_intc_prdata      (intc_apb_prdata[31:0]), // Templated
                           .io_intc_pready      (intc_apb_pready), // Templated
                           .io_intc_pslverr     (intc_apb_pslverr), // Templated
                           .io_timer_prdata     (timer_apb_prdata[31:0]), // Templated
                           .io_timer_pready     (timer_apb_pready), // Templated
                           .io_timer_pslverr    (timer_apb_pslverr)); // Templated



   /* gpio_apb AUTO_TEMPLATE(
    .clk_apb            (clk),
    .rst_apb_n          (rst_n),
    ); */
   gpio_apb U_GPIO (
                    .pad_gpio_in        (pad_gpio_in[15:0]),
                    .gpio_pad_out       (gpio_pad_out[15:0]),

                    /*AUTOINST*/
                    // Outputs
                    .gpio_apb_prdata    (gpio_apb_prdata[31:0]),
                    .gpio_apb_pready    (gpio_apb_pready),
                    .gpio_apb_pslverr   (gpio_apb_pslverr),
                    .gpio_irq           (gpio_irq),
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

                         /*AUTOINST*/
                         // Outputs
                         .uart_apb_prdata       (uart_apb_prdata[31:0]),
                         .uart_apb_pready       (uart_apb_pready),
                         .uart_apb_pslverr      (uart_apb_pslverr),
                         .uart_irq              (uart_irq),
                         .uart_pad_tx           (uart_pad_tx),
                         // Inputs
                         .apb_uart_psel         (apb_uart_psel),
                         .apb_uart_paddr        (apb_uart_paddr[11:0]),
                         .apb_uart_penable      (apb_uart_penable),
                         .apb_uart_pwrite       (apb_uart_pwrite),
                         .apb_uart_pwdata       (apb_uart_pwdata[31:0]),
                         .pad_uart_rx           (pad_uart_rx),
                         .clk                   (clk),
                         .rst_n                 (rst_n));


   /* timer_wrapper AUTO_TEMPLATE(
    ); */
   timer_wrapper U_TIMER (
                          /*AUTOINST*/
                          // Outputs
                          .timer_apb_prdata     (timer_apb_prdata[31:0]),
                          .timer_apb_pready     (timer_apb_pready),
                          .timer_apb_pslverr    (timer_apb_pslverr),
                          .timer_hires_irq      (timer_hires_irq),
                          .timer_systick_irq    (timer_systick_irq),
                          // Inputs
                          .apb_timer_psel       (apb_timer_psel),
                          .apb_timer_paddr      (apb_timer_paddr[11:0]),
                          .apb_timer_penable    (apb_timer_penable),
                          .apb_timer_pwrite     (apb_timer_pwrite),
                          .apb_timer_pwdata     (apb_timer_pwdata[31:0]),
                          .clk                  (clk),
                          .rst_n                (rst_n));




   /* nanorv32_irq_mapper AUTO_TEMPLATE(
    ); */
   nanorv32_irq_mapper U_IRQ_MAPPER (
                                     /*AUTOINST*/
                                     // Outputs
                                     .irqs              (irqs[7:0]),
                                     // Inputs
                                     .uart_irq          (uart_irq),
                                     .gpio_irq          (gpio_irq),
                                     .timer_systick_irq (timer_systick_irq),
                                     .timer_hires_irq   (timer_hires_irq));





   /* nanorv32_intc AUTO_TEMPLATE(
    .intc_irq              (intc_cpu_irq),
    ); */
   nanorv32_intc U_INTC (
                         .irq_ext               (irq_ext),
                         /*AUTOINST*/
                         // Outputs
                         .intc_apb_prdata       (intc_apb_prdata[31:0]),
                         .intc_apb_pready       (intc_apb_pready),
                         .intc_apb_pslverr      (intc_apb_pslverr),
                         .intc_irq              (intc_cpu_irq),  // Templated
                         // Inputs
                         .apb_intc_psel         (apb_intc_psel),
                         .apb_intc_paddr        (apb_intc_paddr[11:0]),
                         .apb_intc_penable      (apb_intc_penable),
                         .apb_intc_pwrite       (apb_intc_pwrite),
                         .apb_intc_pwdata       (apb_intc_pwdata[31:0]),
                         .irqs                  (irqs[7:0]),
                         .irq_ack               (irq_ack),
                         .clk                   (clk),
                         .rst_n                 (rst_n));





   /* tap_top AUTO_TEMPLATE(
    .tdo_pad_o        (tap_pad_tdo),
    .tdo_padoe_o      (tap_pad_tdo_oe),
    .tms_pad_i        (pad_tap_tms),
    .tck_pad_i        (pad_tap_tck),
    .tdi_pad_i        (pad_tap_tdi),
    .trstn_pad_i      (rst_n), // ?? FIXME
    // TAP state signals
    .shift_dr_o       (tap_debug_shift_dr),
    .pause_dr_o       (tap_debug_pause_dr),
    .update_dr_o      (tap_debug_update_dr),
    .capture_dr_o     (tap_debug_capture_dr),
    .debug_select_o   (tap_debug_debug_select),

    .debug_tdo_i      (debug_tap_tdo),
    .tdi_o            (tap_debug_tdi),

    .test_logic_reset_o(tap_debug_rst),

    ); */
   tap_top
     U_TAP_TOP (
                .bs_chain_tdo_i   (1'b0), // Boundary scan chain not used
                .mbist_tdo_i      (1'b0),
                // Unused
                .run_test_idle_o        (),
                .extest_select_o(),
                .sample_preload_select_o(),
                .mbist_select_o(),
                /*AUTOINST*/
                // Outputs
                .tdo_pad_o              (tap_pad_tdo),           // Templated
                .tdo_padoe_o            (tap_pad_tdo_oe),        // Templated
                .test_logic_reset_o     (tap_debug_rst),         // Templated
                .shift_dr_o             (tap_debug_shift_dr),    // Templated
                .pause_dr_o             (tap_debug_pause_dr),    // Templated
                .update_dr_o            (tap_debug_update_dr),   // Templated
                .capture_dr_o           (tap_debug_capture_dr),  // Templated
                .debug_select_o         (tap_debug_debug_select), // Templated
                .tdi_o                  (tap_debug_tdi),         // Templated
                // Inputs
                .tms_pad_i              (pad_tap_tms),           // Templated
                .tck_pad_i              (pad_tap_tck),           // Templated
                .trstn_pad_i            (rst_n),                 // Templated
                .tdi_pad_i              (pad_tap_tdi),           // Templated
                .debug_tdo_i            (debug_tap_tdo));         // Templated


   /* adbg_top AUTO_TEMPLATE(
    .cpu0_\(.*\)_o  (),  // One cpu0 interface is used
    .cpu0_\(.*\)_i  ({@"vl-width"{1'b0}}),  // One cpu0 interface is used

    .cpu1\(.*\)_o  (),  // One cpu0 interface is used
    .cpu1\(.*\)_i  ({@"vl-width"{1'b0}}),  // One cpu0 interface is used

    .wb_jsp\(.*\)_i  ({@"vl-width"{1'b0}}),
    .wb_jsp\(.*\)_o  (),

    .wb_cti_o       (), // Classic transfert only
    .wb_bte_o       (), // Burst type extension - not used
    .wb_\(.*\)_o  (adbg_w2ahb_\1),  // One cpu0 interface is used
    .wb_\(.*\)_i  (w2ahb_adbg_\1),  // One cpu0 interface is used
    .wb_err_i       (1'b0),





    .shift_dr_i     (tap_debug_shift_dr),
    .pause_dr_i     (tap_debug_pause_dr),
    .update_dr_i    (tap_debug_update_dr),
    .capture_dr_i   (tap_debug_capture_dr),
    .debug_select_i (tap_debug_debug_select),

    .cpu0_clk_i     (clk),
    .cpu1_clk_i     (clk),

    .rst_i          (tap_debug_rst),

    .int_o          (),

    .tck_i          (pad_tap_tck),
    .tdo_o          (debug_tap_tdo),
    .tdi_i          (tap_debug_tdi),
    ); */
   adbg_top U_ADBG_TOP (
                        .wb_clk_i       (clk),
                        .wb_rst_i       (!rst_n),
                        .cpu0_stall_o   (), // FIXME
                        .cpu0_rst_o     (), // FIXME

                        /*AUTOINST*/
                        // Outputs
                        .tdo_o          (debug_tap_tdo),         // Templated
                        .wb_adr_o       (adbg_w2ahb_adr),        // Templated
                        .wb_dat_o       (adbg_w2ahb_dat),        // Templated
                        .wb_cyc_o       (adbg_w2ahb_cyc),        // Templated
                        .wb_stb_o       (adbg_w2ahb_stb),        // Templated
                        .wb_sel_o       (adbg_w2ahb_sel),        // Templated
                        .wb_we_o        (adbg_w2ahb_we),         // Templated
                        .wb_cab_o       (adbg_w2ahb_cab),        // Templated
                        .wb_cti_o       (),                      // Templated
                        .wb_bte_o       (),                      // Templated
                        .cpu0_addr_o    (),                      // Templated
                        .cpu0_data_o    (),                      // Templated
                        .cpu0_stb_o     (),                      // Templated
                        .cpu0_we_o      (),                      // Templated
                        .cpu1_addr_o    (),                      // Templated
                        .cpu1_data_o    (),                      // Templated
                        .cpu1_stall_o   (),                      // Templated
                        .cpu1_stb_o     (),                      // Templated
                        .cpu1_we_o      (),                      // Templated
                        .cpu1_rst_o     (),                      // Templated
                        .wb_jsp_dat_o   (),                      // Templated
                        .wb_jsp_ack_o   (),                      // Templated
                        .wb_jsp_err_o   (),                      // Templated
                        .int_o          (),                      // Templated
                        // Inputs
                        .tck_i          (pad_tap_tck),           // Templated
                        .tdi_i          (tap_debug_tdi),         // Templated
                        .rst_i          (tap_debug_rst),         // Templated
                        .shift_dr_i     (tap_debug_shift_dr),    // Templated
                        .pause_dr_i     (tap_debug_pause_dr),    // Templated
                        .update_dr_i    (tap_debug_update_dr),   // Templated
                        .capture_dr_i   (tap_debug_capture_dr),  // Templated
                        .debug_select_i (tap_debug_debug_select), // Templated
                        .wb_dat_i       (w2ahb_adbg_dat),        // Templated
                        .wb_ack_i       (w2ahb_adbg_ack),        // Templated
                        .wb_err_i       (1'b0),                  // Templated
                        .cpu0_clk_i     (clk),                   // Templated
                        .cpu0_data_i    ({32{1'b0}}),            // Templated
                        .cpu0_bp_i      ({1{1'b0}}),             // Templated
                        .cpu0_ack_i     ({1{1'b0}}),             // Templated
                        .cpu1_clk_i     (clk),                   // Templated
                        .cpu1_data_i    ({32{1'b0}}),            // Templated
                        .cpu1_bp_i      ({1{1'b0}}),             // Templated
                        .cpu1_ack_i     ({1{1'b0}}),             // Templated
                        .wb_jsp_adr_i   ({32{1'b0}}),            // Templated
                        .wb_jsp_dat_i   ({32{1'b0}}),            // Templated
                        .wb_jsp_cyc_i   ({1{1'b0}}),             // Templated
                        .wb_jsp_stb_i   ({1{1'b0}}),             // Templated
                        .wb_jsp_sel_i   ({4{1'b0}}),             // Templated
                        .wb_jsp_we_i    ({1{1'b0}}),             // Templated
                        .wb_jsp_cab_i   ({1{1'b0}}),             // Templated
                        .wb_jsp_cti_i   ({3{1'b0}}),             // Templated
                        .wb_jsp_bte_i   ({2{1'b0}}));             // Templated







    /* ahbmas_wbslv_top AUTO_TEMPLATE(

     .data_i         (adbg_w2ahb_dat),
     .data_o         (w2ahb_adbg_dat),
     .clk_i          (clk),
     .rst_i          (!rst_n),

     .addr_i         (adbg_w2ahb_adr),
     .\(.*\)_o  (w2ahb_adbg_\1),
     .\(.*\)_i  (adbg_w2ahb_\1),

     .hclk           (clk),
     .hresetn        (rst_n),

     .haddr          (w2ahb_ahb_haddr[NANORV32_DATA_MSB:0]),
     .hwrite         (w2ahb_ahb_hwrite),
     .hsize          (w2ahb_ahb_hsize[2:0]),
     .hburst         (w2ahb_ahb_hburst[2:0]),
     .hwdata         (w2ahb_ahb_hwdata[NANORV32_DATA_MSB:0]),
     .htrans         (w2ahb_ahb_htrans[1:0]),


     .hrdata         (ahb_w2ahb_hrdata[NANORV32_DATA_MSB:0]),
     .hresp          ({1'b0,ahb_w2ahb_hresp}), // FIXME ??
     .hready         (ahb_w2ahb_hready),
     ); */

    ahbmas_wbslv_top U_INSTANCE (
        /*AUTOINST*/
                                 // Outputs
                                 .haddr                 (w2ahb_ahb_haddr[NANORV32_DATA_MSB:0]), // Templated
                                 .hwrite                (w2ahb_ahb_hwrite), // Templated
                                 .hsize                 (w2ahb_ahb_hsize[2:0]), // Templated
                                 .hburst                (w2ahb_ahb_hburst[2:0]), // Templated
                                 .hwdata                (w2ahb_ahb_hwdata[NANORV32_DATA_MSB:0]), // Templated
                                 .htrans                (w2ahb_ahb_htrans[1:0]), // Templated
                                 .data_o                (w2ahb_adbg_dat), // Templated
                                 .ack_o                 (w2ahb_adbg_ack), // Templated
                                 // Inputs
                                 .hresetn               (rst_n),         // Templated
                                 .hclk                  (clk),           // Templated
                                 .hrdata                (ahb_w2ahb_hrdata[NANORV32_DATA_MSB:0]), // Templated
                                 .hresp                 ({1'b0,ahb_w2ahb_hresp}), // Templated
                                 .hready                (ahb_w2ahb_hready), // Templated
                                 .data_i                (adbg_w2ahb_dat), // Templated
                                 .addr_i                (adbg_w2ahb_adr), // Templated
                                 .cyc_i                 (adbg_w2ahb_cyc), // Templated
                                 .stb_i                 (adbg_w2ahb_stb), // Templated
                                 .sel_i                 (adbg_w2ahb_sel), // Templated
                                 .we_i                  (adbg_w2ahb_we), // Templated
                                 .clk_i                 (clk),           // Templated
                                 .rst_i                 (!rst_n));        // Templated




    /* port_mux AUTO_TEMPLATE(
     ); */
   port_mux U_PORT_MUX (
                           /*AUTOINST*/
                        // Outputs
                        .pmux_pad_ie    (pmux_pad_ie[CHIP_PORT_A_WIDTH-1:0]),
                        .pmux_pad_oe    (pmux_pad_oe[CHIP_PORT_A_WIDTH-1:0]),
                        .pmux_pad_dout  (pmux_pad_dout[CHIP_PORT_A_WIDTH-1:0]),
                        .pad_gpio_in    (pad_gpio_in[CHIP_PORT_A_WIDTH-1:0]),
                        .pad_uart_rx    (pad_uart_rx),
                        // Inputs
                        .pad_pmux_din   (pad_pmux_din[CHIP_PORT_A_WIDTH-1:0]),
                        .gpio_pad_out   (gpio_pad_out[CHIP_PORT_A_WIDTH-1:0]),
                        .uart_pad_tx    (uart_pad_tx));





    /* top_io AUTO_TEMPLATE(
     ); */
   top_io U_TOP_IO (
                           /*AUTOINST*/
                    // Outputs
                    .pad_pmux_din       (pad_pmux_din[CHIP_PORT_A_WIDTH-1:0]),
                    .pad_tap_tdi        (pad_tap_tdi),
                    .pad_tap_tms        (pad_tap_tms),
                    .pad_tap_tck        (pad_tap_tck),
                    // Inouts
                    .PA                 (PA[CHIP_PORT_A_WIDTH-1:0]),
                    .TMS                (TMS),
                    .TDI                (TDI),
                    .TCK                (TCK),
                    .TDO                (TDO),
                    // Inputs
                    .pmux_pad_ie        (pmux_pad_ie[CHIP_PORT_A_WIDTH-1:0]),
                    .pmux_pad_oe        (pmux_pad_oe[CHIP_PORT_A_WIDTH-1:0]),
                    .pmux_pad_dout      (pmux_pad_dout[CHIP_PORT_A_WIDTH-1:0]),
                    .tap_pad_tdo        (tap_pad_tdo),
                    .tap_pad_tdo_oe     (tap_pad_tdo_oe));






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
 "../../adv_debug_sys/Hardware/jtag/tap/rtl/verilog"
 "../../adv_debug_sys/Hardware/adv_dbg_if/rtl/verilog"
 "../../wisbone_2_ahb/src/"
 )
 End:
 */
