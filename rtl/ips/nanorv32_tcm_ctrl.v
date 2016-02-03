//****************************************************************************/
//  NANORV32 CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Wed Feb  3 07:54:33 2016
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
//  Filename        :  nanorv32_tcm_ctrl
//
//  Description     :  Tightly coupled Synchronous RAM controller (32-bit width)
//
//
//
//****************************************************************************/


module nanorv32_tcm_ctrl (/*AUTOARG*/
   // Outputs
   ready_nxt, dout,
   // Inputs
   clk, rst_n, en, din, addr, bytesel
   );
   parameter SIZE = 1024;
   parameter ADDR_WIDTH = 12;

`include "nanorv32_parameters.v"



   input clk;
   input rst_n;

   input en;
   output ready_nxt; // ready during the next cycle

   input [NANORV32_DATA_MSB:0] din;
   output [NANORV32_DATA_MSB:0] dout;
   input [ADDR_WIDTH-1:0]         addr;
   input [3:0]             bytesel;



   /*AUTOINPUT*/
   /*AUTOOUTPUT*/


   /*AUTOREG*/
   /*AUTOWIRE*/

   wire [NANORV32_DATA_MSB:0] dout;
   wire [NANORV32_DATA_MSB:0] din;
   wire [ADDR_WIDTH-1:0]     addr;
   wire [3:0]                bytesel;

   wire [3:0]           we;
   wire                 write_access;
   assign we = bytesel & {4{en}};
   assign write_access = |we;
   bytewrite_ram_32bits #(.SIZE(SIZE),.ADDR_WIDTH(ADDR_WIDTH-2))
   U_MEM (

          // Outputs
          .dout                    (dout),
          // Inputs
          .clk                     (clk),
          .we                      (we),
          .addr                    (addr[ADDR_WIDTH-1:2]),
          .din                     (din));

   // If we have a write, the memory is available immediatly after the following edge
   // If we have a read, the data is available only after the edge - so the CPU must wait
   reg                  en_r;
   wire                 ready_nxt;
   always @(posedge clk or negedge rst_n) begin
      if(rst_n == 1'b0) begin
         /*AUTORESET*/
         // Beginning of autoreset for uninitialized flops
         en_r <= 1'h0;
         // End of automatics
      end
      else begin
         en_r <= en;
      end
   end
   assign ready_nxt = write_access ? en : en_r;

endmodule // nanorv32_tcm_ctrl
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
