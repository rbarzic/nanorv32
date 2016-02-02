//****************************************************************************/
//  J2 CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Tue Jan 19 21:12:09 2016
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
//  Filename        :  nanorv32_simple.v
//
//  Description : A simple chip based on a nanorv32 core and two
//  synchronous RAMS - suitable for FPGA
//
//
//
//****************************************************************************/

// Todo : memory mapping & arbitration (ROM : 0->32K - RAM 32K->64K)


module nanorv32_simple (/*AUTOARG*/
   // Inputs
   rst_n, clk
   );

`include "nanorv32_parameters.v"

   parameter AW = 15; // 32K per RAM



   /*AUTOINPUT*/
   // Beginning of automatic inputs (from unused autoinst inputs)
   input                clk;                    // To U_CPU of nanorv32.v, ...
   input                rst_n;                  // To U_CPU of nanorv32.v
   // End of automatics
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [NANORV32_DATA_MSB:0] codemem_cpu_rdata;// From U_CODE_MEM of bytewrite_ram_32bits.v
   wire [NANORV32_DATA_MSB:0] cpu_codemem_addr; // From U_CPU of nanorv32.v
   wire [NANORV32_DATA_MSB:0] cpu_datamem_addr; // From U_CPU of nanorv32.v
   wire [NANORV32_DATA_MSB:0] cpu_datamem_wdata;// From U_CPU of nanorv32.v
   wire [NANORV32_DATA_MSB:0] datamem_cpu_rdata;// From U_DATA_MEM of bytewrite_ram_32bits.v
   // End of automatics

   wire [3:0]                 cpu_datamem_bytesel;

   reg                        codemem_cpu_ack;

   always @(posedge clk or negedge rst_n) begin
      if(rst_n == 1'b0) begin
         /*AUTORESET*/
         // Beginning of autoreset for uninitialized flops
         codemem_cpu_ack <= 1'h0;
         // End of automatics
      end
      else begin
         codemem_cpu_ack <= cpu_codemem_req;
      end
   end




    /* nanorv32 AUTO_TEMPLATE(
     ); */
   nanorv32 U_CPU (

                   .cpu_datamem_bytesel (cpu_datamem_bytesel[3:0]),
                   .cpu_datamem_req     (cpu_datamem_req),
                   .cpu_codemem_req     (cpu_codemem_req),
                   .codemem_cpu_ack     (codemem_cpu_ack),
                   .datamem_cpu_ack     (datamem_cpu_ack),
                           /*AUTOINST*/
                   // Outputs
                   .cpu_codemem_addr    (cpu_codemem_addr[NANORV32_DATA_MSB:0]),
                   .cpu_datamem_addr    (cpu_datamem_addr[NANORV32_DATA_MSB:0]),
                   .cpu_datamem_wdata   (cpu_datamem_wdata[NANORV32_DATA_MSB:0]),
                   // Inputs
                   .codemem_cpu_rdata   (codemem_cpu_rdata[NANORV32_DATA_MSB:0]),
                   .datamem_cpu_rdata   (datamem_cpu_rdata[NANORV32_DATA_MSB:0]),
                   .rst_n               (rst_n),
                   .clk                 (clk));




     /* bytewrite_ram_32bits AUTO_TEMPLATE(
      .din                (32'b0),
      .dout              (codemem_cpu_rdata[NANORV32_DATA_MSB:0]),
      .addr               (cpu_codemem_addr[NANORV32_ADDR_MSB-1:2]),
      .we                (4'b0),
     ); */
   bytewrite_ram_32bits #(.SIZE(1<<(AW-2)),.ADDR_WIDTH(AW-2))
   U_CODE_MEM (
               /*AUTOINST*/
               // Outputs
               .dout                    (codemem_cpu_rdata[NANORV32_DATA_MSB:0]), // Templated
               // Inputs
               .clk                     (clk),
               .we                      (4'b0),                  // Templated
               .addr                    (cpu_codemem_addr[NANORV32_ADDR_MSB-1:2]), // Templated
               .din                     (32'b0));                 // Templated


   wire [3:0] we_datamem;
   wire       write_access = | we_datamem;
   assign     we_datamem = cpu_datamem_bytesel & {4{cpu_datamem_req}};



    /* bytewrite_ram_32bits AUTO_TEMPLATE(
     .din                (cpu_datamem_wdata[NANORV32_DATA_MSB:0]),
     .dout              (datamem_cpu_rdata[NANORV32_DATA_MSB:0]),
     .addr               (cpu_datamem_addr[NANORV32_ADDR_MSB-1:0]),
     .we                (4'b0),
    ); */
   bytewrite_ram_32bits #(.SIZE(1<<(AW-2)),.ADDR_WIDTH(AW-2))
   U_DATA_MEM (
               .we                 (we_datamem),
               /*AUTOINST*/
               // Outputs
               .dout                    (), // Templated
               // Inputs
               .clk                     (clk),
               .addr                    (cpu_datamem_addr[NANORV32_ADDR_MSB-1:0]), // Templated
               .din                     (cpu_datamem_wdata[NANORV32_DATA_MSB:0])); // Templated

   reg        cpu_datamem_req_r;


   always @(posedge clk or negedge rst_n) begin
      if(rst_n == 1'b0) begin
         /*AUTORESET*/
         // Beginning of autoreset for uninitialized flops
         cpu_datamem_req_r <= 1'h0;
         // End of automatics
      end
      else begin
         cpu_datamem_req_r <= cpu_datamem_req & !write_access;
      end
   end
   // simple handshaking
   // a write is immediate, a read needs to be delayed by one cycle
   assign datamem_cpu_ack = write_access ? cpu_datamem_req : cpu_datamem_req_r;

   reg cpu_data_data_access; // Data access (Load/store) to Data space
   reg cpu_data_code_access; // Data access (Load/store) to Code space
   reg cpu_data_periph_access; // Data access (Load/store) to Periph space

   reg cpu_code_data_access; // Code access (Program fetch) to Data space
   reg cpu_code_code_access; // Code access (Program fetch) to Code space
   reg cpu_code_periph_access; // Code access (Program fetch) to Periph space (Forbidden ?)

   // Address space decoding
   always @(*) begin
      case(cpu_datamem_addr[31:28])
        4'h0: begin
           // Code access - not supported yet
           cpu_data_data_access = 0;
           cpu_data_code_access = 1;
           cpu_data_periph_access = 0;
        end
        4'h2: begin
           // Data RAM access
           cpu_data_data_access = 1;
           cpu_data_code_access = 0;
           cpu_data_periph_access = 0;
        end
        4'hF: begin
           // Peripheral access
           cpu_data_data_access = 0;
           cpu_data_code_access = 0;
           cpu_data_periph_access = 1;
        end
        default: begin
           cpu_data_data_access = 0;
           cpu_data_code_access = 0;
           cpu_data_periph_access = 0;
        end
      endcase
   end // always @ *

   always @* begin
      case(cpu_codemem_addr[31:28])
        4'h0: begin
           // Code access
           cpu_code_data_access = 0;
           cpu_code_code_access = 1;
           cpu_code_periph_access = 0;
        end
        4'h2: begin
           // Data RAM access
           cpu_code_data_access = 1;
           cpu_code_code_access = 0;
           cpu_code_periph_access = 0;
        end
        4'hF: begin
           // Peripheral access
           cpu_code_data_access = 0;
           cpu_code_code_access = 0;
           cpu_code_periph_access = 1;
        end
        default: begin
           cpu_code_data_access = 0;
           cpu_code_code_access = 0;
           cpu_code_periph_access = 0;
        end
      endcase
   end

   // Priority between data and code access
   // For Code ram
   always @* begin
      // default
      datamem_cpu_rdata[NANORV32_DATA_MSB:0] = dout_datamem[NANORV32_DATA_MSB:0];
      if(cpu_data_code_access) begin
         // Data access to code ram
         datamem_cpu_rdata[NANORV32_DATA_MSB:0] = dout_codemem[NANORV32_DATA_MSB:0];

      end
      else if(cpu_data_data_access) begin
         datamem_cpu_rdata[NANORV32_DATA_MSB:0] = dout_datamem[NANORV32_DATA_MSB:0];
      end
      else if(cpu_data_periph_access) begin
         datamem_cpu_rdata[NANORV32_DATA_MSB:0] = periph_rdata[NANORV32_DATA_MSB:0];
      end

   end




endmodule // nanorv32_simple
/*
 Local Variables:
 verilog-library-directories:(
 "."
 "../cores"
 "../ips"
 )
 End:
 */
