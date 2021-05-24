module top_module( 
    input [254:0] in,
    output [7:0] out 
   );
  
  always @(*) begin
     out = 0;
     for(int i = 0; i < $bits(in); i++) begin
         if(in[i])
             out = out + 8'b1;
         else
             out = out + 8'b0;
     end
  end
    
endmodule
