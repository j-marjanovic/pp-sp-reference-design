
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
