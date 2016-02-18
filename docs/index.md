# Welcome to the NanoRv32  project

_Under construction_

A small 32-bit implementation of the RISC-V architecture
Highlights :

- 2-stage pipeline (fetch, execute)
- lot of code is generated from a high level description
- written in verilog (using iverilog or Xilinx xvsim as simulator)

Still under development :
  - currently supporting only RV32I base instructions (no scall,sbreak,rd*)
  - no system register implemented
  - No interrupt support yet
  - no RVC support (16-bit instructions)

FPGA version available (Digilent ARTY board - Xilinx Artix7)



## Project layout


    common/files  # scripts to generate list of verilog files needed for the various targets (simulation, synthesis)
    common/generators # generator for some verilog constructs (like decoder, parameters,...)
    common/include    # C/asm include files (for riscv-tests for example)
    common/instructions # text files listing instructions, for regression testing
    common/linker_scripts # linker script(s) for C and asm programs
    common/makefile # shared Makefile
    common/scripts  # Miscelaneous scripts
    common/spec # architecture/instruction specification as Python data structures
    common/startup # C/asm startup file
    ctests/* # Various tests written in C
    doc_riscv # General Riscv documentation from Internet (when Internet is not available :-) )
    docs # mkdocs source files (this documentation !) see (www.mkdocs.org)
    generated # various generated files from generators
    riscv-opcodes # imported github module, used to create some spec files
    riscv-test    # imported github module, various test programs for the riscv architecture
    rtl/cores     # the nanorv32 CPU files 
    rtl/ips       # "IP" verilog models (memory, peripherals, bus interfaces,....)
    rtl/chips     # top-level and "chip" specific files 
    sim/verilog   # main directory for verilog simulation using iverilog or Xilinx
    synt/fpga     # main directory for FPGA synthesis using Xilinx Vivado




## Installation

### Cloning from github

This project uses submodules. To clone it you need to run the following commands :

```bash
git clone --recursive git@github.com:rbarzic/nanorv32.git nanorv32-clean
```

### Prerequist

#### Icarus verilog

Using  the latest version from github is recommended.

See https://github.com/steveicarus/iverilog

#### Riscv32 gcc

A 32-bit version of the toolchain is needed. See 

```bash
$ git clone git@github.com:riscv/riscv-gnu-toolchain.git
$ cd riscv-gnu-toolchain
$ mkdir build; cd build
$ ../configure --prefix=$RISCV --disable-float --disable-atomic --with-xlen=32 --with-arch=I
$ make install
```



#### Others

To run the regression on multiple cores at a time, you need GNU parallel.

On debian/Unbuntu :

```bash
sudo apt-get install parallel
```

## Simulation  using Icarus iverilog

### Verilog compilation
```bash
make compile
```


## Simulation  using Icarus iverilog

### Verilog compilation
```bash
make compile
```




```bash
# Compile C code
make all
# build iverilog simulator files
make comp
# run the simulation
make run

# optionaly, you can look at waveform using gtkwave
make wave
```

Note : there is no way to stop the simulation from the C code
currently. Hit Ctrl-c then type $finish to exit simulation

## Synthesis using Vivado

## Simulation  using Vivado



## Simulation  using Verilator
