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
    input [15:0] switch

    );
    
    wire clk;
    wire [15:0] rng_out;
    wire led_on;
    
    
    reg [15:0] seed = 56394;
    reg load;
    reg next_load;
    
    wire game_over;
    wire [6:0] timer_cathode;
    wire [7:0] timer_anode;
    wire [6:0] score_cathode;
    wire [7:0] score_anode;
    
    wire hit;
    
    initial begin
        load = 1;
    end
    
    game_timer gt (
        .clock(clock),
        .rst(rst),
        .cathode(timer_cathode),
        .anode(timer_anode),
        .game_over(game_over)
        );
        
    score_counter sc (
        .clock(clock),
        .rst(rst),
        .increment(increment),
        .cathode(score_cathode),
        .anode(score_anode)
        );
    
    PRNG rng(.clk(clock), .rst(rst), .load(load), .seed(seed), .out(rng_out));
    
    counter countup(.clk(in_clk));
    
    
    always @(posedge clk or posedge clk) begin
        if (rst) begin
            load <= 1'b1;
            next_load <= 1'b0;
        end
        else if (next_load == 0) begin
            load <= 1'b0;
            next_load <= 1'b1;
        end
        
        
    end
    
    
endmodule
