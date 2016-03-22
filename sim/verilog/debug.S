        .section .isr_vector

        li t1,5
        li t2,6


        rdcycle a0
        rdcycleh a1

        rdtime a2
        rdtimeh a3

        rdinstret a4
        rdinstreth a5

        c.add    a4,a4
        c.add    a5,a4
        c.add    a5,a4
        c.add    a5,a4
        c.mv     a5,a1
        c.li     a0,8
        c.slli   a0, 9
        lui      sp, 0x20000
        c.swsp   a0, 0 (sp)
        c.li     a0,8
        c.lwsp   a0, 0 (sp)

        j pass

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
