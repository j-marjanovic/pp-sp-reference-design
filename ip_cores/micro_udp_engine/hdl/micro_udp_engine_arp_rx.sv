
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

module micro_udp_engine_arp_rx # (bit [47:0] CONFIG_MAC_ADDR, bit [31:0]
    CONFIG_IP_ADDR
) (
    input wire           clk,
    input wire           reset,

    // RX from Eth layer
    output wire [255:0]  arp_rx_data,
    output wire [4:0]    arp_rx_empty,
    output wire          arp_rx_startofpacket,
    output wire          arp_rx_endofpacket,
    output wire          arp_rx_valid,

    // to ARP table
    output reg           arp_table_insert,
    output reg  [47:0]   arp_table_mac,
    output reg  [31:0]   arp_table_ipv4,

    // to ARP TX
    output reg           arp_reply,
    output reg  [47:0]   arp_reply_tha,
    output reg  [31:0]   arp_reply_tpa
);

import micro_udp_engine_pkg::*;

wire arp_packet_t rx_data_as_arp_packet =
    arp_packet_t'(arp_rx_data[255:255-$size(arp_packet_t)+1]);


always_ff @(posedge clk) begin: proc_state if (reset) begin arp_table_insert <=
    1'b0; arp_reply <= 1'b0; end else begin

        // default
        arp_table_insert <= 1'b0;
        arp_reply <= 1'b0;

        if (arp_rx_valid && arp_rx_startofpacket) begin
            arp_table_insert <= 1'b1;
            arp_table_mac <= rx_data_as_arp_packet.sha;
            arp_table_ipv4 <= rx_data_as_arp_packet.spa;

            if (rx_data_as_arp_packet.htype == 1 &&  // 1 = Ethernet
                    rx_data_as_arp_packet.ptype == 16'h0800 &&  // 0x0800 = IPv4
                    rx_data_as_arp_packet.oper == REQUEST &&
                    rx_data_as_arp_packet.tpa == CONFIG_IP_ADDR) begin

                arp_reply <= 1'b1;
                arp_reply_tha <= rx_data_as_arp_packet.sha;
                arp_reply_tpa <= rx_data_as_arp_packet.spa;
            end
        end
    end
end


endmodule

`default_nettype wire
