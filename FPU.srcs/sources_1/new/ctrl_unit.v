`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2018 09:28:52
// Design Name: 
// Module Name: ctrl_unit
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


module ctrl_unit(
    input I_clk,
    input I_reset,
    output O_enfetch,
    output O_endec,
    output O_enrgrd,
    output O_enalu,
    output O_enrgwr,
    output O_enmem
    );
    
    reg [5:0] state;
    
    assign O_enfetch = state[0];
    assign O_endec = state[1];
    assign O_enrgrd = state[2] | state[4];
    assign O_enalu = state[3];
    assign O_enrgwr = state[4];
    assign O_enmem = state[5];
    
    initial begin
        state = 6'b000001;
    end
    
    always @(posedge I_clk) begin
        if(I_reset) begin
            state <= 6'b000001;
        end
        else begin
            case(state)
                6'b000001 : state <= 6'b000010;
                6'b000010 : state <= 6'b000100;
                6'b000100 : state <= 6'b001000;
                6'b001000 : state <= 6'b010000;
                6'b010000 : state <= 6'b100000;
                default : state <= 6'b000001;
            endcase
        end
    end
endmodule
