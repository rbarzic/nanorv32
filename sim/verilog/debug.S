        .section .isr_vector
loop_counter = x8
loop_max     = 2000000

        li t0,0x1
        li t1,0x1
        li t4,0x1
        li t2,0xF0000000
        nop
gpio_loop:
        sw t0,0(t2)
        jal ra,delay


        addi t1,t1,1
        andi t1,t1,0x0F         //  4 bits only (16 leds)
        sll t0,t4,t1
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
