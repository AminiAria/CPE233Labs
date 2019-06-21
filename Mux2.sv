`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2019 11:10:21 AM
// Design Name: 
// Module Name: Mux4
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


module Mux2 #(parameter WIDTH = 4)(
    input [WIDTH-1:0] ZERO, ONE,
    input SEL,
    output logic [WIDTH-1:0] MUXOUT);


always_comb
begin 
    case(SEL)
        0: MUXOUT = ZERO;
        1: MUXOUT = ONE;
        default: MUXOUT = ZERO;
    endcase
end
endmodule
