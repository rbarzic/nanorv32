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
   output_new_pc, valid_inst, data_access_cycle, pstate_r,
   allow_hidden_use_of_x0, irq_ack, irq_bypass_inst_reg_r, inst_irq,
   interrupt_state_r,
   // Inputs
   branch_taken, datamem_read, datamem_write, hreadyd,
   codeif_cpu_ready_r, interlock, irq, reti_inst_detected, clk, rst_n
   );

`include "nanorv32_parameters.v"

   output force_stall_pstate;
   output force_stall_pstate2;
   output force_stall_reset;
   output output_new_pc;
   output valid_inst;
   output data_access_cycle;
   output [NANORV32_PSTATE_MSB:0] pstate_r;
   output                         allow_hidden_use_of_x0;

   input  branch_taken;
   input  datamem_read;
   input  datamem_write;
   input  hreadyd;

   input  codeif_cpu_ready_r;
   input  interlock;

   // IRQ support
   input  irq;
   output irq_ack;
   output irq_bypass_inst_reg_r;
   output [NANORV32_DATA_MSB:0] inst_irq;       // From U_MICRO_ROM of nanorv32_urom.v
   output                       interrupt_state_r;

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

   wire                        urom_addr_load;
   reg                         urom_addr_inc;

   // (the first cycle normally)


   reg                         irq_bypass_inst_reg_r;
   reg                         set_irq_bypass_inst;
   reg                         clear_irq_bypass_inst;

   reg                         interrupt_state_r;
   reg                         set_interrupt_state;
   reg                         clear_interrupt_state;

   reg                         irq_restore_r;
   reg                         set_irq_restore;
   reg                         clear_irq_restore;







   event                       dbg_evt1;
   event                       dbg_evt2;

   // Makes waveform debugging easier
   wire [NANORV32_UROM_ADDR_MSB:0] irq_entry_start;
   wire [NANORV32_UROM_ADDR_MSB:0] irq_entry_stop;
   wire [NANORV32_UROM_ADDR_MSB:0] irq_exit_start ;
   wire [NANORV32_UROM_ADDR_MSB:0] irq_exit_stop  ;

   assign irq_entry_start = NANORV32_INT_ENTRY_CODE_START_ADDR[NANORV32_UROM_ADDR_MSB+2:0]/4;
   assign irq_entry_stop  = NANORV32_INT_ENTRY_CODE_STOP_ADDR[NANORV32_UROM_ADDR_MSB+2:0]/4-1;
   assign irq_exit_start = NANORV32_INT_EXIT_CODE_START_ADDR[NANORV32_UROM_ADDR_MSB+2:0]/4;
   assign irq_exit_stop  = NANORV32_INT_EXIT_CODE_STOP_ADDR[NANORV32_UROM_ADDR_MSB+2:0]/4-1;



   always @* begin


      pstate_next =  NANORV32_PSTATE_CONT;
      force_stall_pstate = 0;
      force_stall_reset = 0;
      output_new_pc = 0;
      valid_inst = 1;
      data_access_cycle = 0;

      // IRQ support

      set_irq_bypass_inst = 1'b0;
      clear_irq_bypass_inst = 1'b0;

      set_interrupt_state = 1'b0;
      clear_interrupt_state = 1'b0;

      set_irq_restore = 1'b0;
      clear_irq_restore = 1'b0;


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
              urom_addr_inc = 0;
              output_new_pc = 1;
           end
           else if((datamem_write || datamem_read))
             begin
                // we use an early "ready",
                // so we move to state WAITLD when the memory is ready

                force_stall_pstate = 0;
                force_stall_pstate2 = 1;
                data_access_cycle  = 1;
                urom_addr_inc = irq_bypass_inst_reg_r;

                pstate_next = NANORV32_PSTATE_WAITLD;
             end // if ((datamem_write || datamem_read))
           else if (irq && !irq_bypass_inst_reg_r) begin
              set_irq_bypass_inst = 1'b1;
              urom_addr_start_value = irq_entry_start;
              set_interrupt_state <= 1;

           end
           //else if ( reti_inst_detected  && interrupt_state_r) begin
           //   set_irq_bypass_inst = 1'b1;
           //   set_irq_restore     = 1'b1;
           //   urom_addr_start_value = irq_exit_start;
           //   clear_interrupt_state = 1;
           //end
           else begin
              urom_addr_inc = irq_bypass_inst_reg_r;
           end
        end

        NANORV32_PSTATE_BRANCH: begin
           output_new_pc = 1;
           // we are in the second cycle of the reti
           // instruction
           if ( reti_inst_detected  && interrupt_state_r) begin
              set_irq_bypass_inst = 1'b1;
              set_irq_restore     = 1'b1;
              urom_addr_start_value = irq_exit_start;
              clear_interrupt_state = 1;
           end
           else if (codeif_cpu_ready_r) begin

             force_stall_pstate = 1'b0;
             force_stall_pstate2 = 0;
             pstate_next =  NANORV32_PSTATE_CONT;
             clear_irq_bypass_inst =  1;
             urom_addr_inc = 0;
              // a valid branch should end the poping sequence
              // when restoring the context during a interrupt
             if(irq_restore_r) begin
                clear_irq_restore <= 1;
             end


          end
          else begin
             force_stall_pstate = 1'b1;
             force_stall_pstate2 = 0;
             pstate_next =  NANORV32_PSTATE_BRANCH;
             urom_addr_inc = 0;
           end
        end

        NANORV32_PSTATE_WAITLD: begin

              data_started        = 1;

              if(hreadyd) begin

                 if((datamem_write || datamem_read))
                 begin
                  // we use an early "ready",
                  // so we move to state WAITLD when the memory is ready
                    force_stall_pstate = 0;
                    force_stall_pstate2 = 1;
                    data_access_cycle  = 1;
                    urom_addr_inc = irq_bypass_inst_reg_r;
                    pstate_next = NANORV32_PSTATE_WAITLD;
                    if (irq && !irq_bypass_inst_reg_r) begin
                       set_irq_bypass_inst = 1'b1;
                       urom_addr_start_value = irq_entry_start;
                       set_interrupt_state <= 1;
                    end
                    else if ( reti_inst_detected  && interrupt_state_r) begin
                       set_irq_bypass_inst = 1'b1;
                       set_irq_restore     = 1'b1;
                       urom_addr_start_value = irq_exit_start;
                       clear_interrupt_state = 1;
                    end
                 end else
                 if(branch_taken) begin
                    force_stall_pstate = 1;
                    force_stall_pstate2 = 0;
                    pstate_next =  NANORV32_PSTATE_BRANCH;
                    output_new_pc = 1;
                    urom_addr_inc = 0;
                 end
                 else begin
                    pstate_next =  NANORV32_PSTATE_CONT;
                    force_stall_pstate = 1'b0;
                    force_stall_pstate2 = 0;
                    data_access_cycle  = 0;
                    urom_addr_inc = irq_bypass_inst_reg_r;
                    output_new_pc = 0;
                    if (irq && !irq_bypass_inst_reg_r) begin
                       set_irq_bypass_inst = 1'b1;
                       urom_addr_start_value = irq_entry_start;
                       set_interrupt_state <= 1;
                    end
                    else if ( reti_inst_detected  && interrupt_state_r) begin
                       set_irq_bypass_inst = 1'b1;
                       set_irq_restore     = 1'b1;
                       urom_addr_start_value = irq_exit_start;
                       clear_interrupt_state = 1;
                    end

                 end
              end
              else begin
                 pstate_next =  NANORV32_PSTATE_WAITLD;
                 force_stall_pstate = 1'b1;
                 force_stall_pstate2 = 1;
                 urom_addr_inc = 0;
                 output_new_pc = 0;
              end
           // end
        end // case: NANORV32_PSTATE_WAITLD


        default begin

           pstate_next =  NANORV32_PSTATE_CONT;
           force_stall_pstate = 0;
           force_stall_pstate2 = 0;
           force_stall_reset = 0;
           output_new_pc = 0;

           urom_addr_start_value = 0;
           urom_addr_inc = 0;

           set_irq_bypass_inst = 1'b0;
           clear_irq_bypass_inst = 1'b0;




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
        if (~interlock)
         pstate_r <= pstate_next;

      end
   end

   always @(posedge clk or negedge rst_n) begin
      if(rst_n == 1'b0) begin
         /*AUTORESET*/
         // Beginning of autoreset for uninitialized flops
         irq_bypass_inst_reg_r <= 1'h0;
         irq_restore_r <= 1'h0;
         // End of automatics
      end
      else begin
         if(set_irq_bypass_inst) begin
            irq_bypass_inst_reg_r <= 1'b1;
         end
         else if(clear_irq_bypass_inst) begin
            irq_bypass_inst_reg_r <= 1'b0;
         end

         if(set_irq_restore) begin
            irq_restore_r <= 1'b1;
         end
         else if(clear_irq_restore) begin
            irq_restore_r <= 1'b0;
         end
      end
   end

   assign urom_addr_load = set_irq_bypass_inst;
   assign allow_hidden_use_of_x0 = irq_restore_r;


   always @(posedge clk or negedge rst_n) begin
      if(rst_n == 1'b0) begin
         /*AUTORESET*/
         // Beginning of autoreset for uninitialized flops
         interrupt_state_r <= 1'h0;
         // End of automatics
      end
      else begin
         if(set_interrupt_state) begin
            interrupt_state_r <= 1'b1;
         end
         else if(clear_interrupt_state) begin
            interrupt_state_r  <= 1'b0;
         end
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
                              .dout             (inst_irq[NANORV32_DATA_MSB:0])); // Templated

   // just for debug

   wire [NANORV32_UROM_ADDR_MSB:0]dbg_entry_start;
   wire [NANORV32_UROM_ADDR_MSB:0] dbg_entry_stop;
   wire [NANORV32_UROM_ADDR_MSB:0] dbg_exit_start ;
   wire [NANORV32_UROM_ADDR_MSB:0] dbg_exit_stop  ;

   assign dbg_entry_start = NANORV32_INT_ENTRY_CODE_START_ADDR[NANORV32_UROM_ADDR_MSB+2:0]/4;
   assign dbg_entry_stop  = NANORV32_INT_ENTRY_CODE_STOP_ADDR[NANORV32_UROM_ADDR_MSB+2:0]/4-1;
   assign dbg_exit_start = NANORV32_INT_EXIT_CODE_START_ADDR[NANORV32_UROM_ADDR_MSB+2:0]/4;
   assign dbg_exit_stop  = NANORV32_INT_EXIT_CODE_STOP_ADDR[NANORV32_UROM_ADDR_MSB+2:0]/4-1;


endmodule // nanorv32_flow_ctrl
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
