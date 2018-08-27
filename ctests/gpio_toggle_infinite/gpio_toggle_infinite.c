// Infinite loop (for FPGA)
#include <stdint.h>
const uint32_t base_delay = 1000000;

void delay(uint32_t d) {
    uint32_t volatile i;
    i = d;
    while(--i);

}

int main(void){
    uint32_t * GPIO_P0 = (uint32_t*)0xF0000000;
    uint32_t i = 0;
    while(1) {
        i++;
        i = i%4;
        *GPIO_P0 = 0x01<<i;
        delay(base_delay);
        *GPIO_P0 = 0x00;
        delay(base_delay);

    }
    return 0;
}
