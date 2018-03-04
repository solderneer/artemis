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
    
    /* Testing Process for reference
     * 1) Read r0 and r1, write 0xFFFF to r0
     * 2) Ensure 0xFFFF appears on data out line, write 0x2222 to r2
     * 3) Write 0x3333 to r2, testing multiple writes to same location
     * 4) Set up as tho writing 0xFEED to r0 but dont enable the I_we
     * 5) Write 0x4444 to r4, ensure OxFEED was not written to r0
     * 6) After waiting multiple clock cycles, read r4 on both output A and B
     */
  
    initial begin
        // Initialize all inputs
        I_clk = 1'b0;
        I_en = 1'b0;
        I_we = 1'b0;
        
        I_selA = 0;
        I_selB = 0;
        I_selD = 0;
        I_dataD = 0;
        
        // Start testing
        #7; 
        I_en = 1'b1;
        
        I_selA = 3'b000;
        I_selB = 3'b001;
        I_selD = 3'b000;
        
        I_dataD = 16'hFFFF;
        I_we = 1'b1; 
        
        #10;
        I_we = 1'b0;
        I_selD = 3'b010;
        I_dataD = 16'h2222;
        
        #10;
        I_we = 1'b1; // Enable write to reg2
        
        #10;
        I_dataD = 16'h3333;
        
        #10
        I_we = 1'b0;
        I_selD = 3'b000;
        I_dataD = 16'hFEED;
        
        #10;
        I_selD = 3'b100;
        I_dataD = 16'h4444;
        
        #10; I_we = 1'b1;
        
        #50;
        I_selA = 3'b100;
        I_selB = 3'b100;
    end
    
    // Generate clock
    always begin
        #5; I_clk = ~I_clk;
    end
endmodule
