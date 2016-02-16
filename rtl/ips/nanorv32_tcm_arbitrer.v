//****************************************************************************/
//  NANORV32 CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Wed Feb  3 08:30:09 2016
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
//  Filename        :  nanorv32_tcm_arbitrer.v
//
//  Description     :  Arbitrer between code and ram TCM memories for nanorv32_simple.v
//
//
//
//****************************************************************************/


module nanorv32_tcm_arbitrer (/*AUTOARG*/
   // Outputs
   tcmcode_addr, tcmcode_bytesel, tcmcode_din, tcmcode_en,
   tcmdata_addr, tcmdata_bytesel, tcmdata_din, tcmdata_en,
   periph_addr, periph_bytesel, periph_din, periph_en,
   codeif_cpu_rdata, codeif_cpu_early_ready, codeif_cpu_ready_r,
   dataif_cpu_rdata, dataif_cpu_early_ready, dataif_cpu_ready_r,
   // Inputs
   rst_n, clk, tcmcode_dout, tcmcode_ready_nxt, tcmdata_dout,
   tcmdata_ready_nxt, periph_dout, periph_ready_nxt, cpu_codeif_addr,
   cpu_codeif_req, cpu_dataif_addr, cpu_dataif_wdata,
   cpu_dataif_bytesel, cpu_dataif_req
   );
   parameter ADDR_WIDTH = 12;

