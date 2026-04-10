# OVR simulator specific makefile

OVR_EXTRA_V_SRC=$(wildcard $(TEST_DIR)/*.v)

# Path to OVR binary
OVR_BIN ?= ovr

# OVR backend target (sim/exe)
OVR_TARGET ?= sim

# Keep VCD outputs distinct per backend target to avoid stale-file confusion.
ifeq ($(OVR_TARGET),exe)
OVR_VCD_FILENAME := $(SIMULATION_TESTBENCH_NAME)_ovr_exe.vcd
else
OVR_VCD_FILENAME := $(SIMULATION_TESTBENCH_NAME)_ovr_sim.vcd
endif

# Build options (defines)
_OVR_OPTS += $(VERILOG_DEFINES)
_OVR_OPTS += $(SIMULATOR_OVR_OPTIONS)
_OVR_OPTS += $(SIMULATOR_OVR_WARNINGS)
_OVR_OPTS += -DTB=$(SIMULATION_TESTBENCH_NAME)
_OVR_OPTS += -DVCD_FILENAME=\"$(OVR_VCD_FILENAME)\"

# Convert VERILOG_PARAMETER (+key=val) to OVR --plusarg key=val
_OVR_PLUSARGS = $(foreach p,$(VERILOG_PARAMETER),--plusarg $(patsubst +%,%,$(p)))
_OVR_PLUSARGS += --plusarg program_memory=$(TEST_DIR)/$(TEST).vmem

# VCD support
ifneq ($(SIMULATOR_OVR_VCD_OPT),)
_OVR_PLUSARGS += --plusarg vcd=1
endif

# Read file list (one flag/file per line, collapsed by shell)
_OVR_FILES = $(shell cat $(TEST_DIR)/ovr_file_list.txt) $(OVR_EXTRA_V_SRC)

ovr_rtl_build:
	@python3 $(TOP)/common/files/main.py --topdir=$(TOP) --ovr=$(TEST_DIR)/ovr_file_list.txt

ovr_rtl_elab:
	@echo "-I- Nothing to do here..."

ovr_rtl_sim:
	cd $(TEST_DIR) && $(OVR_BIN) -t $(OVR_TARGET) -g 2005 $(_OVR_OPTS) $(_OVR_PLUSARGS) $(_OVR_FILES)
	$(SIMULATOR_OVR_GUI)
