//StopWatch: Modulo-60 Counter
module stopwatch(
    input clk,
    input rst,
    input en,
    output [5:0] state     //6-bits to represent the highest number 59
);


wire [5:0] q; // Current state of DFF
wire [5:0] d; // Next state of dff
wire [5:0] count_next;

// Verilog is smart enough to wire decimal as a binary to q bus
assign count_next = ( q == 6'd59) ? 6'd0 : (q + 6'd1);

assign d = en? count_next : q;

dff ff0(.d(d[0]), .clk(clk), .rst(rst), .q(q[0]));
dff ff1(.d(d[1]), .clk(clk), .rst(rst), .q(q[1]));
dff ff2(.d(d[2]), .clk(clk), .rst(rst), .q(q[2]));
dff ff3(.d(d[3]), .clk(clk), .rst(rst), .q(q[3]));
dff ff4(.d(d[4]), .clk(clk), .rst(rst), .q(q[4]));
dff ff5(.d(d[5]), .clk(clk), .rst(rst), .q(q[5]));

// Assigning bus of wires [5:0] q to the output of ff. Current state is 
// A binary combination of current states of all 6 ff.
assign state = q;
    
   
endmodule




