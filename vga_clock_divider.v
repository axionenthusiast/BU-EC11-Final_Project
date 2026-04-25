`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2026 06:49:18 PM
// Design Name: 
// Module Name: vga_clock_divider
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


module vga_clock_divider(
    input in_clk,      // 100 MHz clock
    input rst,
    output reg divided_clk // 25 MHz clock
);
	
	reg[1:0] count = 2'b0;
	initial divided_clk = 0;
	
	always @(negedge in_clk or posedge rst)
	begin
	   if (rst) begin
	       count <= 2'b0;
	       divided_clk <= 1'b0;
	   end else
 if (count == 2'd1) begin
	       divided_clk <= ~divided_clk;
	       count <= 0;
	   end else begin
	       count <= count + 1'b1;
	   end
	end

endmodule