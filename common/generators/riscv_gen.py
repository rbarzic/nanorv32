import AutoVivification as av
import VerilogTemplates as vt
import PythonTemplates as pt
import math
import copy
import sys
import pprint as pp
from collections import defaultdict

def fix_verilog_name(str):
    return str.replace('.', '_')

def get_instruction_format(spec, cpu='nanorv32'):
    """Return a dictionnary describing all instruction formats"""
    allready_found = dict()
    result = av.AutoVivification()
    spec_cpu = spec[cpu]
    for inst_type, format in spec_cpu['inst_type'].items():
        print "-D- inst_type " + str(inst_type)
        if inst_type not in allready_found.keys():
            inst_format = format['format']
            for field, info in inst_format.items():
                result[field] = info
                result[field]['name_uc'] = field.upper()
                result[field]['name_lc'] = field.lower()
                result[field]['size_str'] = str(info['size'])
                result[field]['msb_str'] = str(info['size']-1)
                result[field]['offset_str'] = str(info['offset'])
            allready_found[inst_type] = True

    return result


def verilog_instruction_format(inst_format):
    """Return a string containing definition for the various
    instruction fields"""
    res = ""
    for inst, data in inst_format.items():
        res += vt.define_inst_format.format(**data)
    return res


def verilog_inst_field(dic_inst_format):
    """Return bus description for each instruction field"""
    return ''.join([vt.decode_inst_field.format(**d)
                    for _, d in dic_inst_format.items()
                    if not d.get('Hint',False)]) + '\n'

def python_inst_field(dic_inst_format):
    """Return  description for each instruction field"""
    return ''.join([pt.decode_inst_field.format(**d)
                    for _, d in dic_inst_format.items()]) + '\n'


def get_decode_fields(spec,dic_inst_format,cpu='nanorv32',inst_group=['rv32i','rvc_rv32']):
    "return a dictionnary indexed by instruction containing fields (and values) needed to decode the instruction"
    decode_fields = {key: value for key, value in dic_inst_format.items() if 'decode' in value}

    res = defaultdict(list)
    for g in inst_group:
        for inst,inst_data in spec[cpu][g].items():
            for k,v in inst_data['desc']['decode'].items():
                if k in decode_fields:
                    res[inst].append({
                        'offset' : decode_fields[k]['offset'],
                        'size'   : decode_fields[k]['size'],
                        'value'  : v,
                    })
    return res


def build_decode_string(list_of_fields,prefix,word_size,dont_care = '?'):
    """Build a set of decode string from a dictionary returned from get_decode_field """

    result = dict()
    # we build the string with the msb on the left first
    for inst,fields in list_of_fields.items():
        bit_array = dont_care*word_size
        print("========= " + inst + " =========="  )
        for field in fields:
            pp.pprint(field)
            size = field ['size']
            value = field ['value']
            offset = field ['offset']
            if value != '?':
                text = bin(value)[2:].zfill(size)
            else:
                text = value
            text = text[::-1] # reverse
            bit_array = bit_array[:offset] + text + bit_array[offset+size:]
            print("bit_array : " + bit_array)
        bit_array = bit_array[::-1] # reverse string
        result[inst] = prefix + bit_array
    return result

def verilog_decode_definition(decode_dic):
    """Return decode string definition for each instruction using dictionary returned by build_decode_string"""
    res = ""
    for k, v in decode_dic.items():
        d = dict()
        d['inst_uc'] = fix_verilog_name(k.upper ())
        d['val'] = v
        res += vt.decode_def.format(**d)
    return res

def python_decode_definition(decode_dic):
    """Return decode string definition for each instruction using dictionary returned by build_decode_string"""
    res = ""
    for k, v in decode_dic.items():
        d = dict()
        d['inst_uc'] = k.upper()
        d['inst_lc'] = k.lower()
        d['val'] = v
        res += pt.decode_def.format(**d)
    return res



