source vivado_utils.tcl

set top_ds [string trim $env(CORTEXM0_DS)]
set xilinx_part [string trim $env(XILINX_PART)]
set top ..

# Cortex-M0 files

set verilog_files []
set include_dir []

source vivado_files.tcl


foreach vfile $verilog_files {
    read_verilog $vfile
}





read_xdc ./xilinx_constraints.xdc



# synth_design -include_dirs $include_dir -top cmsdk_mcu -part $xilinx_part
# for debugging timing loops
synth_design -include_dirs $include_dir -top nanorv32_simple  -part $xilinx_part -flatten_hierarchy none

set outputDir ./rpt
file mkdir $outputDir

report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
report_utilization -file $outputDir/post_synth_util.rpt

check_timing -override_defaults loops -verbose > post_synt_loops.rpt



#read_verilog "$top_ds/logical/cmsdk_ahb_to_apb/verilog/cmsdk_ahb_to_apb.v"
#
#
#read_verilog "$top_ds/logical/models/memories/cmsdk_ahb_memory_models_defs.v"
#
#read_verilog "$top_ds/logical/models/memories/cmsdk_ahb_ram_beh.v"
#read_verilog "$top_ds/logical/models/memories/cmsdk_ahb_rom.v"
#read_verilog "$top_ds/logical/models/clkgate/cmsdk_clock_gate.v"
#read_verilog "$top_ds/logical/cmsdk_ahb_gpio/verilog/cmsdk_ahb_to_iop.v"
#
#
#
#

#read_verilog "$top_ds/systems/cortex_m0_mcu/verilog/tb_cmsdk_mcu.v"
#read_verilog "$top_ds/systems/cortex_m0_mcu/verilog/cmsdk_uart_capture.v"

#
#read_verilog "$top_ds/systems/cortex_m0_mcu/verilog/cmsdk_clkreset.v"
#read_verilog "$top_ds/systems/cortex_m0_mcu/verilog/cmsdk_mcu.v"
#read_verilog "$top_ds/systems/cortex_m0_mcu/verilog/cmsdk_mcu_defs.v"
#
#
#
#



opt_design
reportCriticalPaths $outputDir/post_opt_critpath_report.csv

check_timing -override_defaults loops -verbose > post_opt_loops.rpt
place_design
report_clock_utilization -file $outputDir/clock_util.rpt

check_timing -override_defaults loops -verbose > post_place_loops.rpt

#
# Optionally run optimization if there are timing violations after placement
if {[get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -setup]] < 0} {
puts "Found setup timing violations => running physical optimization"
phys_opt_design
}
write_checkpoint -force $outputDir/post_place.dcp
report_utilization -file $outputDir/post_place_util.rpt
report_timing_summary -file $outputDir/post_place_timing_summary.rpt
#
# STEP#5: run the router, write the post-route design checkpoint, report the routing
# status, report timing, power, and DRC, and finally save the Verilog netlist.
#
route_design
write_checkpoint -force $outputDir/post_route.dcp
report_route_status -file $outputDir/post_route_status.rpt
report_timing_summary -file $outputDir/post_route_timing_summary.rpt
report_power -file $outputDir/post_route_power.rpt
report_drc -file $outputDir/post_imp_drc.rpt
#write_verilog -force $outputDir/cpu_impl_netlist.v -mode timesim -sdf_anno true
#
# STEP#6: generate a bitstream
#
write_bitstream -force $outputDir/cpu.bit

# STEP #7 : netlist with timing
write_verilog -force -mode timesim -sdf_anno true chip_layout.v
write_sdf -force chip_layout.sdf

# STEP #8 : output BRAM location information
source report_bram.tcl > bram.yaml
