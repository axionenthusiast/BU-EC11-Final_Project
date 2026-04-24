`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2026 08:11:47 PM
// Design Name: 
// Module Name: mole
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


module mole(
    input clock, rst, spawn, switch_raw, game_over,
    output reg led, hit
    );
    
    reg sw_sync0, sw_sync1, sw_prev;
    always @(posedge clock or posedge rst) begin
        if (rst) begin
            sw_sync0 <= 1'b0;
            sw_sync1 <= 1'b0;
            sw_prev  <= 1'b0;
        end else begin
            sw_sync0 <= switch_raw;
            sw_sync1 <= sw_sync0;
            sw_prev <= sw_sync1;
        end
    end
    wire sw_rising = sw_sync1 & ~sw_prev;
    
    reg active; 
    reg [25:0] timer;
    localparam [25:0] WINDOW = 26'd49_999_999; // 1/2 second
    
    always @(posedge clock or posedge rst) begin
        if (rst) begin
            active <= 1'b0;
            led <= 1'b0;
            hit <= 1'b0;
            timer <= 26'd0;
        end else begin
            hit <= 1'b0;
            if (game_over) begin
                active <= 1'b0;
                led <= 1'b0;
                timer <= 26'd0;
            end else if (!active) begin
                // idle
                if (spawn) begin
                    active <= 1'b1;
                    led <= 1'b1;
                    timer <= WINDOW;
                end
            end else begin
                // active
                if (sw_rising) begin
                    hit <= 1'b1;
                    active <= 1'b0;
                    led <= 1'b0;
                    timer <= 26'd0;
                end else if (timer == 26'd0) begin
                    // window expired
                    active <= 1'b0;
                    led <= 1'b0;
                end else begin
                    timer <= timer - 26'd1;
                end
            end
        end
    end
endmodule
