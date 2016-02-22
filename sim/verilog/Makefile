TOP:=$(shell cd ../..; pwd)



include ../../common/makefile/gcc.mk


XARGS=xargs
iverilog_file_list.txt:
	make -C $(TOP)/common/files iverilog

vivado_file_list.txt:
	make -C $(TOP)/common/files vivado_sim


compile:
	iverilog -Wall -g2005 -DIVERILOG=1 -f   iverilog_file_list.txt -o testbench.exe

compile_debug:
	iverilog -W infloop -g2005 -p fileline=1  -DIVERILOG=1 -f   iverilog_file_list.txt -o testbench.exe



clean:
	rm -f testbench.exe

TEST_FUNC_NAME=$(notdir $(basename $(TEST)))
TEST_FUNC_TXT='"$(notdir $(basename $(TEST)))"'
TEST_FUNC_RET=$(notdir $(basename $(TEST)))_ret

TEST_FLAGS = -DTEST_FUNC_NAME=$(TEST_FUNC_NAME)
TEST_FLAGS += -DTEST_FUNC_TXT=$(TEST_FUNC_TXT)
TEST_FLAGS += -DTEST_FUNC_RET=$(TEST_FUNC_RET)
TEST_FLAGS += -I$(TOP)/common/include
TEST_FLAGS += -ffreestanding -nostdlib
TEST_FLAGS += -D_STARTUP_DATA_INIT_

run_rv32ui: ../../riscv-tests/isa/rv32ui/$(TEST).S
	@echo  "===================== TEST $(TEST) ============================"
	mkdir -p logs
	($(GNU_GCC)  $(GNU_CC_FLAGS) $(TEST_FLAGS) \
	-L $(LINKER_SCRIPT_PATH) \
	-T $(LINKER_SCRIPT_ROM_SRAM) \
	$< $(STARTUP_CODE) -o $(TEST).elf  || echo "-I- TEST FAILED (gcc compilation)" >> logs/$(TEST).run.log) | tee  logs/$(TEST).run.log
	$(GNU_OBJCOPY) -O binary $(TEST).elf $(TEST).bin
	$(GNU_OBJDUMP) -d $(TEST).elf > $(TEST).lst
	$(GNU_OBJDUMP) -t $(TEST).elf > $(TEST).map
	$(GNU_OBJCOPY) -S $(TEST).elf -O verilog $(TEST).hex
	hexdump -v -e ' 1/4 "%08x " "\n"' $(TEST).bin > $(TEST).vmem32 # Xilinx
	hexdump -v -e '"@%08.8_ax  " 1/1 "%02x " "\n"' $(TEST).bin > $(TEST).vmem # iverilog
	python3 ./makehex.py $(TEST).bin 16384 > $(TEST).hex2
	vvp testbench.exe  +vcd +program_memory=$(TEST).vmem | tee -a logs/$(TEST).run.log


debug: TEST=debug
debug:
	$(GNU_GCC)  $(GNU_CC_FLAGS) $(TEST_FLAGS) \
	-L $(LINKER_SCRIPT_PATH) \
	-T $(LINKER_SCRIPT_ROM_SRAM) \
	debug.S  -o $(TEST).elf
	$(GNU_OBJCOPY) -O binary $(TEST).elf $(TEST).bin
	$(GNU_OBJDUMP) -d $(TEST).elf > $(TEST).lst
	$(GNU_OBJCOPY) -S $(TEST).elf -O verilog $(TEST).hex
	hexdump -v -e ' 1/4 "%08x " "\n"' $(TEST).bin > $(TEST).vmem32 # Xilinx
	hexdump -v -e '"@%08.8_ax  " 1/1 "%02x " "\n"' $(TEST).bin > $(TEST).vmem # iverilog
	python3 ./makehex.py $(TEST).bin 16384 > $(TEST).hex2
	vvp  -l log.jb  testbench.exe  +vcd +program_memory=$(TEST).vmem


wave:
	gtkwave tb_nanorv32.vcd &

