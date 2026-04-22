`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2026 05:46:45 PM
// Design Name: 
// Module Name: game_timer
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


module game_timer(

    input clock,
    input rst,
    output [6:0] cathode,
    output [7:0] anode,
    output reg game_over
    );
    
    wire seconds_clock; // 1 Hz
    wire fsm_clock;     // 1 kHz
    reg [6:0] counter = 7'd90;
    wire [11:0] bcd;
    
        
    clock_divider cd (
        .in_clk(clock),
        .out_clk(seconds_clock)
    );
    
    
    faster_clock_divider fcd (
        .in_clk(clock),
        .out_clk(fsm_clock)
    );
    
    binary_to_BCD_converter timer_bcd (
        .bin(counter),
        .bcd(bcd)
    );
    
    fsm timer_fsm (
        .clock(fsm_clock),
        .sixteen_bit_number({4'd0, bcd}),
        .cathode(cathode),
        .anode(anode)
    );
    
    
    always @(posedge seconds_clock or posedge rst) begin
    if (rst) begin
        counter <= 7'd90;
        game_over <= 1'b0;
        end
    else if (!game_over) begin
        if (counter == 7'd0)
            game_over <= 1'b1;
        else
            counter <= counter - 7'd1;    
        end    
    end
    
endmodule
