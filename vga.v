`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2023 06:21:12 PM
// Design Name: 
// Module Name: vga
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


module vga(
    input in_clk,
    input [15:0] moles,
    input game_over,
    output reg [3:0] VGA_R,
    output reg [3:0] VGA_G,
    output reg [3:0] VGA_B,
    output reg VGA_HS,
    output reg VGA_VS
);

    wire clock = in_clk;

    reg [31:0] count, vertical_count;
    reg [31:0] vertical_position, horizontal_position;
    reg [1:0]  vertical_state, horizontal_state;
    reg        vertical_trigger, vertical_blank;

    wire [1:0] col         = horizontal_position / 160;
    wire [1:0] row         = vertical_position   / 120;
    wire [3:0] mole_index  = {row, col};
    wire [7:0] x_in_cell   = horizontal_position % 160;
    wire [7:0] y_in_cell   = vertical_position   % 120;
    wire       in_border   = (x_in_cell < 8) || (x_in_cell >= 152)
                           || (y_in_cell < 8) || (y_in_cell >= 112);

    reg [3:0] pixel_r, pixel_g, pixel_b;
    always @(*) begin
        if (game_over) begin
            pixel_r = 4'hF; pixel_g = 4'h0; pixel_b = 4'h0;
        end else if (in_border) begin
            pixel_r = 4'h0; pixel_g = 4'h0; pixel_b = 4'h0;
        end else if (moles[mole_index]) begin
            pixel_r = 4'h0; pixel_g = 4'hF; pixel_b = 4'h0;
        end else begin
            pixel_r = 4'h4; pixel_g = 4'h4; pixel_b = 4'h4;
        end
    end

    initial begin
        vertical_position  = 0;  count = 1;  vertical_count = 1;
        horizontal_position = 0; vertical_state = 3; horizontal_state = 3;
        VGA_HS = 1; VGA_VS = 1;
        VGA_R = 0; VGA_G = 0; VGA_B = 0;
        vertical_trigger = 0; vertical_blank = 1;
    end

    always @(posedge clock) begin
        if (horizontal_state == 0) begin
            if (count == 47) begin
                count <= 1; horizontal_state <= 1; vertical_trigger <= 1;
            end else begin
                vertical_trigger <= 0; count <= count + 1;
            end
        end else if (horizontal_state == 1) begin
            if (horizontal_position == 640) begin
                VGA_R <= 0; VGA_G <= 0; VGA_B <= 0;
                horizontal_position <= 0; horizontal_state <= 2;
            end else begin
                if (!vertical_blank) begin
                    VGA_R <= pixel_r; VGA_G <= pixel_g; VGA_B <= pixel_b;
                end else begin
                    VGA_R <= 0; VGA_G <= 0; VGA_B <= 0;
                end
                horizontal_position <= horizontal_position + 1;
            end
        end else if (horizontal_state == 2) begin
            if (count == 16) begin
                count <= 1; VGA_HS <= 0; horizontal_state <= 3;
            end else count <= count + 1;
        end else begin
            if (count == 96) begin
                VGA_HS <= 1; count <= 1; horizontal_state <= 0;
            end else count <= count + 1;
        end
    end

    always @(posedge vertical_trigger) begin
        if (vertical_state == 0) begin
            if (vertical_count == 32) begin
                vertical_count <= 1; vertical_state <= 1;
            end else vertical_count <= vertical_count + 1;
        end else if (vertical_state == 1) begin
            if (vertical_position == 480) begin
                vertical_position <= 0; vertical_state <= 2; vertical_blank <= 1;
            end else begin
                vertical_blank <= 0; vertical_position <= vertical_position + 1;
            end
        end else if (vertical_state == 2) begin
            if (vertical_count == 10) begin
                vertical_count <= 1; VGA_VS <= 0; vertical_state <= 3;
            end else vertical_count <= vertical_count + 1;
        end else begin
            if (vertical_count == 2) begin
                VGA_VS <= 1; vertical_count <= 1; vertical_state <= 0;
            end else vertical_count <= vertical_count + 1;
        end
    end

endmodule









