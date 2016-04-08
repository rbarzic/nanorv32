#!/usr/bin/env python
import sys
import AutoVivification as av
import argparse
import VerilogTemplates as vt
import CTemplates as ct
import pprint as pp

definition_list = ['offset', 'size']



def get_verilog_size_string(size):
    "Return [size-1:0] if size >1, empty string otherwise"
    if size == 1:
        return ""
    else:
        return "[{}:0]".format(size-1)

def get_field_definition_prefix(cfg,reg,field):
    return cfg['prefix'] + '_' + reg.upper() + '_' + field.upper() + '_'

def get_reg_definition_prefix(cfg,reg):
    return cfg['prefix'] + '_' + reg.upper() + '_'

def get_verilog_reg_name(r, f):
    return r.lower() + '_' + f.lower() + '_r'

def get_def_reg_prop(cfg,regs,reg,prop,default_val=0):
    "Return a tupple (string,value) for a register property "
    prop_lc = prop.lower()
    prop_uc = prop.upper()
    reg_uc = reg.upper()
    r_prefix = get_reg_definition_prefix(cfg,reg_uc)
    return (r_prefix+prop_uc, regs[reg].get(prop_lc,default_val))

def get_def_field_prop(cfg,regs,reg,field,prop,default_val=0):
    "Return a tupple (string,value) for a register field property "
    prop_lc = prop.lower()
    prop_uc = prop.upper()
    reg_uc = reg.upper()
    field_uc = field.upper()
    l_prefix = get_field_definition_prefix(cfg,reg_uc,field)
    return (l_prefix+prop_uc, regs[reg]['fields'][field].get(prop_lc,default_val))








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
            f_prefix = get_field_definition_prefix(cfg,reg_uc, f)
            for d in definition_list:
                def_l.append((f_prefix+d.upper(),regs[reg]['fields'][f][d]))
    return def_l

def get_verilog_read_access_code(cfg,regs,ip, bus='apb'):
    "Generate the code corresponding to a register read"
    txt =  ""
    for reg in regs.keys():
        reg_access = regs[reg].get('access','rw')
        dr = dict()
        dr['addr'],_ = get_def_reg_prop(cfg,regs,reg,'addr')
        dr['addr_msb'] = cfg.get('addr_msb',12)
        dr['code'] = ""
        for f in regs[reg]['fields']:
            df = dict()
            df['register'] = get_verilog_reg_name(reg, f)
            _, df['offset'] = get_def_field_prop(cfg, regs, reg, f, 'offset')
            _, df['size'] = get_def_field_prop(cfg, regs, reg, f, 'size')
            df['ip'] = ip
            df['bus'] = bus
            dr['code'] += vt.tpl_verilog_read_field.format(**df)

        txt += vt.tpl_verilog_read.format(**dr)
    return txt

def get_verilog_write_access_code(cfg,regs,ip, bus='apb'):
    "Generate the code corresponding to a register write"
    txt =  ""
    for reg in regs.keys():
        reg_access = regs[reg].get('access','rw')
        dr = dict()
        dr['addr'],_ = get_def_reg_prop(cfg,regs,reg,'addr')
        dr['addr_msb'] = cfg.get('addr_msb',12)
        dr['code'] = ""
        for f in regs[reg]['fields']:
            df = dict()
            df['register'] = get_verilog_reg_name(reg, f)
            _,df['offset'] = get_def_field_prop(cfg, regs, reg, f, 'offset')
            _,df['size'], = get_def_field_prop(cfg, regs, reg, f, 'size')
            df['ip'] = ip
            df['bus'] = bus
            dr['code'] += vt.tpl_verilog_write_field.format(**df)

        txt += vt.tpl_verilog_write.format(**dr)
    return txt

