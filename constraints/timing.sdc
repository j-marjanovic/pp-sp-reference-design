
# Clocks
#create_clock -name clk_125 -period 8 [get_ports CLK_125M]
create_clock -name clk_xcvr_ref -period 1.551 [get_ports CLK_QSFP_OSC]
create_clock -name clk_pcie1 -period 10 [get_ports CLK_PCIE1]
create_clock -name clk_pcie2 -period 10 [get_ports CLK_PCIE2]

derive_pll_clocks
derive_clock_uncertainty

# Exceptions
set_false_path -to [get_ports {LEDS[*]}]

set_false_path -to {system:inst_system|clock_counter:clock_counter_0|reg_clk_meas[*][*]}
set_false_path -to {system:inst_system|clock_counter:clock_counter_0|pulse_1hz_p[*]}
set_false_path -to {system:inst_system|clock_counter:clock_counter_0|avs_ctrl_readdata[*]}

set_false_path -to {inst_system|pcie1_status_amm|status_reg[*]}
set_false_path -to {inst_system|pcie2_status_amm|status_reg[*]}

set_false_path -from {system:inst_system|system_pio_pcie_npor:pio_pcie_npor|data_out}
