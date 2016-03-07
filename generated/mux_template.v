// Mux definitions for pc

//========================================

    case(pc_next)
        NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB: begin
            pc_next <= ;
        end
        NANORV32_MUX_SEL_PC_NEXT_PLUS4: begin
            pc_next <= ;
        end
        NANORV32_MUX_SEL_PC_NEXT_ALU_RES: begin
            pc_next <= ;
        end
//========================================

    case(pc_size)
        NANORV32_MUX_SEL_PC_SIZE_32BITS: begin
            pc_size <= ;
        end
        NANORV32_MUX_SEL_PC_SIZE_16BITS: begin
            pc_size <= ;
        end
//========================================

    case(pc_branch)
        NANORV32_MUX_SEL_PC_BRANCH_YES: begin
            pc_branch <= ;
        end
        NANORV32_MUX_SEL_PC_BRANCH_NO: begin
            pc_branch <= ;
        end// Mux definitions for alu

//========================================

    case(alu_op)
        NANORV32_MUX_SEL_ALU_OP_AND: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_LSHIFT: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_EQ: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_MULHU: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_XOR: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_SUB: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_LT_SIGNED: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_LT_UNSIGNED: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_ADD: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_NOOP: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_REM: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_MUL: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_NEQ: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_MULH: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_RSHIFT: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_GE_SIGNED: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_ARSHIFT: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_MULHSU: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_GE_UNSIGNED: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_DIVU: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_NOP: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_REMU: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_DIV: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_OR: begin
            alu_op <= ;
        end
//========================================

    case(alu_portb)
        NANORV32_MUX_SEL_ALU_PORTB_SHAMT: begin
            alu_portb <= ;
        end
        NANORV32_MUX_SEL_ALU_PORTB_IMM12: begin
            alu_portb <= ;
        end
        NANORV32_MUX_SEL_ALU_PORTB_IMM12HILO: begin
            alu_portb <= ;
        end
        NANORV32_MUX_SEL_ALU_PORTB_IMM20U: begin
            alu_portb <= ;
        end
        NANORV32_MUX_SEL_ALU_PORTB_IMM20UJ: begin
            alu_portb <= ;
        end
        NANORV32_MUX_SEL_ALU_PORTB_RS2: begin
            alu_portb <= ;
        end
//========================================

    case(alu_porta)
        NANORV32_MUX_SEL_ALU_PORTA_PC_EXE: begin
            alu_porta <= ;
        end
        NANORV32_MUX_SEL_ALU_PORTA_RS1: begin
            alu_porta <= ;
        end// Mux definitions for datamem

//========================================

    case(datamem_size_read)
        NANORV32_MUX_SEL_DATAMEM_SIZE_READ_HALFWORD_UNSIGNED: begin
            datamem_size_read <= ;
        end
        NANORV32_MUX_SEL_DATAMEM_SIZE_READ_HALFWORD: begin
            datamem_size_read <= ;
        end
        NANORV32_MUX_SEL_DATAMEM_SIZE_READ_WORD: begin
            datamem_size_read <= ;
        end
        NANORV32_MUX_SEL_DATAMEM_SIZE_READ_BYTE: begin
            datamem_size_read <= ;
        end
        NANORV32_MUX_SEL_DATAMEM_SIZE_READ_BYTE_UNSIGNED: begin
            datamem_size_read <= ;
        end
//========================================

    case(datamem_write)
        NANORV32_MUX_SEL_DATAMEM_WRITE_YES: begin
            datamem_write <= ;
        end
        NANORV32_MUX_SEL_DATAMEM_WRITE_WORD: begin
            datamem_write <= ;
        end
        NANORV32_MUX_SEL_DATAMEM_WRITE_NO: begin
            datamem_write <= ;
        end
//========================================

    case(datamem_size_write)
        NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_BYTE: begin
            datamem_size_write <= ;
        end
        NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_HALFWORD: begin
            datamem_size_write <= ;
        end
        NANORV32_MUX_SEL_DATAMEM_SIZE_WRITE_WORD: begin
            datamem_size_write <= ;
        end
//========================================

    case(datamem_read)
        NANORV32_MUX_SEL_DATAMEM_READ_YES: begin
            datamem_read <= ;
        end
        NANORV32_MUX_SEL_DATAMEM_READ_NO: begin
            datamem_read <= ;
        end// Mux definitions for regfile

//========================================

    case(regfile_portw)
        NANORV32_MUX_SEL_REGFILE_PORTW_RD: begin
            regfile_portw <= ;
        end
        NANORV32_MUX_SEL_REGFILE_PORTW_RS1: begin
            regfile_portw <= ;
        end
//========================================

    case(regfile_source)
        NANORV32_MUX_SEL_REGFILE_SOURCE_PC_EXE_PLUS_4: begin
            regfile_source <= ;
        end
        NANORV32_MUX_SEL_REGFILE_SOURCE_ALU: begin
            regfile_source <= ;
        end
        NANORV32_MUX_SEL_REGFILE_SOURCE_DATAMEM: begin
            regfile_source <= ;
        end
//========================================

    case(regfile_write)
        NANORV32_MUX_SEL_REGFILE_WRITE_YES: begin
            regfile_write <= ;
        end
        NANORV32_MUX_SEL_REGFILE_WRITE_NO: begin
            regfile_write <= ;
        end
//========================================

    case(regfile_port1)
        NANORV32_MUX_SEL_REGFILE_PORT1_RS1: begin
            regfile_port1 <= ;
        end
//========================================

    case(regfile_port2)
        NANORV32_MUX_SEL_REGFILE_PORT2_RS2: begin
            regfile_port2 <= ;
        end