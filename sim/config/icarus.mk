# Icarus verilog specific makefile



EXTRA_V_SRC=$(wildcard $(TEST_DIR)/*.v)

ifeq ($(EXTRA_V_SRC),)
VCD_EXTRA_MODULE=
else
VCD_EXTRA_MODULE=-DVCD_EXTRA_MODULE=,$(TEST)
endif

_ICARUS_OPTS += $(SIMULATOR_ICARUS_OPTIONS)
_ICARUS_OPTS += $(SIMULATOR_ICARUS_WARNINGS)
_ICARUS_OPTS += -DTB=$(SIMULATION_TESTBENCH_NAME)
_ICARUS_OPTS += $(VCD_EXTRA_MODULE) -f iverilog_file_list.txt $(EXTRA_V_SRC)



_ICARUS_SIM += $(VERILOG_PARAMETER)
_ICARUS_SIM += $(SIMULATOR_ICARUS_VVP_OPT)
_ICARUS_SIM += +program_memory=$(TEST_DIR)/$(TEST).vmem

icarus_rtl_build:
	@python $(TOP)/common/files/main.py --topdir=$(TOP)  --iverilog=$(TEST_DIR)/iverilog_file_list.txt
	cd $(TEST_DIR)  && iverilog $(_ICARUS_OPTS)  -o testbench.exe

icarus_rtl_elab:
	@echo "-I- Nothing to do here..."

icarus_rtl_sim:
	cd $(TEST_DIR) && vvp testbench.exe  $(_ICARUS_SIM)
