COMMON_DIR = ../common
DESIGN_FILES = $(COMMON_DIR)/clock_gen.v $(COMMON_DIR)/reset_gen.v design.v
TB_FILES = design_tb.v
TOP_MODULE = design_tb

ifdef VCD
IVERILOG_FLAGS = -DVCD
endif

comp_iverilog:
	iverilog $(IVERILOG_FLAGS) -o design.vvp $(DESIGN_FILES) $(TB_FILES)
run_iverilog: comp_iverilog
	vvp design.vvp
all_iverilog: run_iverilog

OVR ?= ovr
ifdef VCD
OVR_VCDFLAGS = --vcd $(TOP_MODULE)_ovr.vcd
endif
comp_ovr:
	$(OVR) -t sim $(OVR_VCDFLAGS) $(DESIGN_FILES) $(TB_FILES)
all_ovr: comp_ovr

clean:
	rm -f *.vvp *.vcd *.log
.PHONY: comp_iverilog run_iverilog all_iverilog comp_ovr all_ovr clean
