#include <stdint.h>

extern int printf(const char *format, ...);

#ifdef FPGA
#include <stdint.h>
#include "nrv32_chip.h"
#define TARGET_BAUD_RATE 38400
void dhry_uart_init(void) {
    uart_init(NRV32_UART0, NRV32_CLOCK_FREQ_HZ/TARGET_BAUD_RATE);
    printf("-I- Dhrystone on Nanorv32!\n");
}
#else
void dhry_uart_init(void) {};
#endif
