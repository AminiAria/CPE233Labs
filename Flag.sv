`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2019 09:24:26 AM
// Design Name: 
// Module Name: Flag
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


module Flag(
    input   CLK, SET, CLR, LD, DIN,
    output  logic DOUT = 0);

always_ff @ (posedge CLK)
begin
    if (SET==1)
        DOUT <= 1;
    else if (CLR==1)
        DOUT <= 0;
    else if (LD==1)
        DOUT <= DIN;

end
endmodule
