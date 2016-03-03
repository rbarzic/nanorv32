//****************************************************************************/
//  J2 CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Thu Mar  3 22:05:27 2016
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
//  Filename        :  std_pad.v
//
//  Description     :  A generic model for a standard pad, hopefully
//                     hopefully synthetizable with Xilinx Vivado (not tested yet)
//
//
//
//****************************************************************************/

module std_pad (/*AUTOARG*/
   // Outputs
   dout,
   // Inouts
   pad,
   // Inputs
   din, outen, inpen
   );

   output din;
   input  dout;
   input  oe;
   input  ie;

   inout  pad;


   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg                  dout;
   // End of automatics
   /*AUTOWIRE*/

   assign pad = oe ? dout : 1'bz;
   assign din = ie ? pad : 1'b0;

endmodule // std_pad
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
