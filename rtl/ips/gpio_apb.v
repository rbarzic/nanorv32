//****************************************************************************/
//  Nanorv32  CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Wed Mar  2 14:08:33 2016
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
//  Filename        :  gpio_apb.v
//
//  Description     :  Simple GPIO controller with APB interface
//
//
//
//****************************************************************************/

module gpio_apb (/*AUTOARG*/
   // Outputs
   gpio_apb_prdata, gpio_apb_pready, gpio_apb_pslverr, gpio_pad_out,
   // Inputs
   apb_gpio_psel, apb_gpio_paddr, apb_gpio_penable, apb_gpio_pwrite,
   apb_gpio_pwdata, pad_gpio_in, clk_apb, rst_apb_n
   );


   input  wire        apb_gpio_psel;     // Peripheral select

   input  wire [11:0] apb_gpio_paddr;    // Address
   input  wire        apb_gpio_penable;  // Transfer control
   input  wire        apb_gpio_pwrite;   // Write control
   input  wire [31:0] apb_gpio_pwdata;   // Write data

   output wire [31:0] gpio_apb_prdata;   // Read data
   output wire        gpio_apb_pready;   // Device ready
   output wire        gpio_apb_pslverr;  // Device error response


   // GPIO in/out
   output [31:0]      gpio_pad_out;
   input [31:0]       pad_gpio_in;


   input              clk_apb;
   input              rst_apb_n;


   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/

   reg             [31:0]     read_mux;

   reg [31:0]                 gpio_out_r;
   reg [31:0]                 gpio_in_m;
   reg [31:0]                 gpio_in_r;

   wire                       read_enable;
   wire                       write_enable;


   assign  read_enable  = apb_gpio_psel & (~apb_gpio_pwrite); // assert for whole APB read transfer
   assign  write_enable = apb_gpio_psel & (~apb_gpio_penable) & apb_gpio_pwrite; // assert for 1st cycle of write transfer


   // Register Read
   always@* begin
      case(apb_gpio_paddr[3:2])
        2'h0: begin
           read_mux = gpio_out_r;
        end
        2'h1: begin
           read_mux = gpio_in_r;
        end
        default: begin
           read_mux = 0;
        end
      endcase
   end

   // Output read data to APB
   assign gpio_apb_prdata[31: 0] = (read_enable) ? read_mux : {32{1'b0}};
   assign gpio_apb_pready  = 1'b1; //  always ready
   assign gpio_apb_pslverr = 1'b0; //  always okay

   // register write
   always @(posedge clk_apb or negedge rst_apb_n) begin
      if(rst_apb_n == 1'b0) begin
         /*AUTORESET*/
         // Beginning of autoreset for uninitialized flops
         gpio_out_r <= 32'h0;
         // End of automatics
      end
      else begin
         if(write_enable) begin
            case(apb_gpio_paddr[3:2])
              2'h0: begin
                 gpio_out_r <= apb_gpio_pwdata;
              end
              default: begin
              end
            endcase
         end
      end
   end


   always @(posedge clk_apb or posedge rst_apb_n) begin
      if(rst_apb_n == 1'b0) begin
         /*AUTORESET*/
         // Beginning of autoreset for uninitialized flops
         gpio_in_m <= 32'h0;
         gpio_in_r <= 32'h0;
         // End of automatics
      end
      else begin

         gpio_in_m <= pad_gpio_in;
         gpio_in_r <= gpio_in_m;
      end
   end

   assign gpio_pad_out = gpio_out_r;


endmodule // gpio_apb
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
