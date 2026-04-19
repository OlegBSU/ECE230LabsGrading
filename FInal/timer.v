//Timer: Mod-60 downcounter with synchronous load
module timer(
    input clk,
    input rst,
    input en,               //Enables or Disables clock
    input load,             //If load=1, load the counter with "load_value"
    input [5:0] load_value, //Value to load into counter register. Counter will then start counting from this value
    output [5:0] state     //6-bits to represent the highest number 59
);

    wire[5:0] q; // Present state of a FF
    wire[5:0] d; // Next state of FF
    wire[5:0] mux_load // Next state is loading
    wire[5:0] mux_count; // Next state is counting

    // Combinatorial logic responsible for adding via bit toggling
    wire[5:0] summer;

    assign summer[0] = en & ~q[0]; 
    assign summer[1] = ~q[1] & summer[0];
    assign summer[2] = ~q[2] & summer[1];
    assign summer[3] = ~q[3] & summer[2];
    assign summer[4] = ~q[4] & summer[3];

    // Behavioral mux

    assign mux_count[0] = en ^ q[0];
    assign mux_count[1] = summer[0] ^ q[1];
    assign mux_count[2] = summer[1] ^ q[2];
    assign mux_count[3] = summer[2] ^ q[3];
    assign mux_count[4] = summer[3] ^ q[4];
    assign mux_count[5] = summer[4] ^ q[5];
   




endmodule