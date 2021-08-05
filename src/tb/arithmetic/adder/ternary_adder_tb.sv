///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Verilog implementation of Advanced Synthesis Cookbook ~~~
//
// Module Name: ternary_adder_tb
//
// Author: Heqing Huang
// Date Created: 08/04/2021
//
// ================== Description ==================
//
// Testbench for Ternary Adder
//
///////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/10ps

module basic_adder_tb();

parameter WIDTH=16;

reg  [WIDTH-1:0] a;
reg  [WIDTH-1:0] b;
reg  [WIDTH-1:0] c;
wire [WIDTH-1:0] o;

reg  error = 0;

ternary_adder #(WIDTH) DUT(.*);

task test;
    a = $random;
    b = $random;
    c = $random;
    //$display("%d + %d + %d = %d", a, b, c, o);
    assert(o == a + b + c);
    if (o !== a + b + c) error = 1;
    #1;
endtask

initial begin
    for (integer i = 0; i < 1000; i++)
        test();
    if (error == 0) $display("PASSED");
    else $display("FAILED");
    $finish();
end

endmodule