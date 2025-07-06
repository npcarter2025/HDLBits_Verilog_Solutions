module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out
);
    
    reg [3:0] shift;
    
    always @ (posedge clk) begin
        if (!resetn) begin
            shift <= 0;
        end else begin
            shift <= {shift[2:0], in};
        end
    end
    assign out = shift[3];
    
    

endmodule
