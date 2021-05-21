module top_module ( 
  input a,
  input b,
  output out 
  );
  
  mod_a inst(
    .out(out),
    .in1(a),
    .in2(b)
  );
  
endmodule
