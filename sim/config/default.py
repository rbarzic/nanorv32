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
cfg['c_compiler']['arch_opt'] = '-m32 -march=RV32IM'

define['c_compiler']['warnings'] = 'MAKE_VARIABLE'
cfg['c_compiler']['warnings'] = "-Werror -Wall -Wextra -Wshadow -Wundef -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings "


cfg['c_compiler']['warnings'] += " -Wredundant-decls -Wstrict-prototypes  -pedantic # -Wconversion "

define['c_compiler']['optimisation_options'] = 'MAKE_VARIABLE'
cfg['c_compiler']['optimisation_options'] = '-O3'


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
cfg['c_compiler']['extra_c_sources'] = '' # Added in  the config.py  in each test







define['simulation']['timeout_ns'] = 'VERILOG_PARAMETER'
cfg['simulation']['timeout_ns'] = 10000000

define['simulation']['default_exit_address'] = ('VERILOG_PARAMETER','C_DEFINE', 'VERILOG_DEFINE')
cfg['simulation']['default_exit_address'] = '0x00000100'

define['simulation']['testbench_name'] = ('VERILOG_PARAMETER')
cfg['simulation']['testbench_name'] = "tb_nanorv32"


define['simulator']['icarus']['options'] = 'MAKE_VARIABLE'
cfg['simulator']['icarus']['options'] = '-g2005 -DIVERILOG=1'

define['simulator']['icarus']['warnings'] = 'MAKE_VARIABLE'
cfg['simulator']['icarus']['warnings'] = '-Wall -W no-timescale'

if trace:
    cfg['simulator']['icarus']['options'] += ' -DTRACE='+trace
