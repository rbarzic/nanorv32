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
    sim           # directory containing the simulation launcher
    synt/fpga     # main directory for FPGA synthesis using Xilinx Vivado




## Installation

### Cloning from github

This project uses submodules. To clone it you need to run the following commands :

```bash
git clone git@github.com:rbarzic/nanorv32.git
cd nanorv32
git submodule update --init
```

### Dependencies

On debian/Unbuntu :

```bash
sudo apt-get install build-essential gtkwave
```



#### Icarus verilog

Using  the latest version from github is recommended.

See https://github.com/steveicarus/iverilog

#### Riscv32 gcc

A 32-bit version of the toolchain is needed.

To build such a toolchain, please follws the instruction provided by the PicoRV32 project on github :

https://github.com/cliffordwolf/picorv32#building-a-pure-rv32i-toolchain


#### Others

To run the regression on multiple cores at a time, you need GNU parallel.

On debian/Unbuntu :

```bash
sudo apt-get install parallel
```


## Simulation  using Icarus iverilog


### Running a test written in C

C-based tests are located under the <top>/ctests directory.
Each test consists in one or several C files together with a configuration file *options.py*.

C compilation, RTL database compilation and simulation can be launched with the Python script *runtest.py* under the <top>/sim directory

Under sim :

```bash
#./runtest.py  <path to test directory>
# Example :
./runtest.py  ../ctests/gpio_toggle

```

The result should be

```
[OK]      gcc_compile
[OK]      icarus_rtl_build
[OK]      icarus_rtl_elab
[OK]      icarus_rtl_sim

```

To see the commands used during the C compilation, the Verilog compilation and the simulation, add the option *-v* to the previous command line.





### Viewing the waveform

First, the simulation must be launched with the -l option to turn-on the logging of all signals to a vcd file :

```bash
# Example :
./runtest.py  -v -l ../ctests/gpio_toggle

```



Then  using gtkwave, you can open the vcd file that has been created in the directory of the test

```bash
tkwave ../ctests/gpio_toggle/tb_nanorv32.vcd &
```


## Synthesis using Vivado

First, set-up Vivado environment :
```bash
source /opt/Xilinx/Vivado/<vivado version>/settings64.sh
```

Then, in the <top>/synt/fpga directory, type :

```bash
make synt
```

Note : The code is loaded in the ROM using the file
synt/fpga/code.hex. So if you want to have a specific program preloaded, you must make a link between an existing *.hex2 file to the code.hex before launching the synthesis.

Important note : The reset pin in mapped to the SW0 switc on the ARTY7 board. The switch must be in the position toward the board center for the reset to be released.


## Uploading code using the JTAG port


The Nanorv32 project includes a JTAG interface (implemented using the adv_debug_sys project) that allows new CPU code to be uploaded into the FPGA without the need of a new synthesis.

A python script for uploading code using a FT232H-based USB-to-JTAG converter is provided under <top>/jtag.

### JTAG pin mapping for the Arty7 board

The JTAG pins are mapped on the JB connector (TCK is a special clock pin)


| Pin  | FPGA pin |  Arty7 JB pin name |  Arty7 JB pin number | FT232H pin  |
| ---- | -------- | ------------------ |  -------------------  | -----------|
| TMS  | E15      |        P1            |         1             | AD3 (16)   |
| TDI  | E16      |        P2            |         2             | AD1 (14)   |
| TCK  | D15      |        P3            |         3             | AD0 (13)   |
| TDO  | C15      |        P3            |         4             | AD2 (15)   |

(P5 is GND and P6 is VCC on the JB 2x6 PMOD connector)


### C Code compilation

The compilation of the C code to be uploaded is done using the same python script (runtest.py) as for the simulation.
The *.c* option must be used if you want to  prevent   the RTL database compilation and simulation.

```bash
# For example (while under <top>/sim) :
./runtest.py -c -v ../ctests/gpio_toggle_infinite
```

A Intel hex file is created under the test directory test


### Code upload

The Intel hex file can be uploaded using the following command :
```bash
# Example (while under <top>/sim) :
sudo ../jtag/nanorv32_jtag_uploader.py ../ctests/gpio_toggle_infinite/gpio_toggle_infinite.ihex -r
```
The *-r* option is used to force a reset after the code upload so that the CPU can start executing the code right away




The pyftdi and intelhex Python modules  may need to be installed for the comman above to work properly :
```bash
sudo pip install pyftdi intelhex
```




## Simulation  using Vivado (outdated)


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
