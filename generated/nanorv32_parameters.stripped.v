//****************************************************************************/
//  Nanorv32 CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Tue Jan 19 21:01:45 2016
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
//  Filename        :  nanorv32_parameters.v
//
//  Description     :  Parameter file for the nanorv32 core
//
//
//
//****************************************************************************/



parameter NRV32_ADDR_SIZE=16; // 64K
parameter NRV32_ADDR_MSB = NRV32_ADDR_SIZE-1;

parameter NRV32_DATA_SIZE=32;
parameter NRV32_DATA_MSB = NRV32_DATA_SIZE-1;


//@begin[instruction_format]
//@end[instruction_format]

//@begin[inst_decode_definitions]
//@end[inst_decode_definitions]

//@begin[mux_select_definitions]
//@end[mux_select_definitions]
