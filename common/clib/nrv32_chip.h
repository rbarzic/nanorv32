#pragma once

#define NRV32_CLOCK_FREQ_HZ 50000000 // 50MHz currently

#include "uart.h"
#define NRV32_UART0_BASE (0xF1000000)


#define NRV32_UART0 ((volatile NRV32_UART_Type*) NRV32_UART0_BASE)
