        // Content of Micro-rom, expressed as regular instruction
main:
_reset_seq_start_:
        addi x1,x0,1
        nop
_reset_seq_stop_:

_int_entry_code_start_:
	addi x1,x0,1
	addi x2,x0,2
	addi x3,x0,3
	addi x4,x0,4
	addi x5,x0,5
	addi x6,x0,6
	addi x7,x0,7
	addi x8,x0,8

	nop
        nop
_int_entry_code_stop_:


_int_exit_code_start_:
	addi x1,x0,3
	nop
_int_exit_code_stop_:
