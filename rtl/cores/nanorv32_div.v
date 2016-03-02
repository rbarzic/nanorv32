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
   reg [4:0]                          counter;
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
              result <= 0;
              a <= {32'b0,abs_in_1};
              b <= {abs_in_2,32'b0} >> 1;
              negate_output <= rem_op_sel ? sign_in_1 : sign_in_1 ^ sign_in_2;
              rem_op <= rem_op_sel;
              counter <= 32 - 1;
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
           result <= {32'b0,final_result};
        end
      endcase // case (state)
   end // always @ (posedge clk)

endmodule // vscale_mul_div

