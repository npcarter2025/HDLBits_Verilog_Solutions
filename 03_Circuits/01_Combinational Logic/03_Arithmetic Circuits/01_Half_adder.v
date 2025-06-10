module top_module( 
    input a, b,
    output cout, sum );
    
    assign cout = (a & b) ? 1 : 0;
    assign sum = a ^ b;

endmodule
