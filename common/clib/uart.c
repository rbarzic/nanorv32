#include <stdint.h>
#include "uart.h"
#include "nrv32_chip.h"

void uart_init(volatile NRV32_UART_Type* uart,uint32_t baudrate) {
    uart->BAUD = baudrate;

}

void uart_wait_for_not_busy(volatile NRV32_UART_Type* uart) {
    while(uart->USR & (1<<3)); // UART_USR_TX_BUSY : bit 3
}

int putchar_uart0(int c) {
    uart_wait_for_not_busy(NRV32_UART0);
    NRV32_UART0->UDR  = c & 0x0FF;

    return c & 0x0FF;
}
