//****************************************************************************/
//  NanoRV32  CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Mon Mar  7 17:49:24 2016
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
//  Filename        :  nanorv32_rvc_func.v
//
//  Description     :  Helper function(s) for RVC decoding
//
//
//
//****************************************************************************/

// Convert an RVC register index to a regular
// register index
function [4:0] rvc_to_rv32_reg;
   input [2:0] rvc;
   begin
      rvc_to_rv32_reg = {2'b01,rvc} ;
   end
endfunction //
