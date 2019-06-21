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


module Mux4 #(parameter WIDTH = 4)(
    input [WIDTH-1:0] ZERO, ONE, TWO, THREE,
    input [1:0] SEL,
    output logic [WIDTH-1:0] MUXOUT);


always_comb
begin 
    case(SEL)
        0: MUXOUT = ZERO;
        1: MUXOUT = ONE;
        2: MUXOUT = TWO;
        3: MUXOUT = THREE;
        default: MUXOUT = ZERO;
    endcase
end
endmodule
