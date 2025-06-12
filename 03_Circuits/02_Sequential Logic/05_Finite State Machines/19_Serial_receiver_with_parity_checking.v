module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    parameter IDLE=0, 
    		START=1, 
    		S2=2, 
    		S3=3, 
    		S4=4, 
    		S5=5, 
    		S6=6, 
    		S7=7, 
    		S8=8,
    		PARITY=4'd9,
    		STOP=4'd10, 
    		DONE=4'd11, 
    		ERROR=4'd12;  
    
    reg[7:0] shift_register; // Need to shift right; LSB is fed in first
   
    reg[3:0] state, next_state;
    reg parity_reset;
    reg parity_reg;
    wire odd;
    
    parity p ( 
        .clk(clk),
        .reset(parity_reset | reset),
        .in(in),
        .odd(odd) // output
    );

    // NEXT STATE TRANSITION LOGIC
    always@(*) begin
        case(state)
            IDLE	: next_state = ~in ? START : IDLE;
            START	: next_state = S2;
            S2		: next_state = S3;
            S3		: next_state = S4;
            S4		: next_state = S5;
            S5		: next_state = S6;
            S6		: next_state = S7;
            S7		: next_state = S8;
            S8		: next_state = PARITY;
            PARITY	: next_state = STOP; // added this state for extra bit input
            STOP	: next_state = in ? DONE : ERROR;
            DONE	: next_state = in ? IDLE : START; 
            ERROR	: next_state = in ? IDLE : ERROR; 
            default	: next_state = IDLE;
        endcase
    end
    
    always @ (posedge clk) 
        state <= (reset) ? IDLE : next_state;
    
        // shift register
    always @ (posedge clk) begin
        if (state < PARITY && state >= START)
            shift_register <= {in, shift_register[7:1]};
    end


    always @ (posedge clk)
        parity_reg <= (reset) ? 0 : odd;
   
    // parity_reset logic
    // Both this block and the one below are interchange-able.
    // I just like being able to make all of the case statements
    // based off of the same state
    /*
    always @(posedge clk) begin
        case(next_state)
			IDLE : parity_reset <= 1;	
			DONE : parity_reset <= 1;
			default : parity_reset <= 0;
		endcase
    end
    */
    
    // parity_reset logic
    always @(*) begin
        case(state)
			STOP : parity_reset = 1;	
			DONE : parity_reset = 1;
			ERROR: parity_reset = 1;
            IDLE : parity_reset = 1;
            default : parity_reset = 0;
		endcase
    end


    assign done = ((state == DONE) && parity_reg);
    assign out_byte = shift_register;

endmodule


