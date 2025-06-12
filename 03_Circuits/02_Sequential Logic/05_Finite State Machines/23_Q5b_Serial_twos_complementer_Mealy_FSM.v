module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter A=0, B=1;
    reg state, next_state;
    
    always @ (*) begin
        case(state)
            A: next_state = x ? B : A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end
    always @(posedge clk or posedge areset)
        state <= (areset) ? A : next_state;
    
    always @(*) begin
        case(state)
            A: z = x;
            B: z = ~x;
        endcase
    end
endmodule
