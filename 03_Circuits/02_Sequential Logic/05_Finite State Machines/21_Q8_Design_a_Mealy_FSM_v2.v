module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z 
);
    parameter IDLE=0, A=1, B=2;
    reg [2:0] state, next_state;
    
    always @ (*) begin
        case (state)
            IDLE: next_state = x ? A : IDLE;
            A: next_state = ~x ? B : A;
            B: next_state = x ? A : IDLE;
            default : next_state = IDLE;
        endcase
    end
    
    always @ (posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        case (state)
            B: z = x;
            default: z = 0;
        endcase
    end
endmodule
