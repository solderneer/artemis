`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2018 19:01:47
// Design Name: 
// Module Name: regfile_unittest
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


module regfile_unittest(

    );
    
    reg [2:0] I_selA;
    reg [2:0] I_selB;
    reg [2:0] I_selD;
    reg [15:0] I_dataD;
    reg I_clk;
    reg I_en;
    reg I_we;
    wire [15:0] O_dataA;
    wire [15:0] O_dataB;
    
    // Initialize instance of reg_file
    reg_file unittest (I_selA, I_selB, I_selD, I_dataD, I_clk, I_en, I_we, O_dataA, O_dataB);
    
    initial begin
        I_clk = 1'b0;
        I_en = 1'b0;
        I_we = 1'b0;
        
        I_selA = 0;
        I_selB = 0;
        I_selD = 0;
        I_dataD = 0;
        
        // Generate clocl
        forever begin
            #5; I_clk = ~I_clk;
        end
    end
endmodule
