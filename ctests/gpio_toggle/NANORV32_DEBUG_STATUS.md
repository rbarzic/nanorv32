# nanorv32 Debug Status — CPU EXECUTING!

## Test Suite: 77/77 VCD tests passing + 5/17 ivltests passing
## Performance: ~1600 timesteps/sec for nanorv32

## MILESTONE: CPU executes instructions!

PC starts at 0x00000000 during reset, begins incrementing at @180:
- 0x00000004 at @180 (first instruction after pipeline fill)
- Increments by 4 every 24 time units (one clock period)
- Reaches 0x00000668 at @9996
- Matches icarus timing exactly (PC starts at 180000ps in icarus VCD)

## Working Signal Chain
```
CLOCK_GEN.clk toggles @12
  → CLKIN → U_DUT.CLKIN → U_DUT.clk (instant, inline CA depth 100)
  → CPU.clk → PREFETCH, FLOW_CTRL, REG_FILE, ALU clocks

RESET_GEN.rst_n → rst_cpu_n = 0 @1, = 1 @96
  → CPU.rst_n propagates to all child modules

pstate_r: RESET(0) @1 → CONT(1) @108
force_stall_pstate: 1 @1 → 0 @108
fifo_empty: 1 @1 → 0 @156 (first instruction fetched!)
stall_exe: 1 @1 → 0 @156 (pipeline unstalled!)
wr_pt_r: 0→2→4 (instruction fetch pointer advances)
pc_exe_r: 0x00000004 @180, increments by 4 each cycle
```

## Remaining Issues
1. PC only increments linearly (no branches) — instruction decode may not fully work
2. $display format strings show literal %x instead of formatted values
3. Test hasn't reached PASS condition (PC=0x100 with specific register values)
4. Performance: reaching the test timeout at 1B time units would take ~174 hours
