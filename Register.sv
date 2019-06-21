`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2019 09:03:59 AM
// Design Name: 
// Module Name: Register
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


module Register #(parameter WIDTH = 8)(
    input   CLK, LD, RST, INC, DECR,
    input   [WIDTH-1:0] DIN,
    output  logic [WIDTH-1:0] DOUT = 0);

always_ff @ (posedge CLK)
begin
    if (RST==1)
        DOUT <= 0;
    else if (LD==1)
        DOUT <= DIN;
    else if (INC==1)
        DOUT <= DOUT+1;
    else if (DECR==1)
        DOUT <= DOUT-1;
    

end
endmodule
