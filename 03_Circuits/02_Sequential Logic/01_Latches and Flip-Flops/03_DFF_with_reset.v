module top_module (
    input clk,
    input reset,            // Synchronous reset
    input [7:0] d,
    output [7:0] q
);
    reg [7:0] q_temp;
    assign q = q_temp;
    always @ (posedge clk) 
        if (reset)
            q_temp <= 8'b0;
    	else 
            q_temp <= d;

endmodule
