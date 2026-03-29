// Part 1 D-Latch module blueprint

module d_latch(
input D, E,
output reg Q,
output NotQ
);

always @(*) begin
    if (E)
        Q <= D;
    end

    assign NotQ = ~Q;

endmodule

// Part 2 Helper modules

// 8-bit wide D-Latch

module d_latch_8bit(
    input [7:0] D,
    input E,
    output reg [7:0] Q,
    output [7:0] NotQ
);

always @(*) begin
    if (E)
        Q <= D;
    end

    assign NotQ = ~Q;

endmodule


// 8bit  1x4 write-select Demux

module demux1_4_8bit(
input [7:0] In,
input [1:0] Sel,
output [7:0] Y0,
output [7:0] Y1,
output [7:0] Y2,
output [7:0] Y3
);

assign Y0 = (Sel == 2'b00) ? In : 8'b00000000;
assign Y1 = (Sel == 2'b01) ? In : 8'b00000000;
assign Y2 = (Sel == 2'b10) ? In : 8'b00000000;
assign Y3 = (Sel == 2'b11) ? In : 8'b00000000;

endmodule


// 8bit 4x1 read-select Mux

module mux1_4_8bit(
input [7:0] A,
input [7:0] B,
input [7:0] C,
input [7:0] D,
input [1:0] Sel,
output [7:0] Y
);

assign Y = (Sel == 2'b00) ? A :
           (Sel == 2'b01) ? B :
           (Sel == 2'b10) ? C :
           D;

endmodule


// 1bit 1x4 enable demux

module demux1_4_1bit(
input In,
input [1:0] Sel,
output Y0,
output Y1,
output Y2,
output Y3
);

assign Y0 = (Sel == 2'b00) ? In : 1'b0;
assign Y1 = (Sel == 2'b01) ? In : 1'b0;
assign Y2 = (Sel == 2'b10) ? In : 1'b0;
assign Y3 = (Sel == 2'b11) ? In : 1'b0;

endmodule

// memory system

module memory_system(
input [7:0] data, // switches
input store, // btnC
input [1:0] addr, // sw[7:6]
output [7:0] memory // led's
);

// internal wires
wire [7:0] d0, d1, d2, d3; // data wires to the latches
wire e0, e1, e2, e3; // enable wires from 1/4 demux to the latches
wire [7:0] o1, o2, o3, o4; // output wires from latches to the read mux

// Data demultiplexer 

demux1_4_8bit data_router(
  .In(data), .Sel(addr),
  .Y0(d0),  .Y1(d1),  .Y2(d2),  .Y3(d3)
);

// Enable demultiplexer

demux1_4_1bit enable_router(
    .In(store),
    .Sel(addr),
    .Y0(e0),
    .Y1(e1),
    .Y2(e2),
    .Y3(e3)
);

//  4 8-bit wide D-latch blocks

d_latch_8bit byte0(
.D(d0), .E(e0), .Q(o1)
);

d_latch_8bit byte1(
.D(d1), .E(e1), .Q(o2)
);

d_latch_8bit byte2(
.D(d2), .E(e2), .Q(o3)
);

d_latch_8bit byte3(
.D(d3), .E(e3), .Q(o4)
);

// 8bit 4x1 read mux

 mux1_4_8bit read_selector(
 .A(o1),
 .B(o2),
 .C(o3),
 .D(o4),
 .Sel(addr),
 .Y(memory)
 );

endmodule


// Implement top level module

module top (
    input [15:0] sw,
    input btnC,
    output [15:0] led
    );
    
    // part 1
    
    d_latch part1(
    .D(sw[0]),
    .E(btnC),
    .Q(led[0]),
    .NotQ(led[1])
    );
    
    // part 2
 
    memory_system part2(
    .data(sw[15:8]), 
    .store(btnC),
    .addr(sw[7:6]),
    .memory(led[15:8]) 
    );

//
endmodule

