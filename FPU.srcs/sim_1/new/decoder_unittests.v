`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2018 14:45:47
// Design Name: 
// Module Name: decoder_unittests
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


module decoder_unittests(

    );
    
    reg [15:0] I_inst;
    reg I_clk;
    reg I_en;
    
    wire [4:0] O_aluop;
    wire [15:0] O_Imm;
    wire [3:0] O_selA;
    wire [3:0] O_selB;
    wire [3:0] O_selD;
    wire O_regwe;
    
    inst_decoder unittest  (I_inst, 
                            I_clk, 
                            I_en, 
                            O_aluop, 
                            O_Imm, 
                            O_selA, 
                            O_selB, 
                            O_selD);
    
    /* Procedure for testing
     * 1) Insert proper instruction
     * 2) Check update for proper slicing after 1 clk cycle
     */
     
    initial begin
        // Initialize intial values for regs
        I_inst = 0;
        I_en = 0;
        I_clk = 0;
        
        #10;
        I_inst = 16'b0001011100000100; // add r7 r1,r2
        
        #10;
        I_en = 1;
    end
    
    always begin
        #5; I_clk = ~I_clk;
    end

                            
    
endmodule
