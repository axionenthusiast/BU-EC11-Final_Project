`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2023 08:43:13 AM
// Design Name: 
// Module Name: fsm
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

module fsm(
    input clock,
    input [15:0] sixteen_bit_number,
    output [6:0] cathode,
    output reg [7:0] anode
);

    reg [3:0] four_bit_number;
    reg [1:0] state; // 3 states: 0,1,2

    // decoder instance
    decoder dec (
        .number(four_bit_number),
        .cathode(cathode)
    );

    initial begin
        state = 0;
        anode = 8'b11111111;
    end

    always @(posedge clock)
    begin
        // state transition (3-state FSM)
        if (state == 2)
            state <= 0;
        else
            state <= state + 1;

        case (state)
            2'b00: begin
                anode <= 8'b11111110; // enable display 0
                four_bit_number <= sixteen_bit_number[3:0];
            end

            2'b01: begin
                anode <= 8'b11111101; // enable display 1
                four_bit_number <= sixteen_bit_number[7:4];
            end

            2'b10: begin
                anode <= 8'b11111011; // enable display 2
                four_bit_number <= sixteen_bit_number[11:8];
            end

            default: begin
                anode <= 8'b11111111;
                four_bit_number <= 4'b0000;
            end
        endcase
    end

endmodule
