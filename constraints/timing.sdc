
# Clocks
create_clock -name clk_125 -period 8 [get_ports CLK_125M]

# Exceptions
set_false_path -to [get_ports {LEDS[*]}]
