module top_module();
    reg clk;
    reg in;
    reg [2:0] s;
	wire out;

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        in = 0;
        s = 3'd2;
        
        #10 s = 3'd6;
        #10 in = 1;
        s = 3'd2;
        #10 in = 0;
        s = 3'd7;
        #10 in = 1;
        s = 3'd0;
        #30 in = 0;
    end
    q7 thing ( .clk(clk), .in(in), .s(s), .out(out) );
    
        
endmodule
