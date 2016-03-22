    NANORV32_DECODE_AND: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_AND;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_SWSP: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5_SWSP;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_YES;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_C_X2;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_C_LWSP: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5_LWSP;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_YES;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_DATAMEM;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_C_X2;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_LBU: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_BYTE_UNSIGNED;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_YES;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_DATAMEM;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_FENCE: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_SW: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12HILO;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_YES;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_ADDI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_RDCYCLEH: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_CSR_RDATA;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_SBREAK: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_BLTU: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_YES;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_LT_UNSIGNED;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_LW: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5_CL;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_YES;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C_P;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_DATAMEM;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C_P;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_XOR: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_XOR;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_OR: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_OR;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_LUI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM20U;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_WORD;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_MV: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_C_JALR: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_ALU_RES;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_PC_EXE_PLUS_2;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_C_SUB: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_SUB;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_SLTU: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_LT_UNSIGNED;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_MULHU: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_MULHU;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_RDTIME: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_CSR_RDATA;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_LB: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_BYTE;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_YES;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_DATAMEM;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_JALR: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_ALU_RES;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_PC_EXE_PLUS_4;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_ADD4SPN: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM8_CIW;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_YES;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C_P;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_C_X2;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_BLT: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_YES;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_LT_SIGNED;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_SCALL: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_FENCE_I: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_JAL: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_ALU_RES;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_YES;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM20UJ;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_PC_EXE;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_PC_EXE_PLUS_4;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_LH: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_HALFWORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_YES;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_DATAMEM;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_BEQZ: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB_C;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_YES;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_EQ;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5_CB;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_C_BNEZ: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB_C;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_YES;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NEQ;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5_CB;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_LW: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_YES;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_DATAMEM;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_ADD: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_JAL: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_ALU_RES;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_YES;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM10CJ;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_PC_EXE;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_C_X1;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_PC_EXE_PLUS_4;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_AUIPC: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM20U;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_PC_EXE;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_WORD;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_REM: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_REM;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_MUL: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_MUL;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_ADDI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_RDCYCLE: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_CSR_RDATA;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_RDTIMEH: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_CSR_RDATA;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_SW: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5_CL;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_YES;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C_P;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C_P;
    end
    NANORV32_DECODE_MULH: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_MULH;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_BGEU: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_YES;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_GE_UNSIGNED;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_LI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_RDINSTRETH: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_CSR_RDATA;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_SLTIU: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_LT_UNSIGNED;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_ADD: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_C_JR: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_ALU_RES;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_C_SRAI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ARSHIFT;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RS1_C_P;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C_P;
    end
    NANORV32_DECODE_SRAI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ARSHIFT;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_SHAMT;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_EBREAK: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_MULHSU: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_MULHSU;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_ORI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_OR;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_XORI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_XOR;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_ANDI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_AND;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_DIVU: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_DIVU;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_XOR: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_XOR;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_C_ANDI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_AND;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RS1_C_P;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C_P;
    end
    NANORV32_DECODE_SUB: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_SUB;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_SRLI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_RSHIFT;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RS1_C_P;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C_P;
    end
    NANORV32_DECODE_SRA: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ARSHIFT;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_BGE: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_YES;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_GE_SIGNED;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_SLT: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_LT_SIGNED;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_AND: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_AND;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_SRLI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_RSHIFT;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_SHAMT;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_SLLI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_LSHIFT;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_SLTI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_LT_SIGNED;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_REMU: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_REMU;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_SRL: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_RSHIFT;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_NOP: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_SLL: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_LSHIFT;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_LHU: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_HALFWORD_UNSIGNED;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_YES;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_DATAMEM;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_SH: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12HILO;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_YES;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_HALFWORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_SLLI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_LSHIFT;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_SHAMT;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_BNE: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_YES;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NEQ;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_LUI: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5_LUI;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_C_ADDI16SP: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS2;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM5_16SP;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_SB: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_IMM12HILO;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_YES;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_BYTE;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_DIV: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_DIV;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_BEQ: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_YES;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_EQ;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_C_J: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_ALU_RES;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_16BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_YES;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_ADD;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_CIMM10CJ;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_PC_EXE;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD_C;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD_C;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD_C;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_NO;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1_C;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2_C;
    end
    NANORV32_DECODE_OR: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_OR;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_ALU;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
    NANORV32_DECODE_RDINSTRET: begin
        pc_next_sel = NANORV32_MUX_SEL_PC_NEXT_PLUS4;
        pc_size_sel = NANORV32_MUX_SEL_PC_SIZE_32BITS;
        pc_branch_sel = NANORV32_MUX_SEL_PC_BRANCH_NO;
        alu_op_sel = NANORV32_MUX_SEL_ALU_OP_NOOP;
        alu_portb_sel = NANORV32_MUX_SEL_ALU_PORTB_RS2;
        alu_porta_sel = NANORV32_MUX_SEL_ALU_PORTA_RS1;
        datamem_size_read_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD;
        datamem_write_sel = NANORV32_MUX_SEL_DATAMEM_WRITE_NO;
        datamem_size_write_sel = NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD;
        datamem_read_sel = NANORV32_MUX_SEL_DATAMEM_READ_NO;
        regfile_portw_sel = NANORV32_MUX_SEL_REGFILE_PORTW_RD;
        regfile_source_sel = NANORV32_MUX_SEL_REGFILE_SOURCE_CSR_RDATA;
        regfile_write_sel = NANORV32_MUX_SEL_REGFILE_WRITE_YES;
        regfile_port1_sel = NANORV32_MUX_SEL_REGFILE_PORT1_RS1;
        regfile_port2_sel = NANORV32_MUX_SEL_REGFILE_PORT2_RS2;
    end
