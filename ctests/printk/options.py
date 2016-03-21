cfg['simulation']['timeout_ns'] = 2000000
cfg['c_compiler']['extra_c_sources'] = '$(TOP)/common/clib/printf-stdarg.c'

if target_fpga:
    cfg['c_compiler']['extra_c_sources'] += ' $(TOP)/common/clib/uart.c '
    cfg['c_compiler']['extra_defines'] = '-DUART_PUTCHAR=putchar_uart0'

cfg['c_compiler']['extra_incdirs'] = '-I$(TOP)/common/clib'
