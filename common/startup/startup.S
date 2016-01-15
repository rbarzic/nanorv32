        .section .isr_vector
        .global start
        .global exit
        .balign 4
        j start
        .org 0x100
exit:   nop
        nop
        j exit
