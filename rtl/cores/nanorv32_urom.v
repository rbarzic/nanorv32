//****************************************************************************/
//  J2 CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Wed Feb 24 18:56:12 2016
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
//  Filename        :  nanorv32_urom.v
//
//  Description     :  Micro ROM for reset sequence and interrupt entry/exit
//                     The content of this ROM is generated from
//                     common/micro_rom/micro_rom.S
//
//****************************************************************************/



module nanorv32_urom (/*AUTOARG*/
   // Outputs
   dout,
   // Inputs
   addr
   );

`include "nanorv32_parameters.v"

   input [NANORV32_UROM_ADDR_MSB:0] addr;
   output [NANORV32_DATA_MSB:0]     dout;

   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [NANORV32_DATA_MSB:0] dout;
   // End of automatics
   /*AUTOWIRE*/

   // Very stupip async ROM - We let the synthesis tool
   // choose the best implementation
   always @* begin
      case(addr)
      //@begin[micro_rom]
        0: dout<= 32'h0010009;
        1: dout<= 32'h0000001;
        2: dout<= 32'h0020009;
        3: dout<= 32'h0000001;
        4: dout<= 32'h0030009;
        5: dout<= 32'h0000001;
      //@end[micro_rom]
        default: begin
           dout<= 32'h0000000;
        end

      endcase
   end




endmodule // nanorv32_urom
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
