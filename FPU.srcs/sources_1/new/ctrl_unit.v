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
    output O_enrgrd,
    output O_endec,
    output O_enalu,
    output O_enrgwr
    );
    
    reg [3:0] state;
    
    assign O_endec = state[0];
    assign O_enrgrd = state[1] | state[3];
    assign O_enalu = state[2];
    assign O_enrgwr = state[3];
    
    initial begin
        state = 4'b0000;
    end
    
    always @(posedge I_clk) begin
        case(state)
            4'b0001 : state <= 4'b0010;
            4'b0010 : state <= 4'b0100;
            4'b0100 : state <= 4'b1000;
            default : state <= 4'b0001;
        endcase
        state = (I_reset) ? 4'b0001 : state;
    end
endmodule
