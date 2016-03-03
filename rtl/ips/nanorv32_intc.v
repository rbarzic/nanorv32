//****************************************************************************/
//  Nanorv32  CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Wed Mar  2 18:34:26 2016
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
//  Filename        :  nanorv32_intc.v
//
//  Description     :  Interrupt controller
//                     based on ultra-embedded/alor32/intr
//                     See https://github.com/ultraembedded/altor32
//
//
//
//****************************************************************************/


module nanorv32_intc (/*AUTOARG*/
   // Outputs
   intc_apb_prdata, intc_apb_pready, intc_apb_pslverr, intc_irq,
   // Inputs
   apb_intc_psel, apb_intc_paddr, apb_intc_penable, apb_intc_pwrite,
   apb_intc_pwdata, irqs, irq_ext, irq_ack, clk, rst_n
   );



   input          apb_intc_psel;     // Peripheral select
   input [11:0]   apb_intc_paddr;    // Address
   input          apb_intc_penable;  // Transfer control
   input          apb_intc_pwrite;   // Write control
   input [31:0]   apb_intc_pwdata;   // Write data

   output [31:0]  intc_apb_prdata;   // Read data
   output         intc_apb_pready;   // Device ready
   output         intc_apb_pslverr;  // Device error response

   input [7:0]    irqs;
   input          irq_ext;

   output         intc_irq;               // From U_INTR_PERIPH of intr_periph.v
   input          irq_ack;                // Fixme - unused

   input          clk;
   input          rst_n;


   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   wire                 read_enable;
   wire                 write_enable;
   wire                 strobe;


   /*AUTOREG*/
   /*AUTOWIRE*/


   assign  read_enable  = apb_intc_psel & (~apb_intc_pwrite); // assert for whole APB read transfer
   assign  write_enable = apb_intc_psel & (~apb_intc_penable) & apb_intc_pwrite; // assert for 1st cycle of write transfer
   assign  strobe = read_enable | write_enable; // yes, this could be simplify



    /* intr_periph AUTO_TEMPLATE(
     .intr_o          (intc_irq),
     .data_o          (intc_apb_prdata),
     .intr\([0-7]*\)_i          (irqs[\1]),
     .clk_i           (clk),
     .rst_i           (!rst_n),
     .rx_i            (pad_intc_rx),
     .addr_i          (apb_intc_paddr[7:0] ),
     .data_i          (apb_intc_pwdata),
     .we_i            (write_enable),
     .stb_i           (strobe),
     .intr_ext_i(irq_ext),
     ); */
   intr_periph U_INTR_PERIPH (

                           /*AUTOINST*/
                              // Outputs
                              .intr_o           (intc_irq),      // Templated
                              .data_o           (intc_apb_prdata), // Templated
                              // Inputs
                              .clk_i            (clk),           // Templated
                              .rst_i            (!rst_n),        // Templated
                              .intr0_i          (irqs[0]),       // Templated
                              .intr1_i          (irqs[1]),       // Templated
                              .intr2_i          (irqs[2]),       // Templated
                              .intr3_i          (irqs[3]),       // Templated
                              .intr4_i          (irqs[4]),       // Templated
                              .intr5_i          (irqs[5]),       // Templated
                              .intr6_i          (irqs[6]),       // Templated
                              .intr7_i          (irqs[7]),       // Templated
                              .intr_ext_i       (irq_ext),       // Templated
                              .addr_i           (apb_intc_paddr[7:0] ), // Templated
                              .data_i           (apb_intc_pwdata), // Templated
                              .we_i             (write_enable),  // Templated
                              .stb_i            (strobe));        // Templated




   assign intc_apb_pready  = 1'b1; //  always ready
   assign intc_apb_pslverr = 1'b0; //  always okay


endmodule // nanorv32_intc
/*
 Local Variables:
 verilog-library-directories:(
 "."
 "../imported_from_ultraembedded"
 )
 End:
 */
