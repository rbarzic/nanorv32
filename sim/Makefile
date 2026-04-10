TOP:=$(shell cd ..; pwd)

regression: $(TOP)/common/instructions/rv32e_base.txt
	@cat $(TOP)/common/instructions/rv32e_base.txt | xargs -I{} ./runtest.py ../riscv-tests/isa/rv32ui/{}.S | grep FAILED

regression_rvc: $(TOP)/common/instructions/rv32e_base.txt
	cat $(TOP)/common/instructions/rv32e_base.txt | xargs -I{} ./runtest.py --rvc ../riscv-tests/isa/rv32ui/{}.S | grep FAILED


RUN_TEST?=../ctests/dhry
TEST_OPT?= --cdefines=NO_RD_INST=1

# Generic test selector for check_* targets.
# Usage: make check_ovr TEST=uart_simple
TEST?=gpio_toggle
TEST_DIR=../ctests/$(TEST)

run_both_icarus:
	./runtest.py -v  --rvc  --sim=pysim --trace=trace.pysim.txt $(TEST_OPT)  $(RUN_TEST)
	./runtest.py -v  --rvc  --sim=icarus --trace=trace.iverilog.txt $(TEST_OPT)  $(RUN_TEST)

run_both_xilinx:
	./runtest.py -v  --rvc  --sim=pysim --trace=trace.pysim.txt $(TEST_OPT)  $(RUN_TEST)
	./runtest.py -v  --rvc  --sim=xilinx --trace=trace.iverilog.txt $(TEST_OPT)  $(RUN_TEST)

# Note : there is a bug in runtest : the --cdefines option does not override the options.py file
# so you must "edit the options.py file to set ITERATIONS to 1 for now
core_both_icarus: RUN_TEST=../ctests/coremark2
core_both_icarus: TEST_OPT=--cdefines=ITERATIONS=1
core_both_icarus:
	./runtest.py -v  --rvc  --sim=pysim --trace=trace.pysim.txt $(TEST_OPT)  $(RUN_TEST)
	./runtest.py -v  --rvc  --sim=icarus --trace=trace.iverilog.txt $(TEST_OPT)  $(RUN_TEST)



compare:
	./diff_trace.py  --pysim=$(RUN_TEST)/trace.pysim.txt --rtlsim=$(RUN_TEST)/trace.iverilog.txt --rvc --skip_inst_comp | tee $(RUN_TEST)/compare.log

core_compare: RUN_TEST=../ctests/coremark2
core_compare:
	./diff_trace.py  --pysim=$(RUN_TEST)/trace.pysim.txt --rtlsim=$(RUN_TEST)/trace.iverilog.txt --rvc --skip_inst_comp | tee $(RUN_TEST)/compare.log

check:
	./runtest.py $(TEST_DIR) -v


check_icarus:
	./runtest.py --sim=icarus $(TEST_DIR) -v -l

check_ovr:
	OVR_BIN=$(realpath ../../../target/release/ovr) ./runtest.py --sim=ovr $(TEST_DIR) -v -l

check_ovr_exe:
	OVR_BIN=$(realpath ../../../target/release/ovr) OVR_TARGET=exe ./runtest.py --sim=ovr $(TEST_DIR) -v -l
