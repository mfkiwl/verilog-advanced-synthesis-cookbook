///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Verilog implementation of Advanced Synthesis Cookbook ~~~
//
// Module Name: carry_select_adder_tb
//
// Author: Heqing Huang
// Date Created: 08/04/2021
//
// ================== Description ==================
//
// Testbench for Carry Select Adder
//
///////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/10ps

module carry_select_adder_tb();

    parameter WIDTH=16;

    reg  [WIDTH-1:0] a;
    reg  [WIDTH-1:0] b;
    wire [WIDTH-1:0] o;
    wire c;

    reg  error = 0;

    carry_select_adder #(WIDTH, WIDTH/3) DUT(.*);

    task test;
        a = $random;
        b = $random;
        #1;
        //$display("%d + %d = %d", a, b, o);
        assert(o == a + b);
        if (o !== a + b) error++;

    endtask

    initial begin
        for (integer i = 0; i < 1000; i++)
            test();
        if (error == 0) $display("PASSED");
        else $display("FAILED");
        $finish();
    end

endmodule