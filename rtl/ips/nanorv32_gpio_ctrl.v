//****************************************************************************/
//  NANORV32  CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Tue Feb 16 18:35:38 2016
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
//  Filename        :  nanorv32_gpio_ctrl.v
//
//  Description     :  A stupid GPIO controller
//
//
//
//****************************************************************************/

module nanorv32_gpio_ctrl (/*AUTOARG*/
   // Outputs
   gpio_bus_dout, gpio_bus_ready_nxt, gpio_pad_out,
   // Inputs
   bus_gpio_addr, bus_gpio_bytesel, bus_gpio_din, bus_gpio_en,
   pad_gpio_in, clk, rst_n
   );

`include "nanorv32_parameters.v"

   input [NANORV32_PERIPH_ADDR_MSB:0] bus_gpio_addr;           // To U_TCM_DATA of nanorv32_tcm_ctrl.v
   input [3:0]                        bus_gpio_bytesel;        // To U_TCM_DATA of nanorv32_tcm_ ctrl.v
   input [31:0]                       bus_gpio_din;        // To U_TCM_DATA of nanorv32_tcm_ctrl.v
   input                              bus_gpio_en;             // To U_TCM_DATA of nanorv32_tcm_ctrl.v
   output [31:0]                      gpio_bus_dout;   // From U_TCM_DATA of nanorv32_tcm_ctrl.v
   output                             gpio_bus_ready_nxt;      // From U_TCM_DATA of nanorv32_tcm_ctrl.v

   // GPIO in/out
   output [31:0]                      gpio_pad_out;
   input  [31:0]                      pad_gpio_in;


   // Clock and reset
   input                              clk;
   input                              rst_n;


   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/

   reg [31:0]           gpio_out_r;

   reg [31:0]           gpio_in_m;
   reg [31:0]           gpio_in_r;


   assign write = | bus_gpio_bytesel;


   always @(posedge clk or posedge rst_n) begin
      if(rst_n == 1'b0) begin
         /*AUTORESET*/
         // Beginning of autoreset for uninitialized flops
         gpio_in_m <= 32'h0;
         gpio_in_r <= 32'h0;
         gpio_out_r <= 32'h0;
         // End of automatics
      end
      else begin

         gpio_in_m <= pad_gpio_in;
         gpio_in_r <= gpio_in_m;



         if(bus_gpio_en && write) begin
            gpio_out_r <= bus_gpio_din;
         end
      end
   end

assign gpio_bus_dout = gpio_in_r;
assign gpio_pad_out = gpio_out_r;



   assign gpio_bus_ready_nxt =  bus_gpio_en;




endmodule // nanorv32_gpio_ctrl
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
