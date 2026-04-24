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
    output reg game_over,
    output [11:0] bcd
    );
    
    wire seconds_clock; // 1 Hz
    reg [6:0] counter = 7'd90;    
        
    clock_divider cd (
        .in_clk(clock),
        .out_clk(seconds_clock)
    );
    
    binary_to_BCD_converter timer_bcd (
        .bin(counter),
        .bcd(bcd)
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
