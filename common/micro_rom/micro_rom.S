        // Content of Micro-rom, expressed as regular instruction
main:
_reset_seq_start_:
        addi x1,x0,1
        nop
_reset_seq_stop_:

_int_entry_code_start_:
          sw x1,-4(sp)
	  sw x2,-8(sp)  // sp
	  sw x5,-12(sp)
	  sw x6,-16(sp)
	  sw x7,-20(sp)
	  sw x10,-24(sp)
	  sw x11,-28(sp)
	  sw x12,-32(sp)
	  sw x13,-36(sp)
	  sw x14,-40(sp)
	  sw x15,-44(sp)
	  add x1,x0,-1 // 0xFFFFFFFF in x1/ra
	  auipc x1,0  // get the pc of the current instruction (?)
	  sw x1,-48(sp)
	add sp,sp,-48
        lw  x2,0x80(x0) 	// branch to the vector address (0x80 in byte address)
        jalr x0,x2,0x0          // Get the vector address

_int_entry_code_stop_:


_int_exit_code_start_:
	addi x1,x0,3
	nop
_int_exit_code_stop_:
