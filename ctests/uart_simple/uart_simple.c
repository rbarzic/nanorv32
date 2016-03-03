#include <stdint.h>

void delay(uint32_t d) {
    uint32_t volatile i;
    i = d;
    while(--i);

}

int main(void) {
    volatile uint32_t * UART_USR = (uint32_t*)0xF1000004;
    volatile uint32_t * UART_UDR = (uint32_t*)0xF1000008;
    int i;

    *UART_UDR = 0x55;
    delay(100);
    return 0;
}
