module timer(
    input clk,
    input rst,
    input en,
    input load,
    input [5:0] load_value,
    output [5:0] state
);

    wire [5:0] q;          // present state
    reg [5:0] d;          // value fed into DFFs
    wire [5:0] dec_next;   // pure countdown result

    // Pure 6-bit down-count logic
    assign dec_next[0] = ~q[0];
    assign dec_next[1] = q[1] ^ (~q[0]);
    assign dec_next[2] = q[2] ^ (~q[0] & ~q[1]);
    assign dec_next[3] = q[3] ^ (~q[0] & ~q[1] & ~q[2]);
    assign dec_next[4] = q[4] ^ (~q[0] & ~q[1] & ~q[2] & ~q[3]);
    assign dec_next[5] = q[5] ^ (~q[0] & ~q[1] & ~q[2] & ~q[3] & ~q[4]);

    // Priority:
    // 1) load
    // 2) if enabled, count down unless already 0
    // 3) otherwise hold
    always @(*) begin
        if (load)
            d = load_value;
        else if (en && (q != d'd0))
            d = dec_next;
        else
            d=q;
    end

    dff ff0(.d(d[0]), .clk(clk), .rst(rst), .q(q[0]));
    dff ff1(.d(d[1]), .clk(clk), .rst(rst), .q(q[1]));
    dff ff2(.d(d[2]), .clk(clk), .rst(rst), .q(q[2]));
    dff ff3(.d(d[3]), .clk(clk), .rst(rst), .q(q[3]));
    dff ff4(.d(d[4]), .clk(clk), .rst(rst), .q(q[4]));
    dff ff5(.d(d[5]), .clk(clk), .rst(rst), .q(q[5]));

    assign state = q;

endmodule