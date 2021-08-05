///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Verilog implementation of Advanced Synthesis Cookbook ~~~
//
// Module Name: ternary_sum_nine
//
// Author: Heqing Huang
// Date Created: 08/04/2021
//
// ================== Description ==================
//
// Ternary Adder summing 9 value
//
///////////////////////////////////////////////////////////////////////////////////////////////////


module ternary_sum_nine #(
    parameter WIDTH = 32
) (
    input clk,
    input [WIDTH-1:0] i0,
    input [WIDTH-1:0] i1,
    input [WIDTH-1:0] i2,
    input [WIDTH-1:0] i3,
    input [WIDTH-1:0] i4,
    input [WIDTH-1:0] i5,
    input [WIDTH-1:0] i6,
    input [WIDTH-1:0] i7,
    input [WIDTH-1:0] i8,
    output [WIDTH+4-1:0] o
);


// LEVLE 1
wire [WIDTH+2-1:0] level0_sum0, level0_sum1, level0_sum2;

ternary_node #(.WIDTH(WIDTH)) tenary_adder_l0_a(.clk(clk), .a(i0), .b(i1), .c(i2), .o(level0_sum0));
ternary_node #(.WIDTH(WIDTH)) tenary_adder_l0_b(.clk(clk), .a(i3), .b(i4), .c(i5), .o(level0_sum1));
ternary_node #(.WIDTH(WIDTH)) tenary_adder_l0_c(.clk(clk), .a(i6), .b(i7), .c(i8), .o(level0_sum2));

// LEVEL 2
ternary_node #(.WIDTH(WIDTH+2)) tenary_adder_l1(.clk(clk), .a(level0_sum0), .b(level0_sum1), .c(level0_sum2), .o(o));

endmodule

module ternary_node #(
    parameter WIDTH = 32
) (
    input clk,
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    input [WIDTH-1:0] c,
    output reg [WIDTH+2-1:0] o
);

always @(posedge clk) begin
    o <= a + b + c;
end

endmodule
