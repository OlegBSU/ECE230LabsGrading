module top(
    input sw, // w
    output [9:0] led, // see IO table
    input btnC, // clk
    input btnU // reset
);

    // Hook up binary and one-hot state machines
    
    one_hot OH(
    .w(sw),
    .clk(btnC),
    .z(led[0]),
    .L(led[6:2]),
    .rst(btnU)
    );
    
    
    // Binary 
    
    binary B(
    .w(sw),
    .clk(btnC),
    .rst(btnU),
    .z(led[1]),
    .LED(led[9:7])
    );
    
endmodule