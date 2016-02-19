//****************************************************************************/
//  ARTY CM0 Design Start
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Tue Nov 10 23:56:32 2015
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
//  Filename        :  cmsdk_ahb_ram.v
//
//  Description     :  Custom ram implementation for simulation and FPGA
//  Use exactly the same interface than the original file from CM0 designstart
//
//
//****************************************************************************/




module cmsdk_ahb_ram(/*AUTOARG*/
   // Outputs
   HREADYOUT, HRDATA, HRESP,
   // Inputs
   HCLK, HRESETn, HSEL, HADDR, HTRANS, HSIZE, HWRITE, HWDATA, HREADY
   );

   parameter AW       = 16;// Address width
   parameter ROM      = 0;
   parameter filename = "";






   input            HCLK;    // Clock
   input            HRESETn; // Reset
   // AHB inputs
   input            HSEL;    // Device select
   input [AW-1:0]   HADDR;   // Address
   input [1:0]      HTRANS;  // Transfer control
   input [2:0]      HSIZE;   // Transfer size
   input            HWRITE;  // Write control
   input [31:0]     HWDATA;  // Write data
   input            HREADY;  // Transfer phase done
   // AHB Outputs
   output           HREADYOUT; // Device ready
   output [31:0]    HRDATA;  // Read data output
   output           HRESP;  // Device response (always OKAY)

   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [AW-1:0]        ahb_sram_addr;          // From U_AHB_TO_SSRAM of ahb_to_ssram.v
   wire [31:0]          ahb_sram_din;           // From U_AHB_TO_SSRAM of ahb_to_ssram.v
   wire [3:0]           ahb_sram_wb;            // From U_AHB_TO_SSRAM of ahb_to_ssram.v
   wire [31:0]          sram_ahb_dout;          // From U_RAM of bytewrite_ram_1b.v
   // End of automatics

   wire [3:0]           ahb_sram_wb_qual;


     ahb_to_ssram  #(.AW(AW)) U_AHB_TO_SSRAM
  (
   .ahb_sram_we                         (),
   .ahb_sram_en                         (),
   .ahb_sram_enb                        (),
   /*AUTOINST*/
   // Outputs
   .HREADYOUT                           (HREADYOUT),
   .HRDATA                              (HRDATA[31:0]),
   .HRESP                               (HRESP),
   .ahb_sram_addr                       (ahb_sram_addr[AW-1:0]),
   .ahb_sram_wb                         (ahb_sram_wb[3:0]),
   .ahb_sram_din                        (ahb_sram_din[31:0]),
   // Inputs
   .HCLK                                (HCLK),
   .HRESETn                             (HRESETn),
   .HSEL                                (HSEL),
   .HADDR                               (HADDR[AW-1:0]),
   .HTRANS                              (HTRANS[1:0]),
   .HSIZE                               (HSIZE[2:0]),
   .HWRITE                              (HWRITE),
   .HWDATA                              (HWDATA[31:0]),
   .HREADY                              (HREADY),
   .sram_ahb_dout                       (sram_ahb_dout[31:0]));


   assign ahb_sram_wb_qual = ahb_sram_wb & {4{!ROM}};


/* -----\/----- EXCLUDED -----\/-----
   /-* sync_ram_wf_x32 AUTO_TEMPLATE(
    .dout            (sram_ahb_dout[31:0]),
    .din            (ahb_sram_din[31:0]),

    .enb              (ahb_sram_enb[@]),
    .addr            (ahb_sram_addr[9:0]),
    .clk(HCLK),

    ); *-/
   sync_ram_wf_x32 #(.ADDR_WIDTH(AW-2))
   U_RAM(
         .web                           (ahb_sram_wb_qual[3:0]),
         /-*AUTOINST*-/
         // Outputs
         .dout                          (sram_ahb_dout[31:0]),
         // Inputs
         .clk                           (HCLK),
         .enb                           (ahb_sram_enb[3:0]),
         .addr                          (ahb_sram_addr[9:0]),
         .din                           (ahb_sram_din[31:0]));
 -----/\----- EXCLUDED -----/\----- */


    /* bytewrite_ram_32bits  AUTO_TEMPLATE(
     .dout            (sram_ahb_dout[31:0]),
     .din             (ahb_sram_din[31:0]),
     .enb             (ahb_sram_enb[@]),
     .we              (ahb_sram_wb[3:0]),
     .addr            (ahb_sram_addr[9:0]),
     .clk(HCLK),
     ); */
   bytewrite_ram_32bits
   #(.SIZE(1<<(AW-2)),.ADDR_WIDTH(AW-2))
   U_RAM (
                           /*AUTOINST*/
          // Outputs
          .dout                         (sram_ahb_dout[31:0]),   // Templated
          // Inputs
          .clk                          (HCLK),                  // Templated
          .we                           (ahb_sram_wb[3:0]),      // Templated
          .addr                         (ahb_sram_addr[AW-1:2]),    // Templated
          .din                          (ahb_sram_din[31:0]));    // Templated






endmodule
/*
 Local Variables:
 verilog-library-directories:(
 "."
 "../import/amba_components/ahb_to_ssram/rtl/verilog"
 )
 End:
 */
