`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2018 09:52:22
// Design Name: 
// Module Name: alu
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


module alu(
    input [4:0] I_aluop,
    input [15:0] I_dataA,
    input [15:0] I_dataB,
    input [7:0] I_imm,
    input I_en,
    input I_clk,
    output [15:0] O_dataResult,
    output reg O_shldBranch
    );
    
    reg [17:0] int_Result;
    
    assign O_dataResult = int_Result[15:0]; // Only assign first 15 bits, others used for overflow
    initial begin
        int_Result = 0;
        O_shldBranch = 0;
    end
    
    always @(negedge I_clk) begin
        if(I_en) begin
        case(I_aluop[4:1])
            (4'b0000) : begin
                            int_Result <= (I_aluop[0]) ? ($signed(I_dataA) + $signed(I_dataB)) : (I_dataA + I_dataB);
                            O_shldBranch <= 0;
                        end
            (4'b0001) : begin 
                            int_Result <= (I_aluop[0]) ? ($signed(I_dataA) - $signed(I_dataB)) : (I_dataA - I_dataB);
                            O_shldBranch <= 0;
                        end
            (4'b0010) : begin 
                            int_Result <= I_dataA | I_dataB;
                            O_shldBranch <= 0;
                        end
            (4'b0011) : begin 
                            int_Result <= I_dataA & I_dataB;
                            O_shldBranch <= 0;
                        end
            (4'b0100) : begin 
                            int_Result <= I_dataA ^ I_dataB;
                            O_shldBranch <= 0;
                        end
            (4'b0101) : begin 
                            int_Result <= ~I_dataA;
                            O_shldBranch <= 0;
                        end 
            (4'b1000) : begin
                            int_Result <= (I_aluop[0]) ? {I_imm, 8'h00} : {8'h00, I_imm};
                            O_shldBranch <= 0;
                        end
            (4'b1001) : begin
                            if (I_aluop[0]) begin
                                int_Result[0] <= ($signed(I_dataA) == $signed(I_dataB)) ? 1 : 0;
                                int_Result[1] <= ($signed(I_dataA) == 0) ? 1 : 0;
                                int_Result[2] <= ($signed(I_dataB) == 0) ? 1 : 0;
                                int_Result[3] <= ($signed(I_dataA) > $signed(I_dataB)) ? 1 : 0;
                                int_Result[4] <= ($signed(I_dataA) < $signed(I_dataB)) ? 1 : 0;
                            end
                            else begin
                                int_Result[0] <= (I_dataA == I_dataB) ? 1 : 0;
                                int_Result[1] <= (I_dataA == 0) ? 1 : 0;
                                int_Result[2] <= (I_dataB == 0) ? 1 : 0;
                                int_Result[3] <= (I_dataA > I_dataB) ? 1 : 0;
                                int_Result[4] <= (I_dataA < I_dataB) ? 1 : 0;
                            end
                            O_shldBranch <= 0;
                        end
            (4'b1010) : begin
                            int_Result <= I_dataA << (I_dataB[3:0]);
                            O_shldBranch <= 0;
                        end
            (4'b1011) : begin
                            int_Result <= I_dataA >> (I_dataB[3:0]);
                            O_shldBranch <= 0;
                        end
            (4'b1100) : begin
                            int_Result <= (I_aluop[0]) ? I_dataA : I_imm;
                            O_shldBranch <= 1;
                        end
            (4'b1101) : begin
                            int_Result <= I_dataA;
                            O_shldBranch <= I_dataB[{I_aluop[0], I_imm[1:0]}];
                        end
        endcase
        end
    end
endmodule
