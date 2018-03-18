`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2018 13:56:07
// Design Name: 
// Module Name: main_test
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


module main_test(

    );
    wire [2:0] selA;
    wire [2:0] selB;
    wire [2:0] selD;
    wire [15:0] dataD;
    wire [15:0] dataB;
    wire [15:0] dataA;
    wire [4:0] aluop;
    wire [7:0] imm;
    wire Dwe;
    wire shld_branch;
       
    reg [15:0] inst;
    reg clk;
    reg en;
     
    reg_file reg16_8 (selA, selB, selD, dataD, clk, en, Dwe, dataA, dataB);
    inst_decoder main_dec (inst, clk, en, aluop, imm, selA, selB, selD, Dwe);
    alu main_alu (aluop, dataA, dataB, imm, en, clk, dataD, shld_branch);
    
    initial begin 
        clk = 0;
        en = 0;
        inst = 0;
        
        #5; en = 1;
        #10; inst = 16'b1000001011111111; // ldr r2, 0xFF
        #30; inst = 16'b1000000100000001; // ldr r1, 0x01
        #30; inst = 16'b0001001101000100; // sub r1, r2, r3  
    end
    
    always begin
        clk = ~clk; #5;
    end
endmodule
