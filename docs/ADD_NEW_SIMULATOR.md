# Adding a New Verilog Simulator to the Flow

This document describes how to add support for a new Verilog simulator to the nanorv32 test infrastructure.

## Overview

The test runner (`runtest.py`) uses a modular approach where each simulator is defined by:
1. A `*.mk` file in `sim/config/` containing Makefile targets
2. Configuration entries in `sim/config/default.py` for simulator-specific options
3. An entry in the `choices` list in `runtest.py` (line ~165)

## Steps to Add a New Simulator

### 1. Add Simulator Choice to runtest.py

In `sim/runtest.py`, add your simulator name to the `choices` list:

```python
parser.add_argument('-s', '--simulator', action='store', dest='simulator',
                    default='icarus',
                    choices = ['icarus','xilinx','pysim','verilator','yoursim'],
                    help='Select simulator')
```

### 2. Create the Makefile Fragment

Create `sim/config/yoursim.mk` with these mandatory targets:

```makefile
# yoursim.mk - Your Simulator Name

# Optional: Extra Verilog sources in test directory
YOURSIM_EXTRA_V_SRC=$(wildcard $(TEST_DIR)/*.v)

# Optional: Build options (from default.py)
_YOURSIM_OPTS += $(VERILOG_DEFINES)
_YOURSIM_OPTS += $(SIMULATOR_YOURSIM_OPTIONS)
_YOURSIM_OPTS += $(SIMULATOR_YOURSIM_WARNINGS)
_YOURSIM_OPTS += -DTB=$(SIMULATION_TESTBENCH_NAME)

# Optional: Simulation options
_YOURSIM_SIM += $(VERILOG_PARAMETER)
_YOURSIM_SIM += +program_memory=$(TEST_DIR)/$(TEST).vmem

# Mandatory: Build step
yoursim_rtl_build:
	@echo "-I- Build step for your simulator"
	# Your build commands here

# Mandatory: Elaboration step (can be empty)
yoursim_rtl_elab:
	@echo "-I- Nothing to do here..."

# Mandatory: Simulation step
yoursim_rtl_sim:
	cd $(TEST_DIR) && your_simulator_executable $(_YOURSIM_SIM)
	$(SIMULATOR_YOURSIM_GUI)
```

### 3. Include the Makefile Fragment

In `sim/runtest.py`, add your makefile to the footer template (around line 36-42):

```python
tpl_main_makefile_footer  = """

include {config_rel_dir}/gcc.mk
include {config_rel_dir}/icarus.mk
include {config_rel_dir}/verilator.mk
include {config_rel_dir}/xilinx.mk
include {config_rel_dir}/pysim.mk
include {config_rel_dir}/yoursim.mk   # <-- Add this line

...
"""
```

### 4. Add Configuration Options (optional)

In `sim/config/default.py`, add simulator-specific configuration:

```python
# YOURSIM simulator
define['simulator']['yoursim']['options'] = 'MAKE_VARIABLE'
cfg['simulator']['yoursim']['options'] = '--your-option'

define['simulator']['yoursim']['warnings'] = 'MAKE_VARIABLE'
cfg['simulator']['yoursim']['warnings'] = ''

define['simulator']['yoursim']['gui'] = 'MAKE_VARIABLE'
cfg['simulator']['yoursim']['gui'] = ''

# Example: Enable waveform logging
if logging:
    cfg['simulator']['yoursim']['options'] += ' +vcd'

# Example: Enable tracing
if trace:
    cfg['simulator']['yoursim']['options'] += ' -DTRACE='+trace
```

## Makefile Targets

Each simulator must implement these targets:

| Target | Description | Required |
|--------|-------------|----------|
| `{sim}_rtl_build` | Compile Verilog sources | Yes |
| `{sim}_rtl_elab` | Elaborate/link design | Yes |
| `{sim}_rtl_sim` | Run simulation | Yes |

## Configuration Types

Variables in `default.py` can have different types:

| Type | Makefile Output | Purpose |
|------|-----------------|---------|
| `'MAKE_VARIABLE'` | `VAR=value` | Makefile variables |
| `'VERILOG_PARAMETER'` | `+var=value` | Plusargs for Verilog |
| `'C_DEFINE'` | `-DVAR=value` | C preprocessor defines |
| `'VERILOG_DEFINE'` | `-DVAR=value` | Verilog `defines |

## Testing

Run your simulator with:

```bash
./runtest.py --sim=yoursim ../ctests/gpio_toggle -v -l
```

## Example: Minimal Non-Verilog Simulator

For a pure Python simulator (like `pysim`), the Makefile is simpler:

```makefile
# pysim.mk
pysim_rtl_build:
	@echo "-I- Nothing to do here..."

pysim_rtl_elab:
	@echo "-I- Nothing to do here..."

pysim_rtl_sim:
	cd $(TEST_DIR) && $(TOP)/common/spec/nanorv32_simulator.py --hex2=$(TEST_DIR)/$(TEST).hex2
```
