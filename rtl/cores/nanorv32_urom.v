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
        0: dout<= 32'h00100093;
        1: dout<= 32'h00000013;
        2: dout<= 32'hfe112c23;
        3: dout<= 32'hfe212a23;
        4: dout<= 32'hfe512823;
        5: dout<= 32'hfe612623;
        6: dout<= 32'hfe712423;
        7: dout<= 32'hfea12223;
        8: dout<= 32'hfeb12023;
        9: dout<= 32'hfcc12e23;
        10: dout<= 32'hfcd12c23;
        11: dout<= 32'hfce12a23;
        12: dout<= 32'hfcf12823;
        13: dout<= 32'hfff00093;
        14: dout<= 32'h00000297;
        15: dout<= 32'hfc512623;
        16: dout<= 32'hfcc10113;
        17: dout<= 32'h08002503;
        18: dout<= 32'h00050067;
        19: dout<= 32'hff812083;
        20: dout<= 32'hff012283;
        21: dout<= 32'hfec12303;
        22: dout<= 32'hfe812383;
        23: dout<= 32'hfe412503;
        24: dout<= 32'hfe012583;
        25: dout<= 32'hfdc12603;
        26: dout<= 32'hfd812683;
        27: dout<= 32'hfd412703;
        28: dout<= 32'hfd012783;
        29: dout<= 32'hfcc12003;
        30: dout<= 32'hff412103;
        31: dout<= 32'h00000067;
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
