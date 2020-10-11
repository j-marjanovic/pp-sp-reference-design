
`timescale 1ps/1ps

`include "vunit_defines.svh"

module micro_udp_engine_tb;

micro_udp_engine_th inst_th();

`TEST_SUITE begin
    `TEST_SUITE_SETUP begin
        $display("Running test suite setup code");
        inst_th.inst_clk_reset.assert_reset();
        #(50ns);
        inst_th.inst_clk_reset.deassert_reset();
        #(50ns);

    end

    `TEST_CASE("ARP request 1") begin
        logic [111:0] recv_eth_hdr;
        logic [223:0] recv_arp;

        inst_th.inst_l4_src.set_transaction_data(
            256'hFFFFFFFFFFFF3CFDFEA67500080600010800060400013CFDFEA675000A00000A);
        inst_th.inst_l4_src.set_transaction_sop(1);
        inst_th.inst_l4_src.set_transaction_eop(0);
        inst_th.inst_l4_src.set_transaction_empty(5'h00);
        inst_th.inst_l4_src.push_transaction();

        inst_th.inst_l4_src.set_transaction_data(
            256'h0000000000000A000014000000000000000000000000000000000000A8D4A92F);
        inst_th.inst_l4_src.set_transaction_sop(0);
        inst_th.inst_l4_src.set_transaction_eop(1);
        inst_th.inst_l4_src.set_transaction_empty(5'h04);
        inst_th.inst_l4_src.push_transaction();

        inst_th.inst_l4_sink.set_ready(1);

        for (int i = 0; i < 100; i++) begin
            @(posedge inst_th.clk);

            // the response is expected to be 2 words long
            if (inst_th.inst_l4_sink.get_transaction_queue_size() == 2)
                break;

            `CHECK_NOT_EQUAL(i, 99, "Avalon-ST sink (MAC recv) has not received a packet");
        end

        inst_th.inst_l4_sink.pop_transaction();
        `CHECK_EQUAL(inst_th.inst_l4_sink.get_transaction_sop(), 1);
        `CHECK_EQUAL(inst_th.inst_l4_sink.get_transaction_eop(), 0);
        `CHECK_EQUAL(inst_th.inst_l4_sink.get_transaction_empty(), 0);
        recv_eth_hdr = inst_th.inst_l4_sink.get_transaction_data()[255:256-$size(recv_eth_hdr)];
        recv_arp[223:80] = inst_th.inst_l4_sink.get_transaction_data()[255-$size(recv_eth_hdr):0];

        inst_th.inst_l4_sink.pop_transaction();
        `CHECK_EQUAL(inst_th.inst_l4_sink.get_transaction_sop(), 0);
        `CHECK_EQUAL(inst_th.inst_l4_sink.get_transaction_eop(), 1);
        `CHECK_EQUAL(inst_th.inst_l4_sink.get_transaction_empty(), 22);
        recv_arp[79:0] = inst_th.inst_l4_sink.get_transaction_data()[255:176];

        `CHECK_EQUAL(recv_eth_hdr[111:111-47], 48'hFFFFFFFFFFFF, "check dest MAC");
        `CHECK_EQUAL(recv_eth_hdr[111-48:111-48-47], 48'h02ABCD000102, "check src MAC");
        `CHECK_EQUAL(recv_eth_hdr[111-48-48:111-48-48-15], 48'h0806, "check Eth Type");

        `CHECK_EQUAL(recv_arp[223:223-15], 48'h0001, "ARP htype (Eth)");
        `CHECK_EQUAL(recv_arp[111:80], 32'h0A000014, "ARP src procotol addr");
        `CHECK_EQUAL(recv_arp[31:0], 32'h0A00000A, "ARP target procotol addr");

        #(50ns);
    end
end

endmodule