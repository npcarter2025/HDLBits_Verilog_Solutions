module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    
    parameter IDLE=0, A=1, B=2;
    reg [2:0] state, next_state;

    /* starting at LSB, LSB stays the same, and the bits above are flipped
    * State A outputs 1, and state B outputs 0;
    */
    
    always @ (*) begin
        case(state)
            IDLE: next_state = x ? A : IDLE;
            A: next_state = x ? B : A;
            B: next_state = x ? B : A;
            default: next_state = IDLE;
        endcase
    end
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
        

    assign z = (state == A); 

endmodule
