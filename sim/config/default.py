define['c_compiler']['prefix'] = 'MAKE_VARIABLE'
cfg['c_compiler']['prefix'] = 'riscv32-unknown-elf-'

define['c_compiler']['cc'] = 'MAKE_VARIABLE'
cfg['c_compiler']['cc'] = '$(C_COMPILER_PREFIX)gcc'

define['c_compiler']['objdump'] = 'MAKE_VARIABLE'
cfg['c_compiler']['objdump'] = '$(C_COMPILER_PREFIX)objdump'

define['c_compiler']['objcopy'] = 'MAKE_VARIABLE'
cfg['c_compiler']['objcopy'] = '$(C_COMPILER_PREFIX)objcopy'

define['c_compiler']['makehex'] = 'MAKE_VARIABLE'
cfg['c_compiler']['makehex'] = '$(TOP)/common/scripts/makehex.py'


define['c_compiler']['arch_opt'] = 'MAKE_VARIABLE'
if rvc:
    cfg['c_compiler']['arch_opt'] = '-m32 -march=RV32IMC'
else:
    cfg['c_compiler']['arch_opt'] = '-m32 -march=RV32IM'

define['c_compiler']['warnings'] = 'MAKE_VARIABLE'
cfg['c_compiler']['warnings'] = "-Wall -Wextra -Wshadow -Wundef -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings "


cfg['c_compiler']['warnings'] += " -Wredundant-decls -Wstrict-prototypes  -pedantic # -Wconversion "

define['c_compiler']['optimisation_options'] = 'MAKE_VARIABLE'
cfg['c_compiler']['optimisation_options'] = '-O3'

define['c_compiler']['target_options'] = 'MAKE_VARIABLE'
if target_fpga:
    cfg['c_compiler']['target_options'] = ' -DFPGA=1 '
else:
    cfg['c_compiler']['target_options'] = ''


define['c_compiler']['linker_script_path'] = 'MAKE_VARIABLE'
cfg['c_compiler']['linker_script_path'] = '$(TOP)/common/linker_scripts'

define['c_compiler']['linker_script'] = 'MAKE_VARIABLE'
cfg['c_compiler']['linker_script'] = '$(LINKER_SCRIPT_PATH)/nanorv32_rom_sram.ld'

define['c_compiler']['startup_code'] = 'MAKE_VARIABLE'
cfg['c_compiler']['startup_code'] = "$(TOP)/common/startup/startup.S"

define['c_compiler']['startup_code_opt'] = 'MAKE_VARIABLE'
cfg['c_compiler']['startup_code_opt'] = " -D_STARTUP_DATA_INIT_ -D_STARTUP_BSS_INIT_"

define['c_compiler']['default_lib_opt'] = 'MAKE_VARIABLE'
cfg['c_compiler']['default_lib_opt'] = "-ffreestanding -nostdlib"


define['c_compiler']['extra_c_sources'] = 'MAKE_VARIABLE'
cfg['c_compiler']['extra_c_sources'] = ''

define['c_compiler']['extra_incdirs'] = 'MAKE_VARIABLE'
cfg['c_compiler']['extra_incdirs'] = ''

define['c_compiler']['extra_defines'] = 'MAKE_VARIABLE'
cfg['c_compiler']['extra_defines'] = ''


define['simulation']['timeout_ns'] = 'VERILOG_PARAMETER'
cfg['simulation']['timeout_ns'] = 10000000

define['simulation']['default_exit_address'] = ('VERILOG_PARAMETER','C_DEFINE', 'VERILOG_DEFINE')
cfg['simulation']['default_exit_address'] = '0x00000100'

define['simulation']['testbench_name'] = ('VERILOG_PARAMETER','MAKE_VARIABLE')
cfg['simulation']['testbench_name'] = "tb_nanorv32"




# ICARUS iverilog simulator

define['simulator']['icarus']['options'] = 'MAKE_VARIABLE'
cfg['simulator']['icarus']['options'] = '-g2005 -DIVERILOG=1'

define['simulator']['icarus']['warnings'] = 'MAKE_VARIABLE'
cfg['simulator']['icarus']['warnings'] = '-Wall -W no-timescale'

define['simulator']['icarus']['vvp_opt'] = 'MAKE_VARIABLE'
cfg['simulator']['icarus']['vvp_opt'] = ''

define['simulator']['icarus']['gui'] = 'MAKE_VARIABLE'
cfg['simulator']['icarus']['gui'] = ''

if logging:
    cfg['simulator']['icarus']['vvp_opt'] += ' +vcd '

if trace:
    cfg['simulator']['icarus']['options'] += ' -DTRACE='+trace
    cfg['simulator']['icarus']['vvp_opt'] += ' +trace=' + trace

if gui:
    cfg['simulator']['icarus']['gui'] += 'cd $(TEST_DIR) && gtkwave ' + cfg['simulation']['testbench_name'] + '.vcd &'


# VERILATOR simulator

define['simulator']['verilator']['options'] = 'MAKE_VARIABLE'
cfg['simulator']['verilator']['options'] = ' --cc --error-limit 2000'

define['simulator']['verilator']['warnings'] = 'MAKE_VARIABLE'
cfg['simulator']['verilator']['warnings'] = ' '


define['simulator']['verilator']['gui'] = 'MAKE_VARIABLE'
cfg['simulator']['verilator']['gui'] = ''

#if logging:
#    cfg['simulator']['verilator']['vvp_opt'] += ' +vcd '
#else:
#    cfg['simulator']['verilator']['vvp_opt'] += ' '
#
#if trace:
#    cfg['simulator']['verilator']['options'] += ' -DTRACE='+trace


if gui:
    cfg['simulator']['verilator']['gui'] += 'cd $(TEST_DIR) && gtkwave ' + cfg['simulation']['testbench_name'] + '.vcd &'


# Xilinx Vivado  xvlog/xelab/xsim  simulator

define['simulator']['xilinx']['xvlog']['options'] = 'MAKE_VARIABLE'
cfg['simulator']['xilinx']['xvlog']['options'] = '$(XILINX_VIVADO)/data/verilog/src/glbl.v'

define['simulator']['xilinx']['xelab']['options'] = 'MAKE_VARIABLE'
cfg['simulator']['xilinx']['xelab']['options'] = ' --relax --debug all -L unisims_ver $(SIMULATION_TESTBENCH_NAME) glbl  '

define['simulator']['xilinx']['xsim']['options'] = 'MAKE_VARIABLE'
cfg['simulator']['xilinx']['xsim']['options'] = ' work.$(SIMULATION_TESTBENCH_NAME)\\#work.glbl'


define['simulator']['xilinx']['xsim']['batch_or_gui'] = 'MAKE_VARIABLE'

if gui:
    cfg['simulator']['xilinx']['xsim']['batch_or_gui'] = ' -gui '
else:
    cfg['simulator']['xilinx']['xsim']['batch_or_gui'] = ' -runall '


if trace:
    cfg['simulator']['xilinx']['xvlog']['options'] += ' -DTRACE='+trace
    cfg['simulator']['xilinx']['xsim']['options'] += ' +trace=' + trace


# Pysim simulator

define['simulator']['pysim']['options'] = 'MAKE_VARIABLE'
cfg['simulator']['pysim']['options'] = ' '

if trace:
    cfg['simulator']['pysim']['options'] += ' --trace='+trace
