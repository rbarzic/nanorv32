
    wire  [NANORV32_MUX_SEL_PC_NEXT_MSB:0] pc_next_sel;
    wire  [NANORV32_MUX_SEL_PC_BRANCH_MSB:0] pc_branch_sel;
    wire  [NANORV32_MUX_SEL_ALU_OP_MSB:0] alu_op_sel;
    wire  [NANORV32_MUX_SEL_ALU_PORTB_MSB:0] alu_portb_sel;
    wire  [NANORV32_MUX_SEL_ALU_PORTA_MSB:0] alu_porta_sel;
    wire  [NANORV32_MUX_SEL_DATAMEM_SIZE_READ_MSB:0] datamem_size_read_sel;
    wire  [NANORV32_MUX_SEL_DATAMEM_WRITE_MSB:0] datamem_write_sel;
    wire  [NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_MSB:0] datamem_size_write_sel;
    wire  [NANORV32_MUX_SEL_DATAMEM_READ_MSB:0] datamem_read_sel;
    wire  [NANORV32_MUX_SEL_REGFILE_SOURCE_MSB:0] regfile_source_sel;
    wire  [NANORV32_MUX_SEL_REGFILE_WRITE_MSB:0] regfile_write_sel;
