module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging 
);
    parameter WL=0, WR=1, DIG_L=2, FALL_L=3, FALL_R=4, DIG_R=5;
    reg [2:0] state, next_state;
    
    always @(*) begin
        case(state)
            WL: next_state = (!ground) ? FALL_L :
                			dig ? DIG_L :
                			bump_left ? WR :
                			WL;
            
            WR: next_state = (!ground) ? FALL_R :
                			dig ? DIG_R :
                			bump_right ? WL :
                			WR;
            DIG_L: next_state = (!ground) ? FALL_L : DIG_L;
            DIG_R: next_state = (!ground) ? FALL_R : DIG_R;
            FALL_L: next_state = ground ? WL : FALL_L;
            FALL_R: next_state = ground ? WR : FALL_R;
            default: next_state = WL;
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
       state <= areset ? WL : next_state;     
    end
    
    assign walk_left = (state == WL);
    assign walk_right = (state == WR);
    assign aaah = (state == FALL_L || state == FALL_R);
    assign digging = (state == DIG_L || state == DIG_R);               
              
endmodule
