`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2026 08:13:08 PM
// Design Name: 
// Module Name: display_driver
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


module display_driver(
    input clock, rst,
    input [31:0] digits,
    input [7:0] blank,
    output [6:0] cathode,
    output reg [7:0] anode
    );
    wire fsm_clock;
    faster_clock_divider fcd(
        .in_clk(clock),
        .out_clk(fsm_clock)
    );
    
    reg [2:0] state;
    reg [3:0] nibble;
    
    decoder dec(
        .number(nibble),
        .cathode(cathode)
    );
    
    initial begin   
        state = 3'd0;
        anode = 8'b11111111;
        nibble = 4'b0;
    end
    
    always @(posedge fsm_clock or posedge rst) begin
        if (rst) begin
            state <= 3'b0;
            anode <= 8'b11111111;
            nibble <= 4'b0;
        end else begin
            state <= state + 3'd1;
            case (state)
                3'd0: nibble <= digits[3:0];
                3'd1: nibble <= digits[7:4];
                3'd2: nibble <= digits[11:8];
                3'd3: nibble <= digits[15:12];
                3'd4: nibble <= digits[19:16];
                3'd5: nibble <= digits[23:20];
                3'd6: nibble <= digits[27:24];
                3'd7: nibble <= digits[31:28];
            endcase
            
            if (blank[state])
                anode <= 8'b11111111;
            else
                anode <= ~(8'b00000001 << state);
        end
    end

endmodule
