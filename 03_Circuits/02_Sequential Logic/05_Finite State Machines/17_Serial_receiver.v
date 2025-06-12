module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
	parameter IDLE=0, START=1, S2=2, S3=3, S4=4, S5=5, S6=6, S7=7, S8=8, STOP=9, DONE=4'd10, ERROR=4'd11;
    
    reg[3:0] state, next_state;
    /* Notes on extra end states:
    * IDLE: default state that is waiting to begin
    * START-S8 handle the actual bit receiving
    * STOP: if we receive Stop Bit, The Bytes are Correct. proceed to DONE State, or ERROR
    * DONE: Output Done Flag. Then if it is simultaneously receiving Start Bit, bypass to START State
    * ERROR: If we have not received in yet, wait until we do.
    */
    always@(*) begin
        case(state)
            IDLE: next_state = ~in ? START : IDLE;
            START: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S4;
            S4: next_state = S5;
            S5: next_state = S6;
            S6: next_state = S7;
            S7: next_state = S8;
            S8: next_state = STOP;
            STOP: next_state = in ? DONE : ERROR;
            DONE: next_state = in ? IDLE : START; // Done state
            ERROR: next_state = in ? IDLE : ERROR;
            default: next_state = IDLE;
        endcase
    end
    
    always @ (posedge clk)
        state <= reset ? IDLE : next_state;
    
    assign done = (state == DONE);

endmodule
