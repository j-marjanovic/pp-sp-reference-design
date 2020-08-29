

module otma_bringup (
    // Clocks
    input           CLK_125M,

    input           CLK_R_REFCLK0,
    input           CLK_R_REFCLK1,
    input           CLK_R_REFCLK2,
    input           CLK_R_REFCLK3,
    input           CLK_R_REFCLK4,
    input           CLK_R_REFCLK5,

    // LED
    output [7:0]    LEDS
);

//==============================================================================
// blinky

logic [27:0] cntr = 0;

always_ff @(posedge CLK_125M) begin: proc_cntr
    cntr <= cntr + 1'd1;
end

assign LEDS[7] = cntr[27];
assign LEDS[6:3] = 'd0;


//==============================================================================
// clock connections

wire [7:0] clk_cntr_meas;

assign clk_cntr_meas[0] = CLK_R_REFCLK0;
assign clk_cntr_meas[1] = CLK_R_REFCLK1;
assign clk_cntr_meas[2] = CLK_R_REFCLK2;
assign clk_cntr_meas[3] = CLK_R_REFCLK3;
assign clk_cntr_meas[4] = CLK_R_REFCLK4;
assign clk_cntr_meas[5] = CLK_R_REFCLK5;
assign clk_cntr_meas[6] = 1'b0;
assign clk_cntr_meas[7] = 1'b0;

//==============================================================================
// qsys

system inst_system (
    .clk_clk                ( CLK_125M                  ),
    .clk_cntr_meas          ( clk_cntr_meas             ),
    .clk_cntr_led_dbg       ( LEDS[2]                   ),
    .led_dbg_export         ( LEDS[1:0]                 ),
    .reset_reset_n          ( 1'b1                      )
);

endmodule
