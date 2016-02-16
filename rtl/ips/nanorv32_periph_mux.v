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

module nanorv32_periph_mux (/*AUTOARG*/
   // Outputs
   periph_dout, periph_ready_nxt, bus_gpio_addr, bus_gpio_bytesel,
   bus_gpio_din, bus_gpio_en,
   // Inputs
   periph_addr, periph_bytesel, periph_din, periph_en, gpio_bus_dout,
   gpio_bus_ready_nxt
   );

`include "nanorv32_parameters.v"

   input [NANORV32_PERIPH_ADDR_MSB:0]     periph_addr;           // To U_TCM_DATA of nanorv32_tcm_ctrl.v
   input [3:0]                periph_bytesel;        // To U_TCM_DATA of nanorv32_tcm_ctrl.v
   input [NANORV32_DATA_MSB:0] periph_din;        // To U_TCM_DATA of nanorv32_tcm_ctrl.v
   input                       periph_en;             // To U_TCM_DATA of nanorv32_tcm_ctrl.v
   output [NANORV32_DATA_MSB:0]  periph_dout;   // From U_TCM_DATA of nanorv32_tcm_ctrl.v
   output                        periph_ready_nxt;      // From U_TCM_DATA of nanorv32_tcm_ctrl.v



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

   // No decoding for now
   assign bus_gpio_addr = periph_addr;
   assign bus_gpio_bytesel = periph_bytesel;
   assign bus_gpio_din     = periph_din;
   assign bus_gpio_en      = periph_en;
   assign periph_dout = gpio_bus_dout;
   assign periph_ready_nxt = gpio_bus_ready_nxt;




endmodule // nanorv32_periph_mux
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
