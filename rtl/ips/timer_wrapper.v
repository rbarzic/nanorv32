//****************************************************************************/
//  J2 CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Wed Mar  2 19:13:14 2016
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
//  Filename        :  timer_wrapper.v
//
//  Description     :  APBB wrapper for Timer from ultraembedded/altor32
//
//
//
//****************************************************************************/

module timer_wrapper (/*AUTOARG*/
   // Outputs
   timer_apb_prdata, timer_apb_pready, timer_apb_pslverr,
   timer_hires_irq, timer_systick_irq,
   // Inputs
   apb_timer_psel, apb_timer_paddr, apb_timer_penable,
   apb_timer_pwrite, apb_timer_pwdata, clk, rst_n
   );


   input          apb_timer_psel;     // Peripheral select
   input [11:0]   apb_timer_paddr;    // Address
   input          apb_timer_penable;  // Transfer control
   input          apb_timer_pwrite;   // Write control
   input [31:0]   apb_timer_pwdata;   // Write data

   output [31:0]  timer_apb_prdata;   // Read data
   output         timer_apb_pready;   // Device ready
   output         timer_apb_pslverr;  // Device error response

   output         timer_hires_irq;        // From U_TIMER of timer_periph.v
   output         timer_systick_irq;      // From U_TIMER of timer_periph.v


   input          clk;                    // To U_TIMER of timer_periph.v
   input          rst_n;                  // To U_TIMER of timer_periph.v

   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/

   wire           read_enable;
   wire                 write_enable;
   wire                 strobe;

   assign  read_enable  = apb_timer_psel & (~apb_timer_pwrite); // assert for whole APB read transfer
   assign  write_enable = apb_timer_psel & (~apb_timer_penable) & apb_timer_pwrite; // assert for 1st cycle of write transfer
   assign  strobe = read_enable | write_enable; // yes, this could be simplify



    /* timer_periph AUTO_TEMPLATE(
     .intr_o          (timer_irq),
          .data_o          (timer_apb_prdata),
     // Inputs
     .clk_i           (clk),
     .rst_i           (!rst_n),
     .addr_i          (apb_timer_paddr[7:0] ),
     .data_i          (apb_timer_pwdata),
     .we_i            (write_enable),
     .stb_i           (strobe),
     .intr_systick_o        (timer_systick_irq),
     .intr_hires_o          (timer_hires_irq),
     ); */
   timer_periph U_TIMER (
                           /*AUTOINST*/
                         // Outputs
                         .intr_systick_o        (timer_systick_irq), // Templated
                         .intr_hires_o          (timer_hires_irq), // Templated
                         .data_o                (timer_apb_prdata), // Templated
                         // Inputs
                         .clk_i                 (clk),           // Templated
                         .rst_i                 (!rst_n),        // Templated
                         .addr_i                (apb_timer_paddr[7:0] ), // Templated
                         .data_i                (apb_timer_pwdata), // Templated
                         .we_i                  (write_enable),  // Templated
                         .stb_i                 (strobe));        // Templated


   // Output read data to APB

   assign timer_apb_pready  = 1'b1; //  always ready
   assign timer_apb_pslverr = 1'b0; //  always okay



endmodule // timer_wrapper
/*
 Local Variables:
 verilog-library-directories:(
 "."
 "../imported_from_ultraembedded"
 )
 End:
 */
