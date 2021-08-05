///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Verilog implementation of Advanced Synthesis Cookbook ~~~
//
// Module Name: carry_select_adder
//
// Author: Heqing Huang
// Date Created: 08/04/2021
//
// ================== Description ==================
//
// Carry Select Adder
//
// From book:
// Carry select is a method of accelerating addition by supposing both possible carry in
// values, and then selecting the correct one. This technique is commonly used in
// computer hardware design
//
///////////////////////////////////////////////////////////////////////////////////////////////////

module carry_select_adder #(
    parameter WIDTH = 32,
    parameter CUT_WIDTH = 14
) (
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output [WIDTH-1:0] o,
    output c
);

    localparam LEVEL = ceil(WIDTH, CUT_WIDTH);
    localparam LAST_WIDTH = WIDTH % CUT_WIDTH == 0 ? CUT_WIDTH : WIDTH % CUT_WIDTH;

    wire [LEVEL-1:0] carry_chain;

    assign c = carry_chain[LEVEL-1];

    // first level - regular adder
    wire [CUT_WIDTH:0] level_sum;
    assign level_sum = a[CUT_WIDTH-1:0] + b[CUT_WIDTH-1:0];
    assign carry_chain[0] = level_sum[CUT_WIDTH];
    assign o[CUT_WIDTH-1:0] = level_sum[CUT_WIDTH-1:0];

    // middle level
    genvar i;
    generate
        for (i = 1; i < LEVEL-1; i++) begin:csa_node
            carry_select_adder_node #(.WIDTH(CUT_WIDTH))
            node(.a(a[(i+1)*CUT_WIDTH-1:i*CUT_WIDTH]), .b(b[(i+1)*CUT_WIDTH-1:i*CUT_WIDTH]), .s(carry_chain[i-1]), .o(o[(i+1)*CUT_WIDTH-1:i*CUT_WIDTH]), .c(carry_chain[i]));
        end
    endgenerate

    // last level
    carry_select_adder_node #(.WIDTH(LAST_WIDTH))
    last_node(.a(a[WIDTH-1:(LEVEL-1) *CUT_WIDTH]), .b(b[WIDTH-1:(LEVEL-1) *CUT_WIDTH]), .s(carry_chain[LEVEL-2]), .o(o[WIDTH-1:(LEVEL-1) *CUT_WIDTH]), .c(carry_chain[LEVEL-1]));

    function integer ceil;
        input integer a;
        input integer b;
        reg odd;
        odd = a % b > 0 ? 1 : 0;
        ceil = a / b + odd;
    endfunction

endmodule

module carry_select_adder_node #(
    parameter WIDTH = 32
) (
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    input s,
    output [WIDTH-1:0] o,
    output c
);

    wire [WIDTH:0] sum_with0, sum_with1;

    assign sum_with0 = a + b;
    assign sum_with1 = a + b + 1;

    assign o = s ? sum_with1[WIDTH-1:0] : sum_with0[WIDTH-1:0];
    assign c = s ? sum_with1[WIDTH] : sum_with0[WIDTH];

endmodule
