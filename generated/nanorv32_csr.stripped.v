//****************************************************************************/
//  Nanorv32 CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Fri Mar 11 13:41:19 2016
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
//  Filename        :  nanorv_csr.v
//
//  Description     :  Control and Status register implementation for Nanorv32
//
//
//
//****************************************************************************/


module nanorv32_csr (/*AUTOARG*/
   // Outputs
   csr_core_rdata,
   // Inputs
   core_csr_addr, core_csr_wdata, core_csr_write
   );

`include "nanorv32_parameters.v"

   input [NANORV32_CSR_ADDR_MSB:0] core_csr_addr;
   input [NANORV32_DATA_MSB:0] core_csr_wdata;
   input                       core_csr_write;
   output [NANORV32_DATA_MSB:0] csr_core_rdata;



   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [NANORV32_DATA_MSB:0] csr_core_rdata;
   // End of automatics
   /*AUTOWIRE*/


   wire [63:0]               time_cnt = 64'hCAFEBABE_AA55AA55;
   wire [31:0]               time_cnt_low = time_cnt[31:0];
   wire [31:0]               time_cnt_high = time_cnt[63:32];

   wire [63:0]               cycle_cnt = 64'h89ABCDEF_11223344;
   wire [31:0]               cycle_cnt_low = cycle_cnt[31:0];
   wire [31:0]               cycle_cnt_high = cycle_cnt[63:32];


   wire [63:0]               instret_cnt = 64'hDEADBEEF_01234567;
   wire [31:0]               instret_cnt_low = instret_cnt[31:0];
   wire [31:0]               instret_cnt_high = instret_cnt[63:32];



   always @* begin
      case(core_csr_addr[NANORV32_CSR_ADDR_MSB:0])
        //@begin[csr_read_decode]
//@end[csr_read_decode]

        default: begin
        end

      endcase
   end


endmodule // nanorv_csr
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