def write_to_file(path, filename, text):
    full_filename = path + '/' + filename
    with open(full_filename, 'w') as fh:
        fh.write(text)
        fh.close()


# from http://stackoverflow.com/questions/7204805/dictionaries-of-dictionaries-merge/7205107#7205107
def merge_dict(a, b, path=None):
    "merges b into a"
    if path is None: path = []
    for key in b:
        if key in a:
            if isinstance(a[key], dict) and isinstance(b[key], dict):
                merge_dict(a[key], b[key], path + [str(key)])
            elif a[key] == b[key]:
                pass # same leaf value
            else:
                raise Exception('Conflict at %s' % '.'.join(path + [str(key)]))
        else:
            a[key] = b[key]
    return a

def merge_dict2(a, b, path=None):
    "merges b into a, with override"
    if path is None: path = []
    for key in b:
        if key in a:
            if isinstance(a[key], dict) and isinstance(b[key], dict):
                merge_dict2(a[ke104y], b[key], path + [str(key)])
            elif a[key] == b[key]:
                pass # same leaf value
            else:
                a[key] = b[key]
                #raise Exception('Conflict at %s' % '.'.join(path + [str(key)]))
        else:
            a[key] = b[key]
    return a


def merge_inst_impl(spec,impl_spec, inst_group=['rv32i','rvc_rv32']):
    """Merge instruction type description with instruction specific implementation"""
    res = dict()
    for g in inst_group:
        for inst_name, inst_data in impl_spec['nanorv32'][g]['impl']['inst'].items():
            d1 = dict()
            d2 = dict()
            d3 = dict()
            d4 = dict()
            print "-D- merge_inst_impl : inst_name : " + inst_name
            # d2 = inst_data.copy()
            inst_type = spec['nanorv32'][g][inst_name]['desc']['inst_type']
            print "-D- Instruction type : " + inst_type
            d1 = copy.deepcopy(impl_spec['nanorv32'][g]['impl']['inst_type'][inst_type])
            d2 = copy.deepcopy(inst_data)
            print '-'*20
            pp.pprint(d1)
            print '-'*20
            pp.pprint(d2)
            print '-'*20
            d3 = merge_dict2(d1,d2)
            pp.pprint(d2)
            print '-'*20
            res[inst_name] = copy.deepcopy(d3)
    return res


def get_selectors_per_inst(spec,sel_list):
    """Return a dictionnary that describes all selectors ('muxes') settings  for selectors matching sel_list"""
    result = av.AutoVivification()
    # result = dict()
    for inst,inst_data in spec.items():
        print "-D- inst :: " + inst
        for sel in sel_list:
            if sel in inst_data.keys():
                # append name of unit in front of port
                d = dict()
                for k,v in inst_data[sel].items():
                    d[sel + "_" + k] = v
                result[inst][sel] = d
            else:
                # Not describe in the instruction description
                # try to find it in the instruction type description
                print "-D- sel ::" + sel
                inst_type = inst_data['desc']['type']

                if sel in spec['cpu']['inst_type'][inst_type]['impl'].keys():
                    d2 = dict()
                    for k,v in spec['cpu']['inst_type'][inst_type]['impl'][sel].items():
                        d2[sel + "_" + k] = v
                    result[inst][sel] = d2

    return result


def get_selector_values(sel_per_inst):
    """Return a dictionary that gives all possible value per selector"""
    result = av.AutoVivification()
    for inst,sels in sel_per_inst.items():
        for unit,port in sels.items():
            for p,val in port.items():
                result[unit].setdefault(p,[]).append(val)
            # remove duplicate by converting to a set
            for k,v in result[unit].items():
                result[unit][k] = list(set(v))

    # remove duplicate and Autovification type
    for k,v in result.items():
        result[k] = dict(v)
    return result


