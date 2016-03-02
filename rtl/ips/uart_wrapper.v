//****************************************************************************/
//  Nanorv32 CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Wed Mar  2 13:45:17 2016
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
//  Filename        :  uart_wrapper.v
//
//  Description     :  Wrapper for uart from ultraembedded/altor32
//
//
//
//****************************************************************************/


module uart_wrapper (/*AUTOARG*/
   // Outputs
   uart_apb_prdata, uart_apb_pready, uart_apb_pslverr, uart_irq,
   uart_pad_tx,
   // Inputs
   apb_uart_psel, apb_uart_paddr, apb_uart_penable, apb_uart_pwrite,
   apb_uart_pwdata, pad_uart_rx, clk, rst_n
   );


   input          apb_uart_psel;     // Peripheral select
   input   [11:0] apb_uart_paddr;    // Address
   input          apb_uart_penable;  // Transfer control
   input          apb_uart_pwrite;   // Write control
   input   [31:0] apb_uart_pwdata;   // Write data

   output  [31:0] uart_apb_prdata;   // Read data
   output         uart_apb_pready;   // Device ready
   output         uart_apb_pslverr;  // Device error response


   output               uart_irq;               // From U_UART of uart_periph.v

   input              pad_uart_rx;            // To U_UART of uart_periph.v
   output             uart_pad_tx;            // From U_UART of uart_periph.v


   input              clk;
   input              rst_n;



   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/

   wire                 read_enable;
   wire                 write_enable;
   wire                 strobe;

   assign  read_enable  = apb_uart_psel & (~apb_uart_pwrite); // assert for whole APB read transfer
   assign  write_enable = apb_uart_psel & (~apb_uart_penable) & apb_uart_pwrite; // assert for 1st cycle of write transfer
   assign  strobe = read_enable | write_enable; // yes, this could be simplify



    /* uart_periph AUTO_TEMPLATE(
     .intr_o          (uart_irq),
     .tx_o            (uart_pad_tx),
     .data_o          (uart_apb_prdata),
     // Inputs
     .clk_i           (clk),
     .rst_i           (!rst_n),
     .rx_i            (pad_uart_rx),
     .addr_i          (apb_uart_paddr[7:0] ),
     .data_i          (apb_uart_pwdata),
     .we_i            (write_enable),
     .stb_i           (strobe),
     ); */
   uart_periph U_UART (
                           /*AUTOINST*/
                       // Outputs
                       .intr_o          (uart_irq),              // Templated
                       .tx_o            (uart_pad_tx),           // Templated
                       .data_o          (uart_apb_prdata),       // Templated
                       // Inputs
                       .clk_i           (clk),                   // Templated
                       .rst_i           (!rst_n),                // Templated
                       .rx_i            (pad_uart_rx),           // Templated
                       .addr_i          (apb_uart_paddr[7:0] ),  // Templated
                       .data_i          (apb_uart_pwdata),       // Templated
                       .we_i            (write_enable),          // Templated
                       .stb_i           (strobe));                // Templated


   // Output read data to APB

   assign uart_apb_pready  = 1'b1; //  always ready
   assign uart_apb_pslverr = 1'b0; //  always okay

endmodule // uart_wrapper
/*
 Local Variables:
 verilog-library-directories:(
 "."
 "../imported_from_ultraembedded"
 )
 End:
 */
