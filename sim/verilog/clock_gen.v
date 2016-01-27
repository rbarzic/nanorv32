//********************************************************************
//
//  clock_gen.v
//
//  This file is part of the DLX3 project
//  http://
//
//  Description     :  A simple clock generator for DLX3 testbench
//
//
//  Author          :  rbarzic@gmail.com
//  Date            :  Mon Jan 31 23:15:45 2011
//
//********************************************************************
//
// Copyright (C) 2010 Ronan Barzic
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//********************************************************************
`timescale 1ns/1ps

module clock_gen (/*AUTOARG*/
  // Outputs
  clk
  );
  parameter period = 100;

  output clk;


  reg    clk;
  always #(period/2) clk = !clk;

  initial begin
    clk = 1'b0;
  end


endmodule // clock_gen
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
