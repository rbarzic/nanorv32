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
   clk, rst_n
   );

`include "nanorv32_parameters.v"

   parameter AW = 15; // 32K per RAM

   input                clk;                    // To U_CPU of nanorv32.v
   input                rst_n;                  // To U_CPU of nanorv32.v

   // Code memory port
/*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/


   wire [NANORV32_DATA_MSB:0] codemem_dout;   // From U_CODE_MEM of bytewrite_ram_32bits.v
   wire [NANORV32_DATA_MSB:0] datamem_dout;   // From U_DATA_MEM of bytewrite_ram_32bits.v
   wire [NANORV32_DATA_MSB:0] periph_dout;   // From U_DATA_MEM of bytewrite_ram_32bits.v

   wire  [NANORV32_DATA_MSB:0]  cpu_codeif_addr;
   wire                         cpu_codeif_req;
   reg [NANORV32_DATA_MSB:0]   codeif_cpu_rdata;

   wire  [NANORV32_DATA_MSB:0]  cpu_dataif_addr;
   wire                         cpu_dataif_req;
   wire  [NANORV32_DATA_MSB:0]  cpu_dataif_wdata;
   reg [NANORV32_DATA_MSB:0]   dataif_cpu_rdata;




   wire [3:0]                 cpu_dataif_bytesel;

   reg                       codeif_cpu_ack;

   always @(posedge clk or negedge rst_n) begin
      if(rst_n == 1'b0) begin
         /*AUTORESET*/
         // Beginning of autoreset for uninitialized flops
         codeif_cpu_ack <= 1'h0;
         // End of automatics
      end
      else begin
         codeif_cpu_ack <= cpu_codeif_req;
      end
   end




    /* nanorv32 AUTO_TEMPLATE(
     ); */
   nanorv32 U_CPU (
                   // Outputs
                   .cpu_codeif_addr    (cpu_codeif_addr[NANORV32_DATA_MSB:0]),
                   .cpu_codeif_req     (cpu_codeif_req),
                   .cpu_dataif_addr    (cpu_dataif_addr[NANORV32_DATA_MSB:0]),
                   .cpu_dataif_wdata   (cpu_dataif_wdata[NANORV32_DATA_MSB:0]),
                   .cpu_dataif_bytesel (cpu_dataif_bytesel[3:0]),
                   .cpu_dataif_req     (cpu_dataif_req),
                   // Inputs
                   .codeif_cpu_rdata   (codeif_cpu_rdata[NANORV32_DATA_MSB:0]),
                   .codeif_cpu_ack     (codeif_cpu_ack),
                   .dataif_cpu_rdata   (dataif_cpu_rdata[NANORV32_DATA_MSB:0]),
                   .dataif_cpu_ack     (dataif_cpu_ack),
                   .rst_n               (rst_n),
                   .clk                 (clk));




     /* bytewrite_ram_32bits AUTO_TEMPLATE(
      .din                (32'b0),
      .dout              (codemem_dout[NANORV32_DATA_MSB:0]),
      .addr               (cpu_codeif_addr[NANORV32_ADDR_MSB-1:2]),
      .we                (4'b0),
     ); */
   bytewrite_ram_32bits #(.SIZE(1<<(AW-2)),.ADDR_WIDTH(AW-2))
   U_CODE_MEM (

               // Outputs
               .dout                    (codemem_dout[NANORV32_DATA_MSB:0]),
               // Inputs
               .clk                     (clk),
               .we                      (4'b0),
               .addr                    (cpu_codeif_addr[NANORV32_ADDR_MSB-1:2]),
               .din                     (32'b0));


   wire [3:0] we_datamem;
   wire       write_access = | we_datamem;
   assign     we_datamem = cpu_dataif_bytesel & {4{cpu_dataif_req}};



    /* bytewrite_ram_32bits AUTO_TEMPLATE(
     .din                (cpu_dataif_wdata[NANORV32_DATA_MSB:0]),
     .dout              (datamem_dout[NANORV32_DATA_MSB:0]),
     .addr               (cpu_dataif_addr[NANORV32_ADDR_MSB-1:0]),
     .we                (4'b0),
    ); */
   bytewrite_ram_32bits #(.SIZE(1<<(AW-2)),.ADDR_WIDTH(AW-2))
   U_DATA_MEM (
               .we                 (we_datamem),

               // Outputs
               .dout                    (datamem_dout[NANORV32_DATA_MSB:0]),
               // Inputs
               .clk                     (clk),
               .addr                    (cpu_dataif_addr[NANORV32_ADDR_MSB-1:0]),
               .din                     (cpu_dataif_wdata[NANORV32_DATA_MSB:0]));

   reg        cpu_dataif_req_r;


   always @(posedge clk or negedge rst_n) begin
      if(rst_n == 1'b0) begin
         /*AUTORESET*/
         // Beginning of autoreset for uninitialized flops
         cpu_dataif_req_r <= 1'h0;
         // End of automatics
      end
      else begin
         cpu_dataif_req_r <= cpu_dataif_req & !write_access;
      end
   end
   // simple handshaking
   // a write is immediate, a read needs to be delayed by one cycle
   assign dataif_cpu_ack = write_access ? cpu_dataif_req : cpu_dataif_req_r;

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


   assign periph_dout = 0;

   // Priority between data and code access
   // For Code ram
   always @* begin
      // default
      dataif_cpu_rdata[NANORV32_DATA_MSB:0] = datamem_dout[NANORV32_DATA_MSB:0];
      if(cpu_data_code_access) begin
         // Data access to code ram
         dataif_cpu_rdata[NANORV32_DATA_MSB:0] = codemem_dout[NANORV32_DATA_MSB:0];

      end
      else if(cpu_data_data_access) begin
         dataif_cpu_rdata[NANORV32_DATA_MSB:0] = datamem_dout[NANORV32_DATA_MSB:0];
      end
      else if(cpu_data_periph_access) begin
         dataif_cpu_rdata[NANORV32_DATA_MSB:0] = periph_dout[NANORV32_DATA_MSB:0];
      end

   end // always @ *

   always @* begin
      // default
      codeif_cpu_rdata[NANORV32_DATA_MSB:0] = datamem_dout[NANORV32_DATA_MSB:0];
      if(cpu_code_code_access) begin
         // Data access to code ram
         codeif_cpu_rdata[NANORV32_DATA_MSB:0] = codemem_dout[NANORV32_DATA_MSB:0];

      end
      else if(cpu_code_data_access) begin
         codeif_cpu_rdata[NANORV32_DATA_MSB:0] = datamem_dout[NANORV32_DATA_MSB:0];
      end
      else if(cpu_code_periph_access) begin
         // Forbidden ?
         codeif_cpu_rdata[NANORV32_DATA_MSB:0] = periph_dout[NANORV32_DATA_MSB:0];
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
