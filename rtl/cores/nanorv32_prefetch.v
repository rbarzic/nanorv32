//****************************************************************************/
//  Nanorv32 CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) 2016  Ronan Barzic - rbarzic@gmail.com
//                      Jean-Baptiste Brelot xxxx@gmail.com
//  Date            :  Tue Mar  1 18:08:40 2016
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
//  Filename        :  nanorv32_prefetch.v
//
//  Description     :  Prefetch buffer implementation
//
//
//
//****************************************************************************/


module nanorv32_prefetch (/*AUTOARG*/
   // Outputs
   haddri, hproti, hsizei, hmasteri, hmasterlocki, hbursti, hwdatai,
   hwritei, htransi, inst_from_buffer, inst_ret, reset_over, fifo_empty,
   // Inputs
   branch_taken, pstate_r, pc_next, hrdatai, hrespi, hreadyi,hreadyd,
   stall_exe, force_stall_reset, rst_n, clk, irq_bypass_inst_reg_r,
   interlock
   );

`include "nanorv32_parameters.v"


   input branch_taken;
   input [NANORV32_PSTATE_MSB:0] pstate_r;

   input [NANORV32_DATA_MSB:0]     pc_next;


   input [NANORV32_DATA_MSB:0]      hrdatai;
   input                            hrespi;
   input                            hreadyi;
   input                            hreadyd;
   output [NANORV32_DATA_MSB:0]     haddri;
   output [3:0]                     hproti;
   output [2:0]                     hsizei;
   output                           hmasteri;
   output                           hmasterlocki;
   output [2:0]                     hbursti;
   output [NANORV32_DATA_MSB:0]     hwdatai;
   output                           hwritei;
   output                           htransi;





   input                         stall_exe;
   input                         force_stall_reset;


   input                         rst_n;
   input                         clk;
   input                         irq_bypass_inst_reg_r;
   input                         interlock;

   output [NANORV32_DATA_MSB:0]  inst_from_buffer;
   output                        inst_ret;
   output                        reset_over;
   output                        fifo_empty;



   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/

      //===========================================================================
   // Instruction register / decoding
   //===========================================================================
   reg  write_data;
   wire  branch_req_tmp;
   wire  next_inst_en_tmp;
   wire  htransi_tmp;
   wire [31:0] branch_target_tmp = pc_next;
   wire [31:0]  haddri;
   reg  [31:0]  haddri_r;
   reg  [1:0] wr_pt_r , rd_pt_r;
   wire  [2:0] wr_pt_r_plus1 = wr_pt_r + 1;
   wire  [2:0] rd_pt_r_plus1 = rd_pt_r + 1;
   reg fifo_full_reg;
   wire fifo_full = wr_pt_r_plus1[1:0] == rd_pt_r[1:0] & pstate_r != NANORV32_PSTATE_BRANCH & write_data;
   wire fifo_empty = wr_pt_r[1:0] == rd_pt_r[1:0] & pstate_r != NANORV32_PSTATE_BRANCH & ~fifo_full_reg;
   reg  [31:0] iq [0:3];
   wire inst_ret = (!(stall_exe | force_stall_reset));
   reg  branch_taken_reg;
   reg  ignore_branch;
   reg  reset_over;
   always @(posedge clk or negedge rst_n) begin
      if(rst_n == 1'b0) begin
         branch_taken_reg <= 1'b0;
         /*AUTORESET*/
      end
      else begin
         if(hreadyi)
           branch_taken_reg <= branch_taken & hreadyi & ~reset_over &  pstate_r != NANORV32_PSTATE_BRANCH; 
      end
   end
    always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
         fifo_full_reg <= 1'b0;
         /*AUTORESET*/
      end
      else begin
         if(hreadyi & ( write_data | inst_ret)) 
           fifo_full_reg <= fifo_full & ~branch_taken;
      end
   end
   always @(posedge clk or negedge rst_n) begin
      if(rst_n == 1'b0) begin
         write_data <= 1'b0;
         /*AUTORESET*/
      end
      else begin
         if(hreadyi)
           write_data <= htransi & hreadyi;
      end
   end
   always @(posedge clk or negedge rst_n) begin
      if(rst_n == 1'b0) begin
         wr_pt_r <= 2'b00;
         /*AUTORESET*/
      end
      else begin
//         if((write_data | branch_taken & ~ignore_branch & ~hreadyd) & hreadyi)
         if((write_data | branch_taken ) & hreadyi)
//           wr_pt_r <= (branch_taken & ~ignore_branch &  (pstate_r != NANORV32_PSTATE_BRANCH)) ? 2'b00 : wr_pt_r + 1;
           wr_pt_r <= (branch_taken &  (pstate_r != NANORV32_PSTATE_BRANCH)) ? 2'b00 : wr_pt_r + 1;
      end
   end
   always @(posedge clk or negedge rst_n) begin
      if(rst_n == 1'b0) begin
         rd_pt_r <= 2'b00;
         /*AUTORESET*/
      end
      else begin
         if(inst_ret & ~reset_over)
           rd_pt_r <= branch_taken_reg ? 2'b00 : rd_pt_r_plus1[1:0];
      end
   end
   wire  cancel_data = branch_req_tmp;
   always @(posedge clk or negedge rst_n) begin
      if(rst_n == 1'b0) begin
           iq[0][31:0] <= NANORV32_J0_INSTRUCTION;
         /*AUTORESET*/
      end
      else begin

         if(wr_pt_r == 0 & write_data & ~cancel_data)
           iq[0][31:0] <= hrdatai[31:0];
      end
   end
//   always @(posedge clk or negedge rst_n) begin
//      if(rst_n == 1'b0) begin
//           iq[1][31:0] <= NANORV32_J0_INSTRUCTION;
//         /*AUTORESET*/
//      end
//      else begin
//         if(wr_pt_r == 1 & write_data & ~cancel_data)
//           iq[1][31:0] <= codeif_cpu_rdata[31:0];
//      end
//   end
//   always @(posedge clk or negedge rst_n) begin
//      if(rst_n == 1'b0) begin
//           iq[2][31:0] <= NANORV32_J0_INSTRUCTION;
//         /*AUTORESET*/
//      end
//      else begin
//         if(wr_pt_r == 2 & write_data & ~cancel_data)
//           iq[2][31:0] <= codeif_cpu_rdata[31:0];
//      end
//   end
//   always @(posedge clk or negedge rst_n) begin
//      if(rst_n == 1'b0) begin
//           iq[3][31:0] <= NANORV32_J0_INSTRUCTION;
//         /*AUTORESET*/
//      end
//      else begin
//         if(wr_pt_r == 3 & write_data & ~cancel_data)
//           iq[3][31:0] <= codeif_cpu_rdata[31:0];
//      end
//   end
   genvar i;

   generate
      for (i = 0; i < 4; i = i + 1) begin
        always @(posedge clk or negedge rst_n) begin
          if(rst_n == 1'b0) begin
                iq[i][31:0] <= NANORV32_J0_INSTRUCTION;
             /*AUTORESET*/
          end else begin
            if (wr_pt_r == i & write_data & ~cancel_data)  begin
                iq[i][31:0] <= hrdatai[31:0];
            end
          end
        end
      end
   endgenerate

   always @(posedge clk or negedge rst_n) begin
      if(rst_n == 1'b0) begin
           reset_over <= 1'b1;
         /*AUTORESET*/
      end
      else begin
         if( force_stall_reset | reset_over & write_data)
           reset_over <= force_stall_reset;
      end
   end
   always @(posedge clk or negedge rst_n) begin
      if(rst_n == 1'b0) begin
           ignore_branch <= 1'b1;
         /*AUTORESET*/
      end
      else begin
         if(write_data & reset_over )
           ignore_branch <= ~write_data;
      end
   end

   always @(posedge clk or negedge rst_n) begin
      if(rst_n == 1'b0) begin
          haddri_r  <= 32'b0;
         /*AUTORESET*/
      end
      else if ((next_inst_en_tmp | branch_req_tmp) & hreadyi) begin
          haddri_r <= haddri;
      end
   end
//   assign branch_req_tmp =  branch_taken & ~ignore_branch & pstate_r != NANORV32_PSTATE_BRANCH &  ~force_stall_reset;
   assign branch_req_tmp =  branch_taken & pstate_r != NANORV32_PSTATE_BRANCH &  ~force_stall_reset;

   assign next_inst_en_tmp = ~force_stall_reset & ~fifo_full & ~fifo_full_reg;
   // We block eternal request on the bus if we are overriding
   // the instruction register during a irq context save/restore operation
   assign htransi_tmp  = (next_inst_en_tmp | branch_req_tmp) & (!irq_bypass_inst_reg_r) & hreadyi;

   assign haddri  = branch_req_tmp & ~reset_over ? branch_target_tmp : {32{~(force_stall_reset | reset_over & htransi_tmp & ~write_data)}} & (haddri_r + 4);


   assign inst_from_buffer =  iq[rd_pt_r];

   // Code memory interface

//   assign htransi      = hreadyi & ~force_stall_reset & ~(branch_taken & interlock) & ~(fifo_full & ~branch_taken) & ~(fifo_full_reg & ~branch_taken) & ~(branch_taken &  pstate_r == NANORV32_PSTATE_WAITLD);  // request is the AHB is free
   assign htransi = htransi_tmp;
   assign hsizei       = 3'b010;   // word request
   assign hproti       = 4'b0001;  // instruction data
   assign hbursti      = 3'b000;   // Burst not supported
   assign hmasteri     = 1'b0;     // Core is the 0 master ID
   assign hmasterlocki = 1'b0;     // Master lock is not used
   assign hwritei      = 1'b0;     // Iside is doing only reads
   assign hwdatai      = 32'h0;    // Write data is not supported on Iside
   wire   unused       = hrespi;



endmodule // nanorv32_prefetch
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
