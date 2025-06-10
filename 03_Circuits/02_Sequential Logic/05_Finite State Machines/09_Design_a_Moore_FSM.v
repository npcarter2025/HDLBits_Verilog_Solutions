module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output reg dfr
);

    parameter A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3;
    reg [2:0] state, next_state;
    reg [2:0] prev_state_at_dfr; // remembers when dfr was set

    // 1. Next state logic from sensors
    always @(*) begin
        case (s)
            3'b111: next_state = A;
            3'b011: next_state = B;
            3'b001: next_state = C;
            3'b000: next_state = D;
            default: next_state = state;
        endcase
    end

    // 2. State and dfr update logic
    always @(posedge clk) begin
        if (reset) begin
            state <= D;
            dfr <= 1;
            prev_state_at_dfr <= D;
        end else begin
            state <= next_state;

            if (next_state > state) begin
                // Water level fell → assert dfr and remember this state
                dfr <= 1;
                prev_state_at_dfr <= next_state;
            end else if (next_state < prev_state_at_dfr) begin
                // Water has risen back up → clear dfr
                dfr <= 0;
            end
            // else: dfr stays whatever it was (sticky)
        end
    end

    // 3. Moore-style output logic
    assign fr3 = (state == D);
    assign fr2 = (state == C) || (state == D);
    assign fr1 = (state == B) || (state == C) || (state == D);

endmodule
