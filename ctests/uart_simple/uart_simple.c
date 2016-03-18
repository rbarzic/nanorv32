#include <stdint.h>
#include "nrv32_chip.h"

void delay(uint32_t d) {
    uint32_t volatile i;
    i = d;
    while(--i);

}

int main(void) {
    volatile uint32_t * UART_USR = (uint32_t*)0xF1000004;
    volatile uint32_t * UART_UDR = (uint32_t*)0xF1000008;
    volatile uint32_t * UART_BAUD = (uint32_t*)0xF100000C;
    int i;

    // *UART_BAUD = 0x03;
    // *UART_UDR = 0x55;

    NRV32_UART0->BAUD = 0x55;
    NRV32_UART0->UDR  =0xAA;
    delay(100);
    return 0;
}
