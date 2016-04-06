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
    'desc' : "Pad output enable",
    'dir' : 'ip2pad',
    'default' : 0,
    'polarity' : 'active_high'
}

cfg['pad']['control']['ie'] = {
    'desc' : "Pad input enable",
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

pin_muxing['USBPAD@dp']= {
    'func_A' : 'usb/dp',
}



padring['P0']['type'] = 'stdpad3v3p180n'
padring['P0']['order'] = 1


padring['P1']['type'] = 'stdpad3v3p180n'
padring['P1']['order'] = 10

padring['USBPAD']['type'] = 'usbpad3v3p180n'
padring['USBPAD']['order'] = 15




# Standard I/O pad
# definition
iocells['stdpad3v3p180n']['type'] = 'io'

# Mapping of IOCELL pin to generic control signal
iocells['stdpad3v3p180n']['pads']['pad']['dout'] = {
    'signal' : 'i18dout',
    'polarity' : 'active_high'
}
iocells['stdpad3v3p180n']['pads']['pad']['din'] = {
    'signal' : 'o18din',
    'polarity' : 'active_high'
}

iocells['stdpad3v3p180n']['pads']['pad']['oe'] = {
    'signal' : 'i18oe',
    'polarity' : 'active_high'
}


# Non standard  I/O cell, with multiple pads
# definition
iocells['usbpad3v3p180n']['type'] = 'custom'

# Mapping of IOCELL pin to generic control signal

# DM pin
iocells['usbpad3v3p180n']['pads']['dm']['dout'] = {
    'signal' : 'i18dout[0]',
    'polarity' : 'active_high'
}
iocells['usbpad3v3p180n']['pads']['dm']['din'] = {
    'signal' : 'o18din[0]',
    'polarity' : 'active_high'
}

iocells['usbpad3v3p180n']['pads']['dm']['oe'] = {
    'signal' : 'i18oe[0]',
    'polarity' : 'active_high'
}
# DP pin
iocells['usbpad3v3p180n']['pads']['dp']['dout'] = {
    'signal' : 'i18dout[1]',
    'polarity' : 'active_high'
}
iocells['usbpad3v3p180n']['pads']['dp']['din'] = {
    'signal' : 'o18din[1]',
    'polarity' : 'active_high'
}

iocells['usbpad3v3p180n']['pads']['dp']['oe'] = {
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

def get_signal_for_iocell(iocells, pad, func):
    "Return signal and polarity for the function (dout,din, oe...) for the pad of the  iocell"
    pass

def get_iocell_type(padring,cell):
    return padring[cell]['type']

def get_pad_names(padring, iocells, inst_pad):
    "Return an array of all pad names for this instance - array will have one element for std pads"
    t = get_iocell_type(padring,inst_pad)
    print "Type = {}".format(t)
    return [p for p in iocells[t]['pads'].keys()]

def get_iocell_instance(pinmux_elt):
    return pinmux_elt.split('@')[0]

def get_iocell_pad(iocells, iocell_type, pinmux_elt):
    if '@' in pinmux_elt:
        # Fixme : check if this pad exists for this cell
        return pinmux_elt.split('@')[1]
    else:
        # FIXME : Add an extra check to be sure there is only one pad
        return iocells[iocell_type]['pads'].keys()[0]

def get_control_signals_for_pad(iocells, iocell, pad):
    print "-E- iocell : " + iocell
    print "-E- pad : " + pad
    return iocells[iocell]['pads'][pad].keys()


def get_iocell_type_from_instance(inst):
    return padring[inst]['type']

print "Pad list for {} : {}".format('P0',str(get_pad_names(padring, iocells, 'P0')))
print "Pad list for {} : {}".format('P1',str(get_pad_names(padring, iocells, 'P1')))
print "Pad list for {} : {}".format('USBPAD',str(get_pad_names(padring, iocells, 'USBPAD')))


for pm, val  in pin_muxing.items():
    print "Pin muxing for {}".format(pm)
    iocell_inst = get_iocell_instance(pm)
    iocell_type = get_iocell_type_from_instance(iocell_inst)
    current_pad = get_iocell_pad(iocells, iocell_type, pm)
    print "Type of iocell is {} (using {}) ".format( iocell_type, iocell_inst)
    print "Pad  of iocell is {}  ".format( get_iocell_pad(iocells, iocell_type, pm))

    print "List of expected control signals {}  ".format( get_control_signals(cfg))

    # get list of control signal this pad support
    print "List of actual control signals {}  ".format( get_control_signals_for_pad(iocells,iocell_type, current_pad))
