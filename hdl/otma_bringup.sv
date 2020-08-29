

module otma_bringup (
    // Clocks
    input           CLK_125M,

    // LED
    output [7:0]    LEDS
);

logic [27:0] cntr = 0;

always_ff @(posedge CLK_125M) begin: proc_cntr
    cntr <= cntr + 1'd1;
end

assign LEDS[7] = cntr[27];
assign LEDS[6:2] = 'd0;

system inst_system (
    .clk_clk                ( CLK_125M                  ),
    .clk_cntr_export        ( 8'd0                      ),
    .led_dbg_export         ( LEDS[1:0]                 ),
    .reset_reset_n          ( 1'b1                      )
);

endmodule
