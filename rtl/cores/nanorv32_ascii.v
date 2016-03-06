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

   output [6*8-1:0] ascii_chain;
   output [4*8-1:0] reg_to_ascii_rd;
   output [4*8-1:0] reg_to_ascii_rd2;
   output [4*8-1:0] reg_to_ascii_rs1;
   output [4*8-1:0] reg_to_ascii_rs2;
   input  [31:0]    instruction_r;
   input  [4:0]    reg_rd;
   input  [4:0]    reg_rd2;
   input  [4:0]    reg_rs1;
   input  [4:0]    reg_rs2;

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
