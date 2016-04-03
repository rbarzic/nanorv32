#!/usr/bin/env python
import sys
import AutoVivification as av

import pprint as pp

cfg = av.AutoVivification()
ips = av.AutoVivification()
pads = av.AutoVivification()
instances = av.AutoVivification()

cfg['pad']['function']['A'] = {
    'priority' : 100,
    'desc' : "GPIO alternate function A",

}

cfg['pad']['function']['B'] = {
    'priority' : 99,
    'desc' : "GPIO alternate function B",

}

cfg['pad']['function']['C'] = {
    'priority' : 98,
    'desc' : "GPIO alternate function C",

}


cfg['pad']['function']['anatest1'] = {
    'priority' : 200,
    'desc' : "Analog test mode 1",

}

cfg['pad']['function']['anatest2'] = {
    'priority' : 199,
    'desc' : "Analog test mode 2",

}




# List the signals supported for pad control
cfg['pad']['control']['dout'] = {
    'desc' : "Data to be outputed to the pad",
    'dir' : 'ip2pad',
    'default' : 0,
    'polarity' : 'active_high'
}


cfg['pad']['control']['din'] = {
    'desc' : "Data from pad",
    'dir' : 'ip2pad',
    'default' : 0,
    'polarity' : 'active_high'
}

cfg['pad']['control']['oe'] = {
    'desc' : "Pad outpule enable",
    'dir' : 'ip2pad',
    'default' : 0,
    'polarity' : 'active_high'
}




ips['usart']['sig_grp']['tx'] = {
    'dout' : '@_pad_tx_dout',
    'oe' : '@_pad_tx_oe',

}

ips['usart']['sig_grp']['rx'] = {
    'din' : 'pad_@_rx_din',

}


ips['spi']['sig_grp']['mosi'] = {
    'dout' : '@_pad_mosi_dout',
    'oe' : '@_pad_mosi_oe',
    'din' : 'pad_@_mosi_din',

}

ips['spi']['sig_grp']['miso'] = {
    'dout' : '@_pad_miso_dout',
    'oe' : '@_pad_miso_oe',
    'din' : 'pad_@_miso_din',

}


instances['usart0'] = 'usart'
instances['usart0'] = 'usart'
instances['spi'] = 'spi'
instances['rcosc'] = 'rcosc'
instances['bandgap'] = 'bandgap'


ips['rcosc']['sig_grp']['tclk'] = {
    'dout' : '@_pad_tclk_dout',

}

ips['bandgap']['sig_grp']['ten'] = {
    'oe'   : "1'b0",
    'din'   : 'pad_@_ten_din',

}



pads['P0']['pmux']= {
    'A' : 'usart0/tx',
    'B' : 'spi/miso',
    'anatest1' : 'rcosc/tclk'
}

pads['P1']['pmux']= {
    'func_A' : 'usart0/rx',
    'func_B' : 'spi/mosi',
    'anatest2' : 'bandgap/ten'
}


def get_control_signals(cfg):
    return [x for x in cfg['pad']['control']]

def get_pad_functions(pads,pad):
    "return the list of functions mapped to a particular pad"
    return pads[pad]['pmux'].keys()

def type_of_instance(inst):
    if inst in instances:
        return instances[inst]
    else:
        print "-E- instance {} not found !".format(inst)



for pad  in pads.keys():
    print "-I Port {}".format(pad)
    # get functions used by this pad, sorted by decreasing priority
    ordered_func = [f for f in pads[pad]['pmux']]
    pp.pprint(ordered_func)
    control_signals = get_control_signals(cfg)
    pp.pprint(control_signals)
    print "*"*80
    for pad,pmux in  pads.items():
        print "-I- Pad {}".format(pad)
        # pp.pprint(get_pad_functions(pads,pad))
        pad_funcs = [f for f in ordered_func if f in get_pad_functions(pads,pad)]
        for func in pad_funcs:
            inst = pmux['pmux'][func].split('/')[0]
            ip        = type_of_instance( inst)
            sig_group = pmux['pmux'][func].split('/')[1]
            print "-I-     Function {} - Inst : {}({}) Signal group : {}".format(func,inst,ip,sig_group)
            # get each signals
            # all_signals = ips[ip]['sig_grp'][sig_group]
            # TODO : check correctness of sigmal group
            if ip in ips:
                all_signals = ips[ip]['sig_grp'][sig_group]
                for ctrl,sig in all_signals.items():
                    print "-I          signal {} for controlling <{}>".format(sig,ctrl)
            else:
                print "-E- Unknown IP : {}".format(ip)

            # print "-I-       Signal".format(sig)
