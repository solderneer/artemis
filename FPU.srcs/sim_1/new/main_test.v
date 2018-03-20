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
    wire [15:0] ram_dataO;
    wire [1:0] pc_opcode;
    wire [15:0] pc_in;
    wire [15:0] pc_out;
    
    wire Dwe;
    wire shld_branch;
    wire en_rgrd;
    wire en_dec;
    wire en_alu;
    wire en_rgwr;
    wire update;

    reg clk;
    reg reset;
    reg ram_we = 0;
    reg [15:0] ram_dataI = 0;
    
    assign en_rgwr = (Dwe & update);
    assign pc_opcode = (reset) ? 2'b00 : ((en_alu) ? 2'b01 : 2'b00);
     
    reg_file main_reg (selA, selB, selD, dataD, clk, en_rgrd, en_rgwr, dataA, dataB);
    inst_decoder main_dec (ram_dataO, clk, en_dec, aluop, imm, selA, selB, selD, Dwe);
    alu main_alu (aluop, dataA, dataB, imm, en_alu, clk, dataD, shld_branch);
    ctrl_unit main_ctrl (clk, reset, en_rgrd, en_dec, en_alu, update);
    fake_ram main_ram (clk, ram_we, pc_out, ram_dataI, ram_dataO);
    pc_unit main_pc (clk, pc_in, pc_opcode, pc_out);
    
    initial begin 
        clk = 0;
        reset = 1; #20;
        
        reset = 0;
        wait(pc_out == 7) #10;
        reset = 1;
        
        /* Old testing code
        inst = 16'b1000000011111110; // ldrl r0, #0xFE
        
        #1; reset = 0; // Enable stuff  
        wait(update == 1) inst = 16'b1000100111101101; #15;// ldrh r1, 0xed
        wait(update == 1) inst = 16'b0010001000100000; #15;// or r2, r1, r0
        wait(update == 1) inst = 16'b1000001100000001; #15;// ldrl r3, #0x01
        wait(update == 1) inst = 16'b1000010000000010; #15;// ldrl r4, #0x02 
        wait(update == 1) inst = 16'b0000001101110000; #15;// addu r3, r3, r4
        wait(update == 1) inst = 16'b0010010100001100; #15;// or r5, r0, r3
        */      
    end
    
    always begin
        #5; clk = ~clk;
    end
endmodule
