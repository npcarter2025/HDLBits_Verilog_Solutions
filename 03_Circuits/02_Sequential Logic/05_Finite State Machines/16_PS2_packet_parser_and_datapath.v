module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done
); //

    // FSM from fsm_ps2
    parameter S0=0, S1=1, S2=2, S3=3;
    reg [2:0] state, next_state;
    
   	/* We just need to add a shift register
    * since we receive a byte on each clock cycle, 
    * and ALSO need to be able to capture data independently 
    * WHILE 
    * outputting data through "out_bytes" 
    */
    reg [23:0] store; // treat this as a shift register.


    // State transition logic (combinational)
    
    always @(*) begin
        case(state)
            S0: next_state = in[3] ? S1 : S0;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = in[3] ? S1 : S0;
            default: next_state = S0;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
            store <= {store[15:0], in}; 
            // It's easier to just concatenate it on each clk
        end
  
    end

    // Output logic
    assign done = (state == S3);
    assign out_bytes = store;

endmodule
