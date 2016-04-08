################################################################################
#
#  Templates Nanorv32 CPU internals
#
################################################################################

define_inst_format = """
// Instruction {name_lc}
parameter NANORV32_INST_FORMAT_{name_uc}_OFFSET = {offset_str};
parameter NANORV32_INST_FORMAT_{name_uc}_SIZE = {size_str};
parameter NANORV32_INST_FORMAT_{name_uc}_MSB = {msb_str};
"""

decode_def = "parameter NANORV32_DECODE_{inst_uc} = {val};\n"
decode_case = "    NANORV32_DECODE_{inst_uc}: begin\n"
decode_line = "        {port}_sel = NANORV32_MUX_SEL_{port_uc}_{port_val};\n"
decode_end = "    end\n"
decode_inst_field = """
    wire [NANORV32_INST_FORMAT_{name_uc}_MSB:0] dec_{name_lc}  = instruction_r[NANORV32_INST_FORMAT_{name_uc}_OFFSET +: NANORV32_INST_FORMAT_{name_uc}_SIZE];"""


mux_constant_width ="""
parameter NANORV32_MUX_SEL_{port_uc}_SIZE = {bits};
parameter NANORV32_MUX_SEL_{port_uc}_MSB = {msb};
 """

mux_sel_declaration ="""
    reg  [NANORV32_MUX_SEL_{port_uc}_MSB:0] {port_lc}_sel;"""

mux_sel_declaration_as_wire ="""
    wire  [NANORV32_MUX_SEL_{port_uc}_MSB:0] {port_lc}_sel;"""

mux_sel_declaration_as_output ="""
    output  [NANORV32_MUX_SEL_{port_uc}_MSB:0] {port_lc}_sel;"""

mux_constant_sel ="""
parameter NANORV32_MUX_SEL_{name} = {idx};"""

mux_sel_template_1 ="""
    case({port_lc})"""

mux_sel_template_2 ="""
        NANORV32_MUX_SEL_{name}: begin
            {port_lc} <= ;
        end"""

csr_addr_param = "parameter NANORV32_CSR_ADDR_{name_uc} = 12'h{addr};\n"
csr_read_decode = """
        NANORV32_CSR_ADDR_{name_uc}: begin
            csr_core_rdata = {vname_lc};
        end"""



################################################################################
#
#  Templates for Register interface definition (Verilog)
#
################################################################################
tpl_verilog_parameters ="parameter {name} = {value};\n"
tpl_c_defines = "#define  {name}  {value}\n"
tpl_verilog_read = """
              {addr}[{addr_msb}:2]: begin
{code}              end
"""

tpl_verilog_write = tpl_verilog_read

tpl_verilog_read_field = """                {ip}_{bus}_prdata[{offset} +: {size}] = {register};\n"""

tpl_verilog_write_field = """               {register} <=  {bus}_{ip}_pwdata[{offset} +: {size}];\n"""

tpl_verilog_reset_field = """               {register} <=  {size}'h{reset_value_hex};\n"""

tpl_verilog_reg_decl = """  reg {size_str}{register}; // {description}\n"""

tpl_verilog_output_decl = """  output {size_str}{register}; // {description}\n"""


tpl_verilog_apbif = """
module {ip_name}_apbif (/*AUTOARG*/);

`include "{ip_name}_params.v"
   {io_decl_code}

   input  wire        apb_{ip_name}_psel;     // Peripheral select

   input  wire [11:0] apb_{ip_name}_paddr;    // Address
   input  wire        apb_{ip_name}_penable;  // Transfer control
   input  wire        apb_{ip_name}_pwrite;   // Write control
   input  wire [31:0] apb_{ip_name}_pwdata;   // Write data

   output reg  [31:0] {ip_name}_apb_prdata;   // Read data
   output wire        {ip_name}_apb_pready;   // Device ready
   output wire        {ip_name}_apb_pslverr;  // Device error response

   input clk_apb;
   input rst_apb_n;



   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/

   {reg_decl_code}


   wire               read_enable;
   wire               write_enable;


   assign  read_enable  = apb_{ip_name}_psel & (~apb_{ip_name}_pwrite); // assert for whole APB read transfer
   assign  write_enable = apb_{ip_name}_psel & (~apb_{ip_name}_penable) & apb_{ip_name}_pwrite; // assert for 1st cycle of write transfer


   // Register Read
   always@* begin
      {ip_name}_apb_prdata = 0;
      case(apb_{ip_name}_paddr[{addr_msb}:2])
        {read_access_code}
        default: begin
           {ip_name}_apb_prdata = 0;
        end
      endcase
   end

   assign {ip_name}_apb_pready  = 1'b1; //  always ready
   assign {ip_name}_apb_pslverr = 1'b0; //  always okay

   // register write
   always @(posedge clk_apb or negedge rst_apb_n) begin
      if(rst_apb_n == 1'b0) begin
         {reset_code}
         /*AUTORESET*/
         // Beginning of autoreset for uninitialized flops

         // End of automatics
      end
      else begin
         if(write_enable) begin
            case(apb_{ip_name}_paddr[{addr_msb}:2])
              {write_access_code}
            endcase
         end
      end
   end

endmodule // {ip_name}_apb
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
"""
