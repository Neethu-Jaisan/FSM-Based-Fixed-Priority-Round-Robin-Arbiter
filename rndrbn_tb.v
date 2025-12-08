`timescale 1ns / 1ps

module rndrbn_tb;

    reg clk, rst, prior;
    reg [3:0] req;
    wire [3:0] grant;

    rndrbn uut(clk, rst, prior, req, grant);

    always begin
        clk = 1; #5;
        clk = 0; #5;
    end

    initial begin
        rst = 1; prior = 0; req = 0; #20;
        rst = 0;

        // PRIORITY MODE
        prior = 1;
        req = 4'b1000; #20;
        req = 4'b1110; #20;
        req = 4'b0110; #20;
        req = 4'b1111; #20;

        // ROUND ROBIN
        prior = 0;
        req = 4'b1111; #80;
        req = 4'b0100; #20;
        req = 4'b0000; #20;

        $stop;
    end

endmodule
