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
   portb, porta, alu_res, alu_cond, cpu_codemem_addr,
   cpu_codemem_valid, cpu_datamem_addr, cpu_datamem_wdata,
   cpu_datamem_bytesel, cpu_datamem_valid,
   // Inputs
   write_rd, sel_rd, sel_portb, sel_porta, rd, alu_portb, alu_porta,
   alu_cond_sel, codemem_cpu_rdata, codemem_cpu_ready,
   datamem_cpu_rdata, datamem_cpu_ready, rst_n, clk
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
   // Beginning of automatic inputs (from unused autoinst inputs)
   input [NANORV32_MUX_SEL_ALU_COND_MSB:0] alu_cond_sel;// To U_ALU of nanorv32_alu.v
   input [NANORV32_WORD_MSB:0] alu_porta;       // To U_ALU of nanorv32_alu.v
   input [NANORV32_WORD_MSB:0] alu_portb;       // To U_ALU of nanorv32_alu.v
   input [NANORV32_WORD_MSB:0] rd;              // To U_REG_FILE of nanorv32_regfile.v
   input [NANORV32_PORTA_MSB:0] sel_porta;      // To U_REG_FILE of nanorv32_regfile.v
   input [NANORV32_RD_OR_PORTB_MSB:0] sel_portb;// To U_REG_FILE of nanorv32_regfile.v
   input [NANORV32_RD_OR_PORTB_MSB:0] sel_rd;   // To U_REG_FILE of nanorv32_regfile.v
   input                write_rd;               // To U_REG_FILE of nanorv32_regfile.v
   // End of automatics
   /*AUTOOUTPUT*/
   // Beginning of automatic outputs (from unused autoinst outputs)
   output               alu_cond;               // From U_ALU of nanorv32_alu.v
   output [NANORV32_WORD_MSB:0] alu_res;        // From U_ALU of nanorv32_alu.v
   output [NANORV32_WORD_MSB:0] porta;          // From U_REG_FILE of nanorv32_regfile.v
   output [NANORV32_WORD_MSB:0] portb;          // From U_REG_FILE of nanorv32_regfile.v
   // End of automatics

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


   //@begin[mux_select_declarations]
   //@end[mux_select_declarations]

   //@begin[instruction_fields]
   //@end[instruction_fields]



   // Immediate value reconstruction
   wire [NRV32_DATA_MSB:0]                   imm20_sext;
   wire [NRV32_DATA_MSB:0]                   imm12_sext;
   wire [NRV32_DATA_MSB:0]                   imm12hilo_sext;
   wire [NRV32_DATA_MSB:0]                   immsb_sext;
   wire [NRV32_DATA_MSB:0]                   immu_sext;
   wire [NRV32_DATA_MSB:0]                   immuj_sext;

   assign imm20_sext = {dec_imm20[19:0],12'b0};
   assign imm12_sext = {{20{dec_imm12 [11]}},dec_imm12[11:0]};
   assign imm12hilo_sext = {{20{dec_imm12hi[6]}},dec_imm12hi[6:0],dec_imm12lo[4:0]};
   assign immsb_sext = {{20{dec_immsb2[6]}},dec_immsb2[6],dec_immsb1[0],dec_immsb2[5:0],dec_immsb1[4:1],1'b0};

   // Fixme - incomplete/wrong


   assign immu_sext = {dec_imm20uj[19:0],20'b0};

   assign immuj_sext = {{12{dec_imm20uj[19]}},
                        dec_imm20uj[19],
                        dec_imm20uj[7:3],
                        dec_imm20uj[2:0],
                        dec_imm20uj[8],
                        dec_imm20uj[18:13],
                        dec_imm20uj[12:9],
                        1'b0};


   always @* begin
      casez(instruction[NANORV32_INSTRUCTION_MSB:0])
        //@begin[instruction_decoder]
        //@end[instruction_decoder]
      endcase // casez (instruction[NANORV32_INSTRUCTION_MSB:0])
   end


   //===========================================================================
   // ALU input selection
   //===========================================================================
   always @* begin
      case(alu_portb)
        NANORV32_MUX_SEL_ALU_PORTB_IMM20: begin
           alu_portb <= imm20_sext;
        end
        NANORV32_MUX_SEL_ALU_PORTB_SHAMT: begin
           alu_portb <= ;
        end
        NANORV32_MUX_SEL_ALU_PORTB_IMM12: begin
           alu_portb <= ;
        end
        NANORV32_MUX_SEL_ALU_PORTB_RS2: begin
           alu_portb <= ;
        end
        NANORV32_MUX_SEL_ALU_PORTB_IMM20UJ: begin
           alu_portb <= ;
        end
        default:
      endcase
   end

   always @* begin
      case(alu_porta)
        NANORV32_MUX_SEL_ALU_PORTA_PC: begin
           alu_porta <= ;
        end
        NANORV32_MUX_SEL_ALU_PORTA_RS1: begin
           alu_porta <= ;
        end// Mux definitions for datamem
        default:
      endcase
   end

   //===========================================================================
   // Register file write-back
   //===========================================================================
   always @* begin
      case(regfile_source)
        NANORV32_MUX_SEL_REGFILE_SOURCE_NEXT_PC: begin
           regfile_source <= ;
        end
        NANORV32_MUX_SEL_REGFILE_SOURCE_ALU: begin
           regfile_source <= ;
        end
        default:
      endcase
   end // always @ *

   always @* begin
      case(regfile_write)
        NANORV32_MUX_SEL_REGFILE_WRITE_YES: begin
           regfile_write <= ;
        end
        NANORV32_MUX_SEL_REGFILE_WRITE_NO: begin
           regfile_write <= ;
        end
        default:
      endcase // case (regfile_write)

   end

   //===========================================================================
   // Data memory interface
   //===========================================================================

   always @* begin
      case(datamem_read)
        NANORV32_MUX_SEL_DATAMEM_READ_YES: begin
           datamem_read <= ;
        end
        NANORV32_MUX_SEL_DATAMEM_READ_NO: begin
           datamem_read <= ;
        end
        default:
      endcase
   end

   always @* begin
      case(regfile_write)
        NANORV32_MUX_SEL_REGFILE_WRITE_YES: begin
           regfile_write <= ;
        end
        NANORV32_MUX_SEL_REGFILE_WRITE_NO: begin
           regfile_write <= ;
        end
        default:
      endcase
   end




    /* nanorv32_regfile AUTO_TEMPLATE(
     ); */
   nanorv32_regfile U_REG_FILE (
                           /*AUTOINST*/
                                // Outputs
                                .porta          (porta[NANORV32_WORD_MSB:0]),
                                .portb          (portb[NANORV32_WORD_MSB:0]),
                                // Inputs
                                .sel_porta      (sel_porta[NANORV32_PORTA_MSB:0]),
                                .sel_portb      (sel_portb[NANORV32_RD_OR_PORTB_MSB:0]),
                                .sel_rd         (sel_rd[NANORV32_RD_OR_PORTB_MSB:0]),
                                .rd             (rd[NANORV32_WORD_MSB:0]),
                                .write_rd       (write_rd),
                                .clk            (clk),
                                .rst_n          (rst_n));



    /* nanorv32_alu AUTO_TEMPLATE(
     ); */
   nanorv32_alu U_ALU (
                       .alu_op_sel      (alu_op_sel[NANORV32_MUX_SEL_ALU_OP_MSB:0]),
                           /*AUTOINST*/
                       // Outputs
                       .alu_res         (alu_res[NANORV32_WORD_MSB:0]),
                       .alu_cond        (alu_cond),
                       // Inputs
                       .alu_porta       (alu_porta[NANORV32_WORD_MSB:0]),
                       .alu_portb       (alu_portb[NANORV32_WORD_MSB:0]),
                       .alu_cond_sel    (alu_cond_sel[NANORV32_MUX_SEL_ALU_COND_MSB:0]));




endmodule // nanorv32
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
