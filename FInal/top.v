module top 
(
    input clk,           // 100 MHz
    input btnC,          // reset
    input [15:0] sw,     // switches
    output [15:0] led,    //LEDs
    output [3:0] an,     //Outputs for 7-segment display
    output [6:0] seg     //Outputs for 7-segment display
);


/******** DO NOT MODIFY ********/
wire clk_1Hz;       //Generate Internal 1Hz Clock
wire btnC_1Hz;     //Stretch load signal

//If running simulation, output clock frequency is 100MHz, else 1Hz
`ifndef SYNTHESIS
    assign clk_1Hz = clk;
`else
    clk_div #(.INPUT_FREQ(100_000_000), .OUTPUT_FREQ(1)) clk_div_1Hz 
    (.iclk(clk) , .rst(btnC) , .oclk(clk_1Hz));
`endif

// Check stopwatch/timer frequency
initial begin
`ifndef SYNTHESIS
    $display("Stopwatch/Timer Frequency set to 100MHz");
`else
    $display("Stopwatch/Timer Frequency set to 1Hz");
`endif
end

//Seven Segment Display Interface
seven_segment_inf seven_segment_inf_inst (.clk(clk), .rst(btnC), .count(count) , .anode(an), .segs(seg));
/********************************/

/******** UPDATE THIS SECTION ********/
/******* INITIALIZE STOPWATCH AND TIMER MODULE ***********/
// Control signals
wire mode   = sw[0];        // 0 = stopwatch, 1= timer
wire run    = sw[1];        // 0 = pause (circuit holds it state), 1 = run (counter increments/decrements)
wire load   = sw[2];        // 1 = load value from load_value into timer counter, 0 = do nothing
wire [5:0] load_value = sw[15:10];      //Set Timer Value (Value to load in timer)

//Stopwatch Module Instance
//Use "clk_1Hz" as clock signal to stopwatch and timer modules


wire [5:0] stopwatch_cnt; // stopwatch 6-bit bus output
wire[5:0] tmr_cnt; // timer 6-bit buss output


wire[5:0] count; // Output to 7-seg dspl interface
assign count = mode? tmr_cnt : stopwatch_cnt; // Mux using ternary operator


// LED outputs
assign led[8:3]   = stopwatch_cnt;
assign led[15:10] = tmr_cnt;


// Stopwatch Instance
wire stopwatch_en = ~mode & run;
stopwatch stpw(
    .clk(clk_1Hz),
    .rst(btnC),
    .en(stopwatch_en),
    .state(stopwatch_cnt)
);



//Timer Module Instance
//Use "clk_1Hz" as clock signal to stopwatch and timer modules

wire timer_en = mode & run;

timer tmr(
    .clk(clk_1Hz),
    .rst(btnC),
    .en(timer_en),
    .load[load],
    .load_value(load_value),
    .state(tmr_cnt)
);


// Unused LEDs
assign led[9]   = 1'b0;
assign led[2:0] = 3'b000;



endmodule