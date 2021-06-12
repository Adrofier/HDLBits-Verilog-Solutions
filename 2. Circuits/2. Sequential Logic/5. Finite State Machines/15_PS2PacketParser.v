module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done
  );

    localparam [1:0] BYTE1 = 2'b00,
    				 BYTE2 = 2'b01,
    				 BYTE3 = 2'b10,
    				 DONE  = 2'b11;

    reg [1:0] state, next;

    // State transition logic (combinational)
    always @(*) begin
    	case(state)
    		BYTE1 : next = (in[3]) ? BYTE2 : BYTE1;
    		BYTE2 : next = BYTE3;
    		BYTE3 : next = DONE;
    		DONE  : next = (in[3]) ? BYTE2 : BYTE1;
    	endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
    	if(reset) state <= BYTE1;
    	else state <= next;
    end
 
    // Output logic
    assign done = (state == DONE);

endmodule
