#include <stdint.h>
#include "nrv32_chip.h"

// in uart_defs.v
// Basic Peripherals
// `define UART_USR                8'h04
//     `define UART_USR_RX_AVAIL       0
//     `define UART_USR_TX_BUSY        3
// `define UART_UDR                8'h08
// `define UART_BAUD               8'h0C

// #define TARGET_BAUD_RATE 38400
#define TARGET_BAUD_RATE 10000000


extern int printf(const char *format, ...);

void delay(uint32_t d) {
    uint32_t volatile i;
    i = d;
    while(--i);

}



int main(void) {

    // *UART_BAUD = 0x03;
    // *UART_UDR = 0x55;
    uart_init(NRV32_UART0, NRV32_CLOCK_FREQ_HZ/TARGET_BAUD_RATE);
    NRV32_UART0->UDR = 0x55;

    printf("-I Hello world !\n");
    //delay(1000);
    return 0;
}
