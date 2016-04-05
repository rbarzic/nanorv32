#!/usr/bin/env python
import sys
import AutoVivification as av

import pprint as pp

cfg = av.AutoVivification()
ips = av.AutoVivification()
pads = av.AutoVivification()
instances = av.AutoVivification()
iocells = av.AutoVivification()
padring  = av.AutoVivification()

pin_muxing = av.AutoVivification()

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



pin_muxing['P0']= {
    'A' : 'usart0/tx',
    'B' : 'spi/miso',
    'anatest1' : 'rcosc/tclk'
}

pin_muxing['P1']= {
    'func_A' : 'usart0/rx',
    'func_B' : 'spi/mosi',
    'anatest2' : 'bandgap/ten'
}


pin_muxing['USBPAD@dm']= {
    'func_A' : 'usb/dm',
}

pin_muxing['USBPAD@dm']= {
    'func_A' : 'usb/dp',
}



padring['P0']['type'] = 'stdpad3v3p180n'
padring['P0']['order'] = 1


padring['P1']['type'] = 'stdpad3v3p180n'
padring['P1']['order'] = 10

padring['USBPAD']['type'] = 'stdpad3v3p180n'
padring['USBPAD']['order'] = 15




# Standard I/O pad
# definition
iocells['stdpad3v3p180n']['type'] = 'io'

# Mapping of IOCELL pin to generic control signal
iocells['stdpad3v3180n']['pads']['pad']['dout'] = {
    'signal' : 'i18dout',
    'polarity' : 'active_high'
}
iocells['stdpad3v3180n']['pads']['pad']['din'] = {
    'signal' : 'o18din',
    'polarity' : 'active_high'
}

iocells['stdpad3v3180n']['pads']['pad']['oe'] = {
    'signal' : 'i18oe',
    'polarity' : 'active_high'
}


# Standard I/O pad
# definition
iocells['usbpad3v3p180n']['type'] = 'custom'

# Mapping of IOCELL pin to generic control signal

# DM pin
iocells['usbpad3v3180n']['pads']['dm']['dout'] = {
    'signal' : 'i18dout[0]',
    'polarity' : 'active_high'
}
iocells['usbpad3v3180n']['pads']['dm']['din'] = {
    'signal' : 'o18din[0]',
    'polarity' : 'active_high'
}

iocells['stdpad3v3180n']['pads']['dm']['oe'] = {
    'signal' : 'i18oe[0]',
    'polarity' : 'active_high'
}
# DP pin
iocells['usbpad3v3180n']['pads']['dp']['dout'] = {
    'signal' : 'i18dout[1]',
    'polarity' : 'active_high'
}
iocells['usbpad3v3180n']['pads']['dp']['din'] = {
    'signal' : 'o18din[1]',
    'polarity' : 'active_high'
}

iocells['usbpad3v3180n']['pads']['dp']['oe'] = {
    'signal' : 'i18oe[1]',
    'polarity' : 'active_high'
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

def get_signal_for_iocell(iocell, pad, func):
    "Return signal and polarity for the fucntion (dout,din, oe...) for the pad of the  iocell"
    pass

def get pad_names(inst_pad):
    "Return an array of all pad names for this instance - array will have one element for std pads"
    pass

#for pad  in pads.keys():
#    print "-I Port {}".format(pad)
#    # get functions used by this pad, sorted by decreasing priority
#    ordered_func = [f for f in pads[pad]['pmux']]
#    pp.pprint(ordered_func)
#    control_signals = get_control_signals(cfg)
#    pp.pprint(control_signals)
print "-I- Let's go"
for pad,pmux in  pin_muxing.items():
    print "*"*80
    ordered_func = [f for f in pads[pad]['pmux']] # FIXME - this is not ordered
    pp.pprint(ordered_func)
    control_signals = get_control_signals(cfg)
    pp.pprint(control_signals)
    print "-I- Pad {}".format(pad)
    # pp.pprint(get_pad_functions(pads,pad))
    pad_funcs = [f for f in ordered_func if f in get_pad_functions(pads,pad)]
    if '@' in pad:
        # we have a couple pad/instance name
        pass
    else:
        # pad = instance name
        # we need to get the pad name for this instance

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

        # Now found the signals supported by the current pad of the IO cell
        #get_signal_for_iocell()

            # print "-I-       Signal".format(sig)
