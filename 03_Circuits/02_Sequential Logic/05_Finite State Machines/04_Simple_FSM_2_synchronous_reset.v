module top_module(
    input clk,
    input reset,    // Synchronous reset to OFF
    input j,
    input k,
    output reg out
); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        // State transition logic
        case(state)
            OFF: begin
                next_state = j ? ON : OFF;
                out = 0;
            end
            ON: begin
                next_state = k ? OFF : ON;
                out = 1;
            end
            default: begin
                next_state = OFF;
            	out = 1;
            end
        endcase
    end

    always @(posedge clk) begin
        // State flip-flops with synchronous reset
        if (reset)
            state <= OFF;
        else 
            state <= next_state;
            
    end

    // Output logic
    // assign out = (state == ...); // I put it in the combinational always block instead

endmodule
