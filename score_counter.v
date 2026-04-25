`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2026 04:59:59 PM
// Design Name: 
// Module Name: score_counter
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


module score_counter(
    input clock,
    input rst,
    input increment,
    input game_over,
    output [11:0] bcd
    );

    reg [7:0] score = 0;
  
    binary_to_BCD_converter convert(
        .bin(score),
        .bcd(bcd)
    );
      
    always @(posedge clock or posedge rst) begin
        if (rst)
            score <= 8'd0;
        else if (increment && !game_over && score < 8'd99)
            score <= score + 8'd1;
    end
    
endmodule
