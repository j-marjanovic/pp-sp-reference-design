#! /usr/bin/env python3

import os

from vunit.verilog import VUnit

vu = VUnit.from_argv()


lib = vu.add_library("lib")

lib.add_source_files("../hdl/*.sv")
lib.add_source_files("../tb/*.sv")

QUARUTS_ROOTDIR = "/opt/intelFPGA/19.1/"
VIP_DIR = os.path.join(QUARUTS_ROOTDIR, "ip/altera/sopc_builder_ip/verification/")

lib.add_source_files(os.path.join(VIP_DIR, "lib", "verbosity_pkg.sv"))
lib.add_source_files(os.path.join(VIP_DIR, "lib", "avalon_utilities_pkg.sv"))

lib.add_source_files(os.path.join(VIP_DIR, "altera_avalon_clock_reset_source", "*.sv"))
lib.add_source_files(os.path.join(VIP_DIR, "altera_avalon_st_source_bfm", "*.sv"))
lib.add_source_files(os.path.join(VIP_DIR, "altera_avalon_st_sink_bfm", "*.sv"))

vu.set_sim_option("modelsim.init_file.gui", "wave.do")

vu.main()
