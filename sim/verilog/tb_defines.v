`ifndef __TB_DEFINES__
 `define __TB_DEFINES__


`define TB tb_nanorv32
`define CODE_RAM  U_DUT.u_tcm0.U_RAM
`define DATA_RAM  U_DUT.u_tcm1.U_RAM
`define CPU_PIL `TB.U_DUT.U_NANORV32_PIL
`define CPU `TB.U_DUT.U_NANORV32_PIL.U_CPU
`define RF `TB.U_DUT.U_NANORV32_PIL.U_CPU.U_REG_FILE

`define TCK `TB.TCK_r
`define TMS `TB.TMS_r
`define TDI `TB.TDI_r
`define TDO `TB.U_DUT.TDO


`endif
