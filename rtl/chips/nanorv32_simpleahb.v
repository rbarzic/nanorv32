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
   illegal_instruction,
   // Inouts
   P0, P1,
   // Inputs
   clk_in, rst_n
   );

`include "nanorv32_parameters.v"

   parameter AW = 16; // 64K per RAM
   localparam ADDR_WIDTH = AW;

   input                clk_in;                    // To U_CPU of nanorv32.v
   input                rst_n;                  // To U_CPU of nanorv32.v


   output               illegal_instruction;    // From U_CPU of nanorv32.v

   inout  wire [15:0]   P0;
   inout  wire [15:0]   P1;


   // Code memory port
/*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [NANORV32_PERIPH_ADDR_MSB:0] bus_gpio_addr;// From U_PERIPH_MUX of nanorv32_periph_mux.v
   wire [3:0]           bus_gpio_bytesel;       // From U_PERIPH_MUX of nanorv32_periph_mux.v
   wire [NANORV32_DATA_MSB:0] bus_gpio_din;     // From U_PERIPH_MUX of nanorv32_periph_mux.v
   wire                 bus_gpio_en;            // From U_PERIPH_MUX of nanorv32_periph_mux.v
   wire                 clk;                    // From U_CLK_GEN of nanorv32_clkgen.v
   wire                 codeif_cpu_early_ready; // From U_ARBITRER of nanorv32_tcm_arbitrer.v
   wire                 codeif_cpu_ready_r;     // From U_ARBITRER of nanorv32_tcm_arbitrer.v
   wire                 dataif_cpu_early_ready; // From U_ARBITRER of nanorv32_tcm_arbitrer.v
   wire                 dataif_cpu_ready_r;     // From U_ARBITRER of nanorv32_tcm_arbitrer.v
   wire [31:0]          gpio_bus_dout;          // From U_GPIO_CTRL of nanorv32_gpio_ctrl.v
   wire                 gpio_bus_ready_nxt;     // From U_GPIO_CTRL of nanorv32_gpio_ctrl.v
   wire [NANORV32_PERIPH_ADDR_MSB:0] periph_addr;// From U_ARBITRER of nanorv32_tcm_arbitrer.v
   wire [3:0]           periph_bytesel;         // From U_ARBITRER of nanorv32_tcm_arbitrer.v
   wire [NANORV32_DATA_MSB:0] periph_din;       // From U_ARBITRER of nanorv32_tcm_arbitrer.v
   wire                 periph_en;              // From U_ARBITRER of nanorv32_tcm_arbitrer.v
   wire                 periph_ready_nxt;       // From U_PERIPH_MUX of nanorv32_periph_mux.v
   wire [ADDR_WIDTH-1:0] tcmcode_addr;          // From U_ARBITRER of nanorv32_tcm_arbitrer.v
   wire [3:0]           tcmcode_bytesel;        // From U_ARBITRER of nanorv32_tcm_arbitrer.v
   wire [NANORV32_DATA_MSB:0] tcmcode_din;      // From U_ARBITRER of nanorv32_tcm_arbitrer.v
   wire [NANORV32_DATA_MSB:0] tcmcode_dout;     // From U_TCM_CODE of nanorv32_tcm_ctrl.v
   wire                 tcmcode_en;             // From U_ARBITRER of nanorv32_tcm_arbitrer.v
   wire                 tcmcode_ready_nxt;      // From U_TCM_CODE of nanorv32_tcm_ctrl.v
   wire [ADDR_WIDTH-1:0] tcmdata_addr;          // From U_ARBITRER of nanorv32_tcm_arbitrer.v
   wire [3:0]           tcmdata_bytesel;        // From U_ARBITRER of nanorv32_tcm_arbitrer.v
   wire [NANORV32_DATA_MSB:0] tcmdata_din;      // From U_ARBITRER of nanorv32_tcm_arbitrer.v
   wire [NANORV32_DATA_MSB:0] tcmdata_dout;     // From U_TCM_DATA of nanorv32_tcm_ctrl.v
   wire                 tcmdata_en;             // From U_ARBITRER of nanorv32_tcm_arbitrer.v
   wire                 tcmdata_ready_nxt;      // From U_TCM_DATA of nanorv32_tcm_ctrl.v
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

   wire [31:0]  io_periph_haddr; 
   wire         io_periph_hwrite; 
   wire [2:0]   io_periph_hsize; 
   wire [2:0]   io_periph_hburst; 
   wire [3:0]   io_periph_hprot; 
   wire [1:0]   io_periph_htrans; 
   wire         io_periph_hmastlock; 
   wire [31:0]  io_periph_hwdata; 
   wire [31:0]  io_periph_hrdata; 
   wire         io_periph_hsel; 
   wire         io_periph_hreadyin; 
   wire         io_periph_hreadyout; 
   wire         io_periph_hresp; 

    /* nanorv32 AUTO_TEMPLATE(
     ); */
   nanorv32 U_CPU (
   .rst_n      (rst_n),
   .clk        (clk_in),

   .illegal_instruction      (illegal_instruction),


   // Code memory interface
   .hrdatai      (hrdatai     ), 
   .hrespi       (hrespi      ),
   .hreadyi      (hreadyi     ), 
   .haddri       (haddri      ),
   .hproti       (hproti      ),
   .hsizei       (hsizei      ),
   .hmasteri     (hmasteri    ),
   .hmasterlocki (hmasterlocki),
   .hbursti      (hbursti     ),
   .hwdatai      (hwdatai     ),
   .hwritei      (hwritei     ), 
   // Data memory interface
   .hrdatad      (hrdatad     ), 
   .hrespd       (hrespd      ),
   .hreadyd      (hreadyd     ), 
   .haddrd       (haddrd      ),
   .hprotd       (hprotd      ),
   .hsized       (hsized      ),
   .hmasterd     (hmasterd    ),
   .hmasterlockd (hmasterlockd),
   .hburstd      (hburstd     ),
   .hwdatad      (hwdatad     ),
   .hwrited      (hwrited     ) 
   ); 






    /* nanorv32_tcm_ctrl AUTO_TEMPLATE(
     .ready_nxt             (tcmdata_ready_nxt),
     .dout                  (tcmdata_dout[NANORV32_DATA_MSB:0]),
     // Inputs
     .clk                   (clk),
     .rst_n                 (rst_n),
     .en                    (tcmdata_en),
     .din                   (tcmdata_din[NANORV32_DATA_MSB:0]),
     .addr                  (tcmdata_addr[ADDR_WIDTH-1:0]),
     .bytesel               (tcmdata_bytesel[3:0]),
     ); */
 cmsdk_ahb_ram u_tcm0(/*AUTOARG*/
   // Outputs
   .HREADYOUT   (io_tcm0_hreadyout), 
   .HRDATA      (io_tcm0_hrdata), 
   .HRESP       (io_tcm0_hresp),
   // Inputs
   .HCLK        (clk_in), 
   .HRESETn     (rst_in), 
   .HSEL        (io_tcm0_hsel), 
   .HADDR       (io_tcm0_haddr), 
   .HTRANS      (io_tcm0_htrans), 
   .HSIZE       (io_tcm0_hsize), 
   .HWRITE      (io_tcm0_hwrite), 
   .HWDATA      (io_tcm0_hwdata), 
   .HREADY      (io_tcm0_hreadyin)
   );


   /* nanorv32_tcm_ctrl AUTO_TEMPLATE(
     .ready_nxt             (tcmcode_ready_nxt),
     .dout                  (tcmcode_dout[NANORV32_DATA_MSB:0]),
     // Inputs
     .clk                   (clk),
     .rst_n                 (rst_n),
     .en                    (tcmcode_en),
     .din                   (tcmcode_din[NANORV32_DATA_MSB:0]),
     .addr                  (tcmcode_addr[ADDR_WIDTH-1:0]),
     .bytesel               (tcmcode_bytesel[3:0]),
     ); */
 cmsdk_ahb_ram u_tcm1(/*AUTOARG*/
   // Outputs
   .HREADYOUT   (io_tcm1_hreadyout), 
   .HRDATA      (io_tcm1_hrdata), 
   .HRESP       (io_tcm1_hresp),
   // Inputs
   .HCLK        (clk_in), 
   .HRESETn     (rst_in), 
   .HSEL        (io_tcm1_hsel), 
   .HADDR       (io_tcm1_haddr), 
   .HTRANS      (io_tcm1_htrans), 
   .HSIZE       (io_tcm1_hsize), 
   .HWRITE      (io_tcm1_hwrite), 
   .HWDATA      (io_tcm1_hwdata), 
   .HREADY      (io_tcm1_hreadyin)
   );

    /* ahbmatrix AUTO_TEMPLATE(
     ); */
    ZscaleSystem   u_ahbmatrix(
    .clk         (clk_in), 
    .reset       (rst_n),

    .io_iside_haddr       (haddri      ),
    .io_iside_hwrite      (hwritei     ),
    .io_iside_hsize       (hsizei      ),
    .io_iside_hburst      (hbursti     ),
    .io_iside_hprot       (hproti      ),
    .io_iside_htrans      ({htransi,1'b0}),
    .io_iside_hmastlock   (hmastlocki  ),
    .io_iside_hwdata      (hwdatai     ),
    .io_iside_hrdata      (hrdatai     ),
    .io_iside_hready      (hreadyi     ),
    .io_iside_hresp       (hrespi      ),

    .io_dside_haddr       (haddrd      ),
    .io_dside_hwrite      (hwrited     ),
    .io_dside_hsize       (hsized      ),
    .io_dside_hburst      (hburstd     ),
    .io_dside_hprot       (hprotd      ),
    .io_dside_htrans      ({htransd,1'b0}     ),
    .io_dside_hmastlock   (hmastlockd  ),
    .io_dside_hwdata      (hwdatad     ),
    .io_dside_hrdata      (hrdatad     ),
    .io_dside_hready      (hreadyd     ),
    .io_dside_hresp       (hrespd      ),

    .io_tcm0_haddr        (io_tcm0_haddr       ),
    .io_tcm0_hwrite       (io_tcm0_hwrite      ),
    .io_tcm0_hsize        (io_tcm0_hsize       ),
    .io_tcm0_hburst       (io_tcm0_hburst      ),
    .io_tcm0_hprot        (io_tcm0_hprot       ),
    .io_tcm0_htrans       (io_tcm0_htrans      ),
    .io_tcm0_hmastlock    (io_tcm0_hmastlock   ),
    .io_tcm0_hwdata       (io_tcm0_hwdata      ),
    .io_tcm0_hrdata       (io_tcm0_hrdata      ),
    .io_tcm0_hsel         (io_tcm0_hsel        ),
    .io_tcm0_hreadyin     (io_tcm0_hreadyin    ),
    .io_tcm0_hreadyout    (io_tcm0_hreadyout   ),
    .io_tcm0_hresp        (io_tcm0_hresp       ),

    .io_tcm1_haddr        (io_tcm1_haddr       ),
    .io_tcm1_hwrite       (io_tcm1_hwrite      ),
    .io_tcm1_hsize        (io_tcm1_hsize       ),
    .io_tcm1_hburst       (io_tcm1_hburst      ),
    .io_tcm1_hprot        (io_tcm1_hprot       ),
    .io_tcm1_htrans       (io_tcm1_htrans      ),
    .io_tcm1_hmastlock    (io_tcm1_hmastlock   ),
    .io_tcm1_hwdata       (io_tcm1_hwdata      ),
    .io_tcm1_hrdata       (io_tcm1_hrdata      ),
    .io_tcm1_hsel         (io_tcm1_hsel        ),
    .io_tcm1_hreadyin     (io_tcm1_hreadyin    ),
    .io_tcm1_hreadyout    (io_tcm1_hreadyout   ),
    .io_tcm1_hresp        (io_tcm1_hresp       ),

    .io_periph_haddr      (io_periph_haddr     ),
    .io_periph_hwrite     (io_periph_hwrite    ),
    .io_periph_hsize      (io_periph_hsize     ),
    .io_periph_hburst     (io_periph_hburst    ),
    .io_periph_hprot      (io_periph_hprot     ),
    .io_periph_htrans     (io_periph_htrans    ),
    .io_periph_hmastlock  (io_periph_hmastlock ),
    .io_periph_hwdata     (io_periph_hwdata    ),
    .io_periph_hrdata     (io_periph_hrdata    ),
    .io_periph_hsel       (io_periph_hsel      ),
    .io_periph_hreadyin   (io_periph_hreadyin  ),
    .io_periph_hreadyout  (io_periph_hreadyout ),
    .io_periph_hresp      (io_periph_hresp     )
);


    /* nanorv32_periph_mux AUTO_TEMPLATE(
     ); */
   nanorv32_periph_mux_ahb U_PERIPH_MUX (
                           /*AUTOINST*/
                                     // Outputs
                                     .periph_hrdata     (io_periph_hrdata    ), 
                                     .periph_hreadyout  (io_periph_hreadyout ),
                                     .periph_hresp      (io_periph_hresp     ), 
                                     .bus_gpio_addr     (bus_gpio_addr[NANORV32_PERIPH_ADDR_MSB:0]),
                                     .bus_gpio_bytesel  (bus_gpio_bytesel[3:0]),
                                     .bus_gpio_din      (bus_gpio_din[NANORV32_DATA_MSB:0]),
                                     .bus_gpio_en       (bus_gpio_en),
                                     // Inputs
                                     .clk_in            (clk_in), 
                                     .rst_n             (rst_n),
                                     .periph_haddr      (io_periph_haddr      ), 
                                     .periph_hwrite     (io_periph_hwrite     ), 
                                     .periph_hsize      (io_periph_hsize      ), 
                                     .periph_hburst     (io_periph_hburst     ), 
                                     .periph_hprot      (io_periph_hprot      ), 
                                     .periph_htrans     (io_periph_htrans     ), 
                                     .periph_hmastlock  (io_periph_hmastlock  ), 
                                     .periph_hwdata     (io_periph_hwdata     ), 
                                     .periph_hsel       (io_periph_hsel       ), 
                                     .periph_hreadyin   (io_periph_hreadyin   ), 
                                     .gpio_bus_dout     (gpio_bus_dout[NANORV32_DATA_MSB:0]),
                                     .gpio_bus_ready_nxt(gpio_bus_ready_nxt));



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
