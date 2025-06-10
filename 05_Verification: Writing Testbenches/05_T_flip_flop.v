module top_module ();
    
    reg clk, reset, t, q;
    
    
    tff thing ( .clk(clk), .reset(reset), .t(t), .q(q) );
    
    initial begin
        clk = 1;
        forever #5 clk = ~clk;

    end
    
    initial begin
        $dumpvars;
        reset = 1;
        #5;
        reset = 0;
        t = 1;
      
    end
endmodule
