module top_module (
    input clk,
    input d, 
    input r,
    output q
	);
    always@(posedge clk)begin
        if(r)
            q <= 0;
        else
            q <= d;
    end
endmodule
