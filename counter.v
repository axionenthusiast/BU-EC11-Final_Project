`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2023 09:05:20 AM
// Design Name: 
// Module Name: counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module counter(
        input clock, // 100 MHz clock from the board
        output [6:0] cathode,
        output [7:0] anode
    );

    wire seconds_clock; // 1 Hz
    wire fsm_clock;     // 1 kHz
    reg [15:0] counter = 0; // number we want to display

    // instantiate the clock divider (1 Hz)
    clock_divider cd (
        .in_clk(clock),
        .out_clk(seconds_clock)
    );

    // instantiate the faster clock divider (1 kHz)
    faster_clock_divider fcd (
        .in_clk(clock),
        .out_clk(fsm_clock)
    );

    // instantiate the FSM (driven by 1 kHz clock)
    fsm display_fsm (
        .clock(fsm_clock),
        .sixteen_bit_number(counter),
        .cathode(cathode),
        .anode(anode)
    );

    // increment counter every second
    always @(posedge seconds_clock)
    begin
        counter <= counter + 1;
    end

endmodule
