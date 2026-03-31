// D Flip Flop


module D_flip_flop(
    input D,
    input clk,
    output reg Q,
    output notQ
);

initial begin
    Q = 0;
end

always @(posedge clk) begin
    Q <= D;
end

assign notQ = ~Q;

endmodule


// JK Flip Flop

module JK_flip_flop(
    input J,
    input K,
    input clk,
    output reg Q,
    output notQ
);

initial begin 
    Q = 0;
end

wire D;

assign D = (~K & Q) | (J & ~Q);

always @(posedge clk) begin
    Q <= D;
end

assign notQ = ~Q;

endmodule

// T Flip Flop

module T_flip_flop(
    input T,
    input clk,
    output reg Q,
    output notQ
);

wire D;

initial begin
    Q = 0;
end

assign D = (T == 1'b0) ? Q : notQ;

always @(posedge clk) begin
    Q <= D;
end

assign notQ = ~Q;

endmodule

module top (
    input [3:0] sw,
    input btnC,
    output [5:0] led

);

D_flip_flop dff(
    .D(sw[0]),
    .clk(btnC),
    .Q(led[0]),
    .notQ(led[1])
);

JK_flip_flop jff(
    .J(sw[1]),
    .K(sw[2]),
    .clk(btnC),
    .Q(led[2]),
    .notQ(led[3])
);

T_flip_flop tff(
    .T(sw[3]),
    .clk(btnC),
    .Q(led[4]),
    .notQ(led[5])
);


endmodule