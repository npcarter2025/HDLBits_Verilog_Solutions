module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    
    reg [31:0] in_old;
    always @ (posedge clk) begin
        in_old <= in;
        if (reset)
            out <= 32'b0;
        else begin
            
            out <= out | (~in & in_old) ;
        end
    end
           
endmodule
