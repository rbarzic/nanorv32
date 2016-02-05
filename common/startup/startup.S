        .section .isr_vector
        .global start
        .global exit
        .global __data_start__
        .global __data_end__
        .balign 4
#ifdef _STARTUP_DATA_INIT_

        la x2,__data_start__
        la x3,__data_end__
        beq x2,x3,data_loop_done
        la x1,__etext
data_loop:
        lw x4,0(x1)
        sw x4,0(x2)
        addi x2,x2,4
        addi x1,x1,4
        bne      x2,x3, data_loop
data_loop_done:

#endif

        j start
        .org 0x100
exit:   nop
        nop
        j exit
