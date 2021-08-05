///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Verilog implementation of Advanced Synthesis Cookbook ~~~
//
// Module Name: double_addsub_tb
//
// Author: Heqing Huang
// Date Created: 08/04/2021
//
// ================== Description ==================
//
// Testbench for double_addsub
//
///////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/10ps

module double_addsub_tb();

parameter WIDTH=16;

reg [WIDTH-1:0] a;
reg [WIDTH-1:0] b;
reg negate_a;
reg negate_b;
wire [WIDTH-1:0] o;

reg  error = 0;

double_addsub #(WIDTH) DUT(.*);

task test;
    reg [WIDTH-1:0] result;
    a = $random;
    b = $random;
    negate_a = $random;
    negate_b = $random;
    case({negate_a, negate_b})
        2'b00: result = a + b;
        2'b01: result = a - b;
        2'b10: result = b - a;
        2'b11: result = 0 - a - b;
    endcase
    #1;
    //$display("%d, %d", negate_a, negate_b);
    //$display("%d op %d = %d, %d", a, b, o, result);
    assert(result == o);
    if (result !== o) error++;
endtask

initial begin
    for (integer i = 0; i < 1000; i++)
        test();
    if (error == 0) $display("PASSED");
    else $display("FAILED");
    $finish();
end

endmodule