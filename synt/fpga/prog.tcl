# Programming file using Vivado
# hw_server must be launched first

open_hw
connect_hw_server -url localhost:3121
current_hw_target [get_hw_targets */xilinx_tcf/Digilent/*]
open_hw_target
set_property PROGRAM.FILE {./rpt/cpu.bit} [lindex [get_hw_devices] 0]
program_hw_devices [lindex [get_hw_devices] 0]
