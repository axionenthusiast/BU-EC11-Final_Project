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
    input in_clk,
    input rst,
    input [15:0] switch
    
    );
    
    wire clk;
    wire [15:0] rng_out;
    wire led_on;
    
    
    reg [15:0] seed = 56394;
    reg load = 1;
    reg next_load;
    
    faster_clock_divider cd(.in_clk(in_clk), .out_clk(clk));
    PRNG rng(.clk(clk), .rst(rst), .load(load), .seed(seed), .out(rng_out));
    
    
    
    always @(posedge clk or posedge clk) begin
        if (rst) begin
            load <= 1'b1;
            next_load <= 1'b0;
        end
        else if (!next_load) begin
            
            
        
        
    end
    
    
endmodule
