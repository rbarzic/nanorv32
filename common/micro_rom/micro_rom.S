        // Content of Micro-rom, expressed as regular instruction
main:
_reset_seq_start_:
        addi x1,x0,1
        nop
_reset_seq_stop_:

_int_entry_code_start_:
	addi x1,x0,2
	nop
_int_entry_code_stop_:


_int_exit_code_start_:
	addi x1,x0,3
	nop
_int_exit_code_stop_:
