module top_module (
    input a,
    input b,
    input c,
    input d,
    output q 
  );

    assign q = (a + b + c + d == 0 | a + b + c + d == 2 | a + b + c + d == 4); 
    
endmodule
