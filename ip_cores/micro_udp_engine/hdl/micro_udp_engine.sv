
/*

Copyright (c) 2020, Jan Marjanovic

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:
* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this
  list of conditions and the following disclaimer in the documentation and/or
  other materials provided with the distribution.
* Neither the name of the <organization> nor the names of its contributors may
  be used to endorse or promote products derived from this software without
  specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/

`default_nettype none

module micro_udp_engine #(
    bit [47:0] CONFIG_MAC_ADDR,
    bit [31:0] CONFIG_IP_ADDR
) (
    // Clock and reset
    input  wire         clk,
    input  wire         reset,

    // RX from MAC
    input  wire [255:0]  l4_rx_data,
    input  wire [4:0]    l4_rx_empty,
    input  wire          l4_rx_startofpacket,
    input  wire          l4_rx_endofpacket,
    input  wire          l4_rx_error,
    input  wire          l4_rx_valid,
    input  wire          l4_rx_fcs_valid,
    input  wire          l4_rx_fcs_error,

    // TX to MAC
    output wire [255:0]  l4_tx_data,
    output wire [4:0]    l4_tx_empty,
    output wire          l4_tx_startofpacket,
    output wire          l4_tx_endofpacket,
    input  wire          l4_tx_ready,
    output wire          l4_tx_valid
);

wire [255:0]  arp_rx_data;
wire [4:0]    arp_rx_empty;
wire          arp_rx_startofpacket;
wire          arp_rx_endofpacket;
wire          arp_rx_valid;

wire          arp_table_insert;
wire  [47:0]  arp_table_mac;
wire  [31:0]  arp_table_ipv4;

wire          arp_reply;
wire  [47:0]  arp_reply_tha;
wire  [31:0]  arp_reply_tpa;

wire [255:0]  arp_tx_data;
wire [4:0]    arp_tx_empty;
wire          arp_tx_startofpacket;
wire          arp_tx_endofpacket;
wire          arp_tx_ready;
wire          arp_tx_valid;


// TODO: add MAC, check for MAC addr
micro_udp_engine_eth_rx inst_eth_rx (
    .clk,
    .reset,
    .l4_rx_data,
    .l4_rx_empty,
    .l4_rx_startofpacket,
    .l4_rx_endofpacket,
    .l4_rx_error,
    .l4_rx_valid,
    .arp_rx_data,
    .arp_rx_empty,
    .arp_rx_startofpacket,
    .arp_rx_endofpacket,
    .arp_rx_valid
);

micro_udp_engine_eth_tx  # (
    .CONFIG_MAC_ADDR (CONFIG_MAC_ADDR)
) inst_eth_tx (
    .clk,
    .reset,
    .arp_tx_data,
    .arp_tx_empty,
    .arp_tx_startofpacket,
    .arp_tx_endofpacket,
    .arp_tx_ready,
    .arp_tx_valid,
    .l4_tx_data,
    .l4_tx_empty,
    .l4_tx_startofpacket,
    .l4_tx_endofpacket,
    .l4_tx_ready,
    .l4_tx_valid
);

micro_udp_engine_arp_rx # (
    .CONFIG_MAC_ADDR (CONFIG_MAC_ADDR),
    .CONFIG_IP_ADDR  (CONFIG_IP_ADDR)
) inst_arp_rx (
    .clk,
    .reset,
    .arp_rx_data,
    .arp_rx_empty,
    .arp_rx_startofpacket,
    .arp_rx_endofpacket,
    .arp_rx_valid,
    .arp_table_insert,
    .arp_table_mac,
    .arp_table_ipv4,
    .arp_reply,
    .arp_reply_tha,
    .arp_reply_tpa
);

micro_udp_engine_arp_tx # (
    .CONFIG_MAC_ADDR (CONFIG_MAC_ADDR),
    .CONFIG_IP_ADDR  (CONFIG_IP_ADDR)
) inst_arp_tx (
    .clk,
    .reset,
    .arp_reply,
    .arp_reply_tha,
    .arp_reply_tpa,
    .arp_tx_data,
    .arp_tx_empty,
    .arp_tx_startofpacket,
    .arp_tx_endofpacket,
    .arp_tx_ready,
    .arp_tx_valid
);


endmodule

`default_nettype wire
