module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );
    
    wire[99:0] carry;
    
    fadd f0( .a(a[0]), .b(b[0]), .cin(cin), .cout(carry[0]), .sum(sum[0]) );
    
    genvar i;
    
    generate
        for (i = 1; i < 100; i ++ ) begin : fadder
            fadd f ( .a(a[i]), .b(b[i]), .cin(carry[i-1]), .cout(carry[i]), .sum(sum[i]) );
        end
    endgenerate

    assign cout = carry[99];
endmodule

module fadd (
    input a, b, cin,
    output cout, sum);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
    
endmodule



