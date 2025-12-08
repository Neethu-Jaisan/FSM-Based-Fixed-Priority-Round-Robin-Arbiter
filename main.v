`timescale 1ns / 1ps

module rndrbn(
    input clk,
    input rst,
    input prior,
    input [3:0] req,
    output reg [3:0] grant
);

    reg [2:0] pr_state, nxt_state;
    reg [3:0] nxt_grant;

    // State encoding
    parameter Sidl = 3'b000;
    parameter S0   = 3'b001;
    parameter S1   = 3'b010;
    parameter S2   = 3'b011;
    parameter S3   = 3'b100;

    // Sequential Block
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pr_state <= Sidl;
            grant    <= 4'b0000;
        end else begin
            pr_state <= nxt_state;
            grant    <= nxt_grant;
        end
    end

    // Combinational Block
    always @(*) begin
        nxt_grant = 4'b0000;
        nxt_state = pr_state;

        // FIXED PRIORITY MODE
        if (prior == 1) begin
            if      (req[0]) begin nxt_state = S0; nxt_grant = 4'b0001; end
            else if (req[1]) begin nxt_state = S1; nxt_grant = 4'b0010; end
            else if (req[2]) begin nxt_state = S2; nxt_grant = 4'b0100; end
            else if (req[3]) begin nxt_state = S3; nxt_grant = 4'b1000; end
        end 
        
        // ROUND ROBIN MODE
        else begin
            case (pr_state)
                Sidl: begin
                    if      (req[0]) begin nxt_state = S0; nxt_grant = 4'b0001; end
                    else if (req[1]) begin nxt_state = S1; nxt_grant = 4'b0010; end
                    else if (req[2]) begin nxt_state = S2; nxt_grant = 4'b0100; end
                    else if (req[3]) begin nxt_state = S3; nxt_grant = 4'b1000; end
                end

                S0: begin
                    if      (req[1]) begin nxt_state = S1; nxt_grant = 4'b0010; end
                    else if (req[2]) begin nxt_state = S2; nxt_grant = 4'b0100; end
                    else if (req[3]) begin nxt_state = S3; nxt_grant = 4'b1000; end
                    else if (req[0]) begin nxt_state = S0; nxt_grant = 4'b0001; end
                end

                S1: begin
                    if      (req[2]) begin nxt_state = S2; nxt_grant = 4'b0100; end
                    else if (req[3]) begin nxt_state = S3; nxt_grant = 4'b1000; end
                    else if (req[0]) begin nxt_state = S0; nxt_grant = 4'b0001; end
                    else if (req[1]) begin nxt_state = S1; nxt_grant = 4'b0010; end
                end

                S2: begin
                    if      (req[3]) begin nxt_state = S3; nxt_grant = 4'b1000; end
                    else if (req[0]) begin nxt_state = S0; nxt_grant = 4'b0001; end
                    else if (req[1]) begin nxt_state = S1; nxt_grant = 4'b0010; end
                    else if (req[2]) begin nxt_state = S2; nxt_grant = 4'b0100; end
                end

                S3: begin
                    if      (req[0]) begin nxt_state = S0; nxt_grant = 4'b0001; end
                    else if (req[1]) begin nxt_state = S1; nxt_grant = 4'b0010; end
                    else if (req[2]) begin nxt_state = S2; nxt_grant = 4'b0100; end
                    else if (req[3]) begin nxt_state = S3; nxt_grant = 4'b1000; end
                end
            endcase
        end
    end

endmodule
