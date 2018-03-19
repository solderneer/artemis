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
    wire en_rgrd;
    wire en_dec;
    wire en_alu;
    wire en_rgwr;
    wire update;
       
    reg [15:0] inst;
    reg clk;
    reg reset;
    
    assign en_rgwr = (Dwe & update);
     
    reg_file reg16_8 (selA, selB, selD, dataD, clk, en_rgrd, en_rgwr, dataA, dataB);
    inst_decoder main_dec (inst, clk, en_dec, aluop, imm, selA, selB, selD, Dwe);
    alu main_alu (aluop, dataA, dataB, imm, en_alu, clk, dataD, shld_branch);
    ctrl_unit main_ctrl (clk, reset, en_rgrd, en_dec, en_alu, update);
    
    initial begin 
        clk = 0;
        inst = 0;
        reset = 1;
        inst = 16'b1000001011111111; // ldr r2, 0xFF
        
        #1; reset = 0; // Enable stuff  
        wait(update == 1) inst = 16'b1000000100000001; #15; // ldr r1, 0x01
        wait(update == 1) inst = 16'b0001001101000100; #15; // sub r3, r2, r1        
    end
    
    always begin
        #5; clk = ~clk;
    end
endmodule
