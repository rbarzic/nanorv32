# Makefile to generate tools configuration files

iverilog:
	@python main.py --topdir=../..  --iverilog ../../sim/verilog/iverilog_file_list.txt

vivado_sim:
	@python main.py --topdir=../..  --vivado_sim ../sim/vivado_file_list.txt

vivado_synt:
	@python main.py --topdir=../..  --vivado_synt ../../synt/fpga/vivado_files.tcl


all: iverilog vivado_sim
