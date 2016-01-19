//****************************************************************************/
//  nanorv32 CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Tue Jan 19 20:28:48 2016
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
//  Filename        :  nanorv32.v
//
//  Description     :   Put a short descripton here
//
//
//
//****************************************************************************/




module nanorv32 (/*AUTOARG*/
   // Outputs
   cpu_codemem_addr, cpu_codemem_valid, cpu_datamem_addr,
   cpu_datamem_wdata, cpu_datamem_bytesel, cpu_datamem_valid,
   // Inputs
   codemem_cpu_rdata, codemem_cpu_ready, datamem_cpu_rdata,
   datamem_cpu_ready, rst_n, clk
   );

`include "nanorv32_parameters.v"
   // Code memory interface
   output [NRV32_ADDR_MSB:0] cpu_codemem_addr;
   output                    cpu_codemem_valid;
   input  [NRV32_DATA_MSB:0] codemem_cpu_rdata;
   input                     codemem_cpu_ready;

   // Data memory interface

   output [NRV32_ADDR_MSB:0] cpu_datamem_addr;
   output [NRV32_DATA_MSB:0] cpu_datamem_wdata;
   output [3:0]              cpu_datamem_bytesel;
   output                    cpu_datamem_valid;
   input [NRV32_DATA_MSB:0]  datamem_cpu_rdata;
   input                     datamem_cpu_ready;

   input                     rst_n;
   input                     clk;

   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [NRV32_ADDR_MSB:0] cpu_codemem_addr;
   reg                  cpu_codemem_valid;
   reg [NRV32_ADDR_MSB:0] cpu_datamem_addr;
   reg [3:0]            cpu_datamem_bytesel;
   reg                  cpu_datamem_valid;
   reg [NRV32_DATA_MSB:0] cpu_datamem_wdata;
   // End of automatics
   /*AUTOWIRE*/

endmodule // nanorv32
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
