// Mux definitions for pc

//========================================

    case(pc_next)
        NANORV32_MUX_SEL_PC_NEXT_COND_PC_PLUS_IMMSB: begin
            pc_next <= ;
        end
        NANORV32_MUX_SEL_PC_NEXT_PLUS4: begin
            pc_next <= ;
        end// Mux definitions for alu

//========================================

    case(alu_op)
        NANORV32_MUX_SEL_ALU_OP_AND: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_XOR: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_SUB: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_COMP: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_ADD: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_NOOP: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_OR: begin
            alu_op <= ;
        end
        NANORV32_MUX_SEL_ALU_OP_ADDI: begin
            alu_op <= ;
        end
//========================================

    case(alu_portb)
        NANORV32_MUX_SEL_ALU_PORTB_IMM20: begin
            alu_portb <= ;
        end
        NANORV32_MUX_SEL_ALU_PORTB_SHAMT: begin
            alu_portb <= ;
        end
        NANORV32_MUX_SEL_ALU_PORTB_IMM12: begin
            alu_portb <= ;
        end
        NANORV32_MUX_SEL_ALU_PORTB_RS2: begin
            alu_portb <= ;
        end
        NANORV32_MUX_SEL_ALU_PORTB_IMM20UJ: begin
            alu_portb <= ;
        end
//========================================

    case(alu_porta)
        NANORV32_MUX_SEL_ALU_PORTA_PC: begin
            alu_porta <= ;
        end
        NANORV32_MUX_SEL_ALU_PORTA_RS1: begin
            alu_porta <= ;
        end// Mux definitions for datamem

//========================================

    case(datamem_write)
        NANORV32_MUX_SEL_DATAMEM_WRITE_WORD: begin
            datamem_write <= ;
        end
        NANORV32_MUX_SEL_DATAMEM_WRITE_NO: begin
            datamem_write <= ;
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

    case(regfile_source)
        NANORV32_MUX_SEL_REGFILE_SOURCE_NEXT_PC: begin
            regfile_source <= ;
        end
        NANORV32_MUX_SEL_REGFILE_SOURCE_ALU: begin
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