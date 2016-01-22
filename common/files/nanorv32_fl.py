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
        'file': "{top}/rtl/chips/nanorv32_simple.v",
        'targets': 'synt,sim_rtl'
    })

    # Arty specific file

    # Testbench
    l.append({
        'file': "{top}/sim/verilog/reset_gen.v",
        'file': "{top}/sim/verilog/clock_gen.v",
        'file': "{top}/sim/verilog/tb_nanorv32.v",
        'targets': 'sim_rtl'
    })

    d.append({
        'dir': "{top}/rtl/cores/",
        'targets': 'synt,sim_rtl'
    })
    return l, d
