# Makefile to generate tools configuration files

TOP_DIR?=../..
IVERILOG_DEST_DIR?=../../sim/verilog/
VERILATOR_DEST_DIR?=../../sim/verilog/
VIVADO_SIM_DEST_DIR?=../../sim/verilog
VIVADO_SYNT_DEST_DIR?=../../synt/fpga
YOSYS_SYNT_DEST_DIR?=../../synt/yosys

iverilog:
	@python main.py --topdir=$(TOP_DIR)  --iverilog=$(IVERILOG_DEST_DIR)/iverilog_file_list.txt

verilator:
	@python main.py --topdir=$(TOP_DIR)  --verilator=$(VERILATOR_DEST_DIR)/verilator_file_list.txt

vivado_sim:
	@python main.py --topdir=$(TOP_DIR)  --vivado_sim=$(VIVADO_SIM_DEST_DIR)/vivado_file_list.txt

vivado_synt:
	@python main.py --topdir=$(TOP_DIR)  --vivado_synt=$(VIVADO_SYNT_DEST_DIR)/vivado_files.tcl

yosys_synt:
	@python main.py --topdir=$(TOP_DIR)  --yosys_synt=$(YOSYS_SYNT_DEST_DIR)/yosys_files.tcl



all: iverilog vivado_sim vivado_synt verilator
