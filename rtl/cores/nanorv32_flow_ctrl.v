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
   force_stall_pstate, force_stall_pstate2, force_stall_reset,
   output_new_pc, valid_inst, data_access_cycle, pstate_r, irq_ack,
   irq_bypass_inst_reg, inst_irq,
   // Inputs
   branch_taken, datamem_read, datamem_write, hreadyd,
   codeif_cpu_ready_r, irq, reti_inst_detected, clk, rst_n
   );

`include "nanorv32_parameters.v"

   output force_stall_pstate;
   output force_stall_pstate2;
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

   input                        reti_inst_detected;

   input clk;
   input rst_n;




   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg                  data_access_cycle;
   reg                  force_stall_pstate;
   reg                  force_stall_pstate2;
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

   wire                        interrupt_state;
   reg                         irq_bypass_inst_a;

   assign reti_qual = reti_inst_detected && interrupt_state;

   assign interrupt_state = 0;

   always @* begin


      pstate_next =  NANORV32_PSTATE_CONT;
      force_stall_pstate = 0;
      force_stall_reset = 0;
      output_new_pc = 0;
      valid_inst = 1;
      data_access_cycle = 0;

      // IRQ support
      irq_bypass_inst_a = 0;
      urom_addr_load    = 0;
      urom_addr_start_value = 0;
      urom_addr_inc = 0;
      case(pstate_r)

        NANORV32_PSTATE_RESET: begin
           force_stall_pstate = 1;
           force_stall_pstate2 = 1;
           force_stall_reset = 1;
           pstate_next =  NANORV32_PSTATE_CONT;

        end
        NANORV32_PSTATE_CONT: begin
           if(branch_taken) begin
              force_stall_pstate = 1;
              force_stall_pstate2 = 0;
              pstate_next =  NANORV32_PSTATE_BRANCH;
              output_new_pc = 1;
           end
           else if((datamem_write || datamem_read))
             begin
                // we use an early "ready",
                // so we move to state WAITLD when the memory is ready

                force_stall_pstate = 0;
                force_stall_pstate2 = 1;
                data_access_cycle  = 1;


                pstate_next = NANORV32_PSTATE_WAITLD;
             end
           else if(irq) begin
              pstate_next = NANORV32_PSTATE_IRQ_BEGIN;
           end
           else if(reti_qual) begin
              pstate_next = NANORV32_PSTATE_RETI_BEGIN;
           end
        end

        NANORV32_PSTATE_BRANCH: begin
           output_new_pc = 1;
          if (codeif_cpu_ready_r) begin
             if(irq) begin
                pstate_next = NANORV32_PSTATE_IRQ_BEGIN;
             end
             else if(reti_qual) begin
                pstate_next = NANORV32_PSTATE_RETI_BEGIN;
             end
             else begin
              force_stall_pstate = 1'b0;
              force_stall_pstate2 = 0;
              pstate_next =  NANORV32_PSTATE_CONT;
             end
          end
          else begin
              force_stall_pstate = 1'b1;
              force_stall_pstate2 = 0;
              pstate_next =  NANORV32_PSTATE_BRANCH;
           end
        end

        NANORV32_PSTATE_WAITLD: begin
           //if (!dataif_cpu_early_ready)
           //  begin
           //     force_stall_pstate = 1'b1;
           //     pstate_next =  NANORV32_PSTATE_WAITLD;
           //  end
           //else begin


              data_started        = 1;

              if(hreadyd) begin

                 if((datamem_write || datamem_read))
                 begin
                  // we use an early "ready",
                  // so we move to state WAITLD when the memory is ready
                  force_stall_pstate = 0;
                  force_stall_pstate2 = 1;
                  data_access_cycle  = 1;
                  pstate_next = NANORV32_PSTATE_WAITLD;
                 end else
                 if(branch_taken) begin
                  force_stall_pstate = 1;
                  force_stall_pstate2 = 0;
                  pstate_next =  NANORV32_PSTATE_BRANCH;
                  output_new_pc = 1;
                 end
                 else if(irq) begin
                    pstate_next = NANORV32_PSTATE_IRQ_BEGIN;
                 end
                 else if(reti_qual) begin
                    pstate_next = NANORV32_PSTATE_RETI_BEGIN;
                 end
                 else begin
                    pstate_next =  NANORV32_PSTATE_CONT;
                    force_stall_pstate = 1'b0;
                    force_stall_pstate2 = 0;
                    data_access_cycle  = 0;
                 end
              end
              else begin
                 pstate_next =  NANORV32_PSTATE_WAITLD;
                 force_stall_pstate = 1'b1;
                 force_stall_pstate2 = 1;
              end
           // end
        end // case: NANORV32_PSTATE_WAITLD

        NANORV32_PSTATE_IRQ_BEGIN: begin
           irq_bypass_inst_a = 1; // we are going to override the instruction register
           urom_addr_load    = 1;
           urom_addr_start_value = NANORV32_INT_ENTRY_CODE_START_ADDR[NANORV32_UROM_ADDR_MSB:0]/4;
           pstate_next =  NANORV32_PSTATE_IRQ_CONT;
        end
        NANORV32_PSTATE_IRQ_CONT: begin
           irq_bypass_inst_a = 1; // we are going to override the instruction register
           urom_addr_inc = 1;
           if(urom_addr_r == NANORV32_INT_ENTRY_CODE_STOP_ADDR[NANORV32_UROM_ADDR_MSB:0]/4) begin
              pstate_next =  NANORV32_PSTATE_IRQ_END;
           end
           else begin
              pstate_next =  NANORV32_PSTATE_IRQ_CONT;
           end


        end
        NANORV32_PSTATE_IRQ_END: begin
           pstate_next =  NANORV32_PSTATE_CONT;
        end
        NANORV32_PSTATE_RETI_BEGIN: begin
           irq_bypass_inst_a = 1; // we are going to override the instruction register
           urom_addr_load    = 1;
           urom_addr_start_value = NANORV32_INT_EXIT_CODE_START_ADDR[NANORV32_UROM_ADDR_MSB:0]/4;
           pstate_next =  NANORV32_PSTATE_RETI_CONT;
        end

        NANORV32_PSTATE_RETI_CONT: begin
           irq_bypass_inst_a = 1; // we are going to override the instruction register
           urom_addr_inc = 1;
           if(urom_addr_r == NANORV32_INT_EXIT_CODE_STOP_ADDR[NANORV32_UROM_ADDR_MSB:0]/4) begin
              pstate_next =  NANORV32_PSTATE_RETI_END;
           end
           else begin
              pstate_next =  NANORV32_PSTATE_RETI_CONT;
           end


        end

        NANORV32_PSTATE_RETI_END: begin
           pstate_next =  NANORV32_PSTATE_CONT;
        end

        default begin

           pstate_next =  NANORV32_PSTATE_CONT;
           force_stall_pstate = 0;
           force_stall_pstate2 = 0;
           force_stall_reset = 0;
           output_new_pc = 0;

           irq_bypass_inst_a = 0;
           urom_addr_load    = 0;
           urom_addr_start_value = 0;
           urom_addr_inc = 0;



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

   always @(posedge clk or negedge rst_n) begin
      if(rst_n == 1'b0) begin
         /*AUTORESET*/
         // Beginning of autoreset for uninitialized flops
         irq_bypass_inst_reg <= 1'h0;
         // End of automatics
      end
      else begin
         irq_bypass_inst_reg <= irq_bypass_inst_a;

      end
   end



    /* nanorv32_urom AUTO_TEMPLATE(
     .dout             (inst_irq[NANORV32_DATA_MSB:0]),
     ); */
   nanorv32_urom U_MICRO_ROM (
                              .addr             (urom_addr_r[NANORV32_UROM_ADDR_MSB:0]),
                           /*AUTOINST*/
                              // Outputs
                              .dout             (inst_irq[NANORV32_DATA_MSB:0])); // Templated
endmodule // nanorv32_flow_ctrl
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
