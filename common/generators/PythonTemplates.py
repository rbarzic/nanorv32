decode_inst_field ="        self.dec_{name_lc} = bitfield(inst,offset={offset_str},size={size_str})\n"

decode_def = "decode['{inst_lc}'] = \"{val}\"\n"

csr_addr_param = "NANORV32_CSR_ADDR_{name_uc} = {addr}\n"
