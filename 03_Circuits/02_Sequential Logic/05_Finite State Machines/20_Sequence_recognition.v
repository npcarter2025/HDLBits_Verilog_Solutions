module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err
);
    parameter IDLE=0, S1=1, S2=2, S3=3, S4=4, S5=5, S6=6, DISC=7, FLAG=8, ERR=9;
    reg [3:0] state, next_state;
    
    always @(*) begin
        case(state)
            IDLE: next_state = in ? S1 : IDLE;
            S1: next_state = in ? S2 : IDLE;
            S2: next_state = in ? S3 : IDLE;
            S3: next_state = in ? S4 : IDLE;
            S4: next_state = in ? S5 : IDLE;
 			S5: next_state = in ? S6 : DISC;
            S6: next_state = in ? ERR : FLAG;
            DISC: next_state = in ? S1 : IDLE;
            FLAG: next_state = in ? S1 : IDLE;
            ERR: next_state = in ? ERR : IDLE;
            default: next_state = IDLE;
        endcase
    end
    
    always @ (posedge clk)
        state <= (reset) ? IDLE : next_state;
    
    assign disc = (state == DISC);
    assign flag = (state == FLAG);
    assign err = (state == ERR);

endmodule
