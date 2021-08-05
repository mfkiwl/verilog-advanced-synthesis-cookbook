///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Verilog implementation of Advanced Synthesis Cookbook ~~~
//
// Module Name: ternary_adder
//
// Author: Heqing Huang
// Date Created: 08/04/2021
//
// ================== Description ==================
//
// Ternary Adder
//
// From book:
// Standard binary adders are packed into two bits per Adaptive Logic Module (ALM).
// The HDL “+“ operator is the easiest way to specify an adder chain. This format is
// portable and generally leads to the best minimization.
//
///////////////////////////////////////////////////////////////////////////////////////////////////

/**
 Ternary Adder using "+" operation
*/
module ternary_adder #(
    parameter WIDTH = 32
) (
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    input [WIDTH-1:0] c,
    output [WIDTH-1:0] o
);

assign o = a + b + c;

endmodule