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
//  Description     :   Nanorv32 CPU top file
//
//
//
//****************************************************************************/




module nanorv32 (/*AUTOARG*/
   // Outputs
   alu_res, alu_cond, cpu_codemem_addr, cpu_codemem_valid,
   cpu_datamem_addr, cpu_datamem_wdata, cpu_datamem_bytesel,
   cpu_datamem_valid,
   // Inputs
   sel_rd, sel_portb, sel_porta, rd, alu_portb, alu_porta,
   codemem_cpu_rdata, codemem_cpu_ready, datamem_cpu_rdata,
   datamem_cpu_ready, rst_n, clk
   );

`include "nanorv32_parameters.v"

   // Code memory interface
   output [NANORV32_ADDR_MSB:0] cpu_codemem_addr;
   output                    cpu_codemem_valid;
   input  [NANORV32_DATA_MSB:0] codemem_cpu_rdata;
   input                     codemem_cpu_ready;

   // Data memory interface

   output [NANORV32_ADDR_MSB:0] cpu_datamem_addr;
   output [NANORV32_DATA_MSB:0] cpu_datamem_wdata;
   output [3:0]              cpu_datamem_bytesel;
   output                    cpu_datamem_valid;
   input [NANORV32_DATA_MSB:0]  datamem_cpu_rdata;
   input                     datamem_cpu_ready;

   input                     rst_n;
   input                     clk;

   /*AUTOINPUT*/
   // Beginning of automatic inputs (from unused autoinst inputs)
   input [NANORV32_DATA_MSB:0] alu_porta;       // To U_ALU of nanorv32_alu.v
   input [NANORV32_DATA_MSB:0] alu_portb;       // To U_ALU of nanorv32_alu.v
   input [NANORV32_DATA_MSB:0] rd;              // To U_REG_FILE of nanorv32_regfile.v
   input [NANORV32_RF_PORTA_MSB:0] sel_porta;   // To U_REG_FILE of nanorv32_regfile.v
   input [NANORV32_RF_PORTB_MSB:0] sel_portb;   // To U_REG_FILE of nanorv32_regfile.v
   input [NANORV32_RF_PORTRD_MSB:0] sel_rd;     // To U_REG_FILE of nanorv32_regfile.v
   // End of automatics
   /*AUTOOUTPUT*/
   // Beginning of automatic outputs (from unused autoinst outputs)
   output               alu_cond;               // From U_ALU of nanorv32_alu.v
   output [NANORV32_DATA_MSB:0] alu_res;        // From U_ALU of nanorv32_alu.v
   // End of automatics

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [NANORV32_ADDR_MSB:0] cpu_codemem_addr;
   reg                  cpu_codemem_valid;
   reg [NANORV32_ADDR_MSB:0] cpu_datamem_addr;
   reg [3:0]            cpu_datamem_bytesel;
   reg                  cpu_datamem_valid;
   reg [NANORV32_DATA_MSB:0] cpu_datamem_wdata;
   // End of automatics
   /*AUTOWIRE*/


   //@begin[mux_select_declarations]
   //@end[mux_select_declarations]

   //@begin[instruction_fields]
   //@end[instruction_fields]

   reg                                       write_rd;
   reg                                       datamem_read;
   reg                                       datamem_write;

   reg [NANORV32_DATA_MSB:0]                pc_exe;
   reg [NANORV32_DATA_MSB:0]                next_pc;

   reg [NANORV32_DATA_MSB:0]                instruction_r;

   wire [NANORV32_DATA_MSB:0]               rf_porta;
   wire [NANORV32_DATA_MSB:0]               rf_portb;

   wire [NANORV32_DATA_MSB:0]               pc_next;
   wire [NANORV32_DATA_MSB:0]               pc_fetch_r;
   wire [NANORV32_DATA_MSB:0]               pc_exe_r;  // Fixme - we track the PC for the exe stage explicitly
                                                       // this may not be optimal in term of size



   //===========================================================================
   // Immediate value reconstruction
   //===========================================================================

   wire [NANORV32_DATA_MSB:0]                   imm12_sext;
   wire [NANORV32_DATA_MSB:0]                   imm12hilo_sext;
   wire [NANORV32_DATA_MSB:0]                   imm12sb_sext;
   wire [NANORV32_DATA_MSB:0]                   imm20u_sext;
   wire [NANORV32_DATA_MSB:0]                   imm20uj_sext;

   assign imm12_sext = {{20{dec_imm12 [11]}},dec_imm12[11:0]};
   assign imm12hilo_sext = {{20{dec_imm12hi[6]}},dec_imm12hi[6:0],dec_imm12lo[4:0]};
   assign imm12sb_sext = {{20{dec_immsb2[6]}},dec_immsb2[6],dec_immsb1[0],dec_immsb2[5:0],dec_immsb1[4:1],1'b0};

   // Fixme - incomplete/wrong


   assign imm20u_sext = {dec_imm20uj[19:0],20'b0};

   assign imm20uj_sext = {{12{dec_imm20uj[19]}},
                        dec_imm20uj[19],
                        dec_imm20uj[7:3],
                        dec_imm20uj[2:0],
                        dec_imm20uj[8],
                        dec_imm20uj[18:13],
                        dec_imm20uj[12:9],
                        1'b0};




   //===========================================================================
   // Instruction register / decoding
   //===========================================================================

   always @(posedge clk or negedge rst_n) begin
      if(rst_n == 1'b0) begin
         /*AUTORESET*/
         // Beginning of autoreset for uninitialized flops
         instruction_r <= {(1+(NANORV32_DATA_MSB)){1'b0}};
         // End of automatics
      end
      else begin
         instruction_r <= codemem_cpu_rdata;
      end
   end



   always @* begin
      casez(instruction_r[NANORV32_INSTRUCTION_MSB:0])
        //@begin[instruction_decoder]
        //@end[instruction_decoder]
      endcase // casez (instruction[NANORV32_INSTRUCTION_MSB:0])
   end


   //===========================================================================
   // ALU input selection
   //===========================================================================
   always @* begin
      case(alu_portb)
        NANORV32_MUX_SEL_ALU_PORTB_IMM20U: begin
           alu_portb <= imm20u_sext;
        end
        NANORV32_MUX_SEL_ALU_PORTB_SHAMT: begin
           alu_portb <= {{NANORV32_SHAMT_FILL{1'b0}},dec_shamt};
        end
        NANORV32_MUX_SEL_ALU_PORTB_IMM12: begin
           alu_portb <= imm12_sext;
        end
        NANORV32_MUX_SEL_ALU_PORTB_RS2: begin
           alu_portb <= rf_portb;
        end
        NANORV32_MUX_SEL_ALU_PORTB_IMM20UJ: begin
           alu_portb <= imm20uj_sext;
        end
        NANORV32_MUX_SEL_ALU_PORTB_IMM12HILO: begin
           alu_portb <= imm12hilo_sext;
        end
        // default:
      endcase
   end

   always @* begin
      case(alu_porta)
        NANORV32_MUX_SEL_ALU_PORTA_PC: begin
           alu_porta <= pc_exe;
        end
        NANORV32_MUX_SEL_ALU_PORTA_RS1: begin
           alu_porta <= rf_porta;
        end// Mux definitions for datamem
        // default:
      endcase
   end

   //===========================================================================
   // Register file write-back
   //===========================================================================
   always @* begin
      case(regfile_source_sel)
        NANORV32_MUX_SEL_REGFILE_SOURCE_NEXT_PC: begin
           rd <= next_pc;
        end
        NANORV32_MUX_SEL_REGFILE_SOURCE_ALU: begin
           rd <= alu_res;
        end
        // default:
      endcase
   end // always @ *

   always @* begin
      case(regfile_write_sel)
        NANORV32_MUX_SEL_REGFILE_WRITE_YES: begin
           write_rd <= 1'b1;
        end
        NANORV32_MUX_SEL_REGFILE_WRITE_NO: begin
           write_rd <= 1'b0;
        end
        // default:
      endcase // case (regfile_write)

   end

   //===========================================================================
   // Data memory interface
   //===========================================================================

   always @* begin
      case(datamem_read_sel)
        NANORV32_MUX_SEL_DATAMEM_READ_YES: begin
           datamem_read <= 1'b0;
        end
        NANORV32_MUX_SEL_DATAMEM_READ_NO: begin
           datamem_read <= 1'b1;
        end
        // default:
      endcase
   end

   always @* begin
      case(datamem_write_sel)
        NANORV32_MUX_SEL_DATAMEM_WRITE_YES: begin
           datamem_write <= 1'b0;
        end
        NANORV32_MUX_SEL_DATAMEM_WRITE_NO: begin
           datamem_write <= 1'b1;
        end
        // default:
      endcase
   end



   //===========================================================================
   // PC management
   //===========================================================================
   always @* begin
      case(pc_next)
        NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB: begin
           pc_next <= alu_cond ? (pc_exe + imm12sb_sext) : (pc_fetch_r + 4);
        end
        NANORV32_MUX_SEL_PC_NEXT_PLUS4: begin
           pc_next <= pc_fetch_r + 4; // Only 32-bit instruction for now
        end
        NANORV32_MUX_SEL_PC_NEXT_ALU_RES: begin
           pc_next <= alu_res;
        end// Mux definitions for alu
        // default:
      endcase
   end

   always @(posedge clk or negedge rst_n) begin
      if(rst_n == 1'b0) begin
         /*AUTORESET*/
         // Beginning of autoreset for uninitialized flops
         pc_exe_r <= {(1+(NANORV32_DATA_MSB)){1'b0}};
         pc_fetch_r <= {(1+(NANORV32_DATA_MSB)){1'b0}};
         // End of automatics
      end
      else begin
         pc_fetch_r <= pc_next;
         pc_exe_r  <= pc_fetch_r;
      end
   end





    /* nanorv32_regfile AUTO_TEMPLATE(
     ); */
   nanorv32_regfile #(.NUM_REGS(32))
   U_REG_FILE (
               .porta          (rf_porta[NANORV32_DATA_MSB:0]),
               .portb          (rf_portb[NANORV32_DATA_MSB:0]),
               /*AUTOINST*/
               // Inputs
               .sel_porta               (sel_porta[NANORV32_RF_PORTA_MSB:0]),
               .sel_portb               (sel_portb[NANORV32_RF_PORTB_MSB:0]),
               .sel_rd                  (sel_rd[NANORV32_RF_PORTRD_MSB:0]),
               .rd                      (rd[NANORV32_DATA_MSB:0]),
               .write_rd                (write_rd),
               .clk                     (clk),
               .rst_n                   (rst_n));



    /* nanorv32_alu AUTO_TEMPLATE(
     ); */
   nanorv32_alu U_ALU (
                       .alu_op_sel      (alu_op_sel[NANORV32_MUX_SEL_ALU_OP_MSB:0]),
                           /*AUTOINST*/
                       // Outputs
                       .alu_res         (alu_res[NANORV32_DATA_MSB:0]),
                       .alu_cond        (alu_cond),
                       // Inputs
                       .alu_porta       (alu_porta[NANORV32_DATA_MSB:0]),
                       .alu_portb       (alu_portb[NANORV32_DATA_MSB:0]));




endmodule // nanorv32
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
