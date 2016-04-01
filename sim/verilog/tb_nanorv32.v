//****************************************************************************/
//  Nanorv32 CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Tue Jan 19 21:06:58 2016
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
//  Filename        :  tb_nanorv32.v
//
//  Description     :  Testbench for the nanorv32 core
//
//
//
//****************************************************************************/
`timescale 1ns/1ps
`define AHB_IF

`ifndef VCD_EXTRA_MODULE
`define VCD_EXTRA_MODULE
`endif

`ifdef NTL_SIM
// Xilinx clock system will generate a internal 40MHz from the Arty 100MHz internal clock
`define CLOCK_PERIOD 10
`else
`define CLOCK_PERIOD 25
`endif

module tb_nanorv32;

   `include "nanorv32_parameters.v"
   `include "chip_params.v"
   `include "tb_defines.v"

   parameter ROM_ADDRESS_SIZE  = NANORV32_ADDR_SIZE-1; // Rom is half of the address space


   /*AUTOREG*/
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [15:0]          P0;                     // To/From U_DUT of nanorv32_simpleahb.v
   wire                 clk;                    // From U_CLOCK_GEN of clock_gen.v
   wire                 illegal_instruction;    // From U_DUT of nanorv32_simpleahb.v
   wire                 rst_n;                  // From U_RESET_GEN of reset_gen.v
   // End of automatics

   reg                  reset_a_n;

   reg [15:0]          P1reg;                     // To/From U_DUT of nanorv32_simple.v
   reg                 irq_ext;

   wire                 TCK;
   wire                 TMS;
   wire                 TDI;
   wire                 TDO;


   /* nanorv32_simpleahb AUTO_TEMPLATE(
     .clk_in                  (clk),
     ); */
   nanorv32_simpleahb U_DUT (

                           /*AUTOINST*/
                             // Outputs
                             .illegal_instruction(illegal_instruction),
                             .TDO               (TDO),
                             // Inouts
                             .P0                (P0[15:0]),
                             // Inputs
                             .clk_in            (clk),           // Templated
                             .rst_n             (rst_n),
                             .irq_ext           (irq_ext),
                             .TMS               (TMS),
                             .TCK               (TCK),
                             .TDI               (TDI));









    /* reset_gen AUTO_TEMPLATE(_n
     .reset_n              (rst_n));
     ); */
   reset_gen U_RESET_GEN (
                          /*AUTOINST*/
                          // Outputs
                          .reset_n              (rst_n),         // Templated
                          // Inputs
                          .reset_a_n            (reset_a_n),
                          .clk                  (clk));


    /* clock_gen AUTO_TEMPLATE(
     ); */
   clock_gen #(.period(`CLOCK_PERIOD))
   U_CLOCK_GEN (
                          /*AUTOINST*/
                          // Outputs
                          .clk                  (clk));



   task load_program_memory;
      reg [1024:0] filename;
      reg [7:0]    memory [1<<ROM_ADDRESS_SIZE:0]; // byte type memory
      integer      i;
      reg [31:0]   tmp;
      integer      dummy;

      begin
`ifndef NTL_SIM
         filename = 0;
         dummy = $value$plusargs("program_memory=%s", filename);
         if(filename ==0) begin
            $display("WARNING! No content specified for program memory");
         end
         else begin
            $display("-I- Loading <%s>",filename);
            $readmemh (filename, memory);
            for(i=0; i<((1<<ROM_ADDRESS_SIZE)/4); i=i+1) begin
               tmp[7:0] = memory[i*4+0];
               tmp[15:8] = memory[i*4+1];
               tmp[23:16] = memory[i*4+2];
               tmp[31:24] = memory[i*4+3];

               `CODE_RAM.RAM[i]  = tmp;

            end
         end // else: !if(filename ==0)
`endif
      end
   endtask // load_program_memory

   task vcd_dump;
      begin
         if ($test$plusargs("vcd")) begin
            $display("-I- VCD dump is enabled !");
	    $dumpfile("tb_nanorv32.vcd");
	    $dumpvars(0, tb_nanorv32 `VCD_EXTRA_MODULE);
	 end
      end
   endtask // if






   initial begin
      #1;
`ifndef NTL_SIM
      load_program_memory();
`endif
      vcd_dump();
      #1000000000;
      $display("-I- TEST FAILED Timeout !");
      $finish(2);

   end // initial begin

   initial begin
      #0;
      irq_ext = 0;

      P1reg = 16'h0;
      reset_a_n = 0;
      #10;
      reset_a_n = 1;
   end


