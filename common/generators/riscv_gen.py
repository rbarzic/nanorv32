import AutoVivification as av
import VerilogTemplates as vt
import math

import pprint as pp
from collections import defaultdict


def get_instruction_format(spec, cpu='nanorv32'):
    """Return a dictionnary describing all instruction formats"""
    allready_found = dict()
    result = av.AutoVivification()
    spec_cpu = spec[cpu]
    for inst_type, format in spec_cpu['inst_type'].items():
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
                    for _, d in dic_inst_format.items()]) + '\n'


def get_decode_fields(spec,dic_inst_format):
    "return a dictionnary indexed by instruction containing fields (and values) needed to decode the instruction"
    decode_fields = {key: value for key, value in dic_inst_format.items() if 'decode' in value}
    res = defaultdict(list)
    for inst,inst_data in spec['cpu']['inst'].items():
        for k,v in inst_data['desc'].items():
            if k in decode_fields:
                res[inst].append({
                        'offset' : decode_fields[k]['offset'],
                        'size'   : decode_fields[k]['size'],
                        'value'  : v,
                                })
    return res




def write_to_file(path, filename, text):
    full_filename = path + '/' + filename
    with open(full_filename, 'w') as fh:
        fh.write(text)
        fh.close()
