# nanorv32 gpio_toggle Test Failure Investigation

## Summary
OVR fails the nanorv32 gpio_toggle test while iverilog passes, revealing issues with large, complex designs.

## Test Results
- **iverilog:** TEST OK ✓
- **OVR:** TEST FAILED (PC is X) ✗

## Root Cause Analysis

### What We Found
1. PC is monitored via deep hierarchical reference: `tb_nanorv32.U_DUT.U_NANORV32_PIL.U_CPU.pc_exe_r`
2. OVR parses the design correctly (9117 signals, 2390 processes)
3. Hierarchical signal references work in simple test cases
4. Replication operator `{32{value}}` works correctly
5. Non-blocking assignments work correctly in isolation

### What Fails
- **PC remains at X (undefined)** when it should reach 0x00000100 at program start
- The PC update logic: `pc_exe_r <= {32{~reset_over}} & pc_next;` appears correct but doesn't update properly

### Why Unit Tests Pass But System Test Fails
- 1298/1313 iverilog tests are small, focused unit tests
- They test individual language features in isolation
- nanorv32 is a large (9117 signals), complex RISC-V SoC with multiple interacting subsystems
- The design is auto-generated, not hand-written
- Issues only emerge when combining:
  - Deep module hierarchies (6+ levels)
  - Large signal counts (9000+ signals)
  - Complex reset/clock synchronization
  - Multi-file generated designs

## Hypothesis
There may be a subtle bug in OVR when handling:
1. Very large designs with signal counts > 1000
2. Initialization of signals across multiple module boundaries
3. State propagation in deeply nested hierarchies
4. Generated Verilog with complex interconnect patterns

## Next Steps Needed
1. Simplify nanorv32 to identify the specific failing pattern
2. Check signal initialization at time 0 across module boundaries
3. Verify reset signal propagation in OVR
4. Test intermediate-sized designs to find the complexity threshold
