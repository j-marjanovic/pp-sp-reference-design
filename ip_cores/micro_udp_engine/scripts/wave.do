
add wave -divider "Clock and reset"
add wave  \
sim:/micro_udp_engine_tb/inst_th/clk \
sim:/micro_udp_engine_tb/inst_th/reset

add wave -divider "RX from MAC"
add wave -radix hex \
sim:/micro_udp_engine_tb/inst_th/l4_rx_data \
sim:/micro_udp_engine_tb/inst_th/l4_rx_empty \
sim:/micro_udp_engine_tb/inst_th/l4_rx_startofpacket \
sim:/micro_udp_engine_tb/inst_th/l4_rx_endofpacket \
sim:/micro_udp_engine_tb/inst_th/l4_rx_error \
sim:/micro_udp_engine_tb/inst_th/l4_rx_valid \
sim:/micro_udp_engine_tb/inst_th/l4_rx_fcs_valid \
sim:/micro_udp_engine_tb/inst_th/l4_rx_fcs_error

add wave -divider "TX to MAC"
add wave -radix hex \
sim:/micro_udp_engine_tb/inst_th/l4_tx_data \
sim:/micro_udp_engine_tb/inst_th/l4_tx_empty \
sim:/micro_udp_engine_tb/inst_th/l4_tx_startofpacket \
sim:/micro_udp_engine_tb/inst_th/l4_tx_endofpacket \
sim:/micro_udp_engine_tb/inst_th/l4_tx_ready \
sim:/micro_udp_engine_tb/inst_th/l4_tx_valid

add wave -divider "Eth RX debug"
add wave -position insertpoint  \
sim:/micro_udp_engine_tb/inst_th/DUT/inst_eth_rx/state
