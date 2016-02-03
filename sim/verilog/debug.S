        .section .isr_vector
        li x1,0x55
        li x5,0xAA
        li x2,0x20000000
        nop
        sw x1,20(x2)
        sw x5,30(x2)
        lw x3,20(x2)
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
