`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:28:31 11/27/2017 
// Design Name: 
// Module Name:    Cloc_divider 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clock_divider(
    input in_clk,      // 100 MHz clock
    output reg out_clk // 1 Hz clock
);
	
	reg[32:0] count;

	initial begin
	   // initialize everything to zero
	   count = 0;
	   out_clk = 0;
	end
	
	always @(negedge in_clk)
	begin
	   if (count == 26'd49_999_999) begin
	       out_clk <= ~out_clk;
	       count <= 0;
	   end else begin
	       count <= count + 1;
	   end
	end

endmodule
