// Implement one-hot state machine

module one_hot(
    input w,
    input clk,
    input rst,
    output z,
    output [4:0] L
);
    wire Anext, Bnext, Cnext, Dnext, Enext;
    wire Astate, Bstate, Cstate, Dstate, Estate;
    
    
    assign L[0] = Astate;
    assign L[1] = Bstate;
    assign L[2] = Cstate;
    assign L[3] = Dstate;
    assign L[4] = Estate;

    dff Adff(
        .Default(1'b1),
        .D(Anext),
        .clk(clk),
        .reset(rst),
        .Q(Astate)
    );

    dff Bdff(
        .Default(1'b0),
        .D(Bnext),
        .clk(clk),
        .reset(rst),
        .Q(Bstate)
    );

    dff Cdff(
        .Default(1'b0),
        .D(Cnext),
        .clk(clk),
        .reset(rst),
        .Q(Cstate)
    );
    
      dff Ddff(
        .Default(1'b0),
        .D(Dnext),
        .clk(clk),
        .reset(rst),
        .Q(Dstate)
    );
    
      dff Edff(
        .Default(1'b0),
        .D(Enext),
        .clk(clk),
        .reset(rst),
        .Q(Estate)
    );

    assign z = Cstate | Estate;

    assign Anext = 1'b0;
    assign Bnext = (~w & Astate) | (~w & Dstate) | (~w & Estate);
    assign Cnext = (~w & Bstate) | (~w & Cstate);
    assign Dnext = (w & Astate) | (w & Bstate) | (w & Cstate);
    assign Enext = (w & Dstate) | (w & Estate);
endmodule