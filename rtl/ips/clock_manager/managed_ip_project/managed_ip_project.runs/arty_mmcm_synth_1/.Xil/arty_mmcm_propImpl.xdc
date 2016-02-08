set_property SRC_FILE_INFO {cfile:/home/roba/perso/github/arty-designstart-cm0/ips/clock_manager/arty_mmcm/arty_mmcm.xdc rfile:../../../../arty_mmcm/arty_mmcm.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:56 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in]] 0.1
