TOOL_CHAIN      ?= gcc


CPU_TYPE        ?= -m32
ARCH_TYPE       ?= -march=RV32IM



GCC_WARNS  = -Werror -Wall -Wextra -Wshadow -Wundef -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings
GCC_WARNS += -Wredundant-decls -Wstrict-prototypes -Wmissing-prototypes -pedantic # -Wconversion


LINKER_SCRIPT_PATH ?= $(TOP)/common/linker_scripts
LINKER_SCRIPT_ROM_SRAM ?= $(LINKER_SCRIPT_PATH)/nanorv32_rom_sram.ld

STARTUP_CODE=$(TOP)/common/startup/startup.S

TOOLCHAIN_PREFIX ?= riscv32-unknown-elf-
GNU_GCC ?= $(TOOLCHAIN_PREFIX)gcc
GNU_OBJDUMP ?= $(TOOLCHAIN_PREFIX)objdump
GNU_OBJCOPY ?= $(TOOLCHAIN_PREFIX)objcopy

OPT_FLAGS ?= -O3

GNU_CC_FLAGS += -std=c99
GNU_CC_FLAGS += $(OPT_FLAGS)
GNU_CC_FLAGS += $(GCC_WARN)
GNU_CC_FLAGS += $(CPU_TYPE)
GNU_CC_FLAGS += $(ARCH_TYPE)
