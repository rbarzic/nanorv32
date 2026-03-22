yosys -import

set process $::env(PROCESS)
set chip $::env(CHIP)

set process_uc [string toupper $process]
set process_lc [string tolower $process]
set git_sha1 [string trim $env(GIT_SHA1)]

set verilog_netlist ${chip}.${process_lc}.ntl.v
set list_lib_tcl list_liberty.${process_lc}.tcl


set lib_files []

puts "-I-  Reading $list_lib_tcl"
source  $list_lib_tcl


foreach {lib_file} $lib_files {
    puts "-I-  Reading library file : $lib_file"
    read_liberty -lib $lib_file
}

verilog_defines -DCHIP_PROCESS="$process_uc" -DCHIP_VERSION_GIT=32'h$git_sha1 -DSYNTHESIS=1 -DSYNT=1 -DNO_RAM_INIT=1

puts "-I-  Reading verilog files"
source  yosys_files.tcl
uniquify

# blackbox bytewrite_ram_32bits


# From Openroad synt script
# Don't change these unless you know what you are doing
set stat_ext    "_stat.rep"
set gl_ext      "_gl.v"
set abc_script  "+read_constr,$::env(SDC_FILE);strash;ifraig;retime,-D,{D},-M,6;strash;dch,-f;map,-p-M,1,{D},-f;topo;dnsize;buffer,-p;upsize;"

synth -top ${chip}

opt -purge

# Not used by the openroadmap script
uniquify


dfflibmap -liberty  $libmax_stdcells
opt
abc  -liberty  $libmax_stdcells

# abc -D [expr $::env(CLOCK_PERIOD) * 1000] \
#     -constr "$::env(SDC_FILE)" \
#     -liberty $libmax_stdcells \
#     -script $abc_script \
#     -showtmp


#  # technology mapping of constant hi- and/or lo-drivers
#  hilomap -singleton \
#          -hicell {*}$::env(TIEHI_CELL_AND_PORT) \
#          -locell {*}$::env(TIELO_CELL_AND_PORT)


# replace undef values with defined constants
setundef -zero

# Splitting nets resolves unwanted compound assign statements in netlist (assign {..} = {..})
splitnets

# insert buffer cells for pass through wires
insbuf -buf {*}$::env(MIN_BUF_CELL_AND_PORTS)

# remove unused cells and wires
opt_clean -purge

# reports
tee -o $::env(REPORTS_DIR)/synth_check.txt check
tee -o $::env(REPORTS_DIR)/synth_stat.txt stat -liberty $libmax_stdcells

# write synthesized design
write_verilog -noattr -noexpr -nohex -nodec $verilog_netlist

#abc  -liberty  $libmax_stdcells
#write_verilog aldebaran.ntl.v
#tee -o report_usage.txt stat  
#
#flatten
#tee -o report_loop.txt scc 
#write_verilog aldebaran.flat.ntl.v
#stat
