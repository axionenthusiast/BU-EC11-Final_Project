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
    reg [15:0] counter; // this is the number we want to display
    // instantiate the clock divider to drive the 1 Hz signal
    // instantiate the faster clock divider to drive the 1 kHz signal
	// instantiate the FSM using the fsm_clock signal
    
    always @(posedge seconds_clock)
	begin
		// increment counter
	end
	
endmodule
