#!/usr/bin/env python
import sys
import AutoVivification as av

import pprint as pp

regs = av.AutoVivification()
cfg = av.AutoVivification()
cfg['prefix'] = 'NRV32'
regs['dbgctrl']['addr'] = 0
regs['dbgctrl']['description'] = "Debug Control Register"
regs['dbgctrl']['width'] = 32

regs['dbgctrl']['fields']["stepping"] = {
    'offset' : 0,
    'size'   :   1,
    'access' : 'rw',
    'reset_value' : 0,
    'description' : 'CPU will stop after each instruction '
}

regs['dbgctrl']['fields']["bkp0"] = {
    'offset' : 8,
    'size'   :   1,
    'access' : 'rw',
    'reset_value' : 0,
}

regs['bkpt0']['addr'] = 4
regs['bkpt0']['description'] = "Debug Control Register #0"
regs['bkpt0']['width'] = 32

regs['bkpt0']['fields']["addr"] = {
    'offset' : 0,
    'size'   :   32,
    'access' : 'rw',
    'reset_value' : 0,
}

regs['bkpt1']['addr'] = 4
regs['bkpt1']['description'] = "Debug Control Register #0"
regs['bkpt1']['width'] = 32

regs['bkpt1']['fields']["addr"] = {
    'offset' : 0,
    'size'   :   32,
    'access' : 'rw',
    'reset_value' : 0
}

def get_field_definition_prefix(cfg,ref,field):
    return cfg['prefix'] + '_' + reg_uc + '_' + f_uc + '_'

def get_reg_definition_prefix(cfg,ref):
    return cfg['prefix'] + '_' + reg_uc + '_'

def get_verilog_reg_name(r, f):
    return r.lower() + '_' + f.lower() + '_r'

def get_def_reg_prop(cfg,regs,reg,prop):
    prop_lc = prop.lower()
    prop_uc = prop.upper()
    reg_uc = reg.upper()
    r_prefix = get_reg_definition_prefix(cfg,reg_uc)
    return (r_prefix+prop_uc, regs[reg][prop_lc])

def get_def_field_prop(cfg,regs,reg,field,prop):
    prop_lc = prop.lower()
    prop_uc = prop.upper()
    reg_uc = reg.upper()
    field_uc = field.upper()
    l_prefix = get_field_definition_prefix(cfg,reg_uc,field)
    return (r_prefix+prop_uc, regs[reg]['fields'][field][prop_lc])



verilog_reg_dict = dict()
verilog_reset_dict = dict()
verilog_read_dict = dict()
verilog_write_dict = dict()

tpl_verilog_parameters ="parameter {name} = {value};\n"
tpl_c_defines ="#define  {name}  {value}\n"
tpl_verilog_read="""
              {addr}: begin
{code}
              end
"""

tpl_verilog_write=tpl_verilog_read

tpl_verilog_read_field="""                {ip}_{bus}_rdata[{offset} +: {size}] = {register};\n"""

tpl_verilog_write_field="""               {register} <=  {bus}_{ip}_wdata[{offset} +: {size}];\n"""


def get_definitions(cfg,regs):
    """ return a list of pair (name,value) suitable for generation of
         C defines or Verilog defines/parameters
    """
    def_l = list()
    for reg in regs.keys():
        print "Implementing register {}".format(reg)
        reg_uc = reg.upper()
        reg_lc = reg.lower()
        r_prefix = get_reg_definition_prefix(cfg,reg_uc)
        def_l.append(get_def_reg_prop(cfg,regs,reg,'addr'))
        for f in regs[reg]['fields']:
            print "  Implementing field {}".format(f)
            f_prefix = get_field_definition_prefix(cfg,reg_uc, f_uc)
            def_l.append((f_prefix+'OFFSET',regs[reg]['fields'][f]['offset']))
    return def_l

def get_verilog_read_access_code(cfg,regs,ip, bus='apb'):
    txt =  ""
    for reg in regs.keys():
        reg_access = regs[reg].get('access','rw')
        dr = dict()
        dr['addr'],_ = get_def_reg_prop(cfg,regs,reg,'addr')
        dr['code'] = ""
        for f in regs[reg]['fields']:
            df = dict()
            df['register'] = get_verilog_reg_name(reg, f)
            df['offset'],_ = get_def_field_prop(cfg, regs, reg, f, 'offset')
            df['size'],_ = get_def_field_prop(cfg, regs, reg, f, 'size')
            df['ip'] = ip
            df['bus'] = bus
            dr['code'] += tpl_verilog_read_field.format(**df)

        txt += tpl_verilog_read.format(**dr)
    return txt

def get_verilog_write_access_code(cfg,regs,ip, bus='apb'):
    txt =  ""
    for reg in regs.keys():
        reg_access = regs[reg].get('access','rw')
        dr = dict()
        dr['addr'],_ = get_def_reg_prop(cfg,regs,reg,'addr')
        dr['code'] = ""
        for f in regs[reg]['fields']:
            df = dict()
            df['register'] = get_verilog_reg_name(reg, f)
            df['offset'],_ = get_def_field_prop(cfg, regs, reg, f, 'offset')
            df['size'],_ = get_def_field_prop(cfg, regs, reg, f, 'size')
            df['ip'] = ip
            df['bus'] = bus
            dr['code'] += tpl_verilog_write_field.format(**df)

        txt += tpl_verilog_write.format(**dr)
    return txt




print "Definitions :"
def_l = get_definitions(cfg,regs)
pp.pprint(def_l)
print "="*80
txt = ""
for name,val  in def_l:
    txt += tpl_c_defines.format(name=name, value=val)
print txt
print "="*80
print get_verilog_read_access_code(cfg,regs,'uart')
print "="*80
print get_verilog_write_access_code(cfg,regs,'uart')
