
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
vlog $INTEL_QUARUTS_PATH/ip/altera/sopc_builder_ip/verification/altera_avalon_st_source_bfm/altera_avalon_st_source_bfm.sv
vlog $INTEL_QUARUTS_PATH/ip/altera/sopc_builder_ip/verification/altera_avalon_mm_master_bfm/altera_avalon_mm_master_bfm.sv

# DUT
vlog ../../hdl/avalon_st_checker.sv

# TB
vlog ../tb/avalon_st_checker_tb.sv

# simulation
vsim work.avalon_st_checker_tb

# waveform

add wave -divider "Clock and reset"
add wave \
  sim:/avalon_st_checker_tb/csi_clk_clk \
  sim:/avalon_st_checker_tb/rsi_reset_reset

add wave -divider "Control"
add wave -radix hex \
  sim:/avalon_st_checker_tb/avs_ctrl_address \
  sim:/avalon_st_checker_tb/avs_ctrl_read \
  sim:/avalon_st_checker_tb/avs_ctrl_write \
  sim:/avalon_st_checker_tb/avs_ctrl_readdata \
  sim:/avalon_st_checker_tb/avs_ctrl_writedata

add wave -divider "Data"
add wave -radix hex \
  sim:/avalon_st_checker_tb/asi_data_data \
  sim:/avalon_st_checker_tb/asi_data_valid

add wave -divider "Internal"
add wave -radix hex sim:/avalon_st_checker_tb/DUT/reg_scratch

add wave -position insertpoint  \
sim:/avalon_st_checker_tb/DUT/data_ok

add wave -radix hex  \
sim:/avalon_st_checker_tb/DUT/ref_data

add wave -radix unsigned  \
sim:/avalon_st_checker_tb/DUT/reg_cntr_samples \
sim:/avalon_st_checker_tb/DUT/reg_cntr_ok

run -all