regen:
	make -C $(TOP)/common/spec gen_files
	make -C $(TOP)/common/spec extract insert

check-syntax:
	iverilog -f  iverilog_file_list.txt -o /dev/null




rv32ui.regression.txt:
	find ../../riscv-tests/isa/rv32ui -name "*.S" | xargs -n1 basename --suffix=.S > rv32ui.regression.txt

regression: $(TOP)/common/instructions/rv32e_base.txt compile
	rm -f logs/*
	@cat $(TOP)/common/instructions/rv32e_base.txt | $(XARGS) -n1 -IXXX make -C . run_rv32ui TEST=XXX

regression_p: XARGS=parallel
regression_p: regression
#regression_p: rv32ui.regression.txt compile
#	rm -f logs/*
#	@cat rv32ui.regression.txt | parallel -n1 -IXXX make -C . run_rv32ui TEST=XXX

find_failled:
	@(find logs/  -name "*.run.log" | xargs  grep "\-I\- TEST" | grep FAILED) || echo "No error found !"



run_ctest: ../../ctests/$(TEST)/$(TEST).c
	@echo  "===================== TEST $(TEST) ============================"
	mkdir -p logs
	($(GNU_GCC)  $(GNU_CC_FLAGS) $(TEST_FLAGS) \
	-L $(LINKER_SCRIPT_PATH) \
	-T $(LINKER_SCRIPT_ROM_SRAM) \
	$< $(STARTUP_CODE) -o $(TEST).elf  || echo "-I- TEST FAILED (gcc compilation)" >> logs/$(TEST).run.log) | tee  logs/$(TEST).run.log
	$(GNU_OBJCOPY) -O binary $(TEST).elf $(TEST).bin
	$(GNU_OBJDUMP) -d $(TEST).elf > $(TEST).lst
	$(GNU_OBJDUMP) -t $(TEST).elf > $(TEST).map
	$(GNU_OBJCOPY) -S $(TEST).elf -O verilog $(TEST).hex
	hexdump -v -e ' 1/4 "%08x " "\n"' $(TEST).bin > $(TEST).vmem32 # Xilinx
	hexdump -v -e '"@%08.8_ax  " 1/1 "%02x " "\n"' $(TEST).bin > $(TEST).vmem # iverilog
	python3 ./makehex.py $(TEST).bin 16384 > $(TEST).hex2
	vvp -N testbench.exe  +vcd +program_memory=$(TEST).vmem | tee -a logs/$(TEST).run.log



###################  Xilinx simulation ###############################################
# Xilinx :
# xvlog -f xilinx_vlist.txt
# xelab cmsdk_mcu -relax (because of timescale)
# see ug900
#Step2: Elaborating and Creating a Snapshot
#After analysis, elaborate the design and create a snapshot for simulation using the xelab
#command:
#xelab <topDesignUnitName> -debug typicalx
#IMPORTANT: You can provide multiple top-level design unit names with xelab. To use the Vivado
#simulator workspace for purposes similar to those used during launch_simulation, you must set
#debug level to typical.
#Step 3: Running Simulation
#After successful completion of the xelab phase, the Vivado simulator creates a snapshot
#used for running simulation.
#To invoke the Vivado simulator workspace, use the following command:
#xsim
#<SnapShotName> -gui
#To open the wave config file:
#xsim <SnapShotName> -view <wcfg FileName> -gui
#You can provide multiple wcfg files using multiple -view flags. For example:
#xsim
#<SnapShotName> -view <wcfg FileName> -view <wcfg FileName>

xcomp:
	xvlog --define NO_TIME_SCALE -f vivado_file_list.txt  $(XILINX_VIVADO)/data/verilog/src/glbl.v

xelab:
	xelab -L unisims_ver tb_nanorv32 glbl --relax --debug all

xsim:
	xsim work.tb_nanorv32#work.glbl  -runall

xsim_gui:
	xsim work.tb_nanorv32#work.glbl  -gui






.PHONY: iverilog_file_list.txt vivado_file_list.txt
