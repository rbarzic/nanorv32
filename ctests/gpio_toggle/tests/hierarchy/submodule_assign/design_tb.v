`timescale 1ns/1ps
module design_tb;
    wire clk, rst_n;
    reg rst_a_n;
    clock_gen #(.period(20)) U_CLK (.clk(clk));
    reset_gen U_RST (.reset_n(rst_n), .reset_a_n(rst_a_n), .clk(clk));
    wire [7:0] count;
    wire count_msb_and_rst;
    assign_top U_DUT(
        .clk(clk), .rst_n(rst_n),
        .count(count), .count_msb_and_rst(count_msb_and_rst)
    );
    initial begin
        `ifdef VCD
        $dumpfile("design_tb.vcd");
        $dumpvars(0, design_tb);
        `endif
        rst_a_n = 0;
        #1 rst_a_n = 0;
        #100 rst_a_n = 1;
        #6000 $finish;
    end
endmodule
