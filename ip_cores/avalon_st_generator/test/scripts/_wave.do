
# waveform

add wave -divider "Clock and reset"
add wave \
  sim:/avalon_st_generator_tb/csi_clk_clk \
  sim:/avalon_st_generator_tb/rsi_reset_reset

add wave -divider "Control"
add wave -radix hex \
  sim:/avalon_st_generator_tb/avs_ctrl_address \
  sim:/avalon_st_generator_tb/avs_ctrl_read \
  sim:/avalon_st_generator_tb/avs_ctrl_write \
  sim:/avalon_st_generator_tb/avs_ctrl_readdata \
  sim:/avalon_st_generator_tb/avs_ctrl_writedata

add wave -divider "Data"
add wave -radix hex \
  sim:/avalon_st_generator_tb/aso_data_data \
  sim:/avalon_st_generator_tb/aso_data_valid \
  sim:/avalon_st_generator_tb/aso_data_ready

add wave -divider "Internal"

add wave \
  sim:/avalon_st_generator_tb/DUT/state
