module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q
);
    always @(posedge clk)
        q <= (reset || q == 4'b1001) ? 0 : q + 1;

endmodule
