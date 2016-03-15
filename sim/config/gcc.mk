# GCC specific Makefile

C_SRC ?= $(wildcard $(TEST_DIR)/*.c)
S_ASM ?= $(wildcard $(TEST_DIR)/*.S)

CC_FLAGS += $(C_COMPILER_ARCH_OPT)
CC_FLAGS += $(C_COMPILER_OPTIMISATION_OPTIONS)
CC_FLAGS += $(C_COMPILER_WARNINGS)
CC_FLAGS += $(C_COMPILER_STARTUP_CODE_OPT)
CC_FLAGS += $(C_COMPILER_DEFAULT_LIB_OPT)

gcc_compile:
	$(C_COMPILER_CC)   $(CC_FLAGS) \
	$(C_COMPILER_STARTUP_CODE) $(C_SRC) $(C_COMPILER_EXTRA_C_SOURCES) \
	-L $(C_COMPILER_LINKER_SCRIPT_PATH) \
	-T $(C_COMPILER_LINKER_SCRIPT) \
	-o $(TEST_DIR)/$(TEST).elf
	$(C_COMPILER_OBJCOPY) -O binary $(TEST_DIR)/$(TEST).elf $(TEST_DIR)/$(TEST).bin
	$(C_COMPILER_OBJDUMP) -d $(TEST_DIR)/$(TEST).elf > $(TEST_DIR)/$(TEST).lst
	$(C_COMPILER_OBJDUMP) -t $(TEST_DIR)/$(TEST).elf > $(TEST_DIR)/$(TEST).map
	$(C_COMPILER_OBJCOPY) -S $(TEST_DIR)/$(TEST).elf -O verilog $(TEST_DIR)/$(TEST).hex
	hexdump -v -e ' 1/4 "%08x " "\n"' $(TEST_DIR)/$(TEST).bin > $(TEST_DIR)/$(TEST).vmem32 # Xilinx
	hexdump -v -e '"@%08.8_ax  " 1/1 "%02x " "\n"' $(TEST).bin > $(TEST_DIR)/$(TEST_DIR)/$(TEST).vmem # iverilog
	python3 $(C_COMPILER_MAKEHEX) $(TEST_DIR)/$(TEST).bin 16384 > $(TEST_DIR)/$(TEST).hex2
