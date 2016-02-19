//****************************************************************************/
//  Nanorv32  CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Tue Feb 16 18:25:09 2016
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
//  Filename        :  nanorv32_periph_mux.v
//
//  Description     :  Peripheral mux for  nanorv32_simple
//
//
//
//****************************************************************************/

module nanorv32_periph_mux_ahb (/*AUTOARG*/
   // Outputs
   periph_dout, periph_ready_nxt, 
   bus_gpio_addr, bus_gpio_bytesel,
   bus_gpio_din, bus_gpio_en,
   // Inputs
   gpio_bus_dout, gpio_bus_ready_nxt
   );

`include "nanorv32_parameters.v"

    input  [31:0] periph_haddr; 
    input         periph_hwrite; 
    input  [2:0]  periph_hsize; 
    input  [2:0]  periph_hburst; 
    input  [3:0]  periph_hprot; 
    input  [1:0]  periph_htrans; 
    input         periph_hmastlock; 
    input  [31:0] periph_hwdata; 
    output [31:0] periph_hrdata; 
    input         periph_hsel; 
    input         periph_hreadyin; 
    output        periph_hreadyout;
    output        periph_hresp; 
//   input [NANORV32_PERIPH_ADDR_MSB:0]     periph_addr;           // To U_TCM_DATA of nanorv32_tcm_ctrl.v
//   input [3:0]                periph_bytesel;        // To U_TCM_DATA of nanorv32_tcm_ctrl.v
//   input [NANORV32_DATA_MSB:0] periph_din;        // To U_TCM_DATA of nanorv32_tcm_ctrl.v
//   input                       periph_en;             // To U_TCM_DATA of nanorv32_tcm_ctrl.v
//   output [NANORV32_DATA_MSB:0]  periph_dout;   // From U_TCM_DATA of nanorv32_tcm_ctrl.v
//   output                        periph_ready_nxt;      // From U_TCM_DATA of nanorv32_tcm_ctrl.v



   output [NANORV32_PERIPH_ADDR_MSB:0] bus_gpio_addr;           // To U_TCM_DATA of nanorv32_tcm_ctrl.v
   output [3:0]                  bus_gpio_bytesel;        // To U_TCM_DATA of nanorv32_tcm_ctrl.v
   output [NANORV32_DATA_MSB:0]  bus_gpio_din;        // To U_TCM_DATA of nanorv32_tcm_ctrl.v
   output                        bus_gpio_en;             // To U_TCM_DATA of nanorv32_tcm_ctrl.v
   input [NANORV32_DATA_MSB:0]   gpio_bus_dout;   // From U_TCM_DATA of nanorv32_tcm_ctrl.v
   input                         gpio_bus_ready_nxt;      // From U_TCM_DATA of nanorv32_tcm_ctrl.v


   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/
   // AHB bridge 
   reg  [31:0] periph_haddr_reg;
   reg  [ 3:0] periph_bytesel_reg;
   reg         periph_en_reg;
   reg         gpio_bus_ready_nxt_reg;
   wire [3:0] bytesel = {4{periph_hsize == 3'b010}} & 4'b1111 |
                        {4{periph_hsize == 3'b001 & periph_haddr[1:0] == 2'b00}} & & 4'b0011 | 
                        {4{periph_hsize == 3'b001 & periph_haddr[1:0] == 2'b10}} & & 4'b1100 | 
                        {4{periph_hsize == 3'b000 & periph_haddr[1:0] == 2'b00}} & & 4'b0001 | 
                        {4{periph_hsize == 3'b000 & periph_haddr[1:0] == 2'b01}} & & 4'b0010 | 
                        {4{periph_hsize == 3'b000 & periph_haddr[1:0] == 2'b10}} & & 4'b0100 | 
                        {4{periph_hsize == 3'b000 & periph_haddr[1:0] == 2'b11}} & & 4'b1000 ; 

   always @(posedge clk_in or negedge rst_n) begin  
     if (rst_n == 1'b0) begin 
     periph_en_reg <= 1'b0;
     periph_haddr_reg <= 32'b0;
     periph_bytesel_reg <= 4'b0;
     end else begin 
        if (periph_hreadyin & periph_hsel & periph_htrans) periph_en_reg <= periph_htrans;
        if (periph_hreadyin & periph_hsel & periph_htrans) periph_haddr_reg <= periph_haddr;
        if (periph_hreadyin & periph_hsel & periph_htrans & periph_hwrite ) periph_bytesel_reg <= bytesel;
     end
   end 
  
   // No decoding for now
   assign bus_gpio_addr    = periph_addr_reg;
   assign bus_gpio_bytesel = periph_bytesel_reg;
   assign bus_gpio_din     = periph_hwdata;
   assign bus_gpio_en      = periph_en_reg;
   assign periph_hrdata = gpio_bus_dout;
   assign periph_hreadyout = gpio_bus_ready_nxt;




endmodule // nanorv32_periph_mux
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
