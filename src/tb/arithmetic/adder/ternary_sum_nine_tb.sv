///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Verilog implementation of Advanced Synthesis Cookbook ~~~
//
// Module Name: ternary_sum_nine_tb
//
// Author: Heqing Huang
// Date Created: 08/04/2021
//
// ================== Description ==================
//
// Testbench for ternary_sum_nine
//
///////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/10ps

module ternary_sum_nine_tb();

parameter WIDTH=16;

reg  clk;
reg  [WIDTH-1:0] i0;
reg  [WIDTH-1:0] i1;
reg  [WIDTH-1:0] i2;
reg  [WIDTH-1:0] i3;
reg  [WIDTH-1:0] i4;
reg  [WIDTH-1:0] i5;
reg  [WIDTH-1:0] i6;
reg  [WIDTH-1:0] i7;
reg  [WIDTH-1:0] i8;
wire [WIDTH+4-1:0] o;

reg  error = 0;

ternary_sum_nine #(WIDTH) DUT(.*);

task test;
    reg [WIDTH+4-1:0] sum;
    i0 = $random;
    i1 = $random;
    i2 = $random;
    i3 = $random;
    i4 = $random;
    i5 = $random;
    i6 = $random;
    i7 = $random;
    i8 = $random;
    repeat (2) @(posedge clk);
    #1
    sum = i0 + i1 + i2 + i3 + i4 + i5 + i6 + i7 + i8;
    //$display("%d, %d", sum, o);
    assert(o == sum);
    if (o !== sum) error = 1;
endtask

initial begin
    clk = 1'b0;
    forever begin
        #5 clk = ~clk;
    end
end

initial begin
    for (integer i = 0; i < 1000; i++)
        test();
    if (error == 0) $display("PASSED");
    else $display("FAILED");
    $finish();
end

/*
initial
begin
    $dumpfile("output/ternary_sum_nine_tb.vcd");
    $dumpvars(0,ternary_sum_nine_tb);
end
*/

endmodule