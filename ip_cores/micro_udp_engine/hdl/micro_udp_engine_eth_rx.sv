
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

module micro_udp_engine_eth_rx (
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

    // Purposely Shoddy: not discarding corrupted frames
    // input  wire          l4_rx_fcs_valid,
    // input  wire          l4_rx_fcs_error,

    // RX to ARP
    output wire [255:0]  arp_rx_data,
    output wire [4:0]    arp_rx_empty,
    output wire          arp_rx_startofpacket,
    output wire          arp_rx_endofpacket,
    output wire          arp_rx_valid

);

import micro_udp_engine_pkg::*;

//==============================================================================
// Eth header

eth_frame_hdr_t eth_frame_hdr;

wire eth_frame_hdr_t l4_rx_data_as_hdr =
    eth_frame_hdr_t'(l4_rx_data[255:255-$size(eth_frame_hdr_t)+1]);

//==============================================================================
// state machine

enum int unsigned {
    S_HDR,
    S_ARP,
    S_IPV4,
    S_DROP
} state;

always_ff @(posedge clk) begin: proc_state
    if (reset) begin
        state <= S_HDR;
    end else begin
        case (state)
            S_HDR: begin
                if (l4_rx_startofpacket && l4_rx_valid) begin
                    eth_frame_hdr <= l4_rx_data_as_hdr;
                    case (l4_rx_data_as_hdr.eth_type)
                        IPV4: state <= S_IPV4;
                        ARP: state <= S_ARP;
                        default: state <= S_DROP;
                    endcase
                end
            end
            S_IPV4: begin
                if (l4_rx_endofpacket) begin
                    state <= S_HDR;
                end
            end
            S_ARP: begin
                if (l4_rx_endofpacket) begin
                    state <= S_HDR;
                end
            end
            S_DROP: begin
                if (l4_rx_endofpacket) begin
                    state <= S_HDR;
                end
            end
        endcase
    end
end


//==============================================================================
// data re-align (after we strip out header)

// store remaining part of the header/prev packet
logic [255-$size(eth_frame_hdr_t):0] eth_frame_rest;

wire [255:0] rx_data_realign;
logic        rx_sop_realign;
logic        rx_eop_realign;
logic        rx_valid_realign;
logic [5:0]  rx_empty_realign;

assign rx_data_realign = {eth_frame_rest, l4_rx_data[255:255-$size(eth_frame_hdr_t)+1]};

always_ff @(posedge clk) begin: proc_data_realign
    if (l4_rx_valid)
        eth_frame_rest <= l4_rx_data[$size(eth_frame_rest)-1:0];

    rx_sop_realign <= l4_rx_startofpacket;
    rx_eop_realign <= l4_rx_endofpacket;
    rx_valid_realign <= l4_rx_valid;

    // Purposely Shoddy: does not handle underflow correctly
    rx_empty_realign <= l4_rx_endofpacket ? (l4_rx_empty - 1) : 'd0;
end


//==============================================================================
// ARP output

assign arp_rx_data = rx_data_realign;
assign arp_rx_empty = rx_empty_realign;
assign arp_rx_startofpacket = rx_sop_realign;
assign arp_rx_endofpacket = rx_eop_realign;
assign arp_rx_valid = (state == S_ARP) ? rx_valid_realign : 0;


endmodule

`default_nettype wire
