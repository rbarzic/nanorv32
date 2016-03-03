#include <stdint.h>

void delay(uint32_t d) {
    uint32_t volatile i;
    i = d;
    while(--i);

}

int main(void) {
    volatile uint32_t * GPIO_P0 = (uint32_t*)0xF0000000;
    int i;
    for(i=0;i<5;i++) {
        *GPIO_P0 = 0x01;
        delay(5);
        *GPIO_P0 = 0x00;
        delay(5);

    }
    return 0;
}