`ifndef NTL_SIM
   // PC monitoring
   wire [NANORV32_DATA_MSB:0] pc;
   wire [NANORV32_DATA_MSB:0] x10_a0; // return value register

   assign pc = `CPU.pc_exe_r;
   assign illegal_instruction  = `CPU.illegal_instruction;

   assign x10_a0 = `RF.regfile[10];

   always @(posedge clk) begin
      if(rst_n) begin
         if(illegal_instruction) begin
            $display("-I- TEST FAILED (Illegal instruction)");
            $error;
         end
      else
        if(pc === 32'h00000100) begin
           if(x10_a0 === 32'hCAFFE000) begin
              $display("-I- TEST OK");
              $finish(0);
           end
         else
           if(x10_a0 === 32'hDEADD000) begin
              $display("-I- TEST FAILED");
              $error;
           end
           else begin
              $display("-I- TEST FAILED (unknown reason)");
              $error;
           end
      end // if (pc === 32'h00000100)
      else if (pc === 32'hxxxxxxxx) begin
         $display("-I- TEST FAILED (PC is X)");
         $error;
      end
         end
   end
   // printf support
   event dbg_printf;
   event dbg_printf_flush;
   always @(posedge clk) begin
      if (rst_n) begin
         if(pc === 32'h00000088) begin
            -> dbg_printf;
            $write("%c",x10_a0);
            if(x10_a0 == 10) begin
               $fflush(32'h8000_0001);
               -> dbg_printf_flush;
            end
         end
      end
   end



`define TRACE
`ifdef TRACE
  wire [31:0] pc_r =  U_DUT.U_NANORV32_PIL.U_CPU.pc_exe_r;
  wire [34:0] data = U_DUT.U_NANORV32_PIL.U_CPU.U_DECODER.instruction_for_decode_unit;
  reg [31:0] pc_r_r, addrd_r;
  reg [34:0] data_r;
  reg load_ongoing, store_ongoing;
  wire [4:0]  rd   = U_DUT.U_NANORV32_PIL.U_CPU.regfile_portw;
  wire [4:0]  rd2   = U_DUT.U_NANORV32_PIL.U_CPU.dec_rd2;
  wire [4:0]  rs1  = U_DUT.U_NANORV32_PIL.U_CPU.regfile_port1;
  wire [4:0]  rs2  = U_DUT.U_NANORV32_PIL.U_CPU.regfile_port2;
  wire [10*8-1:0] ascii_chain     ;
  wire [4*8-1:0] reg_to_ascii_rd ;
  wire [4*8-1:0] reg_to_ascii_rd2;
  wire [4*8-1:0] reg_to_ascii_rs1;
  wire [4*8-1:0] reg_to_ascii_rs2;
  reg [10*8-1:0] ascii_chain_r     ;
  reg [4*8-1:0] reg_to_ascii_rd_r ;
  reg [4*8-1:0] reg_to_ascii_rd2_r;
  reg [4*8-1:0] reg_to_ascii_rs1_r;
  reg [4*8-1:0] reg_to_ascii_rs2_r;

  reg [7:0]     fifo_pt;
  reg [31:0]    fifo_pc_r    [7:0];
  reg [31:0]    fifo_data    [7:0];
  reg [10*8-1:0] fifo_ascii_chain[7:0];
  reg [4*8-1:0] fifo_reg_to_ascii_rd[7:0];
  reg [4*8-1:0] fifo_reg_to_ascii_rs1[7:0];
  reg [4*8-1:0] fifo_reg_to_ascii_rs2[7:0];
  reg [31:0]    fifo_cur_time[7:0];
  reg [31:0]    fifo_rd[7:0]  ;
  reg [7:0]     fifo_write_rd;
   reg [1024:0] trace_filename = "trace.txt";

   task trace;
      integer dummy;
      begin
         if ($test$plusargs("trace")) begin
            dummy = $value$plusargs("trace=%s", trace_filename);
            $display("-I- Trace file : %s  !",trace_filename);
         end
      end
   endtask // load_program_memory



  nanorv32_ascii u_ascii(
     .ascii_chain (ascii_chain),
     .reg_to_ascii_rd (reg_to_ascii_rd),
     .reg_to_ascii_rd2 (reg_to_ascii_rd2),
     .reg_to_ascii_rs1 (reg_to_ascii_rs1),
     .reg_to_ascii_rs2 (reg_to_ascii_rs2),
     .instruction_r (data),
     .reg_rd        (rd),
     .reg_rd2       (rd2),
     .reg_rs1       (rs1),
     .reg_rs2       (rs2)

  );
  genvar i;
  integer f;
  integer cur_time;
  initial


    begin
       trace();
      f = $fopen(trace_filename,"w");
    end


   always @ (posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
           load_ongoing <= 1'b0;
           store_ongoing <= 1'b0;
        end
        else begin
          cur_time = $time;
          if (load_ongoing & U_DUT.U_NANORV32_PIL.U_CPU.hreadyd) begin
             $fwrite(f,"PC : 0x%08x I : 0x%08x : %s :",pc_r_r, data_r[31:0], ascii_chain_r) ;
             if (U_DUT.U_NANORV32_PIL.U_CPU.write_rd2)
               $fwrite(f," RF[%s] <= 0x%x MEM[0x%x] :",reg_to_ascii_rd2, U_DUT.U_NANORV32_PIL.U_CPU.rd2, addrd_r ) ;
             $fwrite(f," %s, %s, %s %d ns ",reg_to_ascii_rd_r, reg_to_ascii_rs1_r, reg_to_ascii_rs2_r,cur_time);
             $fwrite(f,"\n");
             load_ongoing <= 1'b0;
             end
          if (store_ongoing & U_DUT.U_NANORV32_PIL.U_CPU.hreadyd) begin
             $fwrite(f,"PC : 0x%08x I : 0x%08x : %s :",pc_r_r, data_r[31:0], ascii_chain_r) ;
             $fwrite(f,"  MEM[0x%x] <= RF[%s] : 0x%x : %d ns",addrd_r, reg_to_ascii_rs2_r, U_DUT.U_NANORV32_PIL.U_CPU.hwdatad, cur_time);
             $fwrite(f,"\n");
             store_ongoing <= 1'b0;
             end
          if ((load_ongoing || store_ongoing) & U_DUT.U_NANORV32_PIL.U_CPU.hreadyd & fifo_pt >= 3) begin
                 $fwrite(f,"PC : 0x%08x I : 0x%08x : %s :",fifo_pc_r[2], fifo_data[2][31:0], fifo_ascii_chain[2]) ;
                 if (fifo_write_rd[3])
                   $fwrite(f," RF[%s] <= 0x%x :",fifo_reg_to_ascii_rd[2], fifo_rd[2] ) ;
                 $fwrite(f," %s, %s, %s %d ns ",fifo_reg_to_ascii_rd[2], fifo_reg_to_ascii_rs1[2], fifo_reg_to_ascii_rs2[2],fifo_cur_time[2]);
                 $fwrite(f,"\n");
          end
          if ((load_ongoing || store_ongoing) & U_DUT.U_NANORV32_PIL.U_CPU.hreadyd & fifo_pt >= 2) begin
                 $fwrite(f,"PC : 0x%08x I : 0x%08x : %s :",fifo_pc_r[1], fifo_data[1][31:0], fifo_ascii_chain[1]) ;
                 if (fifo_write_rd[1])
                   $fwrite(f," RF[%s] <= 0x%x :",fifo_reg_to_ascii_rd[1], fifo_rd[1] ) ;
                 $fwrite(f," %s, %s, %s %d ns ",fifo_reg_to_ascii_rd[1], fifo_reg_to_ascii_rs1[1], fifo_reg_to_ascii_rs2[1],fifo_cur_time[1]);
                 $fwrite(f,"\n");
          end
          if ((load_ongoing || store_ongoing) & U_DUT.U_NANORV32_PIL.U_CPU.hreadyd & fifo_pt >= 1) begin
                 $fwrite(f,"PC : 0x%08x I : 0x%08x : %s :",fifo_pc_r[0], fifo_data[0][31:0], fifo_ascii_chain[0]) ;
                 if (fifo_write_rd[0])
                   $fwrite(f," RF[%s] <= 0x%x :",fifo_reg_to_ascii_rd[0], fifo_rd[0] ) ;
                 $fwrite(f," %s, %s, %s %d ns ",fifo_reg_to_ascii_rd[0], fifo_reg_to_ascii_rs1[0], fifo_reg_to_ascii_rs2[0],fifo_cur_time[0]);
                 $fwrite(f,"\n");
          end
          if (U_DUT.U_NANORV32_PIL.U_CPU.inst_ret && ~(U_DUT.U_NANORV32_PIL.U_CPU.htransd) && (~(load_ongoing || store_ongoing) || (load_ongoing || store_ongoing) && U_DUT.U_NANORV32_PIL.U_CPU.hreadyd))
             begin
             $fwrite(f,"PC : 0x%08x I : 0x%08x : %s :",pc_r, data[31:0], ascii_chain) ;
             if (U_DUT.U_NANORV32_PIL.U_CPU.write_rd)
               $fwrite(f," RF[%s] <= 0x%x :",reg_to_ascii_rd, U_DUT.U_NANORV32_PIL.U_CPU.rd ) ;
             $fwrite(f," %s, %s, %s %d ns ",reg_to_ascii_rd, reg_to_ascii_rs1, reg_to_ascii_rs2,cur_time);
             $fwrite(f,"\n");
             end
          else
          if (U_DUT.U_NANORV32_PIL.U_CPU.inst_ret && ~(U_DUT.U_NANORV32_PIL.U_CPU.htransd) && ((load_ongoing || store_ongoing ) & ~U_DUT.U_NANORV32_PIL.U_CPU.hreadyd))
             begin
             // push in fifo , waiting the store or load to release
             fifo_pc_r[fifo_pt]             <= pc_r;
             fifo_data[fifo_pt]             <= data;
             fifo_ascii_chain[fifo_pt]      <= ascii_chain;
             fifo_reg_to_ascii_rd[fifo_pt]  <= reg_to_ascii_rd;
             fifo_reg_to_ascii_rs1[fifo_pt] <= reg_to_ascii_rs1;
             fifo_reg_to_ascii_rs2[fifo_pt] <= reg_to_ascii_rs2;
             fifo_cur_time[fifo_pt]         <= cur_time;
             fifo_rd[fifo_pt]               <= U_DUT.U_NANORV32_PIL.U_CPU.rd;
             fifo_write_rd[fifo_pt]         <= U_DUT.U_NANORV32_PIL.U_CPU.write_rd;
             fifo_pt                        <= fifo_pt + 1;
             end
          else
          if (U_DUT.U_NANORV32_PIL.U_CPU.inst_ret && (U_DUT.U_NANORV32_PIL.U_CPU.htransd && ~U_DUT.U_NANORV32_PIL.U_CPU.hwrited && U_DUT.U_NANORV32_PIL.U_CPU.hreadyd))
          begin
             pc_r_r <= pc_r;
             data_r <= data;
             addrd_r <= U_DUT.U_NANORV32_PIL.U_CPU.haddrd;
             ascii_chain_r <= ascii_chain;
             reg_to_ascii_rd_r  <= reg_to_ascii_rd;
             reg_to_ascii_rs1_r <= reg_to_ascii_rs1;
             reg_to_ascii_rs2_r <= reg_to_ascii_rs2;
             load_ongoing       <= (U_DUT.U_NANORV32_PIL.U_CPU.htransd && ~U_DUT.U_NANORV32_PIL.U_CPU.hwrited);
             fifo_pt             <= 8'h0;
          end
          if (U_DUT.U_NANORV32_PIL.U_CPU.inst_ret && (U_DUT.U_NANORV32_PIL.U_CPU.htransd && U_DUT.U_NANORV32_PIL.U_CPU.hwrited && U_DUT.U_NANORV32_PIL.U_CPU.hreadyd))
          begin
             pc_r_r <= pc_r;
             data_r <= data;
             addrd_r <= U_DUT.U_NANORV32_PIL.U_CPU.haddrd;
             ascii_chain_r <= ascii_chain;
             reg_to_ascii_rd_r  <= reg_to_ascii_rd;
             reg_to_ascii_rs1_r <= reg_to_ascii_rs1;
             reg_to_ascii_rs2_r <= reg_to_ascii_rs2;
             store_ongoing       <= (U_DUT.U_NANORV32_PIL.U_CPU.htransd && U_DUT.U_NANORV32_PIL.U_CPU.hwrited);
             fifo_pt             <= 8'h0;
          end
        end
     end

`endif
`endif //  `ifndef NTL_SIM


endmodule // tb_nanorv32
/*
 Local Variables:
 verilog-library-directories:(
 "."
 "../../rtl/cores"
 "../../rtl/chips"
 )
 End:
 */
