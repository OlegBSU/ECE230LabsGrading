// D Flip Flop
module D_flip_flop(
    input RST,
    input D,
    input clk,
    output reg Q,
    output notQ
);

always @(posedge clk or posedge RST) begin
    if (RST)
        Q <= 1'b0;
    else
        Q <= D;
end

assign notQ = ~Q;

endmodule


// Full Adder
module full_adder (
    input A, B, Cin,
    output Y, Cout
);

assign Y    = A ^ B ^ Cin;
assign Cout = (A & B) | (A & Cin) | (B & Cin);

endmodule


// T Flip Flop
module T_flip_flop(
    input RST,
    input T,
    input clk,
    output reg Q,
    output notQ
);

wire D;
assign D = T ^ Q;   // hold when T=0, toggle when T=1

always @(posedge clk or posedge RST) begin
    if (RST)
        Q <= 1'b0;
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

//
// Ripple counter using T flip-flops
//
wire [2:0] w;

T_flip_flop f1(
    .RST(btnU),
    .T(1'b1),
    .clk(btnC),
    .Q(w[0]),
    .notQ()
);

T_flip_flop f2(
    .RST(btnU),
    .T(1'b1),
    .clk(w[0]),
    .Q(w[1]),
    .notQ()
);

T_flip_flop f3(
    .RST(btnU),
    .T(1'b1),
    .clk(w[1]),
    .Q(w[2]),
    .notQ()
);

assign led[2:0] = w[2:0];


//
// Modulo-6 counter
//
wire [2:0] SUMW;   // adder output = Q + 1
wire [2:0] DW;     // actual D inputs to the counter FFs
wire [2:0] QW;     // current counter state
wire [1:0] CW;     // carry wires

// Detect count = 5 (binary 101)
// On next clock: reset count to 000 and toggle led[6]
wire HIT5;
assign HIT5 = QW[2] & ~QW[1] & QW[0];

// 3-bit incrementer: QW + 1
full_adder FA0(
    .A(QW[0]),
    .B(1'b1),
    .Cin(1'b0),
    .Y(SUMW[0]),
    .Cout(CW[0])
);

full_adder FA1(
    .A(QW[1]),
    .B(1'b0),
    .Cin(CW[0]),
    .Y(SUMW[1]),
    .Cout(CW[1])
);

full_adder FA2(
    .A(QW[2]),
    .B(1'b0),
    .Cin(CW[1]),
    .Y(SUMW[2]),
    .Cout()
);

// If state is 5, next state becomes 000.
// Otherwise next state is Q + 1.
// stuff below cab be used too but DW has to be reg istead of wire
//always @(*) begin
//    if (HIT5)
//        DW = 3'b000;
//    else
//        DW = SUMW;
//end

assign DW = HIT5 ? 3'b000 : SUMW;

D_flip_flop D0(
    .RST(btnU),
    .D(DW[0]),
    .clk(btnC),
    .Q(QW[0]),
    .notQ()
);

D_flip_flop D1(
    .RST(btnU),
    .D(DW[1]),
    .clk(btnC),
    .Q(QW[1]),
    .notQ()
);

D_flip_flop D2(
    .RST(btnU),
    .D(DW[2]),
    .clk(btnC),
    .Q(QW[2]),
    .notQ()
);

assign led[5:3] = QW[2:0];


//
// Modulo counter output on led[6]
// Toggle when count reaches 5
//
wire OUTQ;
wire OUTD;

assign OUTD = HIT5 ? ~OUTQ : OUTQ;

D_flip_flop OUT(
    .RST(btnU),
    .D(OUTD),
    .clk(btnC),
    .Q(OUTQ),
    .notQ()
);

assign led[6] = OUTQ;

endmodule
