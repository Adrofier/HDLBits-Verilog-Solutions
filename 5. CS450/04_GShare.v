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
    
    localparam SNT = 2'd0, WNT = 2'd1, WT = 2'd2, ST = 2'd3;
    
    reg [1:0] PHT [0:127];
    reg [6:0] GHR;
    
    wire [6:0] predict_index = predict_pc ^ GHR;
    
    always @(*) begin
        if(predict_valid) begin
            predict_taken = (PHT[predict_index] >= WT);
            predict_history = GHR;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'd0;
        end
    end
    
    wire [6:0] train_index = train_pc ^ train_history;
    
    integer i;
    always @(posedge clk or posedge areset) begin
        if(areset) begin
            GHR <= 7'd0;
            for(i = 0; i < 128; i = i+1)
                PHT[i] <= WNT;
        end
        else begin
            if(train_valid) begin
                case(PHT[train_index])
                    SNT: PHT[train_index] <= train_taken ? WNT : SNT;
                    WNT: PHT[train_index] <= train_taken ? WT : SNT;
                    WT:  PHT[train_index] <= train_taken ? ST : WNT;
                    ST:  PHT[train_index] <= train_taken ? ST : WT;
                endcase
            end
            if (train_valid && train_mispredicted) begin
                GHR <= {train_history[5:0], train_taken};
            end else if (!(train_valid && train_mispredicted) && predict_valid) begin
                GHR <= {GHR[5:0], predict_taken};
            end
        end
    end

endmodule
