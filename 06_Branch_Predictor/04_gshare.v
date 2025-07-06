module top_module(
    input clk,
    input areset,

    input  predict_valid,
    input  [6:0] predict_pc,
    output reg predict_taken,
    output reg [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    parameter SNT=0, WNT=1, WT=2, ST=3;
    wire [6:0] predict_index, train_index;
    
    assign predict_index 	= predict_pc ^ predict_history;
    assign train_index		= train_history ^ train_pc;
    
    reg [1:0] PHT [0:127];
    
    always @ (*) begin
        case (PHT[predict_index])
            SNT: predict_taken = 0;
            WNT: predict_taken = 0;
            WT: predict_taken = 1;
            ST: predict_taken = 1;
        endcase
    end
    
    integer i;
    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 7'b0;
            for (i = 0; i < 128; i++)
                PHT[i] <= WNT;
            
        end else begin 
            
        	if (train_valid && train_mispredicted) begin
                predict_history <= {train_history[5:0], train_taken};
                
            end else if (predict_valid) begin
                predict_history <= {predict_history[5:0], predict_taken};    
            end
            
            if (train_valid) begin
                case (PHT[train_index])
                    SNT: PHT[train_index] <= train_taken ? WNT : SNT;
                    WNT: PHT[train_index] <= train_taken ? WT  : SNT;
                    WT : PHT[train_index] <= train_taken ? ST  : WNT;
                    ST : PHT[train_index] <= train_taken ? ST  : WT;
            	endcase
                
                /* // Or i could've just put:
                if (train_taken) begin
                    if (PHT[train_index] != ST)
                        PHT[train_index] <= PHT[train_index] + 1;
                    
            	end else begin
                    if (PHT[train_index] != SNT)
                    	PHT[train_index] <= PHT[train_index] - 1;
                    
                end
                */
            end  
        end
    end
         
endmodule
            
