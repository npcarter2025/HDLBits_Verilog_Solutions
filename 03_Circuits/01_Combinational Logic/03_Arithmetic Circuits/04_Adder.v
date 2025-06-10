module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    
    wire [3:0] carry;
    
    fadd f0( .a(x[0]), .b(y[0]), .cin('b0), .cout(carry[0]), .sum(sum[0]) );
    fadd f1( .a(x[1]), .b(y[1]), .cin(carry[0]), .cout(carry[1]), .sum(sum[1]) );
    fadd f2( .a(x[2]), .b(y[2]), .cin(carry[1]), .cout(carry[2]), .sum(sum[2]) );
    fadd f3( .a(x[3]), .b(y[3]), .cin(carry[2]), .cout(sum[4]), .sum(sum[3]) );
   
                                                                   
                                                                  
                                                                  

endmodule

module fadd (
    input a, b, cin,
    output cout, sum);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
    
endmodule
