module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    
    parameter SNT=0, WNT=1, WT=2, ST=3;
    reg [1:0] current_state, next_state;
    
    always @ (*) begin
        case(current_state)
            SNT: 	next_state = train_valid ? (train_taken ? WNT : SNT) : SNT;
            WNT: 	next_state = train_valid ? (train_taken ? WT : SNT) : WNT;
            WT: 	next_state = train_valid ? (train_taken ? ST : WNT) : WT;
            ST: 	next_state = train_valid ? (train_taken ? ST : WT) : ST;
            default:next_state = WNT;
        endcase
    end
    
    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WNT;
        end else
            current_state <= next_state;
    end
    
    assign state = current_state;
            

endmodule
