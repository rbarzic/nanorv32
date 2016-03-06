module nanorv32_divide(
                      input                         clk,
                      input                         rst_n,
                      input                         req_valid,
                      input                         req_in_1_signed,
                      input                         req_in_2_signed,
                      input                         rem_op_sel,
                      input [31:0]                  req_in_1,
                      input [31:0]                  req_in_2,
                      output                        resp_valid,
                      output [31:0]                 resp_result,
                      output                        req_ready
                      );

   localparam md_state_width = 2;
   localparam s_idle = 0;
   localparam s_compute = 1;
   localparam s_setup_output = 2;
   localparam s_done = 3;

   reg [md_state_width-1:0]                         state;
   reg [md_state_width-1:0]                         next_state;
   reg                                              rem_op;
   reg                                              negate_output;
   reg [63:0]                        a;
   reg [63:0]                        b;
   reg [5:0]                          counter;
   reg [63:0]                        result;

   wire [31:0]                              abs_in_1;
   wire                                             sign_in_1;
   wire [31:0]                              abs_in_2;
   wire                                             sign_in_2;

   wire                                             a_geq;
   wire [63:0]                       result_muxed;
   wire [63:0]                       result_muxed_negated;
   wire [31:0]                              final_result;

   function [31:0] abs_input;
      input [31:0]                          data;
      input                                         is_signed;
      begin
         abs_input = (data[31] == 1'b1 && is_signed) ? -data : data;
      end
   endfunction // if
   function [5:0] clz_fnc;
      input [31:0]                          data;
      begin
         clz_fnc = {6{  data[31]              }} & 6'b000000 |
                   {6{~ data[31]    & data[30]}} & 6'b000001 |
                   {6{~|data[31:30] & data[29]}} & 6'b000010 |
                   {6{~|data[31:29] & data[28]}} & 6'b000011 |
                   {6{~|data[31:28] & data[27]}} & 6'b000100 |
                   {6{~|data[31:27] & data[26]}} & 6'b000101 |
                   {6{~|data[31:26] & data[25]}} & 6'b000110 |
                   {6{~|data[31:25] & data[24]}} & 6'b000111 |
                   {6{~|data[31:24] & data[23]}} & 6'b001000 |
                   {6{~|data[31:23] & data[22]}} & 6'b001001 |
                   {6{~|data[31:22] & data[21]}} & 6'b001010 |
                   {6{~|data[31:21] & data[20]}} & 6'b001011 |
                   {6{~|data[31:20] & data[19]}} & 6'b001100 |
                   {6{~|data[31:19] & data[18]}} & 6'b001101 |
                   {6{~|data[31:18] & data[17]}} & 6'b001110 |
                   {6{~|data[31:17] & data[16]}} & 6'b001111 |
                   {6{~|data[31:16] & data[15]}} & 6'b010000 |
                   {6{~|data[31:15] & data[14]}} & 6'b010001 |
                   {6{~|data[31:14] & data[13]}} & 6'b010010 |
                   {6{~|data[31:13] & data[12]}} & 6'b010011 |
                   {6{~|data[31:12] & data[11]}} & 6'b010100 |
                   {6{~|data[31:11] & data[10]}} & 6'b010101 |
                   {6{~|data[31:10] & data[09]}} & 6'b010110 |
                   {6{~|data[31:09] & data[08]}} & 6'b010111 |
                   {6{~|data[31:08] & data[07]}} & 6'b011000 |
                   {6{~|data[31:07] & data[06]}} & 6'b011001 |
                   {6{~|data[31:06] & data[05]}} & 6'b011010 |
                   {6{~|data[31:05] & data[04]}} & 6'b011011 |
                   {6{~|data[31:04] & data[03]}} & 6'b011100 |
                   {6{~|data[31:03] & data[02]}} & 6'b011101 |
                   {6{~|data[31:02] & data[01]}} & 6'b011110 |
                   {6{~|data[31:01] & data[00]}} & 6'b011111 |
                   {6{~|data[31:00]           }} & 6'b100000 ;
      end
   endfunction // if

   assign req_ready = (state == s_idle);
   assign resp_valid = (state == s_done);
   assign resp_result = result[31:0];

   assign abs_in_1 = abs_input(req_in_1,req_in_1_signed);
   assign sign_in_1 = req_in_1_signed && req_in_1[31];
   assign abs_in_2 = abs_input(req_in_2,req_in_2_signed);
   assign sign_in_2 = req_in_2_signed && req_in_2[31];

   assign a_geq = a >= b;
   assign result_muxed = rem_op ? a : result;
   assign result_muxed_negated = (negate_output) ? -result_muxed : result_muxed;
   assign final_result = result_muxed_negated[0+:32];
   wire   [5:0] clz_a = clz_fnc (abs_in_1);
   wire   [5:0] clz_b = clz_fnc (abs_in_2);
   wire   [5:0] clz_diff = clz_b -clz_a;
   always @(posedge clk or negedge rst_n) begin
      if (rst_n == 0) begin
         state <= s_idle;
      end else begin
         state <= next_state;
      end
   end

   always @(*) begin
      case (state)
        s_idle         : next_state = (req_valid) ? s_compute : s_idle;
        s_compute      : next_state = (counter == 0) ? s_setup_output : s_compute;
        s_setup_output : next_state = s_done;
        s_done         : next_state = s_idle;
        default : next_state = s_idle;
      endcase // case (state)
   end

   always @(posedge clk) begin
      case (state)
        s_idle : begin
           if (req_valid) begin
              result <= clz_b == 6'b100000 ? 64'hffff_ffff_ffff_ffff : 64'h0;
              a <= {32'b0,abs_in_1};
              b <= {32'b0,abs_in_2} << clz_diff;
              negate_output <= rem_op_sel ? sign_in_1 : sign_in_1 ^ sign_in_2;
              rem_op <= rem_op_sel;
              counter <= clz_diff;
           end
        end
        s_compute : begin
           counter <= counter - 1;
           b <= b >> 1;
           if (a_geq) begin
              a <= a - b;
              result <= (64'b1 << counter) | result;
           end
        end // case: s_compute
        s_setup_output : begin
           counter <= 0;
           result <= {32'b0,final_result};
        end
      endcase // case (state)
   end // always @ (posedge clk)

endmodule // vscale_mul_div

