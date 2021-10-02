/*
Copyright (c) 2021 Jan Marjanovic

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 */


`timescale 1ps / 1ps

module avalon_st_checker_tb;

  import avalon_mm_pkg::*;

  //============================================================================
  // wires

  // Clock and reset
  wire         csi_clk_clk;
  wire         rsi_reset_reset;

  // Control interface
  wire [  3:0] avs_ctrl_address;
  wire         avs_ctrl_read;
  wire         avs_ctrl_write;
  wire [ 31:0] avs_ctrl_readdata;
  wire [ 31:0] avs_ctrl_writedata;

  // Avalon stream
  wire [255:0] asi_data_data;
  wire         asi_data_valid;

  //============================================================================
  // module

  avalon_st_checker DUT (
      .csi_clk_clk,
      .rsi_reset_reset,
      .avs_ctrl_address,
      .avs_ctrl_read,
      .avs_ctrl_write,
      .avs_ctrl_readdata,
      .avs_ctrl_writedata,
      .asi_data_data,
      .asi_data_valid
  );

  altera_avalon_clock_reset_source clk_rst_source (
      .clk(csi_clk_clk),
      .reset(rsi_reset_reset),
      .dummy_src(),
      .dummy_snk()
  );

  altera_avalon_mm_master_bfm #(
      .AV_ADDRESS_W            (4),
      .AV_SYMBOL_W             (8),
      .AV_NUMSYMBOLS           (4),
      .AV_BURSTCOUNT_W         (1),
      .AV_READRESPONSE_W       (1),
      .AV_WRITERESPONSE_W      (1),
      .USE_READ                (1),
      .USE_WRITE               (1),
      .USE_ADDRESS             (1),
      .USE_BYTE_ENABLE         (0),
      .USE_BURSTCOUNT          (0),
      .USE_READ_DATA           (1),
      .USE_READ_DATA_VALID     (0),
      .USE_WRITE_DATA          (1),
      .USE_BEGIN_TRANSFER      (0),
      .USE_BEGIN_BURST_TRANSFER(0),
      .USE_WAIT_REQUEST        (0),
      .USE_ARBITERLOCK         (0),
      .USE_LOCK                (0),
      .USE_DEBUGACCESS         (0),
      .USE_TRANSACTIONID       (0),
      .USE_WRITERESPONSE       (0),
      .USE_READRESPONSE        (0),
      .USE_CLKEN               (0),
      .AV_FIX_READ_LATENCY     (1),
      .AV_READ_WAIT_TIME       (1)
  ) amm_master (
      .clk(csi_clk_clk),
      .reset(rsi_reset_reset),
      .avm_clken(),
      .avm_waitrequest(),
      .avm_write(avs_ctrl_write),
      .avm_read(avs_ctrl_read),
      .avm_address(avs_ctrl_address),
      .avm_byteenable(),
      .avm_burstcount(),
      .avm_beginbursttransfer(),
      .avm_begintransfer(),
      .avm_writedata(avs_ctrl_writedata),
      .avm_readdata(avs_ctrl_readdata),
      .avm_readdatavalid(),
      .avm_arbiterlock(),
      .avm_lock(),
      .avm_debugaccess(),
      .avm_transactionid(),
      .avm_readresponse(),
      .avm_readid(),
      .avm_writeresponserequest(),
      .avm_writeresponsevalid(),
      .avm_writeresponse(),
      .avm_writeid(),
      .avm_response()
  );

  altera_avalon_st_source_bfm #(
      .ST_SYMBOL_W     (8),
      .ST_NUMSYMBOLS   (256 / 8),
      .ST_CHANNEL_W    (1),
      .ST_ERROR_W      (1),
      .ST_EMPTY_W      (1),
      .ST_READY_LATENCY(0),
      .ST_MAX_CHANNELS (1),
      .USE_PACKET      (0),
      .USE_CHANNEL     (0),
      .USE_ERROR       (0),
      .USE_READY       (0),
      .USE_VALID       (1),
      .USE_EMPTY       (0),
      .ST_BEATSPERCYCLE(1)
  ) ast_data (
      .clk(csi_clk_clk),
      .reset(rsi_reset_reset),
      .src_data(asi_data_data),
      .src_channel(),
      .src_valid(asi_data_valid),
      .src_startofpacket(),
      .src_endofpacket(),
      .src_error(),
      .src_empty(),
      .src_ready(1'b1)
  );

  //============================================================================
  // tasks

  task write_control(input bit [31:0] addr, input logic [31:0] data);
    amm_master.set_command_address(addr / 4);
    amm_master.set_command_data(data, 0);
    amm_master.set_command_request(REQ_WRITE);
    amm_master.push_command();

    @amm_master.signal_all_transactions_complete;
    amm_master.pop_response();
  endtask

  task read_control(input bit [31:0] addr, output logic [31:0] data);
    amm_master.set_command_address(addr / 4);
    amm_master.set_command_request(REQ_READ);
    amm_master.push_command();

    @amm_master.signal_read_response_complete;
    amm_master.pop_response();
    data = amm_master.get_response_data(0);
  endtask

  //============================================================================
  // main

  initial begin : proc_main
    logic [31:0] tmp;

    @(negedge rsi_reset_reset);
    #(100ns);

    read_control('h0, tmp);
    $display("%t id reg = %x", $time, tmp);

    read_control('h4, tmp);
    $display("%t version reg = %x", $time, tmp);

    write_control('hc, 'habcd_1234);
    read_control('hc, tmp);
    $display("%t scratch reg = %x", $time, tmp);


    ast_data.set_transaction_data(
        'h000f000e000d000c000b000a0009000800070006000500040003000200010000);
    ast_data.push_transaction();
    ast_data.set_transaction_data(
        'h001f001e001d001c001b001a0019001800170016001500140013001200110010);
    ast_data.push_transaction();
    ast_data.set_transaction_data(
        'h002f002e002d002c002b002a0029002800270026002500240023002200210020);
    ast_data.push_transaction();
    ast_data.set_transaction_data(
        'h003f003e003d003c003b003a0039003800370036003500340033003200310030);
    ast_data.push_transaction();
    #(100ns);

    read_control('h10, tmp);
    $display("%t cntr samples = %x", $time, tmp);
    assert (tmp == 4);

    read_control('h14, tmp);
    $display("%t cntr OK      = %x", $time, tmp);
    assert (tmp == 4);


    write_control('h10, 1);
    #(20ns);

    ast_data.set_transaction_data(
        'h000f000e000d000c000b000a0009000800070006000500040003000200010000);
    ast_data.push_transaction();
    ast_data.set_transaction_data(
        'h001f001e001d001c001b001a0019001800170016001500140013001200110010);
    ast_data.push_transaction();
    ast_data.set_transaction_data(
        'h002f002e002d002c002b002a0029002800270026002500240023002200210020 ^ 'h100000);
    ast_data.push_transaction();
    ast_data.set_transaction_data(
        'h003f003e003d003c003b003a0039003800370036003500340033003200310030);
    ast_data.push_transaction();
    #(100ns);

    read_control('h10, tmp);
    $display("%t cntr samples = %x", $time, tmp);
    assert (tmp == 4);

    read_control('h14, tmp);
    $display("%t cntr OK      = %x", $time, tmp);
    assert (tmp == 3);

    #(100ns);
    $finish;
  end

endmodule
