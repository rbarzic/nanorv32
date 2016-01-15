# Welcome to the nanoRV32  project

_Under construction_


In addition to allow synthesis of the designstart to a Xilinx target,
this project allows also simulations using the simulation tools :

  - Icarus iverilog
  - Xilinx simulation tools (xvlog/xelab/xsim)
  - Verilator



## Project layout

_Outdated_

    common        # shared files for configuring the projects
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
