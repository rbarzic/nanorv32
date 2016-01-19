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
   // Outputs
   cpu_datamem_valid, cpu_datamem_bytesel, cpu_codemem_valid,
   // Inputs
   rst_n, datamem_cpu_ready, codemem_cpu_ready, clk
   );

`include "nanorv32_parameters.v"

   parameter AW = 15; // 32K per RAM



   /*AUTOINPUT*/
   // Beginning of automatic inputs (from unused autoinst inputs)
   input                clk;                    // To U_CPU of nanorv32.v, ...
   input                codemem_cpu_ready;      // To U_CPU of nanorv32.v
   input                datamem_cpu_ready;      // To U_CPU of nanorv32.v
   input                rst_n;                  // To U_CPU of nanorv32.v
   // End of automatics
   /*AUTOOUTPUT*/
   // Beginning of automatic outputs (from unused autoinst outputs)
   output               cpu_codemem_valid;      // From U_CPU of nanorv32.v
   output [3:0]         cpu_datamem_bytesel;    // From U_CPU of nanorv32.v
   output               cpu_datamem_valid;      // From U_CPU of nanorv32.v
   // End of automatics

   /*AUTOREG*/
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [NRV32_DATA_MSB:0] codemem_cpu_rdata;   // From U_CODE_MEM of bytewrite_ram_32bits.v
   wire [NRV32_ADDR_MSB:0] cpu_codemem_addr;    // From U_CPU of nanorv32.v
   wire [NRV32_ADDR_MSB:0] cpu_datamem_addr;    // From U_CPU of nanorv32.v
   wire [NRV32_DATA_MSB:0] cpu_datamem_wdata;   // From U_CPU of nanorv32.v
   wire [NRV32_DATA_MSB:0] datamem_cpu_rdata;   // From U_DATA_MEM of bytewrite_ram_32bits.v
   // End of automatics


    /* nanorv32 AUTO_TEMPLATE(
     ); */
   nanorv32 U_CPU (
                   .cpu_datamem_valid   (),
                           /*AUTOINST*/
                   // Outputs
                   .cpu_codemem_addr    (cpu_codemem_addr[NRV32_ADDR_MSB:0]),
                   .cpu_codemem_valid   (cpu_codemem_valid),
                   .cpu_datamem_addr    (cpu_datamem_addr[NRV32_ADDR_MSB:0]),
                   .cpu_datamem_wdata   (cpu_datamem_wdata[NRV32_DATA_MSB:0]),
                   .cpu_datamem_bytesel (cpu_datamem_bytesel[3:0]),

                   // Inputs
                   .codemem_cpu_rdata   (codemem_cpu_rdata[NRV32_DATA_MSB:0]),
                   .codemem_cpu_ready   (codemem_cpu_ready),
                   .datamem_cpu_rdata   (datamem_cpu_rdata[NRV32_DATA_MSB:0]),
                   .datamem_cpu_ready   (datamem_cpu_ready),
                   .rst_n               (rst_n),
                   .clk                 (clk));




     /* bytewrite_ram_32bits AUTO_TEMPLATE(
      .din                (32'b0),
      .dout              (codemem_cpu_rdata[NRV32_DATA_MSB:0]),
      .addr               (cpu_codemem_addr[NRV32_ADDR_MSB-1:0]),
      .we                (4'b0),
     ); */
   bytewrite_ram_32bits #(.SIZE(1<<(AW-2)),.ADDR_WIDTH(AW-2))
   U_CODE_MEM (
               /*AUTOINST*/
               // Outputs
               .dout               (codemem_cpu_rdata[NRV32_DATA_MSB:0]), // Templated
               // Inputs
               .clk                (clk),
               .we                 (4'b0),          // Templated
               .addr               (cpu_codemem_addr[NRV32_ADDR_MSB-1:0]), // Templated
               .din                (32'b0));         // Templated


   wire [3:0] we_datamem;
   assign we_datamem = cpu_datamem_bytesel & {4{cpu_datamem_valid}};



    /* bytewrite_ram_32bits AUTO_TEMPLATE(
     .din                (cpu_datamem_wdata[NRV32_DATA_MSB:0]),
     .dout              (datamem_cpu_rdata[NRV32_DATA_MSB:0]),
     .addr               (cpu_datamem_addr[NRV32_ADDR_MSB-1:0]),
     .we                (4'b0),
    ); */
   bytewrite_ram_32bits #(.SIZE(1<<(AW-2)),.ADDR_WIDTH(AW-2))
   U_DATA_MEM (
               .we                 (we_datamem),
               /*AUTOINST*/
               // Outputs
               .dout                 (datamem_cpu_rdata[NRV32_DATA_MSB:0]), // Templated
               // Inputs
               .clk                  (clk),
               .addr                 (cpu_datamem_addr[NRV32_ADDR_MSB-1:0]), // Templated
               .din                  (cpu_datamem_wdata[NRV32_DATA_MSB:0])); // Templated


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
