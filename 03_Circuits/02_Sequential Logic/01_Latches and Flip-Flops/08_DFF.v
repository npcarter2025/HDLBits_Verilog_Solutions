module top_module (
    input clk,
    input d, 
    input ar,   // asynchronous reset
    output q);
    
    always @(posedge clk or posedge ar)
        if (ar)
            q <= 'b0;
    	else
            q <= d;

endmodule
