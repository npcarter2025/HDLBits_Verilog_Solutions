module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z 
);

    // I initially solved it in 2 states. This was possible because I implemented a shift reg, that held the values of 2 prev states
    // See the v2 file to see the 3 state version (no shift reg) 
    parameter A=1, B=2;
    reg [2:0] state, next_state;
    reg [1:0] shift_register;
    
    always @ (*) begin
        case (state)
            A: next_state = ~x ? B : A;
            B: next_state = x ? A : B;
            default : next_state = A;
        endcase
    end 
    
    always @ (posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= A;
        	shift_register <= 3'b0;
        end else begin
            shift_register <= {shift_register[0], x};
            state <= next_state;
        end
    end
    

    assign z = x && (shift_register == 2'd2);
endmodule
