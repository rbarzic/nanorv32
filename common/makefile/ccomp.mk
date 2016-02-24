GNU_CC_FLAGS += -I$(TOP)/common/include
GNU_CC_FLAGS += -ffreestanding -nostdlib
GNU_CC_FLAGS += -D_STARTUP_DATA_INIT_

$(PROG).elf: $(SRC)
	$(GNU_GCC)  $(GNU_CC_FLAGS)  \
	-L $(LINKER_SCRIPT_PATH) \
	-T $(LINKER_SCRIPT_ROM_SRAM) \
	$(SRC) $(STARTUP_CODE) -o $(PROG).elf
	$(GNU_OBJCOPY) -O binary $(PROG).elf $(PROG).bin
	$(GNU_OBJDUMP) -d $(PROG).elf > $(PROG).lst
	$(GNU_OBJDUMP) -t $(PROG).elf > $(PROG).map
	$(GNU_OBJCOPY) -S $(PROG).elf -O verilog $(PROG).hex
	hexdump -v -e ' 1/4 "%08x " "\n"' $(PROG).bin > $(PROG).vmem32
