
.main clear

if {[file exists work]} {
  vdel -lib work -all
}

# BFMs
set INTEL_QUARUTS_PATH /opt/intelFPGA/20.1

vlog $INTEL_QUARUTS_PATH/ip/altera/sopc_builder_ip/verification/lib/verbosity_pkg.sv
vlog $INTEL_QUARUTS_PATH/ip/altera/sopc_builder_ip/verification/lib/avalon_utilities_pkg.sv
vlog $INTEL_QUARUTS_PATH/ip/altera/sopc_builder_ip/verification/lib/avalon_mm_pkg.sv
vlog $INTEL_QUARUTS_PATH/ip/altera/sopc_builder_ip/verification/altera_avalon_clock_reset_source/altera_avalon_clock_reset_source.sv
vlog $INTEL_QUARUTS_PATH/ip/altera/sopc_builder_ip/verification/altera_avalon_st_sink_bfm/altera_avalon_st_sink_bfm.sv
vlog $INTEL_QUARUTS_PATH/ip/altera/sopc_builder_ip/verification/altera_avalon_mm_master_bfm/altera_avalon_mm_master_bfm.sv

# DUT
vlog ../../hdl/avalon_st_generator.sv

# TB
vlog ../tb/avalon_st_generator_tb.sv

# simulation
vsim work.avalon_st_generator_tb

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


run -all
