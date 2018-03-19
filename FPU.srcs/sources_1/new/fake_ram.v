`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2018 13:40:45
// Design Name: 
// Module Name: fake_ram
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


module fake_ram(
    input I_clk,
    input I_we,
    input [15:0] I_addr,
    input [15:0] I_data,
    output reg [15:0] O_data
    );
    
    reg [15:0] mem[31:0]; // Defining 32 bytes of memory
    
    always @(negedge I_clk) begin
        if(I_we) begin
            mem[I_addr[5:0]] <= I_data;
        end
        
        O_data <= mem[I_addr[5:0]];
    end
    
    
endmodule
