// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.3 (lin64) Build 1368829 Mon Sep 28 20:06:39 MDT 2015
// Date        : Mon Nov 16 15:47:09 2015
// Host        : roba-OptiPlex-7010 running 64-bit Ubuntu 15.04
// Command     : write_verilog -force -mode synth_stub
//               /home/roba/perso/github/arty-designstart-cm0/ips/clock_manager/arty_mmcm/arty_mmcm_stub.v
// Design      : arty_mmcm
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k70tfbv676-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module arty_mmcm(clk_in, clk_50m, resetn, locked)
/* synthesis syn_black_box black_box_pad_pin="clk_in,clk_50m,resetn,locked" */;
  input clk_in;
  output clk_50m;
  input resetn;
  output locked;
endmodule
