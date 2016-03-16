# Python simualator specific makefile




pysim_rtl_build:
	@echo "-I- Nothing to do here..."


pysim_rtl_elab:
	@echo "-I- Nothing to do here..."

pysim_rtl_sim:
	cd $(TEST_DIR) && $(TOP)/common/spec/nanorv32_simulator.py --hex2=$(TEST_DIR)/$(TEST).hex2
