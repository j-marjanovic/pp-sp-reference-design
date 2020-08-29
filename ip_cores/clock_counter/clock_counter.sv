

module clock_counter # (
    parameter int CLK_FREQ = 125000000
) (
    // Clock and reset
    input           csi_clk_clk,
    input           rsi_reset_reset,

    // slave interface
    input   [3:0]   avs_ctrl_address,
    input           avs_ctrl_read,
    input           avs_ctrl_write,
    output  [31:0]  avs_ctrl_readdata,
    input   [31:0]  avs_ctrl_writedata,

    // measurements inputs
    input   [ 7:0]  coe_meas,

    // debug led
    output          coe_led_dbg
);

//==============================================================================
// Connections

wire clk = csi_clk_clk;

//==============================================================================
// Avalon interface

logic [31:0] reg_scratch;
logic [31:0] reg_clk_meas [0:7];


always_ff @(posedge clk) begin: proc_avs_ctrl_readdata
    case (avs_ctrl_address)
         0: avs_ctrl_readdata <= 32'hc10cc272;
         1: avs_ctrl_readdata <= 32'h00010000;
         2: avs_ctrl_readdata <= 32'h00000000;
         3: avs_ctrl_readdata <= reg_scratch;
         4: avs_ctrl_readdata <= reg_clk_meas[0];
         5: avs_ctrl_readdata <= reg_clk_meas[1];
         6: avs_ctrl_readdata <= reg_clk_meas[2];
         7: avs_ctrl_readdata <= reg_clk_meas[3];
         8: avs_ctrl_readdata <= reg_clk_meas[4];
         9: avs_ctrl_readdata <= reg_clk_meas[5];
        10: avs_ctrl_readdata <= reg_clk_meas[6];
        11: avs_ctrl_readdata <= reg_clk_meas[7];
        default: avs_ctrl_readdata <= 32'hdeadbeef;
    endcase
end

always_ff @(posedge clk) begin: proc_reg_scratch
    if (avs_ctrl_write && (avs_ctrl_address == 3)) begin
        reg_scratch <= avs_ctrl_writedata;
    end
end

//==============================================================================
// 1 Hz pulse

logic pulse_1hz = 1'b0;
logic [$clog2(CLK_FREQ)-1:0] cntr_pulse_1hz = 'd0;

assign coe_led_dbg = pulse_1hz;

always_ff @(posedge clk) begin: proc_pulse_1hz
    if (cntr_pulse_1hz < CLK_FREQ-1) begin
        cntr_pulse_1hz <= cntr_pulse_1hz + 1'd1;
    end else begin
        cntr_pulse_1hz <= 0;
        pulse_1hz <= !pulse_1hz;
    end
end

//==============================================================================
// counters

logic pulse_1hz_p[0:7], pulse_1hz_pp[0:7], pulse_1hz_ppp[0:7];
logic [31:0] clk_cntr[0:7];

genvar i;

generate
    for (i = 0; i < 8; i++) begin: gen_cntr
        always_ff @(posedge coe_meas[i]) begin: proc_pulse_sync
            pulse_1hz_p[i]   <= pulse_1hz;
            pulse_1hz_pp[i]  <= pulse_1hz_p[i];
            pulse_1hz_ppp[i] <= pulse_1hz_pp[i];
        end

        always_ff @(posedge coe_meas[i]) begin: proc_cntr
            if (pulse_1hz_ppp[i] != pulse_1hz_pp[i]) begin
                clk_cntr[i] <= 0;
                reg_clk_meas[i] <= clk_cntr[i];  // store measurement
            end else begin
                clk_cntr[i] <= clk_cntr[i] + 1;
            end
        end
    end
endgenerate

endmodule
