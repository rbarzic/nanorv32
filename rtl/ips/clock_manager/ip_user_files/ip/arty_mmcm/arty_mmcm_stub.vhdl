-- Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2015.3 (lin64) Build 1368829 Mon Sep 28 20:06:39 MDT 2015
-- Date        : Mon Nov 16 15:47:09 2015
-- Host        : roba-OptiPlex-7010 running 64-bit Ubuntu 15.04
-- Command     : write_vhdl -force -mode synth_stub
--               /home/roba/perso/github/arty-designstart-cm0/ips/clock_manager/arty_mmcm/arty_mmcm_stub.vhdl
-- Design      : arty_mmcm
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k70tfbv676-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity arty_mmcm is
  Port ( 
    clk_in : in STD_LOGIC;
    clk_50m : out STD_LOGIC;
    resetn : in STD_LOGIC;
    locked : out STD_LOGIC
  );

end arty_mmcm;

architecture stub of arty_mmcm is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_in,clk_50m,resetn,locked";
begin
end;
