# GCC specific Makefile

C_SRC ?= $(wildcard $(TEST_DIR)/*.c)


CC_FLAGS += $(C_COMPILER_ARCH_OPT)
CC_FLAGS += $(C_COMPILER_OPTIMISATION_OPTIONS)
CC_FLAGS += $(C_COMPILER_WARNINGS)
CC_FLAGS += $(C_COMPILER_STARTUP_CODE_OPT)
CC_FLAGS += $(C_COMPILER_DEFAULT_LIB_OPT)
CC_FLAGS += $(C_COMPILER_EXTRA_INCDIRS)
CC_FLAGS += $(C_DEFINES)
CC_FLAGS += $(C_COMPILER_EXTRA_DEFINES)
CC_FLAGS += $(C_COMPILER_TARGET_OPTIONS)


# we split the tasks to get correct return error code (Make will stop on first error)
gcc_compile: _gcc_compile gcc_bin gcc_lst gcc_map gcc_hex gcc_vmem32 gcc_vmem gcc_hex2



_gcc_compile:
	$(C_COMPILER_CC)   $(CC_FLAGS) \
	$(C_COMPILER_STARTUP_CODE) $(C_SRC) $(C_COMPILER_EXTRA_C_SOURCES) \
	-L $(C_COMPILER_LINKER_SCRIPT_PATH) \
	-T $(C_COMPILER_LINKER_SCRIPT) \
	-o $(TEST_DIR)/$(TEST).elf

gcc_bin:
	$(C_COMPILER_OBJCOPY) -O binary $(TEST_DIR)/$(TEST).elf $(TEST_DIR)/$(TEST).bin

gcc_lst:
	$(C_COMPILER_OBJDUMP) -d $(TEST_DIR)/$(TEST).elf > $(TEST_DIR)/$(TEST).lst

gcc_map:
	$(C_COMPILER_OBJDUMP) -t $(TEST_DIR)/$(TEST).elf > $(TEST_DIR)/$(TEST).map

gcc_hex:
	$(C_COMPILER_OBJCOPY) -S $(TEST_DIR)/$(TEST).elf -O verilog $(TEST_DIR)/$(TEST).hex

gcc_vmem32:
	hexdump -v -e ' 1/4 "%08x " "\n"' $(TEST_DIR)/$(TEST).bin > $(TEST_DIR)/$(TEST).vmem32 # Xilinx

gcc_vmem:
	hexdump -v -e '"@%08.8_ax  " 1/1 "%02x " "\n"' $(TEST).bin > $(TEST_DIR)/$(TEST_DIR)/$(TEST).vmem # iverilog

gcc_hex2:
	python3 $(C_COMPILER_MAKEHEX) $(TEST_DIR)/$(TEST).bin 16384 > $(TEST_DIR)/$(TEST).hex2
