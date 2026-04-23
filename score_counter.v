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
    output [6:0] cathode,
    output [7:0] anode
    );
    wire fsm_clock;
    reg [7:0] score = 0;
    wire [11:0] bcd;
  
    faster_clock_divider fcd (
        .in_clk  (clock),
        .out_clk (fsm_clock)
    );
    
    
    binary_to_BCD_converter convert(.bin(score), .bcd(bcd));
    
    fsm display_fsm (
        .clock(fsm_clock),
        .sixteen_bit_number({4'd0, bcd}),
        .cathode(cathode),
        .anode(anode)
    );
    
    
    always @(posedge clock or posedge rst) begin
        if (rst)
            score <= 8'd0;
        else if (increment && score < 8'd99)
            score <= score + 8'd1;
    end
    
endmodule
