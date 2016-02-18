# nanorv32
A small 32-bit implementation of the RISC-V architecture
Highlights :

    - 2-stage pipeline (fetch, execute)
    - lot of code is generated from a high level description
    - written in verilog (using iverilog or Xilinx xvsim as simulator)
    
Still under development

  - currently supporting only RV32I base instructions (no scall,sbreak,rd*)
  - No interrupt support yet
  
FPGA version available (Digilent ARTY board - Xilinx Artix7)


See http://rbarzic.github.io/nanorv32 for more information
