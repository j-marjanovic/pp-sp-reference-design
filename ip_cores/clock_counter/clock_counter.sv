

module clock_counter (
    // Clock and reset
    input   csi_clk_clk,
    input   rsi_reset_reset,

    // slave interface
    input [8:0]     avs_ctrl_address,
    input           avs_ctrl_read,
    input           avs_ctrl_write,
    output  [31:0]  avs_ctrl_readdata,
    input   [31:0]  avs_ctrl_writedata,
    // input   [ 3:0]  avs_ctrl_byteenable,

    input   [ 7:0]  coe_meas
);

wire clk = csi_clk_clk;

logic [31:0] reg_scratch;

always_ff @(posedge clk) begin: proc_avs_ctrl_readdata
    case (avs_ctrl_address)
        0: avs_ctrl_readdata <= 32'hc10cc272;
        1: avs_ctrl_readdata <= 32'h00010000;
        2: avs_ctrl_readdata <= 32'h00000000;
        3: avs_ctrl_readdata <= reg_scratch;
        default: avs_ctrl_readdata <= 32'hdeadbeef;
    endcase
end


always_ff @(posedge clk) begin: proc_reg_scratch
    if (avs_ctrl_write && (avs_ctrl_address == 3)) begin
        reg_scratch <= avs_ctrl_writedata;
    end
end

endmodule
