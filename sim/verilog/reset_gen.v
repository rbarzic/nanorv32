//********************************************************************
//
//  reset_gen.v
//
//  This file is part of the DLX3 project
//  http://
//
//  Description     :  Simple reset (active low) generator for DLX3 testbench
//
//
//  Author          :  rbarzic@gmail.com
//  Date            :  Mon Jan 31 23:22:46 2011
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


module reset_gen (/*AUTOARG*/
  // Outputs
  reset_n
  );

  output reset_n;

  parameter duration = 10;
  reg    reset_n;
  initial begin
    reset_n <= 0;
    #duration;
    reset_n <= 1;
  end





endmodule // reset_gen
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
