
.main clear

do ./_compile.do

# simulation
vsim -g DATA_W=256 work.avalon_st_generator_tb

# waveform
do ./_wave.do

run -all
