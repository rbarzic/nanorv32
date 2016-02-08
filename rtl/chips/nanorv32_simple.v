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


module nanorv32_simple (/*AUTOARG*/
   // Inouts
   P0, P1,
   // Inputs
   clk_in, rst_n
   );

`include "nanorv32_parameters.v"

   parameter AW = 15; // 32K per RAM
   localparam ADDR_WIDTH = AW;

   input                clk_in;                    // To U_CPU of nanorv32.v
   input                rst_n;                  // To U_CPU of nanorv32.v


   inout  wire [15:0]   P0;
   inout  wire [15:0]   P1;


   // Code memory port
/*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire                 clk;                    // From U_CLK_GEN of nanorv32_clkgen.v
   wire                 codeif_cpu_early_ready; // From U_ARBITRER of nanorv32_tcm_arbitrer.v
   wire                 codeif_cpu_ready_r;     // From U_ARBITRER of nanorv32_tcm_arbitrer.v
   wire                 dataif_cpu_early_ready; // From U_ARBITRER of nanorv32_tcm_arbitrer.v
   wire                 dataif_cpu_ready_r;     // From U_ARBITRER of nanorv32_tcm_arbitrer.v
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


   wire [NANORV32_DATA_MSB:0] codemem_dout;   // From U_CODE_MEM of bytewrite_ram_32bits.v
   wire [NANORV32_DATA_MSB:0] datamem_dout;   // From U_DATA_MEM of bytewrite_ram_32bits.v
   wire [NANORV32_DATA_MSB:0] periph_dout;   // From U_DATA_MEM of bytewrite_ram_32bits.v

   wire  [NANORV32_DATA_MSB:0]  cpu_codeif_addr;
   wire                         cpu_codeif_req;
   wire [NANORV32_DATA_MSB:0]   codeif_cpu_rdata;

   wire  [NANORV32_DATA_MSB:0]  cpu_dataif_addr;
   wire                         cpu_dataif_req;
   wire  [NANORV32_DATA_MSB:0]  cpu_dataif_wdata;
   wire [NANORV32_DATA_MSB:0]   dataif_cpu_rdata;




   wire [3:0]                 cpu_dataif_bytesel;




    /* nanorv32 AUTO_TEMPLATE(
     ); */
   nanorv32 U_CPU (
                   /*AUTOINST*/
                   // Outputs
                   .cpu_codeif_addr     (cpu_codeif_addr[NANORV32_DATA_MSB:0]),
                   .cpu_codeif_req      (cpu_codeif_req),
                   .cpu_dataif_addr     (cpu_dataif_addr[NANORV32_DATA_MSB:0]),
                   .cpu_dataif_wdata    (cpu_dataif_wdata[NANORV32_DATA_MSB:0]),
                   .cpu_dataif_bytesel  (cpu_dataif_bytesel[3:0]),
                   .cpu_dataif_req      (cpu_dataif_req),
                   // Inputs
                   .codeif_cpu_rdata    (codeif_cpu_rdata[NANORV32_DATA_MSB:0]),
                   .codeif_cpu_early_ready(codeif_cpu_early_ready),
                   .codeif_cpu_ready_r  (codeif_cpu_ready_r),
                   .dataif_cpu_rdata    (dataif_cpu_rdata[NANORV32_DATA_MSB:0]),
                   .dataif_cpu_early_ready(dataif_cpu_early_ready),
                   .dataif_cpu_ready_r  (dataif_cpu_ready_r),
                   .rst_n               (rst_n),
                   .clk                 (clk));






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
   nanorv32_tcm_ctrl
     #(.SIZE(1<<(AW-2)),.ADDR_WIDTH(AW-2))
     U_TCM_DATA (
                 .fast_hanshaking(1'b1),
                           /*AUTOINST*/
                 // Outputs
                 .ready_nxt             (tcmdata_ready_nxt),     // Templated
                 .dout                  (tcmdata_dout[NANORV32_DATA_MSB:0]), // Templated
                 // Inputs
                 .clk                   (clk),                   // Templated
                 .rst_n                 (rst_n),                 // Templated
                 .en                    (tcmdata_en),            // Templated
                 .din                   (tcmdata_din[NANORV32_DATA_MSB:0]), // Templated
                 .addr                  (tcmdata_addr[ADDR_WIDTH-1:0]), // Templated
                 .bytesel               (tcmdata_bytesel[3:0]));  // Templated


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
   nanorv32_tcm_ctrl
     #(.SIZE(1<<(AW-2)),.ADDR_WIDTH(AW-2))
     U_TCM_CODE (
                 .fast_hanshaking(1'b1),
                           /*AUTOINST*/
                 // Outputs
                 .ready_nxt             (tcmcode_ready_nxt),     // Templated
                 .dout                  (tcmcode_dout[NANORV32_DATA_MSB:0]), // Templated
                 // Inputs
                 .clk                   (clk),                   // Templated
                 .rst_n                 (rst_n),                 // Templated
                 .en                    (tcmcode_en),            // Templated
                 .din                   (tcmcode_din[NANORV32_DATA_MSB:0]), // Templated
                 .addr                  (tcmcode_addr[ADDR_WIDTH-1:0]), // Templated
                 .bytesel               (tcmcode_bytesel[3:0]));  // Templated




    /* nanorv32_tcm_arbitrer AUTO_TEMPLATE(
     ); */
   nanorv32_tcm_arbitrer
     #(.ADDR_WIDTH(AW-2))
     U_ARBITRER (
                           /*AUTOINST*/
                 // Outputs
                 .tcmcode_addr          (tcmcode_addr[ADDR_WIDTH-1:0]),
                 .tcmcode_bytesel       (tcmcode_bytesel[3:0]),
                 .tcmcode_din           (tcmcode_din[NANORV32_DATA_MSB:0]),
                 .tcmcode_en            (tcmcode_en),
                 .tcmdata_addr          (tcmdata_addr[ADDR_WIDTH-1:0]),
                 .tcmdata_bytesel       (tcmdata_bytesel[3:0]),
                 .tcmdata_din           (tcmdata_din[NANORV32_DATA_MSB:0]),
                 .tcmdata_en            (tcmdata_en),
                 .codeif_cpu_rdata      (codeif_cpu_rdata[NANORV32_DATA_MSB:0]),
                 .codeif_cpu_early_ready(codeif_cpu_early_ready),
                 .codeif_cpu_ready_r    (codeif_cpu_ready_r),
                 .dataif_cpu_rdata      (dataif_cpu_rdata[NANORV32_DATA_MSB:0]),
                 .dataif_cpu_early_ready(dataif_cpu_early_ready),
                 .dataif_cpu_ready_r    (dataif_cpu_ready_r),
                 // Inputs
                 .rst_n                 (rst_n),
                 .clk                   (clk),
                 .tcmcode_dout          (tcmcode_dout[NANORV32_DATA_MSB:0]),
                 .tcmcode_ready_nxt     (tcmcode_ready_nxt),
                 .tcmdata_dout          (tcmdata_dout[NANORV32_DATA_MSB:0]),
                 .tcmdata_ready_nxt     (tcmdata_ready_nxt),
                 .cpu_codeif_addr       (cpu_codeif_addr[NANORV32_DATA_MSB:0]),
                 .cpu_codeif_req        (cpu_codeif_req),
                 .cpu_dataif_addr       (cpu_dataif_addr[NANORV32_DATA_MSB:0]),
                 .cpu_dataif_wdata      (cpu_dataif_wdata[NANORV32_DATA_MSB:0]),
                 .cpu_dataif_bytesel    (cpu_dataif_bytesel[3:0]),
                 .cpu_dataif_req        (cpu_dataif_req));



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
