`timescale 1ps / 1ps 
module top_module ();
    reg clk;
    initial clk = 0;
    always begin
        #5 clk = ~clk;
    end
    
    dut u_dut(
        .clk(clk)
    );

endmodule
