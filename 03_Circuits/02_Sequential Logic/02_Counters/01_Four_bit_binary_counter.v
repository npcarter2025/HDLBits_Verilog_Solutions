module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q
);
    always @(posedge clk) 
        q <= (reset) ? 0 : q + 1;
endmodule
