//****************************************************************************/
//  Nanorv32 CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Thu Mar  3 22:04:06 2016
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
//  Filename        :  top_io.v
//
//  Description     :  Top level for pad instantiations
//
//
//
//****************************************************************************/

module top_io (/*AUTOARG*/
   // Outputs
   pmux_pad_dout, pad_tap_tdi, pad_tap_tms, pad_tap_tck,
   // Inouts
   PA, TMS, TDI, TCK, TDO,
   // Inputs
   pad_pmux_din, pmux_pad_ie, pmux_pad_oe, tap_pad_tdo,
   tap_pad_tdo_oe
   );

`include "nanorv32_parameters.v"
`include "chip_params.v"



   input    [CHIP_PORT_A_WIDTH-1:0]      pad_pmux_din;          // To U_PA0 of std_pad.v, ...
   input    [CHIP_PORT_A_WIDTH-1:0]      pmux_pad_ie;         // To U_PA0 of std_pad.v, ...
   input    [CHIP_PORT_A_WIDTH-1:0]      pmux_pad_oe;         // To U_PA0 of std_pad.v, ...
   output   [CHIP_PORT_A_WIDTH-1:0]      pmux_pad_dout;          // From U_PA0 of std_pad.v, ...

   inout    [CHIP_PORT_A_WIDTH-1:0]      PA;

   input                                 tap_pad_tdo;
   input                                 tap_pad_tdo_oe;
   output                                pad_tap_tdi;
   output                                pad_tap_tms;
   output                                pad_tap_tck;


   inout                                 TMS;
   inout                                 TDI;
   inout                                 TCK;
   inout                                 TDO;

   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/


   wire [CHIP_PORT_A_WIDTH-1:0] pad_pmux_din;          // To U_PA0 of std_pad.v, ...
   wire [CHIP_PORT_A_WIDTH-1:0] pmux_pad_dout;          // To U_PA0 of std_pad.v, ...
   wire [CHIP_PORT_A_WIDTH-1:0] pmux_pad_ie;         // To U_PA0 of std_pad.v, ...
   wire [CHIP_PORT_A_WIDTH-1:0] pmux_pad_oe;         // To U_PA0 of std_pad.v, ...
   wire [CHIP_PORT_A_WIDTH-1:0] PA;         // To U_PA0 of std_pad.v, ...

   wire                         pad_tap_tck;
   wire                         pad_tap_tdi;
   wire                         pad_tap_tms;



    /* std_pad AUTO_TEMPLATE(
     .dout                (pmux_pad_dout[@]),
     .din                 (pad_pmux_din[@]),
     .pad                 (PA[@]),
     .oe                (pmux_pad_oe[@]),
     .ie                (pmux_pad_ie[@]),
     ); */
   std_pad U_PA0 (
                           /*AUTOINST*/
                  // Outputs
                  .din                  (pad_pmux_din[0]),       // Templated
                  // Inouts
                  .pad                  (PA[0]),                 // Templated
                  // Inputs
                  .dout                 (pmux_pad_dout[0]),      // Templated
                  .oe                   (pmux_pad_oe[0]),        // Templated
                  .ie                   (pmux_pad_ie[0]));        // Templated



   std_pad U_PA1 (
                           /*AUTOINST*/
                  // Outputs
                  .din                  (pad_pmux_din[1]),       // Templated
                  // Inouts
                  .pad                  (PA[1]),                 // Templated
                  // Inputs
                  .dout                 (pmux_pad_dout[1]),      // Templated
                  .oe                   (pmux_pad_oe[1]),        // Templated
                  .ie                   (pmux_pad_ie[1]));        // Templated

   std_pad U_PA2 (
                  /*AUTOINST*/
                  // Outputs
                  .din                  (pad_pmux_din[2]),       // Templated
                  // Inouts
                  .pad                  (PA[2]),                 // Templated
                  // Inputs
                  .dout                 (pmux_pad_dout[2]),      // Templated
                  .oe                   (pmux_pad_oe[2]),        // Templated
                  .ie                   (pmux_pad_ie[2]));        // Templated

   std_pad U_PA3 (
                  /*AUTOINST*/
                  // Outputs
                  .din                  (pad_pmux_din[3]),       // Templated
                  // Inouts
                  .pad                  (PA[3]),                 // Templated
                  // Inputs
                  .dout                 (pmux_pad_dout[3]),      // Templated
                  .oe                   (pmux_pad_oe[3]),        // Templated
                  .ie                   (pmux_pad_ie[3]));        // Templated


   std_pad U_PA4 (
                  /*AUTOINST*/
                  // Outputs
                  .din                  (pad_pmux_din[4]),       // Templated
                  // Inouts
                  .pad                  (PA[4]),                 // Templated
                  // Inputs
                  .dout                 (pmux_pad_dout[4]),      // Templated
                  .oe                   (pmux_pad_oe[4]),        // Templated
                  .ie                   (pmux_pad_ie[4]));        // Templated


   std_pad U_PA5 (
                  /*AUTOINST*/
                  // Outputs
                  .din                  (pad_pmux_din[5]),       // Templated
                  // Inouts
                  .pad                  (PA[5]),                 // Templated
                  // Inputs
                  .dout                 (pmux_pad_dout[5]),      // Templated
                  .oe                   (pmux_pad_oe[5]),        // Templated
                  .ie                   (pmux_pad_ie[5]));        // Templated


   std_pad U_PA6 (
                  /*AUTOINST*/
                  // Outputs
                  .din                  (pad_pmux_din[6]),       // Templated
                  // Inouts
                  .pad                  (PA[6]),                 // Templated
                  // Inputs
                  .dout                 (pmux_pad_dout[6]),      // Templated
                  .oe                   (pmux_pad_oe[6]),        // Templated
                  .ie                   (pmux_pad_ie[6]));        // Templated


   std_pad U_PA7 (
                  /*AUTOINST*/
                  // Outputs
                  .din                  (pad_pmux_din[7]),       // Templated
                  // Inouts
                  .pad                  (PA[7]),                 // Templated
                  // Inputs
                  .dout                 (pmux_pad_dout[7]),      // Templated
                  .oe                   (pmux_pad_oe[7]),        // Templated
                  .ie                   (pmux_pad_ie[7]));        // Templated

   std_pad U_PA8 (
                  /*AUTOINST*/
                  // Outputs
                  .din                  (pad_pmux_din[8]),       // Templated
                  // Inouts
                  .pad                  (PA[8]),                 // Templated
                  // Inputs
                  .dout                 (pmux_pad_dout[8]),      // Templated
                  .oe                   (pmux_pad_oe[8]),        // Templated
                  .ie                   (pmux_pad_ie[8]));        // Templated

   std_pad U_PA9 (
                  /*AUTOINST*/
                  // Outputs
                  .din                  (pad_pmux_din[9]),       // Templated
                  // Inouts
                  .pad                  (PA[9]),                 // Templated
                  // Inputs
                  .dout                 (pmux_pad_dout[9]),      // Templated
                  .oe                   (pmux_pad_oe[9]),        // Templated
                  .ie                   (pmux_pad_ie[9]));        // Templated

   std_pad U_PA10 (
                  /*AUTOINST*/
                   // Outputs
                   .din                 (pad_pmux_din[10]),      // Templated
                   // Inouts
                   .pad                 (PA[10]),                // Templated
                   // Inputs
                   .dout                (pmux_pad_dout[10]),     // Templated
                   .oe                  (pmux_pad_oe[10]),       // Templated
                   .ie                  (pmux_pad_ie[10]));       // Templated

   std_pad U_PA11 (
                  /*AUTOINST*/
                   // Outputs
                   .din                 (pad_pmux_din[11]),      // Templated
                   // Inouts
                   .pad                 (PA[11]),                // Templated
                   // Inputs
                   .dout                (pmux_pad_dout[11]),     // Templated
                   .oe                  (pmux_pad_oe[11]),       // Templated
                   .ie                  (pmux_pad_ie[11]));       // Templated

   std_pad U_PA12 (
                  /*AUTOINST*/
                   // Outputs
                   .din                 (pad_pmux_din[12]),      // Templated
                   // Inouts
                   .pad                 (PA[12]),                // Templated
                   // Inputs
                   .dout                (pmux_pad_dout[12]),     // Templated
                   .oe                  (pmux_pad_oe[12]),       // Templated
                   .ie                  (pmux_pad_ie[12]));       // Templated

   std_pad U_PA13 (
                  /*AUTOINST*/
                   // Outputs
                   .din                 (pad_pmux_din[13]),      // Templated
                   // Inouts
                   .pad                 (PA[13]),                // Templated
                   // Inputs
                   .dout                (pmux_pad_dout[13]),     // Templated
                   .oe                  (pmux_pad_oe[13]),       // Templated
                   .ie                  (pmux_pad_ie[13]));       // Templated

   std_pad U_PA14 (
                  /*AUTOINST*/
                   // Outputs
                   .din                 (pad_pmux_din[14]),      // Templated
                   // Inouts
                   .pad                 (PA[14]),                // Templated
                   // Inputs
                   .dout                (pmux_pad_dout[14]),     // Templated
                   .oe                  (pmux_pad_oe[14]),       // Templated
                   .ie                  (pmux_pad_ie[14]));       // Templated

   std_pad U_PA15 (
                  /*AUTOINST*/
                   // Outputs
                   .din                 (pad_pmux_din[15]),      // Templated
                   // Inouts
                   .pad                 (PA[15]),                // Templated
                   // Inputs
                   .dout                (pmux_pad_dout[15]),     // Templated
                   .oe                  (pmux_pad_oe[15]),       // Templated
                   .ie                  (pmux_pad_ie[15]));       // Templated

   // Special pad

   std_pad U_TDI (
                   .dout                (),
                   .pad                 (TDI),                //
                   .din                 (pad_jtag_tdi),     //
                   .oe               (1'b0),    //
                   .ie               (1'b1));    //

   std_pad U_TDO (
                  .dout                (tap_pad_tdo),     //
                  .pad                 (TDO),                //
                  .din                 (),     //
                  .oe               (tap_pad_tdo_oe),    //
                  .ie               (1'b0));    //
   std_pad U_TMS (

                  .dout                (),     //
                  .pad                 (TMS),                //
                  .din                 (pad_tap_tms),     //
                  .oe               (1'b0),    //
                  .ie               (1'b1));    //

   std_pad U_TCK (
                  .dout                (),     //
                  .pad                 (TCK),                //
                  .din                 (pad_tap_tck),     //
                  .oe               (1'b0),    //
                  .ie               (1'b1));    //



endmodule // top_io
/*
 Local Variables:
 verilog-library-directories:(
 "."
 "../ips"
 )
 End:
 */
