context = {
    'top': '/home/ronan/perso/github/nanorv32',
}

def nanor32_fl():

    l = list()
    d = list()

    # Core
    l.append({
        'file': "{top}/rtl/cores/nanorv32_alu.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/cores/nanorv32_regfile.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/cores/nanorv32.v",
        'targets': 'synt,sim_rtl'
    })



    # peripherals

    # Chip top levels
    l.append({
        'file': "{top}/rtl/ips/bytewrite_ram_32bits.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/ips/nanorv32_tcm_ctrl.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/ips/nanorv32_tcm_arbitrer.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/ips/nanorv32_periph_mux.v",
        'targets': 'synt,sim_rtl'
    })
    l.append({
        'file': "{top}/rtl/ips/nanorv32_gpio_ctrl.v",
        'targets': 'synt,sim_rtl'
    })

    l.append({
        'file': "{top}/rtl/chips/nanorv32_clkgen.v",
        'targets': 'sim_rtl'
    })

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
        'file': "{top}/rtl/chips/nanorv32_simple.v",
        'targets': 'synt,sim_rtl'
    })

    # Arty specific file

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
    return l, d
