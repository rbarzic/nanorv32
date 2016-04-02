TOP:=$(shell cd ..; pwd)

regression: $(TOP)/common/instructions/rv32e_base.txt
	@cat $(TOP)/common/instructions/rv32e_base.txt | xargs -I{} ./runtest.py ../riscv-tests/isa/rv32ui/{}.S | grep FAILED

regression_rvc: $(TOP)/common/instructions/rv32e_base.txt
	cat $(TOP)/common/instructions/rv32e_base.txt | xargs -I{} ./runtest.py --rvc ../riscv-tests/isa/rv32ui/{}.S | grep FAILED


TEST?=../ctests/dhry
TEST_OPT?= --cdefines=NO_RD_INST=1

run_both_icarus:
	./runtest.py -v  --rvc  --sim=pysim --trace=trace.pysim.txt $(TEST_OPT)  $(TEST)
	./runtest.py -v  --rvc  --sim=icarus --trace=trace.iverilog.txt $(TEST_OPT)  $(TEST)

run_both_xilinx:
	./runtest.py -v  --rvc  --sim=pysim --trace=trace.pysim.txt $(TEST_OPT)  $(TEST)
	./runtest.py -v  --rvc  --sim=xilinx --trace=trace.iverilog.txt $(TEST_OPT)  $(TEST)

# Note : there is a bug in runtest : the --cdefines option does not override the options.py file
# so you must "edit the options.py file to set ITERATIONS to 1 for now
core_both_icarus: TEST=../ctests/coremark2
core_both_icarus: TEST_OPT=--cdefines=ITERATIONS=1
core_both_icarus:
	./runtest.py -v  --rvc  --sim=pysim --trace=trace.pysim.txt $(TEST_OPT)  $(TEST)
	./runtest.py -v  --rvc  --sim=icarus --trace=trace.iverilog.txt $(TEST_OPT)  $(TEST)



compare:
	./diff_trace.py  --pysim=$(TEST)/trace.pysim.txt --rtlsim=$(TEST)/trace.iverilog.txt --rvc --skip_inst_comp | tee $(TEST)/compare.log

core_compare: TEST=../ctests/coremark2
core_compare:
	./diff_trace.py  --pysim=$(TEST)/trace.pysim.txt --rtlsim=$(TEST)/trace.iverilog.txt --rvc --skip_inst_comp | tee $(TEST)/compare.log
