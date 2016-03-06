//****************************************************************************/
//  Nanorv32  CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Fri Mar  4 00:05:35 2016
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
//  Filename        :  port_mux.v
//
//  Description     :  Port multiplexer
//
//
//
//****************************************************************************/


module port_mux (/*AUTOARG*/
   // Outputs
   pad_pmux_din, pmux_pad_ie, pmux_pad_oe, pad_gpio_in, pad_uart_rx,
   // Inputs
   pmux_pad_dout, gpio_pad_out, uart_pad_tx
   );


`include "nanorv32_parameters.v"
`include "chip_params.v"

   output [CHIP_PORT_A_WIDTH-1:0]      pad_pmux_din;          // To U_PA0 of std_pad.v, ...
   output [CHIP_PORT_A_WIDTH-1:0]      pmux_pad_ie;         // To U_PA0 of std_pad.v, ...
   output [CHIP_PORT_A_WIDTH-1:0]      pmux_pad_oe;         // To U_PA0 of std_pad.v, ...
   input  [CHIP_PORT_A_WIDTH-1:0]      pmux_pad_dout;          // From U_PA0 of std_pad.v, ...

   input [CHIP_PORT_A_WIDTH-1:0]       gpio_pad_out;
   output [CHIP_PORT_A_WIDTH-1:0]      pad_gpio_in;


   input                               uart_pad_tx;
   output                              pad_uart_rx;




   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [CHIP_PORT_A_WIDTH-1:0] pad_pmux_din;
   reg                  pad_uart_rx;
   reg [CHIP_PORT_A_WIDTH-1:0] pmux_pad_ie;
   reg [CHIP_PORT_A_WIDTH-1:0] pmux_pad_oe;
   // End of automatics
   /*AUTOWIRE*/


   assign pmux_pad_out = gpio_pad_out;
   assign pad_gpio_in = pad_pmux_din;


endmodule // port_mux
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
