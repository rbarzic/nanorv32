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
    'desc' : "Analog test mode",

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



ip['rcosc']['pads']['out'] = {
    'dout' : '@_pad_tx_dout',

}



pads['P0']['pmux']= {
    'A' : 'uart0/tx',
    'B' : 'spi/miso',
    'anatest1' : 'rscoc/out'
}

pads['P1']['pmux']= {
    'func_A' : 'uart0/rx',
    'func_B' : 'spi/mosi',
    'anatest1' : 'rscoc/out'
}


def get_control_signals(cfg):
    return [x for x in cfg['pad']['control']]


for pad  in pads.keys():
    print "-I Port {}".format(pad)
    # get functions used by this pad, sorted by decreasing priority
    ordered_func = [f for f in pads[pad]['pmux']]
    pp.pprint(ordered_func)
