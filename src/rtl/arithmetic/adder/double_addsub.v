///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Verilog implementation of Advanced Synthesis Cookbook ~~~
//
// Module Name: double_addsub
//
// Author: Heqing Huang
// Date Created: 08/04/2021
//
// ================== Description ==================
//
// Double Addsub/ Basic Addsub
//
// From book:
// You can implement (+/-A) as A when the sign is + and invert (A) + 1 when the sign
// is –. Because A and B are in the process of being summed, the +1s can be implemented
// at the same time (+0 when both are positive, +1 when exactly one is negative, and +2
// when both are negative).
// The XOR arrays feeding the adder A and B ports implement the invert step. The adder
// “C“ channel implements +0, +1, or +2 as appropriate to finish the two’s complement.
// Area cost is one cell per bit, packed in two cells per ALM
//
///////////////////////////////////////////////////////////////////////////////////////////////////

module double_addsub #(
    parameter WIDTH = 32
) (
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    input negate_a,
    input negate_b,
    output [WIDTH-1:0] o
);


wire [WIDTH-1:0] a_negated;
wire [WIDTH-1:0] b_negated;
wire [1:0] constant;

assign a_negated = a ^ {WIDTH{negate_a}};
assign b_negated = b ^ {WIDTH{negate_b}};
assign constant = {negate_a & negate_b, negate_a ^ negate_b};

assign o = a_negated + b_negated + constant;

endmodule