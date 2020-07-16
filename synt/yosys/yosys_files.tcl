verilog_defaults -add -I ../../adv_debug_sys/Hardware/jtag/tap/rtl/verilog/
verilog_defaults -add -I ../../adv_debug_sys/Hardware/adv_dbg_if/rtl/verilog/
verilog_defaults -add -I ../../rtl/cores/
verilog_defaults -add -I ../../rtl/chips/
verilog_defaults -add -I ../../sim/verilog/
verilog_defaults -add -I ../../rtl/imported_from_ultraembedded
read_verilog ../../rtl/cores/nanorv32_div.v
read_verilog ../../rtl/cores/nanorv32_csr.v
read_verilog ../../rtl/cores/nanorv32_alumuldiv.v
read_verilog ../../rtl/cores/nanorv32_flow_ctrl.v
read_verilog ../../rtl/cores/nanorv32_prefetch.v
read_verilog ../../rtl/cores/nanorv32_regfile.v
read_verilog ../../rtl/cores/nanorv32_decoder.v
read_verilog ../../rtl/cores/nanorv32_urom.v
read_verilog ../../rtl/cores/nanorv32.v
read_verilog ../../rtl/cores/nanorv32_pil.v
read_verilog ../../adv_debug_sys/Hardware/jtag/tap/rtl/verilog/tap_top.v
read_verilog ../../adv_debug_sys/Hardware/adv_dbg_if/rtl/verilog/adbg_or1k_status_reg.v
read_verilog ../../adv_debug_sys/Hardware/adv_dbg_if/rtl/verilog/adbg_wb_biu.v
read_verilog ../../adv_debug_sys/Hardware/adv_dbg_if/rtl/verilog/adbg_or1k_module.v
read_verilog ../../adv_debug_sys/Hardware/adv_dbg_if/rtl/verilog/bytefifo.v
read_verilog ../../adv_debug_sys/Hardware/adv_dbg_if/rtl/verilog/adbg_or1k_biu.v
read_verilog ../../adv_debug_sys/Hardware/adv_dbg_if/rtl/verilog/adbg_jsp_biu.v
read_verilog ../../adv_debug_sys/Hardware/adv_dbg_if/rtl/verilog/syncflop.v
read_verilog ../../adv_debug_sys/Hardware/adv_dbg_if/rtl/verilog/adbg_top.v
read_verilog ../../adv_debug_sys/Hardware/adv_dbg_if/rtl/verilog/adbg_wb_module.v
read_verilog ../../adv_debug_sys/Hardware/adv_dbg_if/rtl/verilog/adbg_jsp_module.v
read_verilog ../../adv_debug_sys/Hardware/adv_dbg_if/rtl/verilog/adbg_crc32.v
read_verilog ../../adv_debug_sys/Hardware/adv_dbg_if/rtl/verilog/syncreg.v
read_verilog ../../wisbone_2_ahb/src/ahbmas_wbslv_top.v
read_verilog ../../rtl/ips/bytewrite_ram_32bits.v
read_verilog ../../rtl/ips/cmsdk_ahb_ram.v
read_verilog ../../rtl/ips/ahb_to_ssram.v
read_verilog ../../rtl/ips/HastiBus.v
read_verilog ../../rtl/ips/HastiSlaveMux.v
read_verilog ../../rtl/ips/HastiXbar.v
read_verilog ../../rtl/ips/Ahbmli.v
read_verilog ../../rtl/ips/Apbbridge.v
read_verilog ../../rtl/ips/gpio_apb.v
read_verilog ../../rtl/ips/cpuctrl.v
read_verilog ../../rtl/ips/reset_generator.v
read_verilog ../../rtl/imported_from_ultraembedded/uart.v
read_verilog ../../rtl/imported_from_ultraembedded/uart_periph.v
read_verilog ../../rtl/imported_from_ultraembedded/intr_periph.v
read_verilog ../../rtl/imported_from_ultraembedded/timer_periph.v
read_verilog ../../rtl/ips/uart_wrapper.v
read_verilog ../../rtl/ips/timer_wrapper.v
read_verilog ../../rtl/ips/nanorv32_intc.v
read_verilog ../../rtl/chips/nanorv32_irq_mapper.v
read_verilog ../../rtl/chips/nanorv32_clkgen.v
read_verilog ../../rtl/chips/port_mux.v
read_verilog ../../rtl/ips/std_pad.v
read_verilog ../../libraries/local/stdiocell/v/stdiocell.v
read_verilog ../../rtl/chips/top_io.v
read_verilog ../../rtl/chips/primitive_clock_start.v
read_verilog ../../rtl/chips/chip.v
