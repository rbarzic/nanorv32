TOP:=$(shell cd ..; pwd)

regression: $(TOP)/common/instructions/rv32e_base.txt
	@cat $(TOP)/common/instructions/rv32e_base.txt | xargs -I{} ./runtest.py ../riscv-tests/isa/rv32ui/{}.S | grep FAILED
