`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2026 07:47:44 PM
// Design Name: 
// Module Name: clk_divider_tb
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


module clk_divider_tb(
    );
    
    reg clk, rst, D;
    wire Q, notQ;
    wire internal_div_clk;
    assign internal_div_clk = tpb.clkd.divided_clk;
    
    top_part1b  tpb(.D(D), .clk(clk), .rst(rst), .Q(Q), .notQ(notQ));
    
    initial fork
        rst = 1;
        clk = 0;
        D = 0;
        #10 rst = 0;
        #20 D = 1;
        #40 D = 0;
        #100 $finish;
    join
    
    always #2 clk = ~clk;
        
endmodule
