 `timescale 1ns / 1ps

module dut(clk,rst,prior,req,grant);
    input clk,rst,prior;
    input [3:0] req;
    output reg [3:0] grant;
    reg[2:0] pr_state;
    reg[2:0] nxt_state;
    reg[3:0] nxt_grant;

    parameter [2:0] Sidl = 3'b000;
    parameter [2:0] S0   = 3'b001;
    parameter [2:0] S1   = 3'b010;
    parameter [2:0] S2   = 3'b011;
    parameter [2:0] S3   = 3'b100;

    always @(posedge clk or posedge rst) begin
        if (rst == 1) begin
            pr_state <= Sidl;
            grant    <= 4'b0000;
        end else begin
            pr_state <= nxt_state;
            grant    <= nxt_grant;
        end
    end

    always @(*) begin
        nxt_grant = 4'b0000;
        nxt_state = pr_state;

        if (prior == 1) begin
            if (req[0]) begin
                nxt_grant = 4'b0001;
                nxt_state = S0;  end 
            else if (req[1]) begin
                nxt_grant = 4'b0010;
                nxt_state = S1;  end
            else if (req[2]) begin
                nxt_grant = 4'b0100;
                nxt_state = S2;  end
            else if (req[3]) begin
                nxt_grant = 4'b1000;
                nxt_state = S3;  end
        end 
        else begin
            case (pr_state)
                Sidl: begin
                    if (req[0]) begin
                        nxt_grant = 4'b0001; nxt_state = S0;
                    end else if (req[1]) begin
                        nxt_grant = 4'b0010; nxt_state = S1;
                    end else if (req[2]) begin
                        nxt_grant = 4'b0100; nxt_state = S2;
                    end else if (req[3]) begin
                        nxt_grant = 4'b1000; nxt_state = S3;
                    end
                end

                S0: begin
                    if (req[1]) begin
                        nxt_grant = 4'b0010; nxt_state = S1;
                    end else if (req[2]) begin
                        nxt_grant = 4'b0100; nxt_state = S2;
                    end else if (req[3]) begin
                        nxt_grant = 4'b1000; nxt_state = S3;
                    end else if (req[0]) begin
                        nxt_grant = 4'b0001; nxt_state = S0;
                    end
                end

                S1: begin
                    if (req[2]) begin
                        nxt_grant = 4'b0100; nxt_state = S2;
                    end else if (req[3]) begin
                        nxt_grant = 4'b1000; nxt_state = S3;
                    end else if (req[0]) begin
                        nxt_grant = 4'b0001; nxt_state = S0;
                    end else if (req[1]) begin
                        nxt_grant = 4'b0010; nxt_state = S1;
                    end
                end

                S2: begin
                    if (req[3]) begin
                        nxt_grant = 4'b1000; nxt_state = S3;
                    end else if (req[0]) begin
                        nxt_grant = 4'b0001; nxt_state = S0;
                    end else if (req[1]) begin
                        nxt_grant = 4'b0010; nxt_state = S1;
                    end else if (req[2]) begin
                        nxt_grant = 4'b0100; nxt_state = S2;
                    end
                end

                S3: begin
                    if (req[0]) begin
                        nxt_grant = 4'b0001; nxt_state = S0;
                    end else if (req[1]) begin
                        nxt_grant = 4'b0010; nxt_state = S1;
                    end else if (req[2]) begin
                        nxt_grant = 4'b0100; nxt_state = S2;
                    end else if (req[3]) begin
                        nxt_grant = 4'b1000; nxt_state = S3;
                    end
                end
            endcase
        end
    end

endmodule
