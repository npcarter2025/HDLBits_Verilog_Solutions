module top_module(
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
); //

    parameter A=0, B=1, C=2, D=3;

    // State transition logic: next_state = f(state, in)
    always @(*) begin
        case({state, in})
            3'b000: next_state = A;
            3'b001: next_state = B;
            3'b010: next_state = C;
            3'b011: next_state = B;
            3'b100: next_state = A;
            3'b101: next_state = D;
            3'b110: next_state = C;
            3'b111: next_state = B;
            default: next_state = A;
        endcase
        //out = (state == D);
    end

    // Output logic:  out = f(state) for a Moore state machine
    assign out = (state == D);
endmodule
