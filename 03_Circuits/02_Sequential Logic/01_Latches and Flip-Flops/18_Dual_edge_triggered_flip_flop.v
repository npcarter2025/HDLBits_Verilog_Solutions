module top_module (
    input clk,
    input d,
    output q
);
    reg temp_pos, temp_neg;
    always @(posedge clk) temp_pos <= d;
    always @(negedge clk) temp_neg <= d;
    assign q = clk ? temp_pos : temp_neg;

endmodule
