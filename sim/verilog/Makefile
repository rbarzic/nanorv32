TOP:=$(shell cd ../..; pwd)



include ../../common/makefile/gcc.mk

iverilog_file_list.txt:
	make -C $(TOP)/common/files iverilog


compile:
	iverilog -f  iverilog_file_list.txt -o testbench.exe


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

run_rv32ui: ../../riscv-tests/isa/rv32ui/$(TEST).S
	$(GNU_GCC)  $(GNU_CC_FLAGS) $(TEST_FLAGS) \
	-L $(LINKER_SCRIPT_PATH) \
	-T $(LINKER_SCRIPT_ROM_SRAM) \
	$< $(STARTUP_CODE) -o $(TEST).elf
	$(GNU_OBJCOPY) -O binary $(TEST).elf $(TEST).bin
	$(GNU_OBJDUMP) -d $(TEST).elf > $(TEST).lst
	$(GNU_OBJCOPY) -S $(TEST).elf -O verilog $(TEST).hex
	hexdump -v -e ' 1/4 "%08x " "\n"' $(TEST).bin > $(TEST).vmem32 # Xilinx
	hexdump -v -e '"@%08.8_ax  " 1/1 "%02x " "\n"' $(TEST).bin > $(TEST).vmem # iverilog
	python3 ./makehex.py $(TEST).bin 16384 > $(TEST).hex2
	vvp -N testbench.exe  +vcd

regen:
	make -C $(TOP)/common/spec gen_files
	make -C $(TOP)/common/spec extract insert
