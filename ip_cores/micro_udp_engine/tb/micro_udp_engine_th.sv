
`default_nettype none

module micro_udp_engine_th;

// Clock and reset
wire          clk;
wire          reset;

// RX from MAC
wire [255:0]  l4_rx_data;
wire [4:0]    l4_rx_empty;
wire          l4_rx_startofpacket;
wire          l4_rx_endofpacket;
wire          l4_rx_error;
wire          l4_rx_valid;
wire          l4_rx_fcs_valid;    // Purposedly Shoddy: not driven
wire          l4_rx_fcs_error;    // Purposedly Shoddy: not driven

// TX to MAC
wire [255:0]  l4_tx_data;
wire [4:0]    l4_tx_empty;
wire          l4_tx_startofpacket;
wire          l4_tx_endofpacket;
wire          l4_tx_ready;
wire          l4_tx_valid;

micro_udp_engine #(
    .CONFIG_MAC_ADDR (48'h02_AB_CD_00_01_02),
    .CONFIG_IP_ADDR  (32'h0A_00_00_14)
) DUT(
  .clk,
  .reset,

  // RX from MAC
  .l4_rx_data,
  .l4_rx_empty,
  .l4_rx_startofpacket,
  .l4_rx_endofpacket,
  .l4_rx_error,
  .l4_rx_valid,
  .l4_rx_fcs_valid,
  .l4_rx_fcs_error,

  // TX to MAC
  .l4_tx_data,
  .l4_tx_empty,
  .l4_tx_startofpacket,
  .l4_tx_endofpacket,
  .l4_tx_ready,
  .l4_tx_valid
);

altera_avalon_clock_reset_source inst_clk_reset (
  .clk,
  .reset,
  .dummy_src(),
  .dummy_snk()
);

altera_avalon_st_source_bfm #(
  .ST_SYMBOL_W        (   8 ),
  .ST_NUMSYMBOLS      (  32 ),
  .ST_CHANNEL_W       (   0 ),
  .ST_ERROR_W         (   0 ),
  .ST_EMPTY_W         (   5 ),
  .ST_READY_LATENCY   (   0 ),
  .ST_MAX_CHANNELS    (   1 ),
  .USE_PACKET         (   1 ),
  .USE_CHANNEL        (   0 ),
  .USE_ERROR          (   0 ),
  .USE_READY          (   0 ),
  .USE_VALID          (   1 ),
  .USE_EMPTY          (   1 )
) inst_l4_src (
  .clk,
  .reset,
  .src_data           ( l4_rx_data          ),
  .src_channel        (                     ),
  .src_valid          ( l4_rx_valid         ),
  .src_startofpacket  ( l4_rx_startofpacket ),
  .src_endofpacket    ( l4_rx_endofpacket   ),
  .src_error          ( l4_rx_error         ),
  .src_empty          ( l4_rx_empty         ),
  .src_ready          (                     )
);

altera_avalon_st_sink_bfm #(
  .ST_SYMBOL_W        (   8 ),
  .ST_NUMSYMBOLS      (  32 ),
  .ST_CHANNEL_W       (   0 ),
  .ST_ERROR_W         (   0 ),
  .ST_EMPTY_W         (   5 ),
  .ST_READY_LATENCY   (   0 ),
  .ST_MAX_CHANNELS    (   1 ),
  .USE_PACKET         (   1 ),
  .USE_CHANNEL        (   0 ),
  .USE_ERROR          (   0 ),
  .USE_READY          (   1 ),
  .USE_VALID          (   1 ),
  .USE_EMPTY          (   1 )
) inst_l4_sink (
  .clk,
  .reset,
  .sink_data          ( l4_tx_data          ),
  .sink_channel       (                     ),
  .sink_valid         ( l4_tx_valid         ),
  .sink_startofpacket ( l4_tx_startofpacket ),
  .sink_endofpacket   ( l4_tx_endofpacket   ),
  .sink_error         (                     ),
  .sink_empty         ( l4_tx_empty         ),
  .sink_ready         ( l4_tx_ready         )
);

endmodule

`default_nettype wire
