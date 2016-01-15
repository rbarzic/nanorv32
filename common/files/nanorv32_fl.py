context = {
    'top': '/home/ronan/perso/github/nanorv32',
}

def nanor32_fl():

    l = list()
    d = list()

    # Core
    l.append({
        'file': "{top}/rtl/cores/picorv32.v",
        'targets': 'synt,sim_rtl'
    })


    # peripherals

    # nothing for now

    # Arty specific file


    l.append({
        'file': "{top}/sim/verilog/testbench.v",
        'targets': 'sim_rtl'
    })


    return l, d
