# Yosys
TOP?=../..
SHELL=bash
current_dir = $(shell pwd)
sim_dir = $(TOP)/sim
GIT_SHA1=$(shell git log -1 --pretty=format:"%h")
SPEC2CFG?=$(TOP)/common/scripts/libspec2cfg.py

CHIP=nanorv32

# Added when using OpenROAD-type script
PROCESS?=nangate45
CLOCK_PERIOD?=100
SDC_FILE?=nanorv32.sdc

# MIN_BUF_CELL_AND_PORTS?=INVX2 A Y
# nangate045 - FIXME
MIN_BUF_CELL_AND_PORTS?=INV_X2 A ZN

REPORTS_DIR?=./reports

export  CHIP  CLOCK_PERIOD SDC_FILE MIN_BUF_CELL_AND_PORTS REPORTS_DIR PROCESS GIT_SHA1

synt: filelist
	mkdir -p $(REPORTS_DIR)
	yosys synthesis.tcl  

# sudo /opt/Xilinx/SDK/2018.1/bin/hw_server
filelist:
	make -C ../../common/files yosys_synt

liblist:
	$(SPEC2CFG) --tool yosys -v  --process $(PROCESS) --top $(TOP) $(TOP)/libraries/libspec.py


all: filelist liblist synt

.PHONY: filelist liblist synt
