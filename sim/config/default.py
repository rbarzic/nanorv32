define['c_compiler']['cc'] = 'MAKE_VARIABLE'
cfg['c_compiler']['cc'] = 'arm-none-eabi-gcc'

define['c_compiler']['opt_options'] = 'MAKE_VARIABLE'
cfg['c_compiler']['opt_options'] = '-O3'


define['simulation']['timeout_ns'] = 'VERILOG_PARAMETER'
cfg['simulation']['timeout_ns'] = 10000000

define['simulation']['default_exit_address'] = ('VERILOG_PARAMETER','C_DEFINE', 'VERILOG_DEFINE')
cfg['simulation']['default_exit_address'] = '0x00000100'
