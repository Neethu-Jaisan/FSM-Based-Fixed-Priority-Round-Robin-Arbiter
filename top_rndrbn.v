module top_rndrbn(
    input clk,
    input rst,
    input prior,
    input [3:0] req,
    output [3:0] grant
);

    wire slow_clk;

    clk_div divider (.clk(clk), .slow_clk(slow_clk));

    rndrbn arbiter (
        .clk(slow_clk),
        .rst(rst),
        .prior(prior),
        .req(req),
        .grant(grant)
    );

endmodule
