module top_module (
    input clk,
    input x,
    output z
);
    reg q1, q2, q3;
    initial begin
        z = 1;
    end

    always @(posedge clk)
        {q1, q2, q3, z} <= {x ^ q1, x & ~q2, x | ~q3, ~(x ^ q1 | x & ~q2 | x | ~q3)};

endmodule

  
