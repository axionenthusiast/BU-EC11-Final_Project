`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2026 08:12:40 PM
// Design Name: 
// Module Name: spawner
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


module spawner(
    input clock, rst, game_over,
    input [15:0] rng,
    output reg [15:0] spawn
    );
    
    localparam [27:0] MIN_PERIOD = 28'd99_999_999;
    reg [27:0] tick_counter = 0;
    reg [27:0] current_period = 0;
    
    always @(posedge clock or posedge rst) begin
        if (rst) begin
            tick_counter <= 28'd0;
            spawn <= 16'b0;
            current_period <= MIN_PERIOD;
        end else begin
            spawn <= 16'b0;
            if (game_over) begin
                tick_counter <= 28'd0;
            end else if (tick_counter == current_period) begin
                tick_counter <= 28'd0;
                spawn <= 16'b1 << rng[3:0];
                current_period <= MIN_PERIOD + {rng[7:4], 23'b0};
            end else begin
                tick_counter <= tick_counter + 28'd1;
            end
        end
    end
endmodule
