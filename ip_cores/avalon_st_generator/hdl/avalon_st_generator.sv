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

module avalon_st_generator (
    // Clock and reset
    input csi_clk_clk,
    input rsi_reset_reset,

    // Control interface
    input      [ 3:0] avs_ctrl_address,
    input             avs_ctrl_read,
    input             avs_ctrl_write,
    output reg [31:0] avs_ctrl_readdata,
    input      [31:0] avs_ctrl_writedata,

    // Avalon source
    output [255:0] aso_data_data,
    output         aso_data_valid,
    input          aso_data_ready
);

  //============================================================================
  // Connections

  wire clk = csi_clk_clk;

  //============================================================================
  // Avalon interface

  logic reg_ctrl_en;
  logic [31:0] reg_scratch;
  logic [31:0] reg_cntr_samples;
  logic reg_cntr_clear;

  always_ff @(posedge clk) begin : proc_avs_ctrl_readdata
    case (avs_ctrl_address)
      0: avs_ctrl_readdata <= 32'ha51579e2;
      1: avs_ctrl_readdata <= 32'h00000100;
      2: avs_ctrl_readdata <= 32'h00000000;
      3: avs_ctrl_readdata <= reg_scratch;
      5: avs_ctrl_readdata <= reg_ctrl_en;
      8: avs_ctrl_readdata <= reg_cntr_samples;
      default: avs_ctrl_readdata <= 32'hdeadbeef;
    endcase
  end

  always_ff @(posedge clk) begin : proc_reg_scratch
    reg_cntr_clear <= 0;
    if (avs_ctrl_write && (avs_ctrl_address == 3)) begin
      reg_scratch <= avs_ctrl_writedata;
    end
    if (avs_ctrl_write && (avs_ctrl_address == 5)) begin
      reg_ctrl_en <= avs_ctrl_writedata[0];
    end
    if (avs_ctrl_write && (avs_ctrl_address == 8)) begin
      reg_cntr_clear <= avs_ctrl_writedata[0];
    end
  end

  //============================================================================
  // reference data

  logic [15:0][15:0] ref_data;

  always_ff @(posedge clk) begin : proc_ref_data
    if (reg_cntr_clear || rsi_reset_reset) begin
      for (int i = 0; i < 16; i++) begin
        ref_data[i] <= i;
      end

    end else begin
      if (aso_data_ready && aso_data_valid) begin
        for (int i = 0; i < 16; i++) begin
          ref_data[i] <= ref_data[i] + 16;
        end
      end
    end
  end

  assign aso_data_data  = ref_data;
  assign aso_data_valid = reg_ctrl_en;

  //============================================================================
  // counters

  always_ff @(posedge clk) begin : proc_cntr
    if (reg_cntr_clear || rsi_reset_reset) begin
      reg_cntr_samples <= 0;
    end else begin
      if (aso_data_valid && aso_data_ready) begin
        reg_cntr_samples <= reg_cntr_samples + 1;
      end
    end
  end

endmodule
