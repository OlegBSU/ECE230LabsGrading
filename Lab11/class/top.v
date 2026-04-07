// D Flip Flop
module D_flip_flop(
    input RST,
    input D,
    input clk,
    output reg Q,
    output notQ
);

initial begin
    Q = 1'b0;
end

always @(posedge clk or posedge RST) begin
    if (RST)
        Q <= 1'b0;
    else
        Q <= D;
end

assign notQ = ~Q;

endmodule


// Full Adder
module full_adder(
    input A,
    input B,
    input Cin,
    output Y,
    output Cout
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

initial begin
    Q = 1'b0;
end

assign D = (T == 1'b0) ? Q : ~Q;

always @(posedge clk or posedge RST) begin
    if (RST)
        Q <= 1'b0;
    else
        Q <= D;
end

assign notQ = ~Q;

endmodule


module top(
    input btnU,
    input btnC,
    output [6:0] led
);


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


wire [2:0] DW;        
wire [2:0] QW;      
wire [1:0] CW;      
wire [2:0] NEXT;    
wire MOD_HIT;        
wire MC_D;            
wire MC_Q;          

// Add 1 to current counter value
full_adder FA0(
    .A(QW[0]),
    .B(1'b1),
    .Cin(1'b0),
    .Y(DW[0]),
    .Cout(CW[0])
);

full_adder FA1(
    .A(QW[1]),
    .B(1'b0),
    .Cin(CW[0]),
    .Y(DW[1]),
    .Cout(CW[1])
);

full_adder FA2(
    .A(QW[2]),
    .B(1'b0),
    .Cin(CW[1]),
    .Y(DW[2]),
    .Cout()
);

assign MOD_HIT = QW[2] & QW[1] & ~QW[0];

assign NEXT = MOD_HIT ? 3'b000 : DW;

// State flip-flops
D_flip_flop D0(
    .RST(btnU),
    .D(NEXT[0]),
    .clk(btnC),
    .Q(QW[0]),
    .notQ()
);

D_flip_flop D1(
    .RST(btnU),
    .D(NEXT[1]),
    .clk(btnC),
    .Q(QW[1]),
    .notQ()
);

D_flip_flop D2(
    .RST(btnU),
    .D(NEXT[2]),
    .clk(btnC),
    .Q(QW[2]),
    .notQ()
);


assign MC_D = MOD_HIT ? ~MC_Q : MC_Q;

D_flip_flop OUT(
    .RST(btnU),
    .D(MC_D),
    .clk(btnC),
    .Q(MC_Q),
    .notQ()
);

assign led[5:3] = QW[2:0];
assign led[6]   = MC_Q;

endmodule
