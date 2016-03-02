//****************************************************************************/
//  Nanorvr32  CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Tue Mar  1 18:45:11 2016
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
//  Filename        :  nanorv32_pil.v
//
//  Description     :  Processor Integration Level for Nanorv32
//
//
//
//****************************************************************************/
module nanorv32_pil (/*AUTOARG*/
   // Outputs
   haddrd, hburstd, hmasterlockd, hmasterd, hprotd, hsized, htransd,
   hwdatad, hwrited, haddri, hbursti, hmasterlocki, hmasteri, hproti,
   hsizei, htransi, hwdatai, hwritei, illegal_instruction, irq_ack,
   // Inputs
   clk, rst_n, hrdatad, hreadyd, hrespd, hrdatai, hreadyi, hrespi,
   irq
   );

`include "nanorv32_parameters.v"



   input                clk;                    // To U_CPU of nanorv32.v
   input                rst_n;                  // To U_CPU of nanorv32.v


   input [NANORV32_DATA_MSB:0] hrdatad;         // To U_CPU of nanorv32.v
   input                hreadyd;                // To U_CPU of nanorv32.v
   input                hrespd;                 // To U_CPU of nanorv32.v
   output [NANORV32_DATA_MSB:0] haddrd;         // From U_CPU of nanorv32.v
   output [2:0]                 hburstd;                // From U_CPU of nanorv32.v
   output                       hmasterlockd;           // From U_CPU of nanorv32.v
   output                       hmasterd;               // From U_CPU of nanorv32.v
   output [3:0]                 hprotd;                 // From U_CPU of nanorv32.v
   output [2:0]                 hsized;                 // From U_CPU of nanorv32.v
   output                       htransd;                // From U_CPU of nanorv32.v
   output [NANORV32_DATA_MSB:0] hwdatad;        // From U_CPU of nanorv32.v
   output                       hwrited;                // From U_CPU of nanorv32.v

   input [NANORV32_DATA_MSB:0] hrdatai;         // To U_CPU of nanorv32.v
   input                hreadyi;                // To U_CPU of nanorv32.v
   input                hrespi;                 // To U_CPU of nanorv32.v
   output [NANORV32_DATA_MSB:0] haddri;         // From U_CPU of nanorv32.v
   output [2:0]                 hbursti;                // From U_CPU of nanorv32.v
   output                       hmasterlocki;           // From U_CPU of nanorv32.v
   output                       hmasteri;               // From U_CPU of nanorv32.v
   output [3:0]                 hproti;                 // From U_CPU of nanorv32.v
   output [2:0]                 hsizei;                 // From U_CPU of nanorv32.v
   output                       htransi;                // From U_CPU of nanorv32.v
   output [NANORV32_DATA_MSB:0] hwdatai;        // From U_CPU of nanorv32.v
   output                       hwritei;                // From U_CPU of nanorv32.v


   output               illegal_instruction;    // From U_CPU of nanorv32.v

   output               irq_ack;                // From U_CPU of nanorv32.v
   input                irq;                    // To U_CPU of nanorv32.v

   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/


    /* nanorv32 AUTO_TEMPLATE(

     ); */
   nanorv32 U_CPU (
                   /*AUTOINST*/
                   // Outputs
                   .illegal_instruction (illegal_instruction),
                   .haddri              (haddri[NANORV32_DATA_MSB:0]),
                   .hproti              (hproti[3:0]),
                   .hsizei              (hsizei[2:0]),
                   .hmasteri            (hmasteri),
                   .hmasterlocki        (hmasterlocki),
                   .hbursti             (hbursti[2:0]),
                   .hwdatai             (hwdatai[NANORV32_DATA_MSB:0]),
                   .hwritei             (hwritei),
                   .htransi             (htransi),
                   .haddrd              (haddrd[NANORV32_DATA_MSB:0]),
                   .hprotd              (hprotd[3:0]),
                   .hsized              (hsized[2:0]),
                   .hmasterd            (hmasterd),
                   .hmasterlockd        (hmasterlockd),
                   .hburstd             (hburstd[2:0]),
                   .hwdatad             (hwdatad[NANORV32_DATA_MSB:0]),
                   .hwrited             (hwrited),
                   .htransd             (htransd),
                   .irq_ack             (irq_ack),
                   // Inputs
                   .rst_n               (rst_n),
                   .clk                 (clk),
                   .hrdatai             (hrdatai[NANORV32_DATA_MSB:0]),
                   .hrespi              (hrespi),
                   .hreadyi             (hreadyi),
                   .hrdatad             (hrdatad[NANORV32_DATA_MSB:0]),
                   .hrespd              (hrespd),
                   .hreadyd             (hreadyd),
                   .irq                 (irq));


endmodule // nanorv32_pil
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
