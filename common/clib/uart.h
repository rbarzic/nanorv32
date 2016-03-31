#pragma once
#include <stdint.h>



typedef struct {
    uint32_t _RESERSED0_;
    uint32_t USR;
    uint32_t UDR;
    uint32_t BAUD;

} NRV32_UART_Type;

void uart_init(volatile NRV32_UART_Type* uart, uint32_t baudrate);
void uart_wait_for_not_busy(volatile NRV32_UART_Type* uart);
int putchar_uart0(int c);
