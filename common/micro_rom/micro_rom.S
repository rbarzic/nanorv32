        // Content of Micro-rom, expressed as regular instruction
main:
_reset_seq_start_:
        addi x1,x0,1
        nop
_reset_seq_stop_:

_int_entry_code_start_:
        // lsb of load/store adresses are forced to zero
        // in the hardware
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
	auipc x5,0  // get the pc of the current instruction (?)
	sw x5,-52(sp)
	add sp,sp,-52
        lw  x10,0x80(x0) 	// branch to the vector address (0x80 in byte address)
        jalr x0,x10,0x0          // Get the vector address

_int_entry_code_stop_:
_int_exit_code_start_:

        lw x1,-8+52(sp)

	lw x5,-16+52(sp)
	lw x6,-20+52(sp)
	lw x7,-24+52(sp)
	lw x10,-28+52(sp)
	lw x11,-32+52(sp)
	lw x12,-36+52(sp)
	lw x13,-40+52(sp)
	lw x14,-44+52(sp)
	lw x15,-48+52(sp)
        lw x0,-52+52(sp)  // we put back the original PC in x0 (which is readable/writable in this context)
        lw x2,-12+52(sp)   // we restore the original sp (may be not 32-bit aligned)
	// there should be not more use of sp
        // Jump to the previously saved PC address
	jalr x0,x0,0x0          // in this particular case, x0 is not zero !!

_int_exit_code_stop_:
