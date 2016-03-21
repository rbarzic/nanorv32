cfg['c_compiler']['extra_c_sources'] = ' $(TOP)/common/clib/printf-stdarg.c '
if target_fpga:
    cfg['c_compiler']['extra_c_sources'] += ' $(TOP)/common/clib/uart.c '

cfg['c_compiler']['extra_incdirs'] = '-I$(TOP)/common/clib'

cfg['c_compiler']['extra_defines'] = ' -DTIME '

if target_fpga:
    cfg['c_compiler']['extra_defines'] += ' -DUART_PUTCHAR=putchar_uart0 '

# We override the warnings
cfg['c_compiler']['warnings'] = "-Wall "
