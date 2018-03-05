`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2018 14:44:49
// Design Name: 
// Module Name: inst_decoder
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


module inst_decoder(
    input [15:0] I_inst,
    input I_clk,
    input I_en,
    output O_aluop,
    output [15:0] O_Imm,
    output [3:0] O_selA,
    output [3:0] O_selB,
    output [3:0] O_selD,
    output O_regwe
    );
endmodule
