`timescale 1ns/1ps

module logic_block(
    input wire a,
    input wire b,
    output wire y
);
    assign y = a & b;
endmodule

module assign_top(
    input wire clk,
    input wire rst_n,
    output wire [7:0] count,
    output wire count_msb_and_rst
);
    reg [7:0] counter;
    assign count = counter;

    logic_block U_LOGIC(
        .a(counter[7]),
        .b(rst_n),
        .y(count_msb_and_rst)
    );

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            counter <= 8'h00;
        else
            counter <= counter + 1;
    end
endmodule
