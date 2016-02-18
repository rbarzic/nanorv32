# Welcome to the NanoRv32  project

_Under construction_

A small 32-bit implementation of the RISC-V architecture
Highlights :
    - 2-stage pipeline (fetch, execute)
    - lot of code is generated from a high level description
    - written in verilog (using iverilog or Xilinx xvsim as simulator)

Still under development
  - currently supporting only RV32I base instructions (no scall,sbreak,rd*)
  - No interrupt support yet

FPGA version available (Digilent ARTY board - Xilinx Artix7)



## Project layout

_Outdated_

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


    riscv-opcodes

    ips           # Modules created using Xilinx Vivado
    rtl           # Verilog RTL files for the project
    sim           # Verilog simulation directory
    synt          # synthesis directory
    verilator_sim # Verilator build/simulation directory
    software      # Local testsuites (asm/c programs)
    import        # imported github submodules (currently only amba_components)
    docs          # the mkdocs/markdown sources for this site
    site          # generated html/js files for this site


## Installation

### Cloning from github

This project uses submodules. To clone it you need to run the following commands :

```bash
 git clone git@github.com:rbarzic/nanorv32.git
 cd nanorv32
 git submodule init
 git submodule update
```

TBD : check --recursive option for clone (from which git version this is available)

### Setting environment variables


## Compiling test programs

Test programs are located under the software directory.

To compile, enter the directory of the program and type :
`make all`

Several files (bin, hex, vmem and vmem32,..) should be created

## Simulation  using Icarus iverilog

Go into a test program directory (under software/xxx) then :

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
