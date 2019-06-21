`timescale 1ns / 1ps


module RatCPU(
    input [7:0] IN_PORT,
    input CLK, RESET, INTERRUPT,
    output logic IO_STRB,
    output logic [7:0] OUT_PORT, PORT_ID
    );

logic [4:0] opcode_hi_5;
logic [1:0] opcode_lo_2;
logic shad_c_out, shad_z_out, i_andgate, i_flg_out, i_set, i_clr, pc_ld, pc_inc, alu_opy_sel, rf_wr, sp_ld, sp_incr, sp_decr, scr_we, scr_data_sel, flg_c_set, flg_c_clr, flg_c_ld, flg_z_ld, flg_ld_sel, flg_shad_ld, rst, io_strb; 
logic [1:0] pc_mux_sel, rf_wr_sel, scr_addr_sel;
logic [3:0] alu_sel;

logic [9:0] pc_mux_out, pc_count, scr_data_out, sp_data_out, scr_din_mux_out;
logic [17:0] ir; 
logic [7:0] reg_mux_out, dx_out, dy_out, result, alu_mux_out, B, B_1, scr_addr_mux_out;
logic c_flag, z_flag, c, z;

Register #(10) PC (.CLK(CLK), .RST(rst), .LD(pc_ld), .INC(pc_inc), .DIN(pc_mux_out), .DOUT(pc_count));
Mux4 #(10) PC_MUX (.ZERO(ir[12:3]), .ONE(scr_data_out), .TWO(10'h3FF), .THREE(0), .SEL(pc_mux_sel), .MUXOUT(pc_mux_out));
ProgRom PROG_ROM (.PROG_ADDR(pc_count), .PROG_CLK(CLK), .PROG_IR(ir));
Ram REG_FILE (.DIN(reg_mux_out), .WE(rf_wr), .ADRX(ir[12:8]), .ADRY(ir[7:3]), .CLK(CLK), .DX_OUT(dx_out), .DY_OUT(dy_out));
Mux4 #(8) REG_MUX (.ZERO(result), .ONE(scr_data_out), .TWO(sp_data_out), .THREE(IN_PORT), .SEL(rf_wr_sel), .MUXOUT(reg_mux_out));
ALU ALU (.CIN(c_flag), .SEL(alu_sel), .A(dx_out), .B(alu_mux_out), .RESULT(result), .C(c), .Z(z));
Mux2 #(8) ALU_MUX (.ZERO(dy_out), .ONE(ir[7:0]), .SEL(alu_opy_sel), .MUXOUT(alu_mux_out));
Flag Z (.LD(flg_z_ld), .DIN(z), .CLK(CLK), .DOUT(z_flag));
Flag C (.SET(flg_c_set), .LD(flg_c_ld), .DIN(c), .CLK(CLK), .CLR(flg_c_clr), .DOUT(c_flag));
ControlUnit CONTROL_UNIT (.C(c_flag), .Z(z_flag), .INTERRUPT(i_andgate), .RESET(RESET), .OPCODE_HI_5(ir[17:13]), .OPCODE_LO_2(ir[1:0]), .CLK(CLK), .I_SET(i_set), .I_CLR(i_clr), .PC_LD(pc_ld), .PC_INC(pc_inc), .ALU_OPY_SEL(alu_opy_sel), .RF_WR(rf_wr), .SP_LD(sp_ld), .SP_INCR(sp_incr), .SP_DECR(sp_decr), .SCR_WE(scr_we), .SCR_DATA_SEL(scr_data_sel), .FLG_C_SET(flg_c_set), .FLG_C_CLR(flg_c_clr), .FLG_C_LD(flg_c_ld), .FLG_Z_LD(flg_z_ld), .FLG_LD_SEL(flg_ld_sel), .FLG_SHAD_LD(flg_shad_ld), .RST(rst), .IO_STRB(IO_STRB), .PC_MUX_SEL(pc_mux_sel), .RF_WR_SEL(rf_wr_sel), .SCR_ADDR_SEL(scr_addr_sel), .ALU_SEL(alu_sel));
Register #(8) StackPointer (.CLK(CLK), .RST(rst), .LD(sp_ld), .INC(sp_incr), .DECR(sp_decr), .DIN(dx_out), .DOUT(B));
Ram #(8,10) SCR (.CLK(CLK), .DIN(scr_din_mux_out), .WE(scr_we), .ADRX(scr_addr_mux_out), .DX_OUT(scr_data_out));
Mux2 #(10) SCR_DIN_MUX (.ZERO(dx_out), .ONE(pc_count), .SEL(scr_data_sel), .MUXOUT(scr_din_mux_out));
Mux4 #(8) SCR_ADDR_MUX (.ZERO(dy_out), .ONE(ir[7:0]), .TWO(B), .THREE(B_1), .SEL(scr_addr_sel), .MUXOUT(scr_addr_mux_out));
Flag I (.SET(i_set), .CLK(CLK), .CLR(i_clr), .DOUT(i_flg_out));
Flag SHAD_C (.CLK(CLK), .LD(flg_shad_ld), .DIN(c_flag), .DOUT(shad_c_out));
Flag SHAD_Z (.CLK(CLK), .LD(flg_shad_ld), .DIN(z_flag), .DOUT(shad_z_out));
Mux2 #(1) Z_MUX (.ZERO(z), .ONE(shad_z_out), .SEL(flg_ld_sel));
Mux2 #(1) C_MUX (.ZERO(c), .ONE(shad_c_out), .SEL(flg_ld_sel));


assign i_andgate = INTERRUPT & i_flg_out;
assign B_1 = B-1;
assign OUT_PORT = dx_out;
assign PORT_ID = ir[7:0];

endmodule
