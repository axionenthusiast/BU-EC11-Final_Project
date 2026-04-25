`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2026 07:25:52 PM
// Design Name: 
// Module Name: top
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


module top(
    input clock,
    input rst,
    input [15:0] switch,
    
    output [15:0] led,
    output LED16_R,
    output [6:0] cathode,
    output [7:0] anode,
    output [3:0] VGA_R, VGA_G, VGA_B,
    output VGA_HS, VGA_VS
    );
    
    wire [15:0] rng_out;    
    reg [15:0] seed = 16'd56394;
    reg load = 1'b1;
    reg load_cleared = 1'b0;
    
    always @(posedge clock) begin
        if (!load_cleared) begin
            load <= 1'b0;
            load_cleared <= 1'b1;
        end
    end
   
    
    PRNG rng(.clk(clock), .rst(rst), .load(load), .seed(seed), .out(rng_out));    
    
    wire game_over;
    wire [11:0] timer_bcd, score_bcd;
    game_timer gt(.clock(clock), .rst(rst), .game_over(game_over), .bcd(timer_bcd));
    
    wire increment;
    score_counter sc(.clock(clock), .rst(rst), .increment(increment), .game_over(game_over), .bcd(score_bcd));
    
    wire [15:0] spawn_bus;
    spawner sp(.clock(clock), .rst(rst), .rng(rng_out), .game_over(game_over), .spawn(spawn_bus));
    
    wire [15:0] hits;
    wire multiple_switches = (switch & (switch-16'b1)) != 16'b0;
    assign increment = |hits && !multiple_switches;
    
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : moles
            mole m(.clock(clock), .rst(rst), .spawn(spawn_bus[i]), .switch_raw(switch[i]), .game_over(game_over), .led(led[i]), .hit(hits[i]));
        end
    endgenerate
    
    wire [31:0] digits;
    wire [7:0] blank;
    
    assign digits = {score_bcd, 4'd0, 4'd0, timer_bcd};
    assign blank = 8'b0001_1000;
    
    display_driver dd(.clock(clock), .rst(rst), .digits(digits), .blank(blank), .cathode(cathode), .anode(anode));
    assign LED16_R = game_over;
    
    
    
    wire vga_clk;
    vga_clock_divider vga_cd (
        .clk_in (clock),
        .rst (rst),
        .divided_clk (vga_clk)
    );
    
    vga vga1 (
        .in_clk (vga_clk),
        .moles (led),
        .game_over (game_over),
        .VGA_R (VGA_R),
        .VGA_G (VGA_G),
        .VGA_B (VGA_B),
        .VGA_HS (VGA_HS),
        .VGA_VS(VGA_VS)
        );
    
endmodule
