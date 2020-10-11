
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

module micro_udp_engine_eth_tx # (
    bit [47:0] CONFIG_MAC_ADDR
) (
    input wire            clk,
    input wire            reset,

    // from ARP TX
    input  wire [255:0]   arp_tx_data,
    input  wire [4:0]     arp_tx_empty,
    input  wire           arp_tx_startofpacket,
    input  wire           arp_tx_endofpacket,
    output logic          arp_tx_ready,
    input  wire           arp_tx_valid,

    // to MAC
    output logic [255:0]  l4_tx_data,
    output logic [4:0]    l4_tx_empty,
    output logic          l4_tx_startofpacket,
    output logic          l4_tx_endofpacket,
    input  wire           l4_tx_ready,
    output logic          l4_tx_valid
);

import micro_udp_engine_pkg::*;

eth_frame_hdr_t eth_frame_hdr;

initial begin: init_eth_frame_hdr
    eth_frame_hdr.source_mac = CONFIG_MAC_ADDR;
end

//==============================================================================

logic [255:0] arp_tx_data_prev;
logic         arp_tx_eop_prev;
logic   [5:0] arp_tx_empty_prev;

always_ff @(posedge clk) begin: proc_arp_tx_prev
    if (arp_tx_valid && arp_tx_ready) begin
        arp_tx_data_prev <= arp_tx_data;
        arp_tx_eop_prev <= arp_tx_endofpacket;
        arp_tx_empty_prev <= arp_tx_empty;
    end
end

//==============================================================================

enum int unsigned {
    S_IDLE,
    S_ARP_HDR,
    S_ARP,
    S_IPV4_HDR,
    S_IPV4
} state;

always_ff @(posedge clk) begin: proc_fsm
    if (reset) begin
        state <= S_IDLE;
    end else begin
        case (state)
            S_IDLE: begin
                if (arp_tx_valid) begin
                    eth_frame_hdr.dest_mac <= 48'hFF_FF_FF_FF_FF_FF;
                    eth_frame_hdr.eth_type <= ARP;
                    state <= S_ARP_HDR;
                end
            end
            S_ARP_HDR: begin
                if (l4_tx_ready)
                    state <= S_ARP;
            end
            S_ARP: begin
                if (l4_tx_ready) begin
                    if (arp_tx_eop_prev && (arp_tx_empty_prev < $size(eth_frame_hdr_t) / 8))
                        state <= S_IDLE;
                    else if (arp_tx_endofpacket)
                        state <= S_IDLE;
                end

            end
        endcase
    end
end

always_comb begin: proc_fsm_out
    case (state)
        S_IDLE: begin
            arp_tx_ready <= 0;
            l4_tx_data <= 256'd0;
            l4_tx_empty <= 5'd0;
            l4_tx_startofpacket <= 1'b0;
            l4_tx_endofpacket <= 1'b0;
            l4_tx_valid <= 1'b0;
        end
        S_ARP_HDR: begin
            arp_tx_ready <= 1;
            l4_tx_data <= {eth_frame_hdr, arp_tx_data[255:$size(eth_frame_hdr_t)]};
            l4_tx_empty <= 5'd0;
            l4_tx_startofpacket <= 1'b1;
            l4_tx_endofpacket <= 1'b0;
            l4_tx_valid <= 1'b1;
        end
        S_ARP: begin
            arp_tx_ready <= l4_tx_ready;

            l4_tx_data <= {arp_tx_data_prev[$size(eth_frame_hdr_t)-1:0],
                arp_tx_data[255:$size(eth_frame_hdr_t)]};
            l4_tx_valid <= 1'b1;
            l4_tx_startofpacket <= 1'b0;

            if (arp_tx_eop_prev && (arp_tx_empty_prev < $size(eth_frame_hdr_t) / 8)) begin
                l4_tx_endofpacket <= 1'b1;
                l4_tx_empty <= arp_tx_empty_prev - $size(eth_frame_hdr_t) / 8;
            end else begin
                l4_tx_empty <= arp_tx_endofpacket ?
                                arp_tx_empty - $size(eth_frame_hdr_t) / 8 :
                                0;
                l4_tx_endofpacket <= arp_tx_endofpacket;
            end
        end
    endcase
end

endmodule

`default_nettype wire
