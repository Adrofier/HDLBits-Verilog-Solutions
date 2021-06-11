module rule (
    input [7:0] neigh,
    input current,
    output next );

    wire [2:0] pop;
    assign pop = {2'b00, neigh[0]} +
                 {2'b00, neigh[1]} +
                 {2'b00, neigh[2]} +
                 {2'b00, neigh[3]} +
                 {2'b00, neigh[4]} +
                 {2'b00, neigh[5]} +
                 {2'b00, neigh[6]} +
                 {2'b00, neigh[7]}; 
    
    reg tmp;
    assign next = tmp;

    always @(*) begin
        case (pop)
            2: tmp = current;
            3: tmp = 1;
            default: tmp = 0;
        endcase
    end
endmodule

module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
	
    wire [255:0] next;
    
    genvar x, y;
    generate
        for (x=0; x<=15; x=x+1) begin : gen_x
            for (y=0; y<=15; y=y+1) begin : gen_y
                rule fate (
                    .neigh({q[(x==0 ? 15 : x-1) + (y==0 ? 15 : y-1)*16],
                            q[(x==0 ? 15 : x-1) + y                *16],
                            q[(x==0 ? 15 : x-1) + (y==15 ? 0 : y+1)*16],
                            q[x                 + (y==0 ? 15 : y-1)*16],
                            q[x                 + (y==15 ? 0 : y+1)*16],
                            q[(x==15 ? 0 : x+1) + (y==0 ? 15 : y-1)*16],
                            q[(x==15 ? 0 : x+1) + y                *16],
                            q[(x==15 ? 0 : x+1) + (y==15 ? 0 : y+1)*16]}),
                    .current(q[(x + y*16)]),
                    .next(next[(x + y*16)])
                );
            end
        end
    endgenerate
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next;
        end
    end
endmodule
