module nanorv32_ascii (/*AUTOARG*/
   ascii_chain,
   instruction_r );

`include "nanorv32_parameters.v"

   output [6*8-1:0] ascii_chain;
   input  [31:0]    instruction_r;

   reg     [6*8-1:0] ascii_chain; 
   always @* begin
      casez (instruction_r)
          NANORV32_DECODE_AND    : ascii_chain = "AND   ";
          NANORV32_DECODE_LBU    : ascii_chain = "LBU   "; 
          NANORV32_DECODE_FENCE  : ascii_chain = "FENCE "; 
          NANORV32_DECODE_SLTI   : ascii_chain = "SLTI  "; 
          NANORV32_DECODE_SBREAK : ascii_chain = "SBREAK"; 
          NANORV32_DECODE_BLTU   : ascii_chain = "BLTU  "; 
          NANORV32_DECODE_XOR    : ascii_chain = "XOR   "; 
          NANORV32_DECODE_SLL    : ascii_chain = "SLL   "; 
          NANORV32_DECODE_MULHU  : ascii_chain = "MULHU "; 
          NANORV32_DECODE_ANDI   : ascii_chain = "ANDI  "; 
          NANORV32_DECODE_JALR   : ascii_chain = "JALR  "; 
          NANORV32_DECODE_BLT    : ascii_chain = "BLT   "; 
          NANORV32_DECODE_SCALL  : ascii_chain = "SCALL "; 
          NANORV32_DECODE_FENCE_I: ascii_chain = "FENCE_"; 
          NANORV32_DECODE_ADD    : ascii_chain = "ADD   "; 
          NANORV32_DECODE_LH     : ascii_chain = "LH    "; 
          NANORV32_DECODE_LWU    : ascii_chain = "LWU   "; 
          NANORV32_DECODE_LW     : ascii_chain = "LW    "; 
          NANORV32_DECODE_JAL    : ascii_chain = "JAL   "; 
          NANORV32_DECODE_AUIPC  : ascii_chain = "AUIPC "; 
          NANORV32_DECODE_REM    : ascii_chain = "REM   "; 
          NANORV32_DECODE_LUI    : ascii_chain = "LUI   "; 
          NANORV32_DECODE_ADDI   : ascii_chain = "ADDI  "; 
          NANORV32_DECODE_MULH   : ascii_chain = "MULH  "; 
          NANORV32_DECODE_BGEU   : ascii_chain = "BGEU  "; 
          NANORV32_DECODE_SLTIU  : ascii_chain = "SLTIU "; 
          NANORV32_DECODE_SLLI   : ascii_chain = "SLLI  "; 
          NANORV32_DECODE_SRAI   : ascii_chain = "SRAI  "; 
          NANORV32_DECODE_MULHSU : ascii_chain = "MULHSU"; 
          NANORV32_DECODE_LD     : ascii_chain = "LD    "; 
          NANORV32_DECODE_ORI    : ascii_chain = "ORI   "; 
          NANORV32_DECODE_XORI   : ascii_chain = "XORI  "; 
          NANORV32_DECODE_LB     : ascii_chain = "LB    "; 
          NANORV32_DECODE_DIVU   : ascii_chain = "DIVU  "; 
          NANORV32_DECODE_SUB    : ascii_chain = "SUB   "; 
          NANORV32_DECODE_SRA    : ascii_chain = "SRA   "; 
          NANORV32_DECODE_BGE    : ascii_chain = "BGE   "; 
          NANORV32_DECODE_SLT    : ascii_chain = "SLT   "; 
          NANORV32_DECODE_SRLI   : ascii_chain = "SRLI  "; 
          NANORV32_DECODE_SW     : ascii_chain = "SW    "; 
          NANORV32_DECODE_REMU   : ascii_chain = "REMU  "; 
          NANORV32_DECODE_SRL    : ascii_chain = "SRL   "; 
          NANORV32_DECODE_SLTU   : ascii_chain = "SLTU  "; 
          NANORV32_DECODE_LHU    : ascii_chain = "LHU   "; 
          NANORV32_DECODE_SH     : ascii_chain = "SH    "; 
          NANORV32_DECODE_MUL    : ascii_chain = "MUL   "; 
          NANORV32_DECODE_BNE    : ascii_chain = "BNE   "; 
          NANORV32_DECODE_SB     : ascii_chain = "SB    "; 
          NANORV32_DECODE_DIV    : ascii_chain = "DIV   "; 
          NANORV32_DECODE_BEQ    : ascii_chain = "BEQ   "; 
          NANORV32_DECODE_OR     : ascii_chain = "OR    "; 
          NANORV32_DECODE_SD     : ascii_chain = "SD    "; 
          default                : ascii_chain = "UNDEF ";
     endcase
   end

endmodule
