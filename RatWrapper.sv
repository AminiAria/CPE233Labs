`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly
// Engineer: Paul Hummel
//
// Create Date: 06/28/2018 05:21:01 AM
// Module Name: RAT_WRAPPER
// Target Devices: RAT MCU on Basys3
// Description: Basic RAT_WRAPPER
//
// Revision:
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////

module RatWrapper(
    input CLK, BTNC, BTNL, BTNR, BTNU, BTND,
    input [7:0] SWITCHES, UP_SWITCHES,
    output logic [7:0] LEDS, SEG,
    output logic [3:0] AN
    );
    
    logic [7:0] r_sseg;
    
    // INPUT PORT IDS ////////////////////////////////////////////////////////
    localparam SWITCHES_ID = 8'h20;
    localparam UP_SWITCHES_ID = 8'h21;
    localparam BUTTONS_ID = 8'hFF;
    

       
    // OUTPUT PORT IDS ///////////////////////////////////////////////////////
    localparam LEDS_ID = 8'h40;
    localparam SEG_ID = 8'h81;
    
    logic [3:0] buttons;
    assign buttons = {BTNL, BTNU, BTNR, BTND};
    
    // Signals for connecting RAT_MCU to RAT_wrapper /////////////////////////
    logic [7:0] s_output_port;
    logic [7:0] s_port_id;
    logic s_load;
    logic s_interrupt;
    logic s_reset;
    logic s_clk_50 = 1'b0;     // 50 MHz clock
    
    // Register definitions for output devices ///////////////////////////////
    logic [7:0]   s_input_port;
    logic [7:0]   r_leds = 8'h00;

    // Declare RAT_CPU ///////////////////////////////////////////////////////
    RatCPU MyCPU (.IN_PORT(s_input_port), .OUT_PORT(s_output_port),
                .PORT_ID(s_port_id), .IO_STRB(s_load), .RESET(s_reset),
                .INTERRUPT(s_interrupt), .CLK(s_clk_50));
    
    // Clock Divider to create 50 MHz Clock //////////////////////////////////
    always_ff @(posedge CLK) begin
        s_clk_50 <= ~s_clk_50;
    end
    
     
    // MUX for selecting what input to read //////////////////////////////////
    always_comb begin
        if (s_port_id == SWITCHES_ID)
            s_input_port <= SWITCHES;
        else if (s_port_id == BUTTONS_ID)
            s_input_port <= {4'b0,buttons};
        else if (s_port_id == UP_SWITCHES_ID)
            s_input_port <= UP_SWITCHES;
        else
            s_input_port <= 8'h00;
    end
   
    // MUX for updating output registers /////////////////////////////////////
    // Register updates depend on rising clock edge and asserted load signal
    always_ff @ (posedge s_clk_50) begin
        if (s_load == 1'b1) begin
            if (s_port_id == LEDS_ID)
                r_leds <= s_output_port;
            if (s_port_id == SEG_ID)
                r_sseg <= s_output_port;
            end
        end
     
    // Connect Signals ///////////////////////////////////////////////////////
    assign s_reset = BTNC;
    //assign s_interrupt = afnjd1'b0;  // set this to output of debouncer
     
    // Output Assignments ////////////////////////////////////////////////////
    assign LEDS = r_leds;
   
   DebounceOneShot DEBOUNCER (.CLK(s_clk_50), .BTN(BTNL), .DB_BTN(s_interrupt));
   
   univ_sseg SSEG (.clk(CLK), .valid(1), .cnt1({5'b0, r_sseg}), .ssegs(SEG), .disp_en(AN));  


    endmodule
