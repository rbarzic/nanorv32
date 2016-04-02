#!/usr/bin/env python
import AutoVivification as av

import pprint as pp

cfg = av.AutoVivification()
ip = av.AutoVivification()
pads = av.AutoVivification()

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




ip['usart']['pads']['tx'] = {
    'dout' : '@_pad_tx_dout',
    'oe' : '@_pad_tx_oe',

}

ip['usart']['pads']['rx'] = {
    'din' : 'pad_@_rx_din',

}


ip['spi']['pads']['mosi'] = {
    'dout' : '@_pad_mosi_dout',
    'oe' : '@_pad_mosi_oe',
    'din' : 'pad_@_mosi_din',

}

ip['usart']['pads']['miso'] = {
    'dout' : '@_pad_miso_dout',
    'oe' : '@_pad_miso_oe',
    'din' : 'pad_@_miso_din',

}



ip['rcosc']['pads']['tclk'] = {
    'dout' : '@_pad_tclk_dout',

}

ip['bandgap']['pads']['ten'] = {
    'oe'   : "1'b0",
    'din'   : 'pad_@_ten_din',

}



pads['P0']['pmux']= {
    'A' : 'uart0/tx',
    'B' : 'spi/miso',
    'anatest1' : 'rscoc/out'
}

pads['P1']['pmux']= {
    'func_A' : 'uart0/rx',
    'func_B' : 'spi/mosi',
    'anatest2' : 'rscoc/out'
}


def get_control_signals(cfg):
    return [x for x in cfg['pad']['control']]

def get_pad_functions(pads,pad):
    "return the list of functions mapped to a particular pad"
    return pads[pad].keys()

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
        pp.pprint(get_pad_functions(pads,pad))
        pad_funcs = [f for f in ordered_func if f in get_pad_functions(pads,pad)]
        for func in pad_funcs:
            print "-I-     Function {}".format(func)
            pass
