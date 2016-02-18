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

### /opt/riscv32i

On debian/Unbuntu :

```bash
sudo apt-get install build-essential gtkwave
```



#### Icarus verilog

Using  the latest version from github is recommended.

See https://github.com/steveicarus/iverilog

#### Riscv32 gcc

A 32-bit version of the toolchain is needed.

See https://github.com/ucb-bar/riscv-sodor#building-a-rv32i-toolchain.

For example :

```bash
$ sudo mkdir -p /opt/riscv32i
$ sudo chown $USER /opt/riscv32i
$ git clone git@github.com:riscv/riscv-gnu-toolchain.git
$ cd riscv-gnu-toolchain
$ mkdir build; cd build
$ ../configure --prefix=/opt/riscv32i  --disable-float --disable-atomic --with-xlen=32 --with-arch=I
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
cd sim/verilog
make compile
```

Note : the file iverilog_file_list.txt is generated from the file common/files/nanorv32_fl.py.
If you need to add verilog files to the project, you should add them to the nanorv32_fl.py file instead and run :

```bash
make iverilog_file_list.txt
```

### Simulation

#### Running a test from the riscv-tests/isa/rv32ui list

Under sim/verilog :

```bash
make run_rv32ui TEST=<test_name>

```

For example :

```bash
make run_rv32ui TEST=addi
```


#### Running a C-based test

C programs are expected to be stored under the ctests/<test_name>/<test_name>.c

Under sim/verilog :

```bash
make run_ctest TEST=<test_name>

```

For example :

```bash
make run_ctest TEST=gpio_toggle
```

### Viewing the waveform


Using gtkwave :

```bash
make wave
```


## Synthesis using Vivado

First, set-up Vivado environment :
```bash
source /opt/Xilinx/Vivado/<vivado version>/settings64.sh
```

Then

```bash
make synt
```

Note : The code is loaded in the ROM using the file
synt/fpga/code.hex. So you must make a link between a existing *.hex2 file to
the code.hex before launching the synthesis.





## Simulation  using Vivado


### Compilation

```bash
make xcomp
make xelab
```
### Simulation (Batch mode)

```bash
make xsim
```

### Simulation (GUI)

```bash
make xsim_gui
```





## Simulation  using Verilator

TBD
