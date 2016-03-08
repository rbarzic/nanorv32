#include <stdint.h>

void delay(uint32_t d) {
    uint32_t volatile i;
    i = d;
    while(--i);

}

int main(void) {
    delay(500);
    return 0;

}
