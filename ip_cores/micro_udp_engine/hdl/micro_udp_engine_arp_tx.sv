
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

module micro_udp_engine_arp_tx # (
    bit [47:0] CONFIG_MAC_ADDR,
    bit [31:0] CONFIG_IP_ADDR
) (
    input wire           clk,
    input wire           reset,

    // from ARP RX
    input wire           arp_reply,
    input wire  [47:0]   arp_reply_tha,
    input wire  [31:0]   arp_reply_tpa,

    // to Eth TX
    output wire [255:0]  arp_tx_data,
    output wire [4:0]    arp_tx_empty,
    output wire          arp_tx_startofpacket,
    output wire          arp_tx_endofpacket,
    input  wire          arp_tx_ready,
    output wire          arp_tx_valid
);

import micro_udp_engine_pkg::*;

arp_packet_t arp_packet_reply;

initial begin: proc_init_pkt
    arp_packet_reply.htype = 16'h0001;  // Ethernet
    arp_packet_reply.ptype = 16'h0800;  // IPv4
    arp_packet_reply.hlen = 8'h6;  // 6 octets
    arp_packet_reply.plen = 8'h4;  // 4 octets
    arp_packet_reply.oper = 16'h0002; // reply
    arp_packet_reply.sha = CONFIG_MAC_ADDR;
    arp_packet_reply.spa = CONFIG_IP_ADDR;
end

enum int unsigned {
    S_IDLE,
    S_TX
} state;

always_ff @(posedge clk) begin: proc_state
    if (reset) begin
        state <= S_IDLE;
    end else begin
        case (state)
            S_IDLE: begin
                if (arp_reply) begin
                    arp_packet_reply.tha <= arp_reply_tha;
                    arp_packet_reply.tpa <= arp_reply_tpa;
                    state <= S_TX;
                end
            end
            S_TX: begin
                if (arp_tx_ready) begin
                    state <= S_IDLE;
                end
            end
        endcase
    end
end


// output
assign arp_tx_data = {arp_packet_reply, {(256-$size(arp_packet_t)){1'b0}}};
assign arp_tx_empty = (256-$size(arp_packet_t)) / 8;
assign arp_tx_startofpacket = state == S_TX;
assign arp_tx_endofpacket = state == S_TX;
assign arp_tx_valid = state == S_TX;


endmodule

`default_nettype wire
