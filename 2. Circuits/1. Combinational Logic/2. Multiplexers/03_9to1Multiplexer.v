module top_module( 
    input [15:0] a, b, c, d, e, f, g, h, i,
    input [3:0] sel,
    output [15:0] out 
	);
    
    always@(*)begin
        case(sel)
            4'h0 : out = a;
            4'h1 : out = b;
            4'h2 : out = c;
            4'h3 : out = d;
            4'h4 : out = e;
            4'h5 : out = f;
            4'h6 : out = g;
            4'h7 : out = h;
            4'h8 : out = i;
            default : out = 16'hFFFF;
        endcase
    end

endmodule
