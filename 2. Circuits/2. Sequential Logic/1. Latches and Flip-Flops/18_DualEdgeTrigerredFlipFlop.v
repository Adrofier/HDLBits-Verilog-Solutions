module top_module (
    input clk,
    input d,
    output q
  );
    
  reg [1:0] r;
    
  always @(posedge clk) begin
      r[0] <= d;
  end
    
  always @(negedge clk) begin
      r[1] <= d; 
  end
    
  assign q = (clk) ? r[0] : r[1];
    
endmodule
