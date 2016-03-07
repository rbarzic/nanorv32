import copy
import sys
import os
sys.path.append(os.getcwd())
sys.path.append('../generators')

import riscv_gen as rg
#import nanorv32
#import nanorv32_impl as impl
import pprint as pp

import AutoVivification as av

spec_rv32i = av.AutoVivification()
impl_rv32i = av.AutoVivification()
spec_rvc32 = av.AutoVivification()
impl_rvc32 = av.AutoVivification()
execfile("nanorv32.py", {}, {"spec": spec_rv32i})
execfile("nanorv32_impl.py", {}, {"spec": impl_rv32i})


execfile("nanorv32_rvc.py", {}, {"spec": spec_rvc32})
execfile("nanorv32_rvc_impl.py", {}, {"spec": impl_rvc32})


spec_nanorv32 = copy.deepcopy(spec_rv32i)
spec_nanorv32_impl = copy.deepcopy(impl_rv32i)

# We merge rv32i and rvc spec
spec_nanorv32 = rg.merge_dict2(spec_nanorv32,spec_rvc32)
spec_nanorv32_impl = rg.merge_dict2(impl_rv32i, impl_rvc32)

#pp.pprint(spec_nanorv32,indent=4)

if True:
    #pp.pprint(nanorv32.spec)
    dic_inst_format = rg.get_instruction_format(spec_nanorv32)
    pp.pprint(dic_inst_format)
    rg.write_to_file("../../generated", "instruction_format.generated.v",
                     rg.verilog_instruction_format(dic_inst_format))
    rg.write_to_file("../../generated", "instruction_fields.generated.v",
                     rg.verilog_inst_field(dic_inst_format))



    decode_fields = rg.get_decode_fields(spec_nanorv32, dic_inst_format)
    pp.pprint(decode_fields)
    decode_dic = rg.build_decode_string(decode_fields, "35'b", 35)

    pp.pprint(decode_dic)

    rg.write_to_file("../../generated", "inst_decode_definitions.generated.v",
                     rg.verilog_decode_definition(decode_dic))
    print "="*80
    merged_impl = rg.merge_inst_impl(spec_nanorv32, spec_nanorv32_impl)
    print "$"*80
    pp.pprint(merged_impl)
    print "$"*80
    sel_val = rg.get_selectors_per_inst(merged_impl, ["pc", "alu", "datamem", "regfile"])

    sel_value_dic = rg.get_selector_values(sel_val)
    print "@"*80
    pp.pprint(sel_val)
    print "+"*80
    rg.write_to_file("../../generated", "mux_select_definitions.generated.v",
                     rg.verilog_selector_definition(sel_value_dic))

    rg.write_to_file("../../generated", "mux_select_declarations.generated.v",
                     rg.verilog_selector_declaration(sel_value_dic))

    rg.write_to_file("../../generated", "mux_select_declarations_as_wire.generated.v",
                     rg.verilog_selector_declaration(sel_value_dic, decl_type="wire"))

    rg.write_to_file("../../generated", "mux_select_declarations_as_output.generated.v",
                     rg.verilog_selector_declaration(sel_value_dic, decl_type="output"))

    rg.write_to_file("../../generated", "mux_template.v",
                     rg.verilog_selector_template(sel_value_dic))

    rg.write_to_file("../../generated", "instruction_decoder.generated.v",
                     rg.verilog_decode_logic(sel_val))


    print("-I Done")