`include "nanorv32_parameters.v"
   input rst_n;
   input clk;


   // TCM code signals
   output [ADDR_WIDTH-1:0]  tcmcode_addr;           // To U_TCM_CODE of nanorv32_tcm_ctrl.v
   output [3:0]             tcmcode_bytesel;        // To U_TCM_CODE of nanorv32_tcm_ctrl.v
   output [NANORV32_DATA_MSB:0] tcmcode_din;        // To U_TCM_CODE of nanorv32_tcm_ctrl.v
   output                       tcmcode_en;             // To U_TCM_CODE of nanorv32_tcm_ctrl.v
   input [NANORV32_DATA_MSB:0] tcmcode_dout;   // From U_TCM_CODE of nanorv32_tcm_ctrl.v
   input                       tcmcode_ready_nxt;      // From U_TCM_CODE of nanorv32_tcm_ctrl.v

   // TCM data signals
   output [ADDR_WIDTH-1:0]     tcmdata_addr;           // To U_TCM_DATA of nanorv32_tcm_ctrl.v
   output [3:0]                tcmdata_bytesel;        // To U_TCM_DATA of nanorv32_tcm_ctrl.v
   output [NANORV32_DATA_MSB:0] tcmdata_din;        // To U_TCM_DATA of nanorv32_tcm_ctrl.v
   output                       tcmdata_en;             // To U_TCM_DATA of nanorv32_tcm_ctrl.v
   input [NANORV32_DATA_MSB:0] tcmdata_dout;   // From U_TCM_DATA of nanorv32_tcm_ctrl.v
   input                       tcmdata_ready_nxt;      // From U_TCM_DATA of nanorv32_tcm_ctrl.v


   // Peripheral bus
   output [ADDR_WIDTH-1:0]     periph_addr;           // To U_TCM_DATA of nanorv32_tcm_ctrl.v
   output [3:0]                periph_bytesel;        // To U_TCM_DATA of nanorv32_tcm_ctrl.v
   output [NANORV32_DATA_MSB:0] periph_din;        // To U_TCM_DATA of nanorv32_tcm_ctrl.v
   output                       periph_en;             // To U_TCM_DATA of nanorv32_tcm_ctrl.v
   input [NANORV32_DATA_MSB:0]  periph_dout;   // From U_TCM_DATA of nanorv32_tcm_ctrl.v
   input                        periph_ready_nxt;      // From U_TCM_DATA of nanorv32_tcm_ctrl.v

   // CPU Code memory interface
   input [NANORV32_DATA_MSB:0] cpu_codeif_addr;
   input                       cpu_codeif_req;
   output [NANORV32_DATA_MSB:0]  codeif_cpu_rdata;
   output                        codeif_cpu_early_ready;
   output                        codeif_cpu_ready_r;

   // Data memory interface

   input [NANORV32_DATA_MSB:0] cpu_dataif_addr;
   input [NANORV32_DATA_MSB:0] cpu_dataif_wdata;
   input [3:0]                 cpu_dataif_bytesel;
   input                       cpu_dataif_req;
   output [NANORV32_DATA_MSB:0]  dataif_cpu_rdata;
   output                        dataif_cpu_early_ready;
   output                        dataif_cpu_ready_r;


   //   data_data   data_code  code_data  code_code                               mux_data   mux_code
   //       1          0          0          1       : std access no conflict        0          0
   //       1          0          1          0       : data cpu port wins            0
   //       0          1          1          0       : cross
   //       0          1          0          1       : data cpu port wins
   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg                  codeif_cpu_early_ready;
   reg                  codeif_cpu_ready_r;
   reg                  dataif_cpu_early_ready;
   reg                  dataif_cpu_ready_r;
   reg [ADDR_WIDTH-1:0] periph_addr;
   reg [3:0]            periph_bytesel;
   reg [NANORV32_DATA_MSB:0] periph_din;
   reg                  periph_en;
   reg [ADDR_WIDTH-1:0] tcmcode_addr;
   reg [3:0]            tcmcode_bytesel;
   reg [NANORV32_DATA_MSB:0] tcmcode_din;
   reg                  tcmcode_en;
   reg [ADDR_WIDTH-1:0] tcmdata_addr;
   reg [3:0]            tcmdata_bytesel;
   reg [NANORV32_DATA_MSB:0] tcmdata_din;
   reg                  tcmdata_en;
   // End of automatics
   /*AUTOWIRE*/

   wire [NANORV32_DATA_MSB:0] codeif_cpu_rdata;
   wire [NANORV32_DATA_MSB:0] dataif_cpu_rdata;

   wire [NANORV32_DATA_MSB:0] periph_tcmdata_rdata;


   reg cpu_data_data_access; // Data access (Load/store) to Data space
   reg cpu_data_code_access; // Data access (Load/store) to Code space
   reg cpu_data_periph_access; // Data access (Load/store) to Periph space

   reg cpu_code_data_access; // Code access (Program fetch) to Data space
   reg cpu_code_code_access; // Code access (Program fetch) to Code space
   reg cpu_code_periph_access; // Code access (Program fetch) to Periph space (Forbidden ?)

   // Address space decoding
   always @(*) begin
      case(cpu_dataif_addr[31:28])
        4'h0: begin
           // Code access - not supported yet
           cpu_data_data_access = 0;
           cpu_data_code_access = cpu_dataif_req;
           cpu_data_periph_access = 0;
        end
        4'h2: begin
           // Data RAM access
           cpu_data_data_access = cpu_dataif_req;
           cpu_data_code_access = 0;
           cpu_data_periph_access = 0;
        end
        4'hF: begin
           // Peripheral access
           cpu_data_data_access = 0;
           cpu_data_code_access = 0;
           cpu_data_periph_access = cpu_dataif_req;
        end
        default: begin
           cpu_data_data_access = 0;
           cpu_data_code_access = 0;
           cpu_data_periph_access = cpu_dataif_req;
        end
      endcase
   end // always @ *

   always @* begin
      case(cpu_codeif_addr[31:28])
        4'h0: begin
           // Code access
           cpu_code_data_access = 0;
           cpu_code_code_access = cpu_codeif_req;
           cpu_code_periph_access = 0;
        end
        4'h2: begin
           // Data RAM access
           cpu_code_data_access = cpu_codeif_req;
           cpu_code_code_access = 0;
           cpu_code_periph_access = 0;
        end
        4'hF: begin
           // Peripheral access
           cpu_code_data_access = 0;
           cpu_code_code_access = 0;
           cpu_code_periph_access = 0; // Simplification - no code access to peripheral space cpu_codeif_req;
        end
        default: begin
           cpu_code_data_access = 0;
           cpu_code_code_access = 0;
           cpu_code_periph_access = 0;
        end
      endcase
   end



   // assign periph_dout = 0;

   // Priority between data and code access
   //   data_data   data_code  code_data  code_code
   //1       1          0          0          1       : std access no conflict
   //2       1          0          1          0       : data cpu port wins
   //3       0          1          1          0       : cross
   //4       0          1          0          1       : data cpu port wins
   //5       0          0          1          0       :
   //6      0          1          0          0

   // dout busses need to be muxed *after* the clock edge
   reg swap_dout_a;
   reg swap_dout_r;
   event dbg_evt1,dbg_evt2,dbg_evt3,dbg_evt4;
   event dbg_evt5,dbg_evt6;
   integer debug;

   // For Code TCM
   always @* begin



      if(cpu_data_data_access & cpu_code_data_access) begin


         // CPU code port try to access data ram while CPU data port is accessing it
         // line #2 in the table above
         codeif_cpu_early_ready = 0; // Instruction fetch has to wait
         debug =1;


      end
      else if(cpu_data_code_access & cpu_code_data_access) begin
         debug =2;
         swap_dout_a = 1;

         // codeif_cpu_rdata[NANORV32_DATA_MSB:0] = tcmdata_dout[NANORV32_DATA_MSB:0];
         // crossing signals
         codeif_cpu_early_ready = tcmdata_ready_nxt;
         tcmdata_addr = cpu_codeif_addr[ADDR_WIDTH-1:0];
         tcmdata_din  = 0; // code interface reads only
         tcmdata_bytesel  = 0;
         tcmdata_en       = cpu_codeif_req;

         // dataif_cpu_rdata[NANORV32_DATA_MSB:0] = tcmcode_dout[NANORV32_DATA_MSB:0];
         dataif_cpu_early_ready = tcmcode_ready_nxt;
         tcmcode_addr = cpu_dataif_addr[ADDR_WIDTH-1:0];
         tcmcode_din  = cpu_dataif_wdata;
         tcmcode_bytesel  = cpu_dataif_bytesel;
         tcmcode_en       = cpu_dataif_req;
      end
      else if(cpu_data_code_access & cpu_code_code_access) begin
         debug =3;
         // CPU code port try to access code ram while CPU data port is accessing it
         // line #4 in the table above
         swap_dout_a = 1;

         // dataif_cpu_rdata[NANORV32_DATA_MSB:0] = tcmcode_dout[NANORV32_DATA_MSB:0];
         dataif_cpu_early_ready = tcmcode_ready_nxt;
         tcmcode_addr = cpu_dataif_addr[ADDR_WIDTH-1:0];
         tcmcode_din  = cpu_dataif_wdata;
         tcmcode_bytesel  = cpu_dataif_bytesel;
         tcmcode_en       = cpu_dataif_req;

         codeif_cpu_early_ready = 0; // Instruction fetch has to wait

      end
      else if(cpu_data_code_access) begin
         debug =4;
         // Data access to code mem, no access from cpu code port
         swap_dout_a = 1;
         // dataif_cpu_rdata[NANORV32_DATA_MSB:0] = tcmcode_dout[NANORV32_DATA_MSB:0];
         dataif_cpu_early_ready = tcmcode_ready_nxt;
         tcmcode_addr = cpu_dataif_addr[ADDR_WIDTH-1:0];
         tcmcode_din  = cpu_dataif_wdata;
         tcmcode_bytesel  = cpu_dataif_bytesel;
         tcmcode_en       = cpu_dataif_req;

      end
      else if(cpu_code_data_access) begin
         debug =5;
         // cpu code port accessing data mem, no conflict
         swap_dout_a = 1;
         // codeif_cpu_rdata[NANORV32_DATA_MSB:0] = tcmcode_dout[NANORV32_DATA_MSB:0];
         codeif_cpu_early_ready = tcmdata_ready_nxt;
         tcmdata_addr = cpu_codeif_addr[ADDR_WIDTH-1:0];
         tcmdata_din  = 0; // Read only
         tcmdata_bytesel  = 0;
         tcmdata_en       = cpu_codeif_req;
      end // if (cpu_code_data_access)
      else if(cpu_data_periph_access) begin

         debug =6;
         dataif_cpu_early_ready = periph_ready_nxt;
         periph_addr = cpu_dataif_addr[ADDR_WIDTH-1:0];
         periph_din  = cpu_dataif_wdata;
         periph_bytesel  = cpu_dataif_bytesel;
         periph_en       = cpu_dataif_req;

      end
      else begin
         // default
         // TCM Data <-> CPU Code
         // dataif_cpu_rdata[NANORV32_DATA_MSB:0] = tcmdata_dout[NANORV32_DATA_MSB:0];
         debug =7;
         dataif_cpu_early_ready = tcmdata_ready_nxt;
         tcmdata_addr = cpu_dataif_addr[ADDR_WIDTH-1:0];
         tcmdata_din  = cpu_dataif_wdata;
         tcmdata_bytesel  = cpu_dataif_bytesel;
         tcmdata_en       = cpu_dataif_req;
         // TCM Code <-> CPU codeif_cpu_rdata
         // codeif_cpu_rdata[NANORV32_DATA_MSB:0] = tcmcode_dout[NANORV32_DATA_MSB:0];
         codeif_cpu_early_ready = tcmcode_ready_nxt;
         tcmcode_addr = cpu_codeif_addr[ADDR_WIDTH-1:0];
         tcmcode_din  = 0; // Read only
         tcmcode_bytesel  = 0;
         tcmcode_en       = cpu_codeif_req;

         codeif_cpu_early_ready = tcmcode_ready_nxt;

         periph_addr = 0;
         periph_din  = 0;
         periph_bytesel  = 0;
         periph_en       = 0;

         debug =0;
         swap_dout_a = 0;


      end
   end // always @ *

   always @(posedge clk or negedge rst_n) begin
      if(rst_n == 1'b0) begin
         /*AUTORESET*/
         // Beginning of autoreset for uninitialized flops
         swap_dout_r <= 1'h0;
         // End of automatics
      end
      else begin
         swap_dout_r <= swap_dout_a;

      end
   end

   assign codeif_cpu_rdata[NANORV32_DATA_MSB:0] = swap_dout_r ?
     tcmdata_dout[NANORV32_DATA_MSB:0] :
     tcmcode_dout[NANORV32_DATA_MSB:0];

   assign periph_tcmdata_rdata = cpu_data_periph_access ?
                                 periph_dout : tcmdata_dout;



   assign dataif_cpu_rdata[NANORV32_DATA_MSB:0] = swap_dout_r ?
                                                  tcmcode_dout[NANORV32_DATA_MSB:0] :
                                                  periph_tcmdata_rdata[NANORV32_DATA_MSB:0];

always @(posedge clk or negedge rst_n) begin
   if(rst_n == 1'b0) begin
      /*AUTORESET*/
      // Beginning of autoreset for uninitialized flops
      codeif_cpu_ready_r <= 1'h0;
      dataif_cpu_ready_r <= 1'h0;
      // End of automatics
   end
   else begin
      dataif_cpu_ready_r <=  dataif_cpu_early_ready;
      codeif_cpu_ready_r <=  codeif_cpu_early_ready;

   end
end


// No arbitration

//   // Code mem
//
//   assign tcmcode_addr      = cpu_codeif_addr[ADDR_WIDTH-1:0];
//   assign tcmcode_bytesel   = cpu_dataif_bytesel;
//   assign tcmcode_din       = cpu_dataif_wdata;
//   assign tcmcode_en        = cpu_codeif_req;
//   assign codeif_cpu_rdata  = tcmcode_dout;
//   assign codeif_cpu_early_ready  = tcmcode_ready_nxt;
//
//   // data mem
//
//   assign tcmdata_addr      = cpu_dataif_addr[ADDR_WIDTH-1:0];
//   assign tcmdata_bytesel   = cpu_dataif_bytesel;
//   assign tcmdata_din       = cpu_dataif_wdata;
//   assign tcmdata_en        = cpu_dataif_req;
//   assign dataif_cpu_rdata  = tcmdata_dout;
//   assign dataif_cpu_early_ready  = tcmdata_ready_nxt;











endmodule // nanorv32_tcm_arbitrer
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
