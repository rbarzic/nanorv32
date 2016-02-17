        .section .isr_vector
loop_counter = x8
loop_max     = 10000000

        li t1,0x1
        li t2,0xF0000000
        nop
gpio_loop:
        sw t1,0(t2)
        jal ra,delay
        nop
        sw x0,0(t2)
        nop

        jal ra,delay
        j gpio_loop


delay:  li t3,loop_max
delay_loop:
        addi t3,t3,-1
        bne x0,t3,delay_loop
        jalr x0,ra

pass:
	lui	a0,0xcaffe
	j	exit

fail:
	lui	a0,0xdead
	j	exit


	.org 0x100
exit:    nop
	nop
	j exit
