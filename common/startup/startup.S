        .section .isr_vector
        .global start
        .global exit
        .global __data_start__
        .global __data_end__
        .balign 4
#ifdef _STARTUP_DATA_INIT_
        la sp,	__StackTop

        la t0,__data_start__
        la t1,__data_end__
        beq t0,t1,data_loop_done
        la t2,__etext
data_loop:
        lw a0,0(t2)
        sw a0,0(t0)
        addi t0,t0,4
        addi t2,t2,4
        bne      t0,t1, data_loop
data_loop_done:

#endif

        jal ra, main
        // if main return 0 -> pass
        beq a0,x0,pass
        bne a0,x0,fail

fail:
	lui	a0,0xdead
	j	exit

pass:
	lui	a0,0xcaffe
	j	exit


        .org 0x100
exit:   nop
        nop
        j exit
