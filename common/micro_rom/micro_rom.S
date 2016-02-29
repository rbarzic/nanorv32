        // Content of Micro-rom, expressed as regular instruction
main:
_reset_seq_start_:
        addi x1,x0,1
        nop
_reset_seq_stop_:

_int_entry_code_start_:
        sw x1,-8(sp)
	sw x2,-12(sp)  // sp
	sw x5,-16(sp)
	sw x6,-20(sp)
	sw x7,-24(sp)
	sw x10,-28(sp)
	sw x11,-32(sp)
	sw x12,-36(sp)
	sw x13,-40(sp)
	sw x14,-44(sp)
	sw x15,-48(sp)
	add x1,x0,-1 // 0xFFFFFFFF in x1/ra
	auipc x1,0  // get the pc of the current instruction (?)
	sw x1,-52(sp)
	add sp,sp,-52
        andi sp,sp,-4 // clear the 2 lsbs
        lw  x10,0x80(x0) 	// branch to the vector address (0x80 in byte address)
        jalr x0,x10,0x0          // Get the vector address

_int_entry_code_stop_:


_int_exit_code_start_:
	addi x1,x0,3
	nop
_int_exit_code_stop_:
