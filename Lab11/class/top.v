// D Flip Flop
module D_flip_flop(
    input RST,
    input D,
    input clk,
    output reg Q,
    output notQ
);

initial begin
    Q = 0;
end

always @(posedge clk or posedge RST) begin
    if(RST)
        Q<=1'b0;
    else
        Q <= D;
end

assign notQ = ~Q;

endmodule


// Implement module called full_adder
module full_adder (
    input A, B, Cin,
    output Y, Cout
);

assign Y = Cin ^ A ^ B;

assign Cout = (A & Cin) | (A & B) | (B & Cin);

endmodule

// T-flip-flop

module T_flip_flop(
    input RST,
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

always @(posedge clk or posedge RST) begin //TODO: Add reset
     if(RST)
        Q<=1'b0;
    else
     Q <= D;
end

assign notQ = ~Q;

endmodule

module top (
input btnU,
input btnC,
output [6:0] led
);

// Ripple counter using T-flip flops

wire [2:0] w;

T_flip_flop f1(
    .RST(btnUW),
    .T(1'b1),
    .clk(btnC),
    .Q(w[0]),
    .notQ()
);

T_flip_flop f2(
    .RST(btnUW),
    .T(1'b1),
    .clk(w[0]),
    .Q(w[1]),
    .notQ()
);

T_flip_flop f3(
    .RST(btnUW),
    .T(1'b1),
    .clk(w[1]),
    .Q(w[2]),
    .notQ()
);

assign led[2:0] = w[2:0];


// Simple Modulo Counter
 wire [2:0] DW;
 wire [2:0] QW;
 wire [1:0] CW;
 
// Stage 0
D_flip_flop D0(
    .D(DW[0]),
    .clk(btnC),
    .Q(QW[0]),
    .notQ(),
    .RST(RSTW)
);

full_adder FA0(
    .A(QW[0]),
    .B(1'b1),
    .Cout(CW[0]),
    .Cin(1'b0),
    .Y(DW[0])
);

// Stage 1

D_flip_flop D1(
    .D(DW[1]),
    .clk(btnC),
    .Q(QW[1]),
    .notQ(),
    .RST(RSTW)
);

full_adder FA1(
    .A(QW[1]),
    .B(1'b0),
    .Cout(CW[1]),
    .Cin(CW[0]),
    .Y(DW[1])
);

// Stage 2

D_flip_flop D2(
    .D(DW[2]),
    .clk(btnC),
    .Q(QW[2]),
    .notQ(),
    .RST(RSTW)
);

full_adder FA2(
    .A(QW[2]),
    .B(1'b0),
    .Cout(),
    .Cin(CW[1]),
    .Y(DW[2])
);

assign led[5:3] = QW[2:0];

// Comparator

wire OU;
wire btnUW;
assign  btnUW = btnU;
assign OU = ~QW[0] & QW[1] & QW[2];


// Condition for a reset
wire RSTW;
assign RSTW = (~QW[0] & QW[1] & QW[2]) | btnUW;


// Otput to LED

D_flip_flop OUT(
    .D(DW[OU]),
    .clk(btnC),
    .Q(led[6]),
    .notQ()
);

endmodule





