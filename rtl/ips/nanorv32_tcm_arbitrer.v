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
   codeif_cpu_rdata, codeif_cpu_ready, dataif_cpu_rdata,
   dataif_cpu_ready,
   // Inputs
   tcmcode_dout, tcmcode_ready_nxt, tcmdata_dout, tcmdata_ready_nxt,
   cpu_codeif_addr, cpu_codeif_req, cpu_dataif_addr, cpu_dataif_wdata,
   cpu_dataif_bytesel, cpu_dataif_req
   );
   parameter ADDR_WIDTH = 12;

`include "nanorv32_parameters.v"
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

   // CPU Code memory interface
   input [NANORV32_DATA_MSB:0] cpu_codeif_addr;
   input                       cpu_codeif_req;
   output [NANORV32_DATA_MSB:0]  codeif_cpu_rdata;
   output                        codeif_cpu_ready;

   // Data memory interface

   input [NANORV32_DATA_MSB:0] cpu_dataif_addr;
   input [NANORV32_DATA_MSB:0] cpu_dataif_wdata;
   input [3:0]                 cpu_dataif_bytesel;
   input                       cpu_dataif_req;
   output [NANORV32_DATA_MSB:0]  dataif_cpu_rdata;
   output                        dataif_cpu_ready;



   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/

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
           cpu_code_periph_access = cpu_codeif_req;
        end
        default: begin
           cpu_code_data_access = 0;
           cpu_code_code_access = 0;
           cpu_code_periph_access = 0;
        end
      endcase
   end


//   assign periph_dout = 0;
//
//   // Priority between data and code access
//   // For Code ram
//   always @* begin
//      // default
//      dataif_cpu_rdata[NANORV32_DATA_MSB:0] = datamem_dout[NANORV32_DATA_MSB:0];
//      if(cpu_data_code_access) begin
//         // Data access to code ram
//         dataif_cpu_rdata[NANORV32_DATA_MSB:0] = codemem_dout[NANORV32_DATA_MSB:0];
//
//      end
//      else if(cpu_data_data_access) begin
//         dataif_cpu_rdata[NANORV32_DATA_MSB:0] = datamem_dout[NANORV32_DATA_MSB:0];
//      end
//      else if(cpu_data_periph_access) begin
//         dataif_cpu_rdata[NANORV32_DATA_MSB:0] = periph_dout[NANORV32_DATA_MSB:0];
//      end
//
//   end // always @ *
//
//   always @* begin
//      // default
//      codeif_cpu_rdata[NANORV32_DATA_MSB:0] = datamem_dout[NANORV32_DATA_MSB:0];
//      if(cpu_code_code_access) begin
//         // Data access to code ram
//         codeif_cpu_rdata[NANORV32_DATA_MSB:0] = codemem_dout[NANORV32_DATA_MSB:0];
//
//      end
//      else if(cpu_code_data_access) begin
//         codeif_cpu_rdata[NANORV32_DATA_MSB:0] = datamem_dout[NANORV32_DATA_MSB:0];
//      end
//      else if(cpu_code_periph_access) begin
//         // Forbidden ?
//         codeif_cpu_rdata[NANORV32_DATA_MSB:0] = periph_dout[NANORV32_DATA_MSB:0];
//      end
//
//   end
//
//


// No arbitration

   // Code mem

   assign tcmcode_addr      = cpu_codeif_addr[ADDR_WIDTH-1:0];
   assign tcmcode_bytesel   = cpu_dataif_bytesel;
   assign tcmcode_din       = cpu_dataif_wdata;
   assign tcmcode_en        = cpu_codeif_req;
   assign codeif_cpu_rdata  = tcmcode_dout;
   assign codeif_cpu_ready  = tcmcode_ready_nxt;

   // data mem

   assign tcmdata_addr      = cpu_dataif_addr[ADDR_WIDTH-1:0];
   assign tcmdata_bytesel   = cpu_dataif_bytesel;
   assign tcmdata_din       = cpu_dataif_wdata;
   assign tcmdata_en        = cpu_dataif_req;
   assign dataif_cpu_rdata  = tcmdata_dout;
   assign dataif_cpu_ready  = tcmdata_ready_nxt;











endmodule // nanorv32_tcm_arbitrer
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
