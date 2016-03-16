# Python simualator specific makefile


_ICARUS_OPTS += $(SIMULATOR_ICARUS_OPTIONS)
_ICARUS_OPTS += $(SIMULATOR_ICARUS_WARNINGS)
_ICARUS_OPTS += $(VCD_EXTRA_MODULE) -f   iverilog_file_list.txt $(EXTRA_V_SRC)

_ICARUS_SIM += $(VERILOG_PARAMETER)
_ICARUS_SIM += +program_memory=$(TEST_DIR)/$(TEST).vmem

pysim_rtl_build:
	@echo "-I- Nothing to do here..."


pysim_rtl_elab:
	@echo "-I- Nothing to do here..."

pysim_rtl_sim:
	cd $(TEST_DIR) && $(TOP)/common/spec/nanorv32_simulator.py --hex2=$(TEST_DIR)/$(TEST).hex2
