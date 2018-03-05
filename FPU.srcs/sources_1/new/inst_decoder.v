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
    output reg [4:0] O_aluop,
    output reg [15:0] O_Imm,
    output reg [3:0] O_selA,
    output reg [3:0] O_selB,
    output reg [3:0] O_selD,
    output reg O_regwe
    );
    
    initial begin
        // Initialize all output registers to 0
        O_aluop = 0;
        O_Imm = 0;
        O_selA = 0;
        O_selB = 0;
        O_selD = 0;
        O_regwe = 0;
    end  
    
    always @(posedge I_clk) begin
        if(I_en) begin
            // Assign the bits statically according to ISA
            O_aluop <= I_inst[15:11];
            O_selD <= I_inst[10:8];
            O_selA <= I_inst[7:5];
            O_selB <= I_inst[4:2];
            O_Imm <= I_inst[7:0];
            
            case(I_inst[3:0])
                5'b0111 : O_regwe <= 0;
                5'b1100 : O_regwe <= 0;
                5'b1101 : O_regwe <= 0;
                default : O_regwe <= 1;
            endcase
            
        end
    end
    
    
endmodule
