# Xilinx verilog simulator specific Makefile

EXTRA_V_SRC=$(wildcard $(TEST_DIR)/*.v)

ifeq ($(EXTRA_V_SRC),)
VCD_EXTRA_MODULE=
XELAB_EXTRA_MODULE=
XSIM_EXTRA_MODULE=
else
VCD_EXTRA_MODULE=-DVCD_EXTRA_MODULE=,$(TEST)
XSIM_EXTRA_MODULE=\#work.$(TEST)
endif

##_XILINX_XVLOG_OPTS += --work worklib=$(TEST_DIR)/worklib
##_XILINX_XVLOG_OPTS += -L worklib=$(TEST_DIR)/worklib
_XILINX_XVLOG_OPTS += --define NO_TIME_SCALE -f vivado_file_list.txt $(EXTRA_V_SRC)
_XILINX_XVLOG_OPTS += $(SIMULATOR_XILINX_XVLOG_OPTIONS)
#
#_XILINX_XELAB_OPTS += -L worklib=$(TEST_DIR)/worklib
_XILINX_XELAB_OPTS += $(SIMULATOR_XILINX_XELAB_OPTIONS) $(XELAB_EXTRA_MODULE)

_XILINX_XSIM_OPTS += $(SIMULATOR_XILINX_XSIM_OPTIONS)$(XSIM_EXTRA_MODULE)
_XILINX_XSIM_OPTS += $(subst +, -testplusarg ,$(VERILOG_PARAMETER))
_XILINX_XSIM_OPTS += --testplusarg program_memory=$(TEST_DIR)/$(TEST).vmem
_XILINX_XSIM_OPTS += $(SIMULATOR_XILINX_XSIM_BATCH_OR_GUI)


xilinx_rtl_build:
	@python $(TOP)/common/files/main.py --topdir=$(TOP) --vivado_sim=$(TEST_DIR)/vivado_file_list.txt
	cd $(TEST_DIR)  && xvlog $(_XILINX_XVLOG_OPTS)

xilinx_rtl_elab:
	cd $(TEST_DIR) && xelab $(_XILINX_XELAB_OPTS)

xilinx_rtl_sim:
	cd $(TEST_DIR) && xsim $(_XILINX_XSIM_OPTS)
