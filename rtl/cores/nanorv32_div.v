module nanorv32_divide(
ready,
quotient,
remainder,
dividend,
divider,
sign,
clk
);

input clk;
input sign;
input [31:0] dividend, divider;
output [31:0] quotient, remainder;
output ready;

reg [31:0] quotient, quotient_temp;
reg [63:0] dividend_copy, divider_copy, diff;
reg negative_output;

wire [31:0] remainder = (!negative_output) ?
dividend_copy[31:0] :
~dividend_copy[31:0] + 1'b1;

reg [5:0] bit;
wire ready = !bit;

always @( posedge clk or negedge rst_n)
   if (rst_n == 0) bgein 
      bit             <= 6'b0;
      quotient        <= 32'h0;
      quotient_temp   <= 32'h0;
      dividend_copy   <= 64'h0;
      divider_copy    <= 64'h0; 
      negative_output <= 1'b0;
      diff            <= 64'h0;
   end else 
   if( ready ) begin
      bit             <= 6'd32;
      quotient        <= 32'h0;
      quotient_temp   <= 32'h0;
      dividend_copy   <= (!sign || !dividend[31]) ?  {32'd0,dividend} : {32'd0,~dividend + 1'b1};
      divider_copy    <= (!sign || !divider[31]) ?   {1'b0,divider,31'd0} : {1'b0,~divider + 1'b1,31'd0};
      negative_output <= sign &&  ((divider[31] && !dividend[31]) ||(!divider[31] && dividend[31]));
   end
else if ( bit > 0 ) begin

     bit               <= bit - 1'b1;
     quotient           <= (!negative_output) ? quotient_temp : ~quotient_temp + 1'b1;
     quotient_temp     <= quotient_temp << 1;
     if( !diff[63] ) begin
        dividend_copy    <= diff;
        quotient_temp[0] <= 1'd1;
     end
     divider_copy       <= divider_copy >> 1;
     diff              <= dividend_copy - divider_copy;
end
endmodule

