module top_module();
	

    reg [1:0] test;
    
    wire result;
    
    andgate a1 ( .in(test), .out(result) );

    
    
	initial begin

        test = 2'b00;
        #10 test = 2'b01;
        #10 test = 2'b10;
        #10 test = 2'b11;
    end
    
endmodule
