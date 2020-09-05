

module otma_bringup (
    // Clocks
    input           CLK_125M,

    input           CLK_R_REFCLK0,
    input           CLK_R_REFCLK1,
    input           CLK_R_REFCLK2,
    input           CLK_R_REFCLK3,
    input           CLK_R_REFCLK4,
    input           CLK_R_REFCLK5,

    inout           I2C_IDT_SCL,
    inout           I2C_IDT_SDA,

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
// I2C

wire i2c_idt_osc_sda_oe;
wire i2c_idt_osc_scl_oe;

assign I2C_IDT_SDA = i2c_idt_osc_sda_oe ? 1'b0 : 1'bz;
assign I2C_IDT_SCL = i2c_idt_osc_scl_oe ? 1'b0 : 1'bz;

//==============================================================================
// qsys

system inst_system (
    .clk_clk                ( CLK_125M                  ),
    .clk_cntr_meas          ( clk_cntr_meas             ),
    .clk_cntr_led_dbg       ( LEDS[2]                   ),
    .led_dbg_export         ( LEDS[1:0]                 ),
    .i2c_idt_osc_sda_in     ( I2C_IDT_SDA               ),
    .i2c_idt_osc_scl_in     ( I2C_IDT_SCL               ),
    .i2c_idt_osc_sda_oe     ( i2c_idt_osc_sda_oe        ),
    .i2c_idt_osc_scl_oe     ( i2c_idt_osc_scl_oe        ),
    .reset_reset_n          ( 1'b1                      )
);

endmodule
