import glob
import file_list as fl
import pprint as pp
import os

context = {
    'top': '/home/ronan/perso/github/nanorv32',
}

def nanor32_fl(context):

    l = list()
    d = list()

    # Core
    l.append({
        'file': "{top}/rtl/cores/nanorv32_div.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/cores/nanorv32_ascii.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/cores/nanorv32_alu.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/cores/nanorv32_csr.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/cores/nanorv32_alumuldiv.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/cores/nanorv32_flow_ctrl.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/cores/nanorv32_prefetch.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/cores/nanorv32_regfile.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/cores/nanorv32_decoder.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/cores/nanorv32_urom.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/cores/nanorv32.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/cores/nanorv32_pil.v",
        'targets': 'synt,sim_rtl'
    })

    # Debug system
    ## TAP
    l.append({
        'file': "{top}/adv_debug_sys/Hardware/jtag/tap/rtl/verilog/tap_top.v",
        'targets': 'synt,sim_rtl'
    })

    d.append({
        'dir': "{top}/adv_debug_sys/Hardware/jtag/tap/rtl/verilog/",
        'targets': 'synt,sim_rtl'
    })
    ############################################################################
    # adv_debug_sys files - We use some helper functions
    ############################################################################
    dbg_fl = fl.glob_v_file(
        "{top}/adv_debug_sys/Hardware/adv_dbg_if/rtl/verilog",
        context,
        exclude_list=[
            "adbg_wb_defines.v",
            "adbg_defines. v",
            "adbg_or1k_defines.v",
            "adbg_defines.v",
        ]
    )
    # everything from adv_debug_sys is ok for RTL or synt
    for f in dbg_fl:
        l.append({
            'file' : f,
            'targets': 'synt,sim_rtl',
        })

    d.append({
        'dir': "{top}/adv_debug_sys/Hardware/adv_dbg_if/rtl/verilog/",
        'targets': 'synt,sim_rtl'
    })

    l.append({
        'file': "{top}/wisbone_2_ahb/src/ahbmas_wbslv_top.v",
        'targets': 'synt,sim_rtl'
    })

    # peripherals

    # Chip top levels
    l.append({
        'file': "{top}/rtl/ips/bytewrite_ram_32bits.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/ips/cmsdk_ahb_ram.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/ips/ahb_to_ssram.v",
        'targets': 'synt,sim_rtl'
    })
    # Ahbmli is split now
    l.append({
        'file': "{top}/rtl/ips/HastiBus.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/ips/HastiSlaveMux.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/ips/HastiXbar.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/ips/Ahbmli.v",
        'targets': 'synt,sim_rtl'
    })

    l.append({
        'file': "{top}/rtl/ips/Apbbridge.v",
        'targets': 'synt,sim_rtl'
    })

    l.append({
        'file': "{top}/rtl/ips/gpio_apb.v",
        'targets': 'synt,sim_rtl'
    })

    l.append({
        'file': "{top}/rtl/imported_from_ultraembedded/uart.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/imported_from_ultraembedded/uart_periph.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/imported_from_ultraembedded/intr_periph.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/imported_from_ultraembedded/timer_periph.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/ips/uart_wrapper.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/ips/timer_wrapper.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/ips/nanorv32_intc.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/chips/nanorv32_irq_mapper.v",
        'targets': 'synt,sim_rtl'
    })



    l.append({
        'file': "{top}/rtl/chips/nanorv32_clkgen.v",
        'targets': 'sim_rtl'
    })

    # Arty specific file
    l.append({
        'file': "{top}/rtl/ips/clock_manager/arty_mmcm/arty_mmcm_clk_wiz.v",
        'targets': 'sim_xilinx,synt_xilinx'
    })
    l.append({
        'file': "{top}/rtl/ips/clock_manager/arty_mmcm/arty_mmcm.v",
        'targets': 'sim_xilinx,synt_xilinx'
    })

    l.append({
        'file': "{top}/rtl/chips/nanorv32_clkgen_xilinx.v",
        'targets': 'sim_xilinx,synt_xilinx'
    })

    l.append({
        'file': "{top}/rtl/chips/port_mux.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/ips/std_pad.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/chips/top_io.v",
        'targets': 'synt,sim_rtl'
    })



    l.append({
        'file': "{top}/rtl/chips/nanorv32_simpleahb.v",
        'targets': 'synt,sim_rtl'
    })



    # Testbench
    l.append({
        'file': "{top}/sim/verilog/reset_gen.v",
        'targets': 'sim_rtl'
    })
    l.append({
        'file': "{top}/sim/verilog/clock_gen.v",
        'targets': 'sim_rtl'
    })
    l.append({
        'file': "{top}/sim/verilog/tb_nanorv32.v",
        'targets': 'sim_rtl'
    })

    d.append({
        'dir': "{top}/rtl/cores/",
        'targets': 'synt,sim_rtl'
    })

    d.append({
        'dir': "{top}/rtl/chips/",
        'targets': 'synt,sim_rtl'
    })
    d.append({
        'dir': "{top}/rtl/imported_from_ultraembedded",
        'targets': 'synt,sim_rtl'
    })
    return l, d