def verilog_selector_definition(selector_dic):
    """Generate Verilog code for the mux selectors as generated by get_selector_values"""
    res = ""
    for unit,unit_val in selector_dic.items():
        res += "// Mux definitions for " + unit + "\n"
        for port,val in unit_val.items():
            data = dict()
            data['bits'] = int(math.ceil(math.log(len(val), 2)))
            data['msb'] = data['bits'] - 1
            data['port_uc'] = port.upper()
            res += "\n//  " + port + "\n"
            res += vt.mux_constant_width.format(**data)
            idx = 0
            for idx,v in enumerate(val):

                data['name'] = (port + "_" + v).upper()
                data['idx']  = idx
                res += vt.mux_constant_sel.format(**data)
        res += '\n'
    return res


def verilog_selector_declaration(selector_dic, decl_type="reg"):
    """Generate Verilog code for the mux selectors as generated by get_selector_values"""
    res = ""
    for unit,unit_val in selector_dic.items():
        for port,val in unit_val.items():
            data = dict()
            data['bits'] = int(math.ceil(math.log(len(val), 2)))
            data['msb'] = data['bits'] - 1
            data['port_uc'] = port.upper()
            data['port_lc'] = port.lower()
            if(decl_type == "reg"):
                res += vt.mux_sel_declaration.format(**data)
            elif(decl_type=="wire"):
                res += vt.mux_sel_declaration_as_wire.format(**data)
            elif(decl_type=="output"):
                res += vt.mux_sel_declaration_as_output.format(**data)
            else:
                sys.exit('-E- unsupported  parameter value for ' + str(decl_type))
    res += '\n'
    return res


def verilog_selector_template(selector_dic):
    """Generate template Verilog code for mux selector case statement"""
    res = ""
    for unit,unit_val in selector_dic.items():
        res += "// Mux definitions for " + unit + "\n"
        for port,val in unit_val.items():
            data = dict()
            data['bits'] = int(math.ceil(math.log(len(val), 2)))
            data['msb'] = data['bits'] - 1
            data['port_uc'] = port.upper()
            data['port_lc'] = port.lower()
            idx = 0
            res += "\n//========================================\n"
            res += vt.mux_sel_template_1.format(**data)
            for idx,v in enumerate(val):

                data['name'] = (port + "_" + v).upper()
                data['idx']  = idx
                res += vt.mux_sel_template_2.format(**data)

    return res


# to be completed
def verilog_decode_logic(sel_per_inst):
    """Return instruction decoding verilog code """
    res=""
    for inst,sels in sel_per_inst.items():
        d = dict()
        d['inst_uc'] = fix_verilog_name( inst.upper ())
        res += vt.decode_case.format(**d)
        for unit,port in sels.items():
            for p,val in port.items():
                d['port'] = p.lower()
                d['port_uc'] = p.upper()
                d['port_val'] = val.upper()
                res += vt.decode_line.format(**d)
        res += vt.decode_end
    return res

# CSR related stuff


def get_csr_address(spec, cpu='nanorv32'):
    " return a dictionary giving the address and verilog name of each CSR"
    spec_cpu = spec[cpu]
    res = dict()
    for csr, val in spec_cpu['cpu']['csr'].items():

        res[csr] = {
            'addr' : val['addr'],
            'vname': val['verilog_name'],
        }

    return res


def verilog_csr_addr(csr_addr):
    res = ""
    d = dict()
    for csr,val in csr_addr.items():
        d['name_uc'] = csr.upper()
        d['addr'] = hex(val['addr'])[2:] # remove the 0x in front
        res += vt.csr_addr_param.format(**d)
    return res

def python_csr_addr(csr_addr):
    res = ""
    d = dict()
    for csr,val in csr_addr.items():
        d['name_uc'] = csr.upper()
        d['addr'] = hex(val['addr']) # remove the 0x in front
        res += pt.csr_addr_param.format(**d)
    return res


def verilog_csr_read_decode(csr_addr):
    res = ""
    d = dict()
    for csr,val in csr_addr.items():
        d['name_uc'] = csr.upper()
        d['vname_lc'] = val['vname'].lower()
        res += vt.csr_read_decode.format(**d)
    res += '\n'
    return res
