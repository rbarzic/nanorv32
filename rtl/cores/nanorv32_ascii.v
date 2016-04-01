module nanorv32_ascii (/*AUTOARG*/
   ascii_chain,
   reg_to_ascii_rd,
   reg_to_ascii_rd2,
   reg_to_ascii_rs1,
   reg_to_ascii_rs2,
   instruction_r,
   reg_rd,
   reg_rd2,
   reg_rs1,
   reg_rs2 );

`include "nanorv32_parameters.v"

   output [10*8-1:0] ascii_chain;
   output [4*8-1:0] reg_to_ascii_rd;
   output [4*8-1:0] reg_to_ascii_rd2;
   output [4*8-1:0] reg_to_ascii_rs1;
   output [4*8-1:0] reg_to_ascii_rs2;
   input  [34:0]    instruction_r;
   input  [4:0]    reg_rd;
   input  [4:0]    reg_rd2;
   input  [4:0]    reg_rs1;
   input  [4:0]    reg_rs2;

   reg     [10*8-1:0] ascii_chain;
   always @* begin
      casez (instruction_r)
          NANORV32_DECODE_C_SWSP    :ascii_chain ="c.swsp    ";
          NANORV32_DECODE_C_LWSP    :ascii_chain ="c.lwsp    ";
          NANORV32_DECODE_C_ADDI    :ascii_chain ="c.addi    ";
          NANORV32_DECODE_C_ADD4SPN :ascii_chain ="c.add4spn ";
          NANORV32_DECODE_C_SLLI    :ascii_chain ="c.slli    ";
          NANORV32_DECODE_C_OR      :ascii_chain ="c.or      ";
          NANORV32_DECODE_C_MV      :ascii_chain ="c.mv      ";
          NANORV32_DECODE_C_JALR    :ascii_chain ="c.jalr    ";
          NANORV32_DECODE_C_BEQZ    :ascii_chain ="c.beqz    ";
          NANORV32_DECODE_C_BNEZ    :ascii_chain ="c.bnez    ";
          NANORV32_DECODE_C_SW      :ascii_chain ="c.sw      ";
          NANORV32_DECODE_C_LI      :ascii_chain ="c.li      ";
          NANORV32_DECODE_C_ADD     :ascii_chain ="c.add     ";
          NANORV32_DECODE_C_JR      :ascii_chain ="c.jr      ";
          NANORV32_DECODE_C_SRAI    :ascii_chain ="c.srai    ";
          NANORV32_DECODE_C_XOR     :ascii_chain ="c.xor     ";
          NANORV32_DECODE_C_LW      :ascii_chain ="c.lw      ";
          NANORV32_DECODE_C_ANDI    :ascii_chain ="c.andi    ";
          NANORV32_DECODE_C_EBREAK  :ascii_chain ="c.ebreak  ";
          NANORV32_DECODE_C_SRLI    :ascii_chain ="c.srli    ";
          NANORV32_DECODE_C_NOP     :ascii_chain ="c.nop     ";
          NANORV32_DECODE_C_SUB     :ascii_chain ="c.sub     ";
          NANORV32_DECODE_C_LUI     :ascii_chain ="c.lui     ";
          NANORV32_DECODE_C_AND     :ascii_chain ="c.and     ";
          NANORV32_DECODE_C_J       :ascii_chain ="c.j       ";
          NANORV32_DECODE_C_JAL     :ascii_chain ="c.jal     ";
          NANORV32_DECODE_C_ADDI16SP:ascii_chain ="c.addi16sp";

          NANORV32_DECODE_AND    : ascii_chain = "and     ";
          NANORV32_DECODE_LBU    : ascii_chain = "lbu     ";
          NANORV32_DECODE_FENCE  : ascii_chain = "fence   ";
          NANORV32_DECODE_SLTI   : ascii_chain = "slti    ";
          NANORV32_DECODE_SBREAK : ascii_chain = "sbreak  ";
          NANORV32_DECODE_BLTU   : ascii_chain = "bltu    ";
          NANORV32_DECODE_XOR    : ascii_chain = "xor     ";
          NANORV32_DECODE_SLL    : ascii_chain = "sll     ";
          NANORV32_DECODE_MULHU  : ascii_chain = "mulhu   ";
          NANORV32_DECODE_ANDI   : ascii_chain = "andi    ";
          NANORV32_DECODE_JALR   : ascii_chain = "jalr    ";
          NANORV32_DECODE_BLT    : ascii_chain = "blt     ";
          NANORV32_DECODE_SCALL  : ascii_chain = "scall   ";
          NANORV32_DECODE_FENCE_I: ascii_chain = "fence_  ";
          NANORV32_DECODE_ADD    : ascii_chain = "add     ";
          NANORV32_DECODE_LH     : ascii_chain = "lh      ";
          NANORV32_DECODE_LWU    : ascii_chain = "lwu     ";
          NANORV32_DECODE_LW     : ascii_chain = "lw      ";
          NANORV32_DECODE_JAL    : ascii_chain = "jal     ";
          NANORV32_DECODE_AUIPC  : ascii_chain = "auipc   ";
          NANORV32_DECODE_REM    : ascii_chain = "rem     ";
          NANORV32_DECODE_LUI    : ascii_chain = "lui     ";
          NANORV32_DECODE_ADDI   : ascii_chain = "addi    ";
          NANORV32_DECODE_MULH   : ascii_chain = "mulh    ";
          NANORV32_DECODE_BGEU   : ascii_chain = "bgeu    ";
          NANORV32_DECODE_SLTIU  : ascii_chain = "sltiu   ";
          NANORV32_DECODE_SLLI   : ascii_chain = "slli    ";
          NANORV32_DECODE_SRAI   : ascii_chain = "srai    ";
          NANORV32_DECODE_MULHSU : ascii_chain = "mulhsu  ";
          NANORV32_DECODE_LD     : ascii_chain = "ld      ";
          NANORV32_DECODE_ORI    : ascii_chain = "ori     ";
          NANORV32_DECODE_XORI   : ascii_chain = "xori    ";
          NANORV32_DECODE_LB     : ascii_chain = "lb      ";
          NANORV32_DECODE_DIVU   : ascii_chain = "divu    ";
          NANORV32_DECODE_SUB    : ascii_chain = "sub     ";
          NANORV32_DECODE_SRA    : ascii_chain = "sra     ";
          NANORV32_DECODE_BGE    : ascii_chain = "bge     ";
          NANORV32_DECODE_SLT    : ascii_chain = "slt     ";
          NANORV32_DECODE_SRLI   : ascii_chain = "srli    ";
          NANORV32_DECODE_SW     : ascii_chain = "sw      ";
          NANORV32_DECODE_REMU   : ascii_chain = "remu    ";
          NANORV32_DECODE_SRL    : ascii_chain = "srl     ";
          NANORV32_DECODE_SLTU   : ascii_chain = "sltu    ";
          NANORV32_DECODE_LHU    : ascii_chain = "lhu     ";
          NANORV32_DECODE_SH     : ascii_chain = "sh      ";
          NANORV32_DECODE_MUL    : ascii_chain = "mul     ";
          NANORV32_DECODE_BNE    : ascii_chain = "bne     ";
          NANORV32_DECODE_SB     : ascii_chain = "sb      ";
          NANORV32_DECODE_DIV    : ascii_chain = "div     ";
          NANORV32_DECODE_BEQ    : ascii_chain = "beq     ";
          NANORV32_DECODE_OR     : ascii_chain = "or      ";
          NANORV32_DECODE_SD        :ascii_chain ="sd      ";

          default                : ascii_chain = "UNDEF   ";
     endcase
   end
   reg   [4*8-1:0] tmp_rd;
   always @* begin
     case (reg_rd)
        5'h00 : tmp_rd = "zero";
        5'h01 : tmp_rd = "ra  ";
        5'h02 : tmp_rd = "sp  ";
        5'h03 : tmp_rd = "gp  ";
        5'h04 : tmp_rd = "tp  ";
        5'h05 : tmp_rd = "t0  ";
        5'h06 : tmp_rd = "t1  ";
        5'h07 : tmp_rd = "t2  ";
        5'h08 : tmp_rd = "so  ";
        5'h09 : tmp_rd = "s1  ";
        5'h0a : tmp_rd = "a0  ";
        5'h0b : tmp_rd = "a1  ";
        5'h0c : tmp_rd = "a2  ";
        5'h0d : tmp_rd = "a3  ";
        5'h0e : tmp_rd = "a4  ";
        5'h0f : tmp_rd = "a5  ";
        5'h10 : tmp_rd = "a6  ";
        5'h11 : tmp_rd = "a7  ";
        5'h12 : tmp_rd = "s2  ";
        5'h13 : tmp_rd = "s3  ";
        5'h14 : tmp_rd = "s4  ";
        5'h15 : tmp_rd = "s5  ";
        5'h16 : tmp_rd = "s6  ";
        5'h17 : tmp_rd = "s7  ";
        5'h18 : tmp_rd = "s8  ";
        5'h19 : tmp_rd = "s9  ";
        5'h1a : tmp_rd = "s10 ";
        5'h1b : tmp_rd = "s11 ";
        5'h1c : tmp_rd = "t3  ";
        5'h1d : tmp_rd = "t4  ";
        5'h1e : tmp_rd = "t5  ";
        5'h1f : tmp_rd = "t6  ";
     endcase
   end
   assign reg_to_ascii_rd = tmp_rd;
   reg   [4*8-1:0] tmp_rd2;
   always @* begin
     case (reg_rd2)
        5'h00 : tmp_rd2 = "zero";
        5'h01 : tmp_rd2 = "ra  ";
        5'h02 : tmp_rd2 = "sp  ";
        5'h03 : tmp_rd2 = "gp  ";
        5'h04 : tmp_rd2 = "tp  ";
        5'h05 : tmp_rd2 = "t0  ";
        5'h06 : tmp_rd2 = "t1  ";
        5'h07 : tmp_rd2 = "t2  ";
        5'h08 : tmp_rd2 = "so  ";
        5'h09 : tmp_rd2 = "s1  ";
        5'h0a : tmp_rd2 = "a0  ";
        5'h0b : tmp_rd2 = "a1  ";
        5'h0c : tmp_rd2 = "a2  ";
        5'h0d : tmp_rd2 = "a3  ";
        5'h0e : tmp_rd2 = "a4  ";
        5'h0f : tmp_rd2 = "a5  ";
        5'h10 : tmp_rd2 = "a6  ";
        5'h11 : tmp_rd2 = "a7  ";
        5'h12 : tmp_rd2 = "s2  ";
        5'h13 : tmp_rd2 = "s3  ";
        5'h14 : tmp_rd2 = "s4  ";
        5'h15 : tmp_rd2 = "s5  ";
        5'h16 : tmp_rd2 = "s6  ";
        5'h17 : tmp_rd2 = "s7  ";
        5'h18 : tmp_rd2 = "s8  ";
        5'h19 : tmp_rd2 = "s9  ";
        5'h1a : tmp_rd2 = "s10 ";
        5'h1b : tmp_rd2 = "s11 ";
        5'h1c : tmp_rd2 = "t3  ";
        5'h1d : tmp_rd2 = "t4  ";
        5'h1e : tmp_rd2 = "t5  ";
        5'h1f : tmp_rd2 = "t6  ";
     endcase
   end
   assign reg_to_ascii_rd2 = tmp_rd2;
     reg   [4*8-1:0] tmp_rs1;
     always @* begin
       case (reg_rs1)
          5'h00 : tmp_rs1 = "zero";
          5'h01 : tmp_rs1 = "ra  ";
          5'h02 : tmp_rs1 = "sp  ";
          5'h03 : tmp_rs1 = "gp  ";
          5'h04 : tmp_rs1 = "tp  ";
          5'h05 : tmp_rs1 = "t0  ";
          5'h06 : tmp_rs1 = "t1  ";
          5'h07 : tmp_rs1 = "t2  ";
          5'h08 : tmp_rs1 = "so  ";
          5'h09 : tmp_rs1 = "s1  ";
          5'h0a : tmp_rs1 = "a0  ";
          5'h0b : tmp_rs1 = "a1  ";
          5'h0c : tmp_rs1 = "a2  ";
          5'h0d : tmp_rs1 = "a3  ";
          5'h0e : tmp_rs1 = "a4  ";
          5'h0f : tmp_rs1 = "a5  ";
          5'h10 : tmp_rs1 = "a6  ";
          5'h11 : tmp_rs1 = "a7  ";
          5'h12 : tmp_rs1 = "s2  ";
          5'h13 : tmp_rs1 = "s3  ";
          5'h14 : tmp_rs1 = "s4  ";
          5'h15 : tmp_rs1 = "s5  ";
          5'h16 : tmp_rs1 = "s6  ";
          5'h17 : tmp_rs1 = "s7  ";
          5'h18 : tmp_rs1 = "s8  ";
          5'h19 : tmp_rs1 = "s9  ";
          5'h1a : tmp_rs1 = "s10 ";
          5'h1b : tmp_rs1 = "s11 ";
          5'h1c : tmp_rs1 = "t3  ";
          5'h1d : tmp_rs1 = "t4  ";
          5'h1e : tmp_rs1 = "t5  ";
          5'h1f : tmp_rs1 = "t6  ";
       endcase
     end
   assign reg_to_ascii_rs1 = tmp_rs1;
     reg   [4*8-1:0] tmp_rs2;
     always @* begin
       case (reg_rs2)
          5'h00 : tmp_rs2 = "zero";
          5'h01 : tmp_rs2 = "ra  ";
          5'h02 : tmp_rs2 = "sp  ";
          5'h03 : tmp_rs2 = "gp  ";
          5'h04 : tmp_rs2 = "tp  ";
          5'h05 : tmp_rs2 = "t0  ";
          5'h06 : tmp_rs2 = "t1  ";
          5'h07 : tmp_rs2 = "t2  ";
          5'h08 : tmp_rs2 = "so  ";
          5'h09 : tmp_rs2 = "s1  ";
          5'h0a : tmp_rs2 = "a0  ";
          5'h0b : tmp_rs2 = "a1  ";
          5'h0c : tmp_rs2 = "a2  ";
          5'h0d : tmp_rs2 = "a3  ";
          5'h0e : tmp_rs2 = "a4  ";
          5'h0f : tmp_rs2 = "a5  ";
          5'h10 : tmp_rs2 = "a6  ";
          5'h11 : tmp_rs2 = "a7  ";
          5'h12 : tmp_rs2 = "s2  ";
          5'h13 : tmp_rs2 = "s3  ";
          5'h14 : tmp_rs2 = "s4  ";
          5'h15 : tmp_rs2 = "s5  ";
          5'h16 : tmp_rs2 = "s6  ";
          5'h17 : tmp_rs2 = "s7  ";
          5'h18 : tmp_rs2 = "s8  ";
          5'h19 : tmp_rs2 = "s9  ";
          5'h1a : tmp_rs2 = "s10 ";
          5'h1b : tmp_rs2 = "s11 ";
          5'h1c : tmp_rs2 = "t3  ";
          5'h1d : tmp_rs2 = "t4  ";
          5'h1e : tmp_rs2 = "t5  ";
          5'h1f : tmp_rs2 = "t6  ";
       endcase
     end
   assign reg_to_ascii_rs2 = tmp_rs2;

endmodule
