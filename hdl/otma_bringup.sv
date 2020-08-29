

module otma_bringup (
    input           CLK_125M,
    output [7:0]    LEDS
);

logic [27:0] cntr = 0;

always_ff @(posedge CLK_125M) begin: proc_cntr
    cntr <= cntr + 1'd1;
end

assign LEDS = cntr[27:20];

endmodule
