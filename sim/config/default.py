define['c_compiler']['cc'] = 'MAKE_VARIABLE'
cfg['c_compiler']['cc'] = 'arm-none-eabi-gcc'

define['c_compiler']['arch_opt'] = 'MAKE_VARIABLE'
cfg['c_compiler']['arch_opt'] = '-m32 -march=RV32IM'

define['c_compiler']['warnings'] = 'MAKE_VARIABLE'
cfg['c_compiler']['warnings'] = "-Werror -Wall -Wextra -Wshadow -Wundef -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings"


cfg['c_compiler']['warnings'] += "-Wredundant-decls -Wstrict-prototypes -Wmissing-prototypes -pedantic # -Wconversion"

define['c_compiler']['opt_options'] = 'MAKE_VARIABLE'
cfg['c_compiler']['opt_options'] = '-O3'


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
