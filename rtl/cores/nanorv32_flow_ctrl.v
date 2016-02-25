//****************************************************************************/
//  Nanorv32  CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Tue Feb 23 23:49:25 2016
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
//  Filename        :  nanorv32_flow_ctrl.v
//
//  Description     :  Pipeline control state machine
//
//
//
//****************************************************************************/
module nanorv32_flow_ctrl (/*AUTOARG*/
   // Outputs
   inst_irq, force_stall_pstate, force_stall_reset, output_new_pc,
   valid_inst, data_access_cycle, pstate_r, irq_ack,
   irq_bypass_inst_reg,
   // Inputs
   branch_taken, datamem_read, datamem_write, hreadyd,
   codeif_cpu_ready_r, irq, clk, rst_n
   );

`include "nanorv32_parameters.v"

   output force_stall_pstate;
   output force_stall_reset;
   output output_new_pc;
   output valid_inst;
   output data_access_cycle;
   output [NANORV32_PSTATE_MSB:0] pstate_r;

   input  branch_taken;
   input  datamem_read;
   input  datamem_write;
   input  hreadyd;

   input  codeif_cpu_ready_r;

   // IRQ support
   input  irq;
   output irq_ack;
   output irq_bypass_inst_reg;
   output [NANORV32_DATA_MSB:0] inst_irq;       // From U_MICRO_ROM of nanorv32_urom.v


   input clk;
   input rst_n;




   /*AUTOINPUT*/
   /*AUTOOUTPUT*/
   // Beginning of automatic outputs (from unused autoinst outputs)

   // End of automatics

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg                  data_access_cycle;
   reg                  force_stall_pstate;
   reg                  force_stall_reset;
   reg                  irq_ack;
   reg                  irq_bypass_inst_reg;
   reg                  output_new_pc;
   reg                  valid_inst;
   // End of automatics
   /*AUTOWIRE*/
   reg data_started;
   reg [NANORV32_PSTATE_MSB:0] pstate_next;
   reg [NANORV32_PSTATE_MSB:0] pstate_r;

   // Counter for micro-rom address
   reg [NANORV32_UROM_ADDR_MSB:0] urom_addr_r;
   reg [NANORV32_UROM_ADDR_MSB:0] urom_addr_start_value;

   reg                         urom_addr_load;
   reg                         urom_addr_inc;

   // (the first cycle normally)

   always @* begin


      pstate_next =  NANORV32_PSTATE_CONT;
      force_stall_pstate = 0;
      force_stall_reset = 0;
      output_new_pc = 0;
      valid_inst = 1;
      data_access_cycle = 0;


      case(pstate_r)

        NANORV32_PSTATE_RESET: begin
           force_stall_pstate = 1;
           force_stall_reset = 1;
           pstate_next =  NANORV32_PSTATE_CONT;

        end
        NANORV32_PSTATE_CONT: begin
           if(branch_taken) begin
              force_stall_pstate = 1;
              pstate_next =  NANORV32_PSTATE_BRANCH;
              output_new_pc = 1;
           end
           else if((datamem_write || datamem_read))
             begin
                // we use an early "ready",
                // so we move to state WAITLD when the memory is ready
                force_stall_pstate = 1;
                data_access_cycle  = 1;
                pstate_next = NANORV32_PSTATE_WAITLD;
             end
        end

        NANORV32_PSTATE_BRANCH: begin
           output_new_pc = 1;
          if (codeif_cpu_ready_r) begin
              force_stall_pstate = 1'b0;
              pstate_next =  NANORV32_PSTATE_CONT;
           end
           else begin
              force_stall_pstate = 1'b1;
              pstate_next =  NANORV32_PSTATE_BRANCH;
           end
        end
        NANORV32_PSTATE_STALL: begin
           valid_inst = 0;
           if (codeif_cpu_ready_r)
             begin
              force_stall_pstate = 1'b0;
              pstate_next =  NANORV32_PSTATE_CONT ;
           end
           else begin
              force_stall_pstate = 1'b1;
              pstate_next =  NANORV32_PSTATE_STALL;
           end
        end // case: NANORV32_PSTATE_STALL
        NANORV32_PSTATE_WAITLD: begin
           //if (!dataif_cpu_early_ready)
           //  begin
           //     force_stall_pstate = 1'b1;
           //     pstate_next =  NANORV32_PSTATE_WAITLD;
           //  end
           //else begin
              data_started        = 1;
              data_access_cycle  = 0;
              if(hreadyd) begin
                pstate_next =  NANORV32_PSTATE_CONT;
                force_stall_pstate = 1'b0;
              end
              else begin
                 pstate_next =  NANORV32_PSTATE_WAITLD;
                 force_stall_pstate = 1'b1;
              end
           // end
        end // case: NANORV32_PSTATE_WAITLD
        default begin

           pstate_next =  NANORV32_PSTATE_CONT;
           force_stall_pstate = 0;
           force_stall_reset = 0;
           output_new_pc = 0;
        end
     endcase // case (pstate_r)
   end // always @ *

   always @(posedge clk or negedge rst_n) begin
      if(rst_n == 1'b0) begin
         pstate_r <= NANORV32_PSTATE_RESET;
         // instruction_r - so it must be valid
         /*AUTORESET*/
      end
      else begin
         pstate_r <= pstate_next;

      end
   end


   always @(posedge clk or negedge rst_n) begin
      if(rst_n == 1'b0) begin
         /*AUTORESET*/
         // Beginning of autoreset for uninitialized flops
         urom_addr_r <= {(1+(NANORV32_UROM_ADDR_MSB)){1'b0}};
         // End of automatics
      end
      else begin
         if(urom_addr_load) begin
            urom_addr_r <= urom_addr_start_value;

         end
         else if(urom_addr_inc) begin
            urom_addr_r <= urom_addr_r + 1'b1;
         end

      end
   end




    /* nanorv32_urom AUTO_TEMPLATE(
     .dout             (inst_irq[NANORV32_DATA_MSB:0]),
     ); */
   nanorv32_urom U_MICRO_ROM (
                              .addr             (urom_addr_r[NANORV32_UROM_ADDR_MSB:0]),
                           /*AUTOINST*/
                              // Outputs
                              .dout             (inst_irq[NANORV32_DATA_MSB:0])); // Templated // Templated) // Templated)







endmodule // nanorv32_flow_ctrl
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
