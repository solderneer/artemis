`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2018 06:57:14
// Design Name: 
// Module Name: reg_file
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


module reg_file(
    input [2:0] I_selA,
    input [2:0] I_selB,
    input [2:0] I_selD,
    input [15:0] I_dataD,
    input I_clk,
    input I_en,
    input I_we,
    output reg [15:0] O_dataA,
    output reg [15:0] O_dataB
    );
    
    // Initialize internal registers
    reg [15:0] regs[7:0];
    
    // Loop variable
    integer count;
  
    // Initialize output registers
    initial begin
        O_dataA = 1'd0;
        O_dataB = 1'd0;
        
        for(count = 0; count < 8; count = count + 1) begin
            regs[count] = 0;
        end
    end
    
    // On clock positive edge
    always @(posedge I_clk) begin
        if(I_en)
        begin
            // Assign correct output value to A and B
            O_dataA <= regs[I_selA];
            O_dataB <= regs[I_selB];
            
            // Check for write enable flag and then assign to register
            if(I_we)
                regs[I_selD] <= I_dataD;
        end
    end
endmodule
