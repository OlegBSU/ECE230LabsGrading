// Implement binary state machine

module binary(
    input w,
    input clk,
    input rst,
    output z,
    output [2:0] LED
);

    wire [2:0] State; // Present state
    wire [2:0] Next; // Next state

assign LED = State;

    dff zero(
        .Default(1'b0),
        .D(Next[0]),
        .clk(clk),
        .reset(rst),
        .Q(State[0])
    );

    dff one(
        .Default(1'b0),
        .D(Next[1]),
        .clk(clk),
        .reset(rst),
        .Q(State[1])
    );

    dff two(
    .Default(1'b0),
        .D(Next[2]),
        .clk(clk),
        .reset(rst),
        .Q(State[2])
    );
    
    
    /// b2 = Next[2] b1=Next[1] b0 = Next[0]
    
assign z = (~State[2] & State[1] & ~State[0]) | (State[2] & ~State[1] & ~State[0]);

assign Next[0] = (~w & ~State[1] & ~State[0]) 
               | ( w & ~State[2] & ~State[1])
               | ( w & ~State[2] & ~State[0]) 
               | (~w & State[1] & State[0]);

assign Next[1] = ( w & ~State[2] & ~State[1]) 
               | (~State[1] & State[0]) 
               | ( State[1] & ~State[0]);

assign Next[2] = (w & State[2]) 
               | (w & State[1] & State[0]);

endmodule