
[![Build Status](https://travis-ci.org/rbarzic/nanorv32.svg?branch=master)](https://travis-ci.org/rbarzic/nanorv32)
[![Join the chat at https://gitter.im/rbarzic/nanorv32](https://badges.gitter.im/rbarzic/nanorv32.svg)](https://gitter.im/rbarzic/nanorv32?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Stories in Ready](https://badge.waffle.io/rbarzic/nanorv32.png?label=Ready&title=Ready)](https://waffle.io/rbarzic/nanorv32)
[![Stories in Backlog](https://badge.waffle.io/rbarzic/nanorv32.png?label=Backlog&title=Backlog)](https://waffle.io/rbarzic/nanorv32)

# nanorv32


A small 32-bit implementation of the RISC-V architecture

Highlights :

    - 2-stage pipeline (fetch, execute)
    - 2 AHB-lite  master interfaces (Code &  Data)
    - lot of code is generated from a high level description
    - written in verilog (using iverilog or Xilinx xvsim as simulator)
    - RV32I ISA simulator available 

Still under development in dedicated branches: 

  - RVC support 
  - interrupt support (with auto push/pop of registers, like for Cortex-M)
  - debugger support

FPGA version available (Digilent ARTY board - Xilinx Artix7)


See http://rbarzic.github.io/nanorv32 for more information

