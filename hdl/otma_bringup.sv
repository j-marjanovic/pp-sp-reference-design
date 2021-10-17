
`default_nettype none

module otma_bringup (
    // Clocks
    input           CLK_125M,
    input           CLK_QSFP_OSC,
    input           CLK_PCIE1,
    input           CLK_PCIE2,

    // I2C
    inout           I2C_IDT_SCL,
    inout           I2C_IDT_SDA,

    inout           I2C_QSFP0_SCL,
    inout           I2C_QSFP0_SDA,

    inout           I2C_QSFP1_SCL,
    inout           I2C_QSFP1_SDA,

    inout           I2C_MON_SCL,
    inout           I2C_MON_SDA,

    // DDR3
// TODO: only temp, for PCIe test
/*
    output [15:0]   memory_mem_a,
    output [ 2:0]   memory_mem_ba,
    output [ 0:0]   memory_mem_ck,
    output [ 0:0]   memory_mem_ck_n,
    output [ 0:0]   memory_mem_cke,
    output [ 0:0]   memory_mem_cs_n,
    output [ 8:0]   memory_mem_dm,
    output [ 0:0]   memory_mem_ras_n,
    output [ 0:0]   memory_mem_cas_n,
    output [ 0:0]   memory_mem_we_n,
    output          memory_mem_reset_n,
    inout  [71:0]   memory_mem_dq,
    inout  [ 8:0]   memory_mem_dqs,
    inout  [ 8:0]   memory_mem_dqs_n,
    output [ 0:0]   memory_mem_odt,
    input           oct_rzqin,
*/

    // QSFP0
    // input  [3:0]    XCVR_QSFP0_RX,
    // output [3:0]    XCVR_QSFP0_TX,

    // QSFP1
    // input  [3:0]    XCVR_QSFP1_RX,
    // output [3:0]    XCVR_QSFP1_TX,

    // PCIe 1
    input           PCIE1_PERSTN,
    input  [ 7:0]   PCIE1_SERIAL_RX,
    output [ 7:0]   PCIE1_SERIAL_TX,

    // PCIe 2
    //input           PCIE2_PERSTN,
    //input  [ 7:0]   PCIE2_SERIAL_RX,
    //output [ 7:0]   PCIE2_SERIAL_TX,

    // LED
    output [7:0]    LEDS
);


//==============================================================================
// clocks

wire clk_125_int;  // generated by Qsys


//==============================================================================
// blinky

logic [27:0] cntr = 0;

always_ff @(posedge CLK_125M) begin: proc_cntr
    cntr <= cntr + 1'd1;
end

assign LEDS[7] = cntr[26];


//==============================================================================
// clock connections

wire [7:0] clk_cntr_meas = {1'b0, 1'b0, 1'b0, 1'b0, CLK_PCIE2, CLK_PCIE1, CLK_QSFP_OSC, clk_125_int};

//==============================================================================
// I2C

wire i2c_idt_osc_sda_oe;
wire i2c_idt_osc_scl_oe;

assign I2C_IDT_SDA = i2c_idt_osc_sda_oe ? 1'b0 : 1'bz;
assign I2C_IDT_SCL = i2c_idt_osc_scl_oe ? 1'b0 : 1'bz;

wire i2c_qsfp0_sda_oe;
wire i2c_qsfp0_scl_oe;

assign I2C_QSFP0_SDA = i2c_qsfp0_sda_oe ? 1'b0 : 1'bz;
assign I2C_QSFP0_SCL = i2c_qsfp0_scl_oe ? 1'b0 : 1'bz;

wire i2c_qsfp1_sda_oe;
wire i2c_qsfp1_scl_oe;

assign I2C_QSFP1_SDA = i2c_qsfp1_sda_oe ? 1'b0 : 1'bz;
assign I2C_QSFP1_SCL = i2c_qsfp1_scl_oe ? 1'b0 : 1'bz;

wire i2c_mon_sda_oe;
wire i2c_mon_scl_oe;

assign I2C_MON_SDA = i2c_mon_sda_oe ? 1'b0 : 1'bz;
assign I2C_MON_SCL = i2c_mon_scl_oe ? 1'b0 : 1'bz;


//==============================================================================
// DDR3

wire ddr3_mem_status_local_init_done;
wire ddr3_mem_status_local_cal_success;
wire ddr3_mem_status_local_cal_fail;

assign LEDS[6] = ddr3_mem_status_local_init_done;
assign LEDS[5] = ddr3_mem_status_local_cal_success;
// assign LEDS[4] = ddr3_mem_status_local_cal_fail;

//==============================================================================
// PCIe

wire [31:0] pcie_test_in;
assign pcie_test_in[0] = 1'b0;
assign pcie_test_in[4:1] = 4'b1000;
assign pcie_test_in[5] = 1'b0;
assign pcie_test_in[31:6] = 26'h2;

wire pcie_cpu_npor;

//==============================================================================
// qsys

system inst_system (
    .clk_clk                            ( CLK_125M                              ),
    .reset_reset_n                      ( 1'b1                                  ),
    .clk_cntr_meas                      ( clk_cntr_meas                         ),
    .clk_cntr_led_dbg                   ( LEDS[2]                               ),
    .clk_125_clk                        ( clk_125_int                           ),
    .led_dbg_export                     ( LEDS[1:0]                             ),
    .cpu_pcie_npor_export               ( pcie_cpu_npor                         ),
    .i2c_idt_osc_sda_in                 ( I2C_IDT_SDA                           ),
    .i2c_idt_osc_scl_in                 ( I2C_IDT_SCL                           ),
    .i2c_idt_osc_sda_oe                 ( i2c_idt_osc_sda_oe                    ),
    .i2c_idt_osc_scl_oe                 ( i2c_idt_osc_scl_oe                    ),
    .i2c_qsfp_0_sda_in                  ( I2C_QSFP0_SDA                         ),
    .i2c_qsfp_0_scl_in                  ( I2C_QSFP0_SCL                         ),
    .i2c_qsfp_0_sda_oe                  ( i2c_qsfp0_sda_oe                      ),
    .i2c_qsfp_0_scl_oe                  ( i2c_qsfp0_scl_oe                      ),
    .i2c_qsfp_1_sda_in                  ( I2C_QSFP1_SDA                         ),
    .i2c_qsfp_1_scl_in                  ( I2C_QSFP1_SCL                         ),
    .i2c_qsfp_1_sda_oe                  ( i2c_qsfp1_sda_oe                      ),
    .i2c_qsfp_1_scl_oe                  ( i2c_qsfp1_scl_oe                      ),
// TODO: only temp, for PCIe test
/*
    .i2c_mon_sda_in                     ( I2C_MON_SDA                           ),
    .i2c_mon_scl_in                     ( I2C_MON_SCL                           ),
    .i2c_mon_sda_oe                     ( i2c_mon_sda_oe                        ),
    .i2c_mon_scl_oe                     ( i2c_mon_scl_oe                        ),
    .ddr3_mem_status_local_init_done    ( ddr3_mem_status_local_init_done       ),
    .ddr3_mem_status_local_cal_success  ( ddr3_mem_status_local_cal_success     ),
    .ddr3_mem_status_local_cal_fail     ( ddr3_mem_status_local_cal_fail        ),
    .memory_mem_a                       ( memory_mem_a                          ),
    .memory_mem_ba                      ( memory_mem_ba                         ),
    .memory_mem_ck                      ( memory_mem_ck                         ),
    .memory_mem_ck_n                    ( memory_mem_ck_n                       ),
    .memory_mem_cke                     ( memory_mem_cke                        ),
    .memory_mem_cs_n                    ( memory_mem_cs_n                       ),
    .memory_mem_dm                      ( memory_mem_dm                         ),
    .memory_mem_ras_n                   ( memory_mem_ras_n                      ),
    .memory_mem_cas_n                   ( memory_mem_cas_n                      ),
    .memory_mem_we_n                    ( memory_mem_we_n                       ),
    .memory_mem_reset_n                 ( memory_mem_reset_n                    ),
    .memory_mem_dq                      ( memory_mem_dq                         ),
    .memory_mem_dqs                     ( memory_mem_dqs                        ),
    .memory_mem_dqs_n                   ( memory_mem_dqs_n                      ),
    .memory_mem_odt                     ( memory_mem_odt                        ),
    .oct_rzqin                          ( oct_rzqin                             ),
*/
    .pcie1_hip_ctrl_test_in             ( pcie_test_in                          ),
    .pcie1_hip_ctrl_simu_mode_pipe      (                                       ),
    .pcie1_hip_serial_rx_in0            ( PCIE1_SERIAL_RX[0]                    ),
    .pcie1_hip_serial_rx_in1            ( PCIE1_SERIAL_RX[1]                    ),
    .pcie1_hip_serial_rx_in2            ( PCIE1_SERIAL_RX[2]                    ),
    .pcie1_hip_serial_rx_in3            ( PCIE1_SERIAL_RX[3]                    ),
    .pcie1_hip_serial_rx_in4            ( PCIE1_SERIAL_RX[4]                    ),
    .pcie1_hip_serial_rx_in5            ( PCIE1_SERIAL_RX[5]                    ),
    .pcie1_hip_serial_rx_in6            ( PCIE1_SERIAL_RX[6]                    ),
    .pcie1_hip_serial_rx_in7            ( PCIE1_SERIAL_RX[7]                    ),
    .pcie1_hip_serial_tx_out0           ( PCIE1_SERIAL_TX[0]                    ),
    .pcie1_hip_serial_tx_out1           ( PCIE1_SERIAL_TX[1]                    ),
    .pcie1_hip_serial_tx_out2           ( PCIE1_SERIAL_TX[2]                    ),
    .pcie1_hip_serial_tx_out3           ( PCIE1_SERIAL_TX[3]                    ),
    .pcie1_hip_serial_tx_out4           ( PCIE1_SERIAL_TX[4]                    ),
    .pcie1_hip_serial_tx_out5           ( PCIE1_SERIAL_TX[5]                    ),
    .pcie1_hip_serial_tx_out6           ( PCIE1_SERIAL_TX[6]                    ),
    .pcie1_hip_serial_tx_out7           ( PCIE1_SERIAL_TX[7]                    ),
//    .pcie1_led_dbg_export               ( LEDS[3]                               ),
    .pcie1_npor_npor                    ( pcie_cpu_npor                         ),
    .pcie1_npor_pin_perst               ( PCIE1_PERSTN                          ),
    .pcie1_refclk_clk                   ( CLK_PCIE1                             ),
/*
    .pcie2_hip_ctrl_test_in             ( pcie_test_in                          ),
    .pcie2_hip_ctrl_simu_mode_pipe      (                                       ),
    .pcie2_hip_serial_rx_in0            ( PCIE2_SERIAL_RX[0]                    ),
    .pcie2_hip_serial_rx_in1            ( PCIE2_SERIAL_RX[1]                    ),
    .pcie2_hip_serial_rx_in2            ( PCIE2_SERIAL_RX[2]                    ),
    .pcie2_hip_serial_rx_in3            ( PCIE2_SERIAL_RX[3]                    ),
    .pcie2_hip_serial_rx_in4            ( PCIE2_SERIAL_RX[4]                    ),
    .pcie2_hip_serial_rx_in5            ( PCIE2_SERIAL_RX[5]                    ),
    .pcie2_hip_serial_rx_in6            ( PCIE2_SERIAL_RX[6]                    ),
    .pcie2_hip_serial_rx_in7            ( PCIE2_SERIAL_RX[7]                    ),
    .pcie2_hip_serial_tx_out0           ( PCIE2_SERIAL_TX[0]                    ),
    .pcie2_hip_serial_tx_out1           ( PCIE2_SERIAL_TX[1]                    ),
    .pcie2_hip_serial_tx_out2           ( PCIE2_SERIAL_TX[2]                    ),
    .pcie2_hip_serial_tx_out3           ( PCIE2_SERIAL_TX[3]                    ),
    .pcie2_hip_serial_tx_out4           ( PCIE2_SERIAL_TX[4]                    ),
    .pcie2_hip_serial_tx_out5           ( PCIE2_SERIAL_TX[5]                    ),
    .pcie2_hip_serial_tx_out6           ( PCIE2_SERIAL_TX[6]                    ),
    .pcie2_hip_serial_tx_out7           ( PCIE2_SERIAL_TX[7]                    ),
    .pcie2_led_dbg_export               ( LEDS[4]                               ),
    .pcie2_npor_npor                    ( pcie_cpu_npor                         ),
    .pcie2_npor_pin_perst               ( PCIE2_PERSTN                          ),
    .pcie2_refclk_clk                   ( CLK_PCIE2                             ),
*/
);

endmodule

`default_nettype wire
