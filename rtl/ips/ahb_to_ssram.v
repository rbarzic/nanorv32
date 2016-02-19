//****************************************************************************/
//  AMBA Components
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Mon Nov  9 09:47:28 2015
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
//  Filename        :  ahb_to_ssram.v
//
//  Description     :   A simple AHB to Synchronous SRAM interface
//                      AHB interface is modeled according to cmsdk_ahb_ram_beh.v
//
//
//****************************************************************************/



module ahb_to_ssram (/*AUTOARG*/
   // Outputs
   HREADYOUT, HRDATA, HRESP, ahb_sram_addr, ahb_sram_en, ahb_sram_enb,
   ahb_sram_wb, ahb_sram_we, ahb_sram_din,
   // Inputs
   HCLK, HRESETn, HSEL, HADDR, HTRANS, HSIZE, HWRITE, HWDATA, HREADY,
   sram_ahb_dout
   );


   parameter AW = 12;

`include "ahb_params.v"

   localparam AHB_ADDRESS_PHASE = 1;
   localparam AHB_DATA_PHASE    = 2;
   localparam AHB_IDLE_PHASE    = 0;


   // AHB interface

   input  wire HCLK;    // Clock
   input  wire HRESETn; // Reset
   input  wire HSEL;    // Device select
   input  wire [AW-1:0] HADDR;   // Address
   input  wire [1:0]    HTRANS;  // Transfer control
   input  wire [2:0]    HSIZE;   // Transfer size
   input  wire          HWRITE;  // Write control
   input  wire [31:0]   HWDATA;  // Write data
   input  wire          HREADY;  // Transfer phase done
   output reg           HREADYOUT; // Device ready
   output wire [31:0]   HRDATA;    // Read data output
   output wire          HRESP;     // Device response (always OKAY)


   // Synchronous SRAM connections
   output [AW-1:0]      ahb_sram_addr;
   output               ahb_sram_en;
   output [3:0]         ahb_sram_enb;
   output [3:0]         ahb_sram_wb;
   output               ahb_sram_we;
   input [31:0]         sram_ahb_dout;
   output [31:0]        ahb_sram_din;




   reg [3:0]           byte_sel_a;
   reg [3:0]           byte_sel_r;
   reg data_phase_r;
   reg write_en_r;
   reg [AW-1:0] haddr_r;







   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/



   //assign seq_cycle  = (HTRANS[1:0] == AMBA_AHB_HTRANS_SEQ[1:0]);
   //assign nonseq_cycle  = (HTRANS[1:0] ==AMBA_AHB_HTRANS_NONSEQ);
   //
   //
   //assign busy_cycle = (HTRANS==AMBA_AHB_HTRANS_BUSY);
   //assign idle_cycle = (HTRANS==AMBA_AHB_HTRANS_IDLE);

   reg                  seq_cycle;
   reg                  nonseq_cycle;
   reg                  busy_cycle;
   reg                  idle_cycle;


   always @* begin
      seq_cycle = 0;
      nonseq_cycle = 0;

      busy_cycle   = 0;
      idle_cycle   = 0;

      case(HTRANS[1:0])
        AMBA_AHB_HTRANS_SEQ : begin
           seq_cycle = 1'b1;

        end
        AMBA_AHB_HTRANS_NON_SEQ : begin
           nonseq_cycle = 1'b1;
        end
        AMBA_AHB_HTRANS_BUSY : begin
           busy_cycle = 1'b1;
        end
        AMBA_AHB_HTRANS_IDLE : begin
           idle_cycle = 1'b1;
        end
      endcase
   end

   assign active_cycle = seq_cycle || nonseq_cycle;
   assign read_valid  = active_cycle & HSEL & HREADY & (~HWRITE);
   assign write_valid = active_cycle & HSEL & HREADY & HWRITE;
   assign rw_cycle = read_valid | write_valid;

   always @(/*AUTOSENSE*/HADDR or HSIZE or rw_cycle) begin
      /*AUTO_CONSTANT (  AMBA_AHB_HSIZE_16BITS AMBA_AHB_HSIZE_32BITS  AMBA_AHB_HSIZE_8BITS) */
      byte_sel_a = 4'b1111;
      if (rw_cycle) begin
         case(HSIZE[2:0])
           AMBA_AHB_HSIZE_8BITS : begin
              case(HADDR[1:0])
                0 : begin
                   byte_sel_a = 4'b0001;
                end
                1 : begin
                   byte_sel_a = 4'b0010;
                end
                2 : begin
                   byte_sel_a = 4'b0100;
                end
                3 : begin
                   byte_sel_a = 4'b1000;
                end
                default: begin
                end

              endcase
           end
           AMBA_AHB_HSIZE_16BITS : begin
              byte_sel_a = HADDR[1] ? 4'b1100 : 4'b0011;
           end
           AMBA_AHB_HSIZE_32BITS : begin
              byte_sel_a = 4'b1111;
           end
           default: begin
              byte_sel_a = 4'b1111;
           end
         endcase
      end
   end



   always @(posedge HCLK or negedge HRESETn) begin
      if(HRESETn == 1'b0) begin
         /*AUTORESET*/
         // Beginning of autoreset for uninitialized flops
         byte_sel_r <= 4'h0;
         haddr_r <= {AW{1'b0}};
         write_en_r <= 1'h0;
         // End of automatics

      end
      else begin
         if(HREADY && HREADYOUT) begin
            byte_sel_r <= byte_sel_a;
            write_en_r <= write_valid;
            haddr_r    <= HADDR; // Could be optimize (?)
         end


      end
   end

   always @(posedge HCLK or negedge HRESETn) begin
      if(HRESETn == 1'b0) begin
         HREADYOUT <= 1'b1;

         /*AUTORESET*/
      end
      else begin
         HREADYOUT <= !(write_en_r & read_valid);
      end
   end






   assign ahb_sram_addr = write_en_r ? haddr_r : HADDR;
   assign ahb_sram_en   = read_valid | write_en_r;
   assign ahb_sram_we   = write_en_r;

   // Write cycle followed by a read cycle -> we must wait

   assign ahb_sram_wb  = byte_sel_r & {4{write_en_r}};
   assign ahb_sram_enb = byte_sel_r & {4{ahb_sram_en}};

   assign ahb_sram_din = HWDATA;
   assign HRDATA  = sram_ahb_dout;
   assign HRESP     = 1'b0;

endmodule // ahb_to_ssram
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
