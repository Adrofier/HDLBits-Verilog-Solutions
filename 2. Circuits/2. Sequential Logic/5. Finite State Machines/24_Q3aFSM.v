module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
parameter A = 0, B = 1;

 reg state, next;
    reg [1:0] count;
    reg [1:0] count1;

    always @(*) begin
  		case(state)
   			A : next = (s) ? B : A;
   			B : next = B;
  endcase
 end

 always @(posedge clk) begin
  if (reset) begin
   state <= A;
            count=0;
            count1=0;
  end
  else begin 
      state <= next;
        
        if(state==B)
            begin
                if(count1==3)begin
                    count=0;
                    count1=0;
                end
                if(w==1) count=count+1;
                
                    count1=count1+1;
                
             end
    end
 end    

 

    assign z = ((count == 2) & (count1 == 3) );
endmodule
