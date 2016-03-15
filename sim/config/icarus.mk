# Icarus verilog specific makefile



EXTRA_V_SRC=$(wildcard $(TEST_DIR)/*.v)

ifeq ($(EXTRA_V_SRC),)
VCD_EXTRA_MODULE=
else
VCD_EXTRA_MODULE=-DVCD_EXTRA_MODULE=,$(TEST)
endif

_ICARUS_OPTS += $(SIMULATOR_ICARUS_OPTIONS)
_ICARUS_OPTS += $(SIMULATOR_ICARUS_WARNINGS)
_ICARUS_OPTS += $(VCD_EXTRA_MODULE) -f   iverilog_file_list.txt $(EXTRA_V_SRC)


icarus_build:
	cd $(TOP)/sim/verilog  && iverilog $(_ICARUS_OPTS)  -o $(TEST_DIR)/testbench.exe

icarus_elab:
	@echo "-I- Nothing to do here..."

icarus_sim:
	cd $(TEST_DIR) && vpp $(TEST_DIR)/testbench.exe $(VERILOG_PARAMETER)