def get_verilog_reset_code(cfg,regs,ip, bus='apb'):
    "Code used for the reset of registers"
    txt =  ""
    for reg in regs.keys():
        reg_access = regs[reg].get('access','rw')
        dr = dict()
        for f in regs[reg]['fields']:
            df = dict()
            df['register'] = get_verilog_reg_name(reg, f)
            _,df['size'] = get_def_field_prop(cfg, regs, reg, f, 'size')
            _, reset_val = get_def_field_prop(cfg, regs, reg, f, 'reset_value', 0)
            df['reset_value_hex'] = hex(reset_val)[2:]
            txt += vt.tpl_verilog_reset_field.format(**df)

    return txt

def get_verilog_reg_decl_code(cfg,regs,ip, bus='apb'):
    "Verilog declaration for each register fields"
    txt =  ""
    for reg in regs.keys():
        reg_access = regs[reg].get('access','rw')
        dr = dict()
        for f in regs[reg]['fields']:
            df = dict()
            df['register'] = get_verilog_reg_name(reg, f)
            _, size = get_def_field_prop(cfg, regs, reg, f, 'size')
            df['size_str'] = get_verilog_size_string(size)
            _,df['description'] = get_def_field_prop(cfg, regs, reg, f,
                                                     'description',
                                                     "no description provided")
            txt += vt.tpl_verilog_reg_decl.format(**df)

    return txt

def get_verilog_io_decl_code(cfg,regs,ip, bus='apb'):
    "Verilog declaration for input/output related to register fields"
    txt =  ""
    for reg in regs.keys():
        reg_access = regs[reg].get('access','rw')
        dr = dict()
        for f in regs[reg]['fields']:
            df = dict()
            df['register'] = get_verilog_reg_name(reg, f)
            _, size = get_def_field_prop(cfg, regs, reg, f, 'size')
            df['size_str'] = get_verilog_size_string(size)
            _,df['description'] = get_def_field_prop(cfg, regs, reg, f,
                                                     'description',
                                                     "no descprition provided")
            txt += vt.tpl_verilog_output_decl.format(**df)

    return txt

def get_verilog_params(cfg, regs):
    params = get_definitions(cfg,regs)
    txt = ""
    for p,v  in params:
        d = dict()
        d['name'] = p
        d['value'] = v
        txt += "parameter {name} = {value};\n".format(**d)

    return txt

def get_args():
    """
    A bus-interface generator
    """
    parser = argparse.ArgumentParser(description="""
Put description of application here
                   """)
    parser.add_argument('--vif', action='store', dest='vif',
                        help='Main verilog file', default="")
    parser.add_argument('--vparams', action='store', dest='vparams',
                        help='Verilog parameter  file', default="")
    parser.add_argument('--spec', action='store', dest='spec',
                        help='Spec file (in Python)', default="")


    parser.add_argument('--version', action='version', version='%(prog)s 0.1')
    return parser.parse_args()



if __name__ == '__main__':
    args= get_args()
    cfg = av.AutoVivification()
    regs = av.AutoVivification()
    # Read the spec
    global_args  = dict() # unused for now
    execfile(args.spec, global_args, {"cfg": cfg, "regs" : regs})
    pp.pprint(cfg)

    ip_name = cfg['ip_name']
    d = dict()
    d['ip_name'] = ip_name
    d['addr_msb'] = 10
    d['read_access_code'] = get_verilog_read_access_code(cfg,regs,ip_name)
    d['write_access_code'] = get_verilog_write_access_code(cfg,regs,ip_name)
    d['reset_code'] = get_verilog_reset_code(cfg,regs,ip_name)
    d['reg_decl_code'] = get_verilog_reg_decl_code(cfg,regs,ip_name)
    d['io_decl_code']  = get_verilog_io_decl_code(cfg,regs,ip_name)

    final_txt = vt.tpl_verilog_apbif.format(**d)
    with open(args.vif, 'w') as fh:
        fh.write(final_txt)
        fh.close()


    params_txt = get_verilog_params(cfg,regs)
    with open(args.vparams, 'w') as fh:
        fh.write(params_txt)
        fh.close()
