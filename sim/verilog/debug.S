        .section .isr_vector

        addi x5,x0,0x5
        addi x4,x0,0x0

loop:   addi x1,x0,0x55
        addi x2,x0,0xAA
        addi x4,x4,1
        bne  x4,x5,loop
        addi x3,x0,0x11
        li x7,6
        beq x4,x7,pass
        bne x4,x7,fail
fail:
	lui	a0,0xdead
	j	exit

pass:
	lui	a0,0xcaffe
	j	exit


	.org 0x100
exit:    nop
	nop
	j exit
