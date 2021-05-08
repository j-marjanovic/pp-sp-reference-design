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

module pcie_status_amm (
    input clk,
    input rsi_reset_reset,

    input        [ 3:0] avs_ctrl_address,
    input               avs_ctrl_read,
    output logic [31:0] avs_ctrl_readdata,

    input [1:0] hip_currentspeed_currentspeed,

    input [4:0] hip_status_ltssmstate,
    input [3:0] hip_status_lane_act,
    input       hip_status_dlup
);

  logic [31:0] status_reg;
  logic [31:0] status_reg_s;

  always_ff @(posedge clk) begin : proc_status_reg
    status_reg[1:0]   <= hip_currentspeed_currentspeed;
    status_reg[7:2]   <= 'd0;
    status_reg[12:8]  <= hip_status_ltssmstate;
    status_reg[15:13] <= 'd0;
    status_reg[19:16] <= hip_status_lane_act;
    status_reg[23:20] <= 'd0;
    status_reg[24:24] <= hip_status_dlup;
    status_reg[31:25] <= 'd0;
  end


  always_ff @(posedge clk) begin : proc_status_reg_s
    status_reg_s <= status_reg;
  end

  always_ff @(posedge clk) begin : proc_readdata
    if (avs_ctrl_read) begin
      case (avs_ctrl_address)
        0:       avs_ctrl_readdata <= 32'h2c1e57a7;  // PCIE STAT
        1:       avs_ctrl_readdata <= 32'h00010000;
        4:       avs_ctrl_readdata <= status_reg_s;
        default: avs_ctrl_readdata <= 32'hdeadbeef;
      endcase
    end
  end

endmodule
