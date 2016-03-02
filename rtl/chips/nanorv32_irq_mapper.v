//****************************************************************************/
//  Nanorv32  CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Wed Mar  2 18:53:11 2016
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
//  Filename        :  nanorv32_irq_mapper.v
//
//  Description     :  Interrupt mapper - Currently build manually
//                     Should be generated automatically in the future
//
//
//
//****************************************************************************/


module nanorv32_irq_mapper (/*AUTOARG*/
   // Outputs
   irqs,
   // Inputs
   uart_irq, gpio_irq
   );

   output [7:0] irqs;

   input        uart_irq;
   input        gpio_irq;


   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/

   wire [7:0]   irqs;

   assign irqs[0] = uart_irq;
   assign irqs[1] = gpio_irq;


endmodule // nanorv32_irq_mapper
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
