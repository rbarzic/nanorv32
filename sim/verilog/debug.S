        .section .isr_vector
        li x1,0x55
        li x5,0xAA
        li x2,0xF0000000
        nop
        sw x1,0(x2)
        lw x3,0(x2)
        bne x3,x1,fail
        beq x3,x1,pass

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
