// Infinite loop (for FPGA)
#include <stdint.h>

void delay(uint32_t d) {
    uint32_t volatile i;
    i = d;
    while(--i);

}

int main(void) {
    uint32_t * GPIO_P0 = (uint32_t*)0xF0000000;

    while(1) {
        *GPIO_P0 = 0x01;
        delay(2000000);
        *GPIO_P0 = 0x00;
        delay(2000000);

    }
    return 0;
}
