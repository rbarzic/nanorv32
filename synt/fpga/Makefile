# Vivado synt script



XILINX_PART=xc7a35tcsg324-1
export CORTEXM0_DS
export XILINX_PART
synt:
	vivado -mode tcl -source vivado.tcl


mmi:
	python yaml2mmi.py > nanorv32.mmi

# use --debug option below if something is wrong after updating the bitstream
update:
	updatemem --debug -bit rpt/cpu.bit -meminfo nanorv32.mmi  -data ../software/$(TEST)/$(TEST).elf  -proc design/nanorv32 -o $(TEST).bit | tee debug.txt

file_list:
	make -C ../../common/files vivado_synt
