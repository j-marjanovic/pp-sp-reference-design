
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

package micro_udp_engine_pkg;

// Ethernet

typedef enum bit [15:0] {
    IPV4 = 16'h0800,
    ARP = 16'h0806,
    DOT1Q = 16'h8100,
    LLDP = 16'h88CC
} eth_type_t;

typedef struct packed {
    logic [47:0] dest_mac;
    logic [47:0] source_mac;
    logic [15:0] eth_type;
} eth_frame_hdr_t;

// ARP
typedef enum bit [15:0] {
    REQUEST = 16'h0001,
    REPLY = 16'h0002
} arp_oper_t;

typedef struct packed {
    logic [15:0] htype;
    logic [15:0] ptype;
    logic [7:0] hlen;
    logic [7:0] plen;
    logic [15:0] oper;
    logic [47:0] sha;
    logic [31:0] spa;
    logic [47:0] tha;
    logic [31:0] tpa;
} arp_packet_t;

endpackage;
