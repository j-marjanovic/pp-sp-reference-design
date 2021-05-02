module MemCheckerAxiSlave(
  input         clock,
  input         reset,
  output        io_ctrl_AW_ready,
  input         io_ctrl_AW_valid,
  input  [7:0]  io_ctrl_AW_bits_addr,
  output        io_ctrl_W_ready,
  input         io_ctrl_W_valid,
  input  [31:0] io_ctrl_W_bits_wdata,
  input         io_ctrl_B_ready,
  output        io_ctrl_B_valid,
  output        io_ctrl_AR_ready,
  input         io_ctrl_AR_valid,
  input  [7:0]  io_ctrl_AR_bits_addr,
  input         io_ctrl_R_ready,
  output        io_ctrl_R_valid,
  output [31:0] io_ctrl_R_bits_rdata,
  output        io_ctrl_dir,
  output [2:0]  io_ctrl_mode,
  output [63:0] io_read_addr,
  output [31:0] io_read_len,
  output        io_read_start,
  input  [31:0] io_rd_stats_resp_cntr,
  input         io_rd_stats_done,
  input  [31:0] io_rd_stats_duration,
  output [63:0] io_write_addr,
  output [31:0] io_write_len,
  output        io_write_start,
  input  [31:0] io_wr_stats_resp_cntr,
  input         io_wr_stats_done,
  input  [31:0] io_wr_stats_duration,
  input  [31:0] io_check_tot,
  input  [31:0] io_check_ok
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [63:0] _RAND_23;
`endif // RANDOMIZE_REG_INIT
  reg  reg_ctrl_dir; // @[MemCheckerAxiSlave.scala 85:29]
  reg [2:0] reg_ctrl_mode; // @[MemCheckerAxiSlave.scala 86:30]
  reg [31:0] reg_read_status; // @[MemCheckerAxiSlave.scala 87:32]
  reg  reg_read_start; // @[MemCheckerAxiSlave.scala 89:31]
  reg [63:0] reg_read_addr; // @[MemCheckerAxiSlave.scala 90:30]
  reg [31:0] reg_read_len; // @[MemCheckerAxiSlave.scala 91:29]
  reg [31:0] reg_read_resp_cntr; // @[MemCheckerAxiSlave.scala 92:35]
  reg [31:0] reg_read_duration; // @[MemCheckerAxiSlave.scala 93:34]
  reg [31:0] reg_write_status; // @[MemCheckerAxiSlave.scala 94:33]
  reg  reg_write_start; // @[MemCheckerAxiSlave.scala 96:32]
  reg [63:0] reg_write_addr; // @[MemCheckerAxiSlave.scala 97:31]
  reg [31:0] reg_write_len; // @[MemCheckerAxiSlave.scala 98:30]
  reg [31:0] reg_write_resp_cntr; // @[MemCheckerAxiSlave.scala 99:36]
  reg [31:0] reg_write_duration; // @[MemCheckerAxiSlave.scala 100:35]
  reg [31:0] reg_check_tot; // @[MemCheckerAxiSlave.scala 101:30]
  reg [31:0] reg_check_ok; // @[MemCheckerAxiSlave.scala 102:29]
  reg  wr_en; // @[MemCheckerAxiSlave.scala 128:18]
  reg [5:0] wr_addr; // @[MemCheckerAxiSlave.scala 129:20]
  wire  _T_20 = 6'h4 == wr_addr; // @[Conditional.scala 37:30]
  wire  _T_23 = 6'h8 == wr_addr; // @[Conditional.scala 37:30]
  reg [31:0] wr_data; // @[MemCheckerAxiSlave.scala 130:20]
  wire [31:0] _GEN_79 = _T_23 ? wr_data : 32'h0; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 237:52 MemCheckerAxiSlave.scala 228:25]
  wire [31:0] _GEN_89 = _T_20 ? 32'h0 : _GEN_79; // @[Conditional.scala 40:58 MemCheckerAxiSlave.scala 228:25]
  wire [31:0] reg_read_status_clear = wr_en ? _GEN_89 : 32'h0; // @[MemCheckerAxiSlave.scala 231:15 MemCheckerAxiSlave.scala 228:25]
  wire [31:0] _T = ~reg_read_status_clear; // @[MemCheckerAxiSlave.scala 113:42]
  wire [31:0] _T_1 = reg_read_status & _T; // @[MemCheckerAxiSlave.scala 113:39]
  wire [31:0] _T_2 = {31'h0,io_rd_stats_done}; // @[Cat.scala 30:58]
  wire [31:0] _T_3 = _T_1 | _T_2; // @[MemCheckerAxiSlave.scala 113:76]
  wire  _T_24 = 6'h9 == wr_addr; // @[Conditional.scala 37:30]
  wire  _T_26 = 6'ha == wr_addr; // @[Conditional.scala 37:30]
  wire  _T_28 = 6'hb == wr_addr; // @[Conditional.scala 37:30]
  wire  _T_30 = 6'hc == wr_addr; // @[Conditional.scala 37:30]
  wire  _T_31 = 6'h18 == wr_addr; // @[Conditional.scala 37:30]
  wire [31:0] _GEN_51 = _T_31 ? wr_data : 32'h0; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 242:54 MemCheckerAxiSlave.scala 229:26]
  wire [31:0] _GEN_56 = _T_30 ? 32'h0 : _GEN_51; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 229:26]
  wire [31:0] _GEN_62 = _T_28 ? 32'h0 : _GEN_56; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 229:26]
  wire [31:0] _GEN_68 = _T_26 ? 32'h0 : _GEN_62; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 229:26]
  wire [31:0] _GEN_75 = _T_24 ? 32'h0 : _GEN_68; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 229:26]
  wire [31:0] _GEN_83 = _T_23 ? 32'h0 : _GEN_75; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 229:26]
  wire [31:0] _GEN_93 = _T_20 ? 32'h0 : _GEN_83; // @[Conditional.scala 40:58 MemCheckerAxiSlave.scala 229:26]
  wire [31:0] reg_write_status_clear = wr_en ? _GEN_93 : 32'h0; // @[MemCheckerAxiSlave.scala 231:15 MemCheckerAxiSlave.scala 229:26]
  wire [31:0] _T_4 = ~reg_write_status_clear; // @[MemCheckerAxiSlave.scala 117:44]
  wire [31:0] _T_5 = reg_write_status & _T_4; // @[MemCheckerAxiSlave.scala 117:41]
  wire [31:0] _T_6 = {31'h0,io_wr_stats_done}; // @[Cat.scala 30:58]
  wire [31:0] _T_7 = _T_5 | _T_6; // @[MemCheckerAxiSlave.scala 117:79]
  reg [1:0] state_wr; // @[MemCheckerAxiSlave.scala 126:25]
  wire  _T_8 = 2'h0 == state_wr; // @[Conditional.scala 37:30]
  wire  _T_9 = io_ctrl_AW_valid & io_ctrl_W_valid; // @[MemCheckerAxiSlave.scala 139:29]
  wire [31:0] _GEN_0 = io_ctrl_W_valid ? io_ctrl_W_bits_wdata : wr_data; // @[MemCheckerAxiSlave.scala 149:36 MemCheckerAxiSlave.scala 150:19 MemCheckerAxiSlave.scala 130:20]
  wire [1:0] _GEN_2 = io_ctrl_W_valid ? 2'h2 : state_wr; // @[MemCheckerAxiSlave.scala 149:36 MemCheckerAxiSlave.scala 152:20 MemCheckerAxiSlave.scala 126:25]
  wire [5:0] _GEN_3 = io_ctrl_AW_valid ? io_ctrl_AW_bits_addr[7:2] : wr_addr; // @[MemCheckerAxiSlave.scala 145:36 MemCheckerAxiSlave.scala 146:19 MemCheckerAxiSlave.scala 129:20]
  wire  _T_12 = 2'h1 == state_wr; // @[Conditional.scala 37:30]
  wire  _T_13 = 2'h2 == state_wr; // @[Conditional.scala 37:30]
  wire [1:0] _GEN_16 = io_ctrl_AW_valid ? 2'h3 : state_wr; // @[MemCheckerAxiSlave.scala 164:30 MemCheckerAxiSlave.scala 167:18 MemCheckerAxiSlave.scala 126:25]
  wire  _T_15 = 2'h3 == state_wr; // @[Conditional.scala 37:30]
  wire [1:0] _GEN_17 = io_ctrl_B_ready ? 2'h0 : state_wr; // @[MemCheckerAxiSlave.scala 171:29 MemCheckerAxiSlave.scala 172:18 MemCheckerAxiSlave.scala 126:25]
  wire [1:0] _GEN_18 = _T_15 ? _GEN_17 : state_wr; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 126:25]
  wire  _GEN_19 = _T_13 & io_ctrl_AW_valid; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 135:9]
  wire  _GEN_36 = _T_12 ? 1'h0 : _T_15; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 197:23]
  wire  _GEN_38 = _T_13 ? 1'h0 : _T_12; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 191:23]
  wire  _GEN_39 = _T_13 ? 1'h0 : _GEN_36; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 192:23]
  wire [31:0] hi = reg_read_addr[63:32]; // @[MemCheckerAxiSlave.scala 239:65]
  wire [63:0] _T_27 = {hi,wr_data}; // @[Cat.scala 30:58]
  wire [31:0] lo = reg_read_addr[31:0]; // @[MemCheckerAxiSlave.scala 240:74]
  wire [63:0] _T_29 = {wr_data,lo}; // @[Cat.scala 30:58]
  wire  _T_32 = 6'h19 == wr_addr; // @[Conditional.scala 37:30]
  wire  _T_34 = 6'h1a == wr_addr; // @[Conditional.scala 37:30]
  wire [31:0] hi_1 = reg_write_addr[63:32]; // @[MemCheckerAxiSlave.scala 244:68]
  wire [63:0] _T_35 = {hi_1,wr_data}; // @[Cat.scala 30:58]
  wire  _T_36 = 6'h1b == wr_addr; // @[Conditional.scala 37:30]
  wire [31:0] lo_1 = reg_write_addr[31:0]; // @[MemCheckerAxiSlave.scala 245:77]
  wire [63:0] _T_37 = {wr_data,lo_1}; // @[Cat.scala 30:58]
  wire  _T_38 = 6'h1c == wr_addr; // @[Conditional.scala 37:30]
  wire [31:0] _GEN_43 = _T_38 ? wr_data : reg_write_len; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 246:42 MemCheckerAxiSlave.scala 98:30]
  wire [63:0] _GEN_44 = _T_36 ? _T_37 : reg_write_addr; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 245:47 MemCheckerAxiSlave.scala 97:31]
  wire [31:0] _GEN_45 = _T_36 ? reg_write_len : _GEN_43; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 98:30]
  wire [63:0] _GEN_46 = _T_34 ? _T_35 : _GEN_44; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 244:47]
  wire [31:0] _GEN_47 = _T_34 ? reg_write_len : _GEN_45; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 98:30]
  wire  _GEN_48 = _T_32 & wr_data[0]; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 243:45 MemCheckerAxiSlave.scala 227:19]
  wire [63:0] _GEN_49 = _T_32 ? reg_write_addr : _GEN_46; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 97:31]
  wire [31:0] _GEN_50 = _T_32 ? reg_write_len : _GEN_47; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 98:30]
  wire  _GEN_52 = _T_31 ? 1'h0 : _GEN_48; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 227:19]
  wire [63:0] _GEN_53 = _T_31 ? reg_write_addr : _GEN_49; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 97:31]
  wire [31:0] _GEN_54 = _T_31 ? reg_write_len : _GEN_50; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 98:30]
  wire [31:0] _GEN_55 = _T_30 ? wr_data : reg_read_len; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 241:40 MemCheckerAxiSlave.scala 91:29]
  wire  _GEN_57 = _T_30 ? 1'h0 : _GEN_52; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 227:19]
  wire [63:0] _GEN_58 = _T_30 ? reg_write_addr : _GEN_53; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 97:31]
  wire [31:0] _GEN_59 = _T_30 ? reg_write_len : _GEN_54; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 98:30]
  wire [63:0] _GEN_60 = _T_28 ? _T_29 : reg_read_addr; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 240:45 MemCheckerAxiSlave.scala 90:30]
  wire [31:0] _GEN_61 = _T_28 ? reg_read_len : _GEN_55; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 91:29]
  wire  _GEN_63 = _T_28 ? 1'h0 : _GEN_57; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 227:19]
  wire [63:0] _GEN_64 = _T_28 ? reg_write_addr : _GEN_58; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 97:31]
  wire [31:0] _GEN_65 = _T_28 ? reg_write_len : _GEN_59; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 98:30]
  wire [63:0] _GEN_66 = _T_26 ? _T_27 : _GEN_60; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 239:45]
  wire [31:0] _GEN_67 = _T_26 ? reg_read_len : _GEN_61; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 91:29]
  wire  _GEN_69 = _T_26 ? 1'h0 : _GEN_63; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 227:19]
  wire [63:0] _GEN_70 = _T_26 ? reg_write_addr : _GEN_64; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 97:31]
  wire [31:0] _GEN_71 = _T_26 ? reg_write_len : _GEN_65; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 98:30]
  wire  _GEN_72 = _T_24 & wr_data[0]; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 238:43 MemCheckerAxiSlave.scala 226:18]
  wire [63:0] _GEN_73 = _T_24 ? reg_read_addr : _GEN_66; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 90:30]
  wire [31:0] _GEN_74 = _T_24 ? reg_read_len : _GEN_67; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 91:29]
  wire  _GEN_76 = _T_24 ? 1'h0 : _GEN_69; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 227:19]
  wire [63:0] _GEN_77 = _T_24 ? reg_write_addr : _GEN_70; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 97:31]
  wire [31:0] _GEN_78 = _T_24 ? reg_write_len : _GEN_71; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 98:30]
  wire  _GEN_80 = _T_23 ? 1'h0 : _GEN_72; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 226:18]
  wire  _GEN_84 = _T_23 ? 1'h0 : _GEN_76; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 227:19]
  wire  _GEN_90 = _T_20 ? 1'h0 : _GEN_80; // @[Conditional.scala 40:58 MemCheckerAxiSlave.scala 226:18]
  wire  _GEN_94 = _T_20 ? 1'h0 : _GEN_84; // @[Conditional.scala 40:58 MemCheckerAxiSlave.scala 227:19]
  wire  _GEN_100 = wr_en & _GEN_90; // @[MemCheckerAxiSlave.scala 231:15 MemCheckerAxiSlave.scala 226:18]
  wire  _GEN_104 = wr_en & _GEN_94; // @[MemCheckerAxiSlave.scala 231:15 MemCheckerAxiSlave.scala 227:19]
  reg [1:0] state_rd; // @[MemCheckerAxiSlave.scala 254:25]
  reg  rd_en; // @[MemCheckerAxiSlave.scala 256:18]
  reg [5:0] rd_addr; // @[MemCheckerAxiSlave.scala 257:20]
  reg [33:0] rd_data; // @[MemCheckerAxiSlave.scala 258:20]
  wire  _T_39 = 2'h0 == state_rd; // @[Conditional.scala 37:30]
  wire  _T_41 = 2'h1 == state_rd; // @[Conditional.scala 37:30]
  wire  _T_42 = 2'h2 == state_rd; // @[Conditional.scala 37:30]
  wire [1:0] _GEN_110 = io_ctrl_R_ready ? 2'h0 : state_rd; // @[MemCheckerAxiSlave.scala 275:29 MemCheckerAxiSlave.scala 276:18 MemCheckerAxiSlave.scala 254:25]
  wire [33:0] _GEN_118 = _T_42 ? rd_data : 34'h0; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 299:28 MemCheckerAxiSlave.scala 283:24]
  wire  _GEN_120 = _T_41 ? 1'h0 : _T_42; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 293:23]
  wire [33:0] _GEN_121 = _T_41 ? 34'h0 : _GEN_118; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 294:28]
  wire [33:0] _GEN_124 = _T_39 ? 34'h0 : _GEN_121; // @[Conditional.scala 40:58 MemCheckerAxiSlave.scala 289:28]
  wire  _T_46 = 6'h0 == rd_addr; // @[Conditional.scala 37:30]
  wire  _T_47 = 6'h1 == rd_addr; // @[Conditional.scala 37:30]
  wire  _T_48 = 6'h2 == rd_addr; // @[Conditional.scala 37:30]
  wire  _T_50 = 6'h4 == rd_addr; // @[Conditional.scala 37:30]
  wire [10:0] _T_51 = {reg_ctrl_mode,7'h0,reg_ctrl_dir}; // @[Cat.scala 30:58]
  wire  _T_52 = 6'h8 == rd_addr; // @[Conditional.scala 37:30]
  wire  _T_53 = 6'h9 == rd_addr; // @[Conditional.scala 37:30]
  wire  _T_54 = 6'ha == rd_addr; // @[Conditional.scala 37:30]
  wire  _T_56 = 6'hb == rd_addr; // @[Conditional.scala 37:30]
  wire  _T_58 = 6'hc == rd_addr; // @[Conditional.scala 37:30]
  wire  _T_59 = 6'hd == rd_addr; // @[Conditional.scala 37:30]
  wire  _T_60 = 6'he == rd_addr; // @[Conditional.scala 37:30]
  wire  _T_61 = 6'h18 == rd_addr; // @[Conditional.scala 37:30]
  wire  _T_62 = 6'h19 == rd_addr; // @[Conditional.scala 37:30]
  wire  _T_63 = 6'h1a == rd_addr; // @[Conditional.scala 37:30]
  wire  _T_65 = 6'h1b == rd_addr; // @[Conditional.scala 37:30]
  wire  _T_67 = 6'h1c == rd_addr; // @[Conditional.scala 37:30]
  wire  _T_68 = 6'h1d == rd_addr; // @[Conditional.scala 37:30]
  wire  _T_69 = 6'h1e == rd_addr; // @[Conditional.scala 37:30]
  wire  _T_70 = 6'h28 == rd_addr; // @[Conditional.scala 37:30]
  wire  _T_71 = 6'h29 == rd_addr; // @[Conditional.scala 37:30]
  wire [33:0] _GEN_125 = _T_71 ? {{2'd0}, reg_check_ok} : rd_data; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 325:35 MemCheckerAxiSlave.scala 258:20]
  wire [33:0] _GEN_126 = _T_70 ? {{2'd0}, reg_check_tot} : _GEN_125; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 324:36]
  wire [33:0] _GEN_127 = _T_69 ? {{2'd0}, reg_write_duration} : _GEN_126; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 323:41]
  wire [33:0] _GEN_128 = _T_68 ? {{2'd0}, reg_write_resp_cntr} : _GEN_127; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 322:42]
  wire [33:0] _GEN_129 = _T_67 ? {{2'd0}, reg_write_len} : _GEN_128; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 321:36]
  wire [33:0] _GEN_130 = _T_65 ? {{2'd0}, hi_1} : _GEN_129; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 320:40]
  wire [33:0] _GEN_131 = _T_63 ? {{2'd0}, lo_1} : _GEN_130; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 319:40]
  wire [33:0] _GEN_132 = _T_62 ? 34'h0 : _GEN_131; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 318:37]
  wire [33:0] _GEN_133 = _T_61 ? {{2'd0}, reg_write_status} : _GEN_132; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 317:39]
  wire [33:0] _GEN_134 = _T_60 ? {{2'd0}, reg_read_duration} : _GEN_133; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 316:40]
  wire [33:0] _GEN_135 = _T_59 ? {{2'd0}, reg_read_resp_cntr} : _GEN_134; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 315:41]
  wire [33:0] _GEN_136 = _T_58 ? {{2'd0}, reg_read_len} : _GEN_135; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 314:35]
  wire [33:0] _GEN_137 = _T_56 ? {{2'd0}, hi} : _GEN_136; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 313:39]
  wire [33:0] _GEN_138 = _T_54 ? {{2'd0}, lo} : _GEN_137; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 312:39]
  wire [33:0] _GEN_139 = _T_53 ? 34'h0 : _GEN_138; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 311:36]
  wire [33:0] _GEN_140 = _T_52 ? {{2'd0}, reg_read_status} : _GEN_139; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 310:38]
  wire [33:0] _GEN_141 = _T_50 ? {{23'd0}, _T_51} : _GEN_140; // @[Conditional.scala 39:67 MemCheckerAxiSlave.scala 309:31]
  assign io_ctrl_AW_ready = _T_8 | _T_13; // @[Conditional.scala 40:58 MemCheckerAxiSlave.scala 185:24]
  assign io_ctrl_W_ready = _T_8 | _GEN_38; // @[Conditional.scala 40:58 MemCheckerAxiSlave.scala 186:23]
  assign io_ctrl_B_valid = _T_8 ? 1'h0 : _GEN_39; // @[Conditional.scala 40:58 MemCheckerAxiSlave.scala 187:23]
  assign io_ctrl_AR_ready = 2'h0 == state_rd; // @[Conditional.scala 37:30]
  assign io_ctrl_R_valid = _T_39 ? 1'h0 : _GEN_120; // @[Conditional.scala 40:58 MemCheckerAxiSlave.scala 288:23]
  assign io_ctrl_R_bits_rdata = _GEN_124[31:0];
  assign io_ctrl_dir = reg_ctrl_dir; // @[MemCheckerAxiSlave.scala 104:15]
  assign io_ctrl_mode = reg_ctrl_mode; // @[MemCheckerAxiSlave.scala 105:16]
  assign io_read_addr = reg_read_addr; // @[MemCheckerAxiSlave.scala 106:16]
  assign io_read_len = reg_read_len; // @[MemCheckerAxiSlave.scala 107:15]
  assign io_read_start = reg_read_start; // @[MemCheckerAxiSlave.scala 108:17]
  assign io_write_addr = reg_write_addr; // @[MemCheckerAxiSlave.scala 109:17]
  assign io_write_len = reg_write_len; // @[MemCheckerAxiSlave.scala 110:16]
  assign io_write_start = reg_write_start; // @[MemCheckerAxiSlave.scala 111:18]
  always @(posedge clock) begin
    if (reset) begin // @[MemCheckerAxiSlave.scala 85:29]
      reg_ctrl_dir <= 1'h0; // @[MemCheckerAxiSlave.scala 85:29]
    end else if (wr_en) begin // @[MemCheckerAxiSlave.scala 231:15]
      if (_T_20) begin // @[Conditional.scala 40:58]
        reg_ctrl_dir <= wr_data[0]; // @[MemCheckerAxiSlave.scala 234:22]
      end
    end
    if (reset) begin // @[MemCheckerAxiSlave.scala 86:30]
      reg_ctrl_mode <= 3'h0; // @[MemCheckerAxiSlave.scala 86:30]
    end else if (wr_en) begin // @[MemCheckerAxiSlave.scala 231:15]
      if (_T_20) begin // @[Conditional.scala 40:58]
        reg_ctrl_mode <= wr_data[10:8]; // @[MemCheckerAxiSlave.scala 235:23]
      end
    end
    if (reset) begin // @[MemCheckerAxiSlave.scala 87:32]
      reg_read_status <= 32'h0; // @[MemCheckerAxiSlave.scala 87:32]
    end else begin
      reg_read_status <= _T_3; // @[MemCheckerAxiSlave.scala 113:19]
    end
    if (reset) begin // @[MemCheckerAxiSlave.scala 89:31]
      reg_read_start <= 1'h0; // @[MemCheckerAxiSlave.scala 89:31]
    end else begin
      reg_read_start <= _GEN_100;
    end
    if (reset) begin // @[MemCheckerAxiSlave.scala 90:30]
      reg_read_addr <= 64'h0; // @[MemCheckerAxiSlave.scala 90:30]
    end else if (wr_en) begin // @[MemCheckerAxiSlave.scala 231:15]
      if (!(_T_20)) begin // @[Conditional.scala 40:58]
        if (!(_T_23)) begin // @[Conditional.scala 39:67]
          reg_read_addr <= _GEN_73;
        end
      end
    end
    if (reset) begin // @[MemCheckerAxiSlave.scala 91:29]
      reg_read_len <= 32'h0; // @[MemCheckerAxiSlave.scala 91:29]
    end else if (wr_en) begin // @[MemCheckerAxiSlave.scala 231:15]
      if (!(_T_20)) begin // @[Conditional.scala 40:58]
        if (!(_T_23)) begin // @[Conditional.scala 39:67]
          reg_read_len <= _GEN_74;
        end
      end
    end
    reg_read_resp_cntr <= io_rd_stats_resp_cntr; // @[MemCheckerAxiSlave.scala 92:35]
    reg_read_duration <= io_rd_stats_duration; // @[MemCheckerAxiSlave.scala 93:34]
    if (reset) begin // @[MemCheckerAxiSlave.scala 94:33]
      reg_write_status <= 32'h0; // @[MemCheckerAxiSlave.scala 94:33]
    end else begin
      reg_write_status <= _T_7; // @[MemCheckerAxiSlave.scala 117:20]
    end
    if (reset) begin // @[MemCheckerAxiSlave.scala 96:32]
      reg_write_start <= 1'h0; // @[MemCheckerAxiSlave.scala 96:32]
    end else begin
      reg_write_start <= _GEN_104;
    end
    if (reset) begin // @[MemCheckerAxiSlave.scala 97:31]
      reg_write_addr <= 64'h0; // @[MemCheckerAxiSlave.scala 97:31]
    end else if (wr_en) begin // @[MemCheckerAxiSlave.scala 231:15]
      if (!(_T_20)) begin // @[Conditional.scala 40:58]
        if (!(_T_23)) begin // @[Conditional.scala 39:67]
          reg_write_addr <= _GEN_77;
        end
      end
    end
    if (reset) begin // @[MemCheckerAxiSlave.scala 98:30]
      reg_write_len <= 32'h0; // @[MemCheckerAxiSlave.scala 98:30]
    end else if (wr_en) begin // @[MemCheckerAxiSlave.scala 231:15]
      if (!(_T_20)) begin // @[Conditional.scala 40:58]
        if (!(_T_23)) begin // @[Conditional.scala 39:67]
          reg_write_len <= _GEN_78;
        end
      end
    end
    reg_write_resp_cntr <= io_wr_stats_resp_cntr; // @[MemCheckerAxiSlave.scala 99:36]
    reg_write_duration <= io_wr_stats_duration; // @[MemCheckerAxiSlave.scala 100:35]
    reg_check_tot <= io_check_tot; // @[MemCheckerAxiSlave.scala 101:30]
    reg_check_ok <= io_check_ok; // @[MemCheckerAxiSlave.scala 102:29]
    if (_T_8) begin // @[Conditional.scala 40:58]
      wr_en <= _T_9;
    end else if (_T_12) begin // @[Conditional.scala 39:67]
      wr_en <= io_ctrl_W_valid;
    end else begin
      wr_en <= _GEN_19;
    end
    if (_T_8) begin // @[Conditional.scala 40:58]
      if (io_ctrl_AW_valid & io_ctrl_W_valid) begin // @[MemCheckerAxiSlave.scala 139:49]
        wr_addr <= io_ctrl_AW_bits_addr[7:2]; // @[MemCheckerAxiSlave.scala 141:17]
      end else begin
        wr_addr <= _GEN_3;
      end
    end else if (!(_T_12)) begin // @[Conditional.scala 39:67]
      if (_T_13) begin // @[Conditional.scala 39:67]
        wr_addr <= _GEN_3;
      end
    end
    if (_T_8) begin // @[Conditional.scala 40:58]
      if (io_ctrl_AW_valid & io_ctrl_W_valid) begin // @[MemCheckerAxiSlave.scala 139:49]
        wr_data <= io_ctrl_W_bits_wdata; // @[MemCheckerAxiSlave.scala 142:17]
      end else if (!(io_ctrl_AW_valid)) begin // @[MemCheckerAxiSlave.scala 145:36]
        wr_data <= _GEN_0;
      end
    end else if (_T_12) begin // @[Conditional.scala 39:67]
      wr_data <= _GEN_0;
    end
    if (reset) begin // @[MemCheckerAxiSlave.scala 126:25]
      state_wr <= 2'h0; // @[MemCheckerAxiSlave.scala 126:25]
    end else if (_T_8) begin // @[Conditional.scala 40:58]
      if (io_ctrl_AW_valid & io_ctrl_W_valid) begin // @[MemCheckerAxiSlave.scala 139:49]
        state_wr <= 2'h3; // @[MemCheckerAxiSlave.scala 144:18]
      end else if (io_ctrl_AW_valid) begin // @[MemCheckerAxiSlave.scala 145:36]
        state_wr <= 2'h1; // @[MemCheckerAxiSlave.scala 147:20]
      end else begin
        state_wr <= _GEN_2;
      end
    end else if (_T_12) begin // @[Conditional.scala 39:67]
      if (io_ctrl_W_valid) begin // @[MemCheckerAxiSlave.scala 156:29]
        state_wr <= 2'h3; // @[MemCheckerAxiSlave.scala 160:18]
      end
    end else if (_T_13) begin // @[Conditional.scala 39:67]
      state_wr <= _GEN_16;
    end else begin
      state_wr <= _GEN_18;
    end
    if (reset) begin // @[MemCheckerAxiSlave.scala 254:25]
      state_rd <= 2'h0; // @[MemCheckerAxiSlave.scala 254:25]
    end else if (_T_39) begin // @[Conditional.scala 40:58]
      if (io_ctrl_AR_valid) begin // @[MemCheckerAxiSlave.scala 265:30]
        state_rd <= 2'h1; // @[MemCheckerAxiSlave.scala 268:18]
      end
    end else if (_T_41) begin // @[Conditional.scala 39:67]
      state_rd <= 2'h2; // @[MemCheckerAxiSlave.scala 272:16]
    end else if (_T_42) begin // @[Conditional.scala 39:67]
      state_rd <= _GEN_110;
    end
    rd_en <= _T_39 & io_ctrl_AR_valid; // @[Conditional.scala 40:58 MemCheckerAxiSlave.scala 261:9]
    if (_T_39) begin // @[Conditional.scala 40:58]
      if (io_ctrl_AR_valid) begin // @[MemCheckerAxiSlave.scala 265:30]
        rd_addr <= io_ctrl_AR_bits_addr[7:2]; // @[MemCheckerAxiSlave.scala 267:17]
      end
    end
    if (rd_en) begin // @[MemCheckerAxiSlave.scala 304:15]
      if (_T_46) begin // @[Conditional.scala 40:58]
        rd_data <= 34'h3e3c8ec8; // @[MemCheckerAxiSlave.scala 306:29]
      end else if (_T_47) begin // @[Conditional.scala 39:67]
        rd_data <= 34'h10003; // @[MemCheckerAxiSlave.scala 307:34]
      end else if (_T_48) begin // @[Conditional.scala 39:67]
        rd_data <= 34'h4040; // @[MemCheckerAxiSlave.scala 308:31]
      end else begin
        rd_data <= _GEN_141;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_ctrl_dir = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  reg_ctrl_mode = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  reg_read_status = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  reg_read_start = _RAND_3[0:0];
  _RAND_4 = {2{`RANDOM}};
  reg_read_addr = _RAND_4[63:0];
  _RAND_5 = {1{`RANDOM}};
  reg_read_len = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  reg_read_resp_cntr = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  reg_read_duration = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  reg_write_status = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  reg_write_start = _RAND_9[0:0];
  _RAND_10 = {2{`RANDOM}};
  reg_write_addr = _RAND_10[63:0];
  _RAND_11 = {1{`RANDOM}};
  reg_write_len = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  reg_write_resp_cntr = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  reg_write_duration = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  reg_check_tot = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  reg_check_ok = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  wr_en = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  wr_addr = _RAND_17[5:0];
  _RAND_18 = {1{`RANDOM}};
  wr_data = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  state_wr = _RAND_19[1:0];
  _RAND_20 = {1{`RANDOM}};
  state_rd = _RAND_20[1:0];
  _RAND_21 = {1{`RANDOM}};
  rd_en = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  rd_addr = _RAND_22[5:0];
  _RAND_23 = {2{`RANDOM}};
  rd_data = _RAND_23[33:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AvalonMMWriter(
  input          clock,
  input          reset,
  output [31:0]  io_address,
  input  [1:0]   io_response,
  output         io_write,
  output [511:0] io_writedata,
  input          io_waitrequest,
  input          io_writeresponsevalid,
  output [7:0]   io_burstcount,
  input  [31:0]  io_ctrl_addr,
  input  [31:0]  io_ctrl_len_bytes,
  input          io_ctrl_start,
  output         io_data_init,
  output         io_data_inc,
  input  [511:0] io_data_data,
  output [31:0]  io_stats_resp_cntr,
  output         io_stats_done,
  output [31:0]  io_stats_duration
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] cur_addr; // @[AvalonMMWriter.scala 64:21]
  reg [31:0] rem_tot_len_bytes; // @[AvalonMMWriter.scala 65:30]
  reg [7:0] rem_cyc_len_words; // @[AvalonMMWriter.scala 66:30]
  reg [1:0] state; // @[AvalonMMWriter.scala 69:22]
  wire  _T = 2'h0 == state; // @[Conditional.scala 37:30]
  wire [31:0] _T_2 = io_ctrl_len_bytes - 32'h40; // @[AvalonMMWriter.scala 75:48]
  wire [31:0] _T_4 = io_ctrl_len_bytes / 32'h40; // @[AvalonMMWriter.scala 79:51]
  wire [31:0] _T_6 = _T_4 - 32'h1; // @[AvalonMMWriter.scala 79:70]
  wire [31:0] _GEN_0 = io_ctrl_len_bytes > 32'h1000 ? 32'h3f : _T_6; // @[AvalonMMWriter.scala 76:65 AvalonMMWriter.scala 77:29 AvalonMMWriter.scala 79:29]
  wire [31:0] _GEN_3 = io_ctrl_start ? _GEN_0 : {{24'd0}, rem_cyc_len_words}; // @[AvalonMMWriter.scala 73:27 AvalonMMWriter.scala 66:30]
  wire  _T_7 = 2'h1 == state; // @[Conditional.scala 37:30]
  wire  _T_8 = ~io_waitrequest; // @[AvalonMMWriter.scala 85:12]
  wire [7:0] _T_10 = rem_cyc_len_words - 8'h1; // @[AvalonMMWriter.scala 86:48]
  wire [31:0] _T_12 = rem_tot_len_bytes - 32'h40; // @[AvalonMMWriter.scala 87:48]
  wire  _T_13 = rem_cyc_len_words == 8'h0; // @[AvalonMMWriter.scala 88:32]
  wire [1:0] _GEN_5 = rem_cyc_len_words == 8'h0 ? 2'h0 : 2'h2; // @[AvalonMMWriter.scala 88:41 AvalonMMWriter.scala 89:17 AvalonMMWriter.scala 91:17]
  wire [7:0] _GEN_6 = ~io_waitrequest ? _T_10 : rem_cyc_len_words; // @[AvalonMMWriter.scala 85:29 AvalonMMWriter.scala 86:27 AvalonMMWriter.scala 66:30]
  wire [31:0] _GEN_7 = ~io_waitrequest ? _T_12 : rem_tot_len_bytes; // @[AvalonMMWriter.scala 85:29 AvalonMMWriter.scala 87:27 AvalonMMWriter.scala 65:30]
  wire  _T_14 = 2'h2 == state; // @[Conditional.scala 37:30]
  wire [31:0] _T_23 = cur_addr + 32'h1000; // @[AvalonMMWriter.scala 104:34]
  wire [31:0] _T_25 = rem_tot_len_bytes / 32'h40; // @[AvalonMMWriter.scala 108:55]
  wire [31:0] _T_27 = _T_25 - 32'h1; // @[AvalonMMWriter.scala 108:74]
  wire [31:0] _GEN_9 = rem_tot_len_bytes >= 32'h1000 ? 32'h3f : _T_27; // @[AvalonMMWriter.scala 105:70 AvalonMMWriter.scala 106:33 AvalonMMWriter.scala 108:33]
  wire [1:0] _GEN_10 = rem_tot_len_bytes == 32'h0 ? 2'h0 : 2'h1; // @[AvalonMMWriter.scala 100:43 AvalonMMWriter.scala 101:19 AvalonMMWriter.scala 103:19]
  wire [31:0] _GEN_11 = rem_tot_len_bytes == 32'h0 ? cur_addr : _T_23; // @[AvalonMMWriter.scala 100:43 AvalonMMWriter.scala 64:21 AvalonMMWriter.scala 104:22]
  wire [31:0] _GEN_12 = rem_tot_len_bytes == 32'h0 ? {{24'd0}, _T_10} : _GEN_9; // @[AvalonMMWriter.scala 100:43 AvalonMMWriter.scala 97:27]
  wire [1:0] _GEN_13 = _T_13 ? _GEN_10 : state; // @[AvalonMMWriter.scala 99:41 AvalonMMWriter.scala 69:22]
  wire [31:0] _GEN_14 = _T_13 ? _GEN_11 : cur_addr; // @[AvalonMMWriter.scala 99:41 AvalonMMWriter.scala 64:21]
  wire [31:0] _GEN_15 = _T_13 ? _GEN_12 : {{24'd0}, _T_10}; // @[AvalonMMWriter.scala 99:41 AvalonMMWriter.scala 97:27]
  wire [31:0] _GEN_16 = _T_8 ? _GEN_15 : {{24'd0}, rem_cyc_len_words}; // @[AvalonMMWriter.scala 96:29 AvalonMMWriter.scala 66:30]
  wire [1:0] _GEN_18 = _T_8 ? _GEN_13 : state; // @[AvalonMMWriter.scala 96:29 AvalonMMWriter.scala 69:22]
  wire [31:0] _GEN_20 = _T_14 ? _GEN_16 : {{24'd0}, rem_cyc_len_words}; // @[Conditional.scala 39:67 AvalonMMWriter.scala 66:30]
  wire [31:0] _GEN_24 = _T_7 ? {{24'd0}, _GEN_6} : _GEN_20; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_30 = _T ? _GEN_3 : _GEN_24; // @[Conditional.scala 40:58]
  wire  _T_29 = state == 2'h1; // @[AvalonMMWriter.scala 118:14]
  wire [7:0] _T_31 = rem_cyc_len_words + 8'h1; // @[AvalonMMWriter.scala 119:40]
  wire  _T_33 = state != 2'h0; // @[AvalonMMWriter.scala 130:21]
  wire  _T_34 = state == 2'h0; // @[AvalonMMWriter.scala 133:25]
  wire  _T_35 = state == 2'h0 & io_ctrl_start; // @[AvalonMMWriter.scala 133:35]
  reg [31:0] resp_cntr_reg; // @[AvalonMMWriter.scala 139:26]
  wire [31:0] _T_45 = resp_cntr_reg + 32'h1; // @[AvalonMMWriter.scala 146:38]
  reg [1:0] state_prev; // @[AvalonMMWriter.scala 152:27]
  reg [31:0] wr_duration; // @[AvalonMMWriter.scala 155:28]
  reg  wr_duration_en; // @[AvalonMMWriter.scala 156:31]
  wire  _GEN_37 = io_stats_done ? 1'h0 : wr_duration_en; // @[AvalonMMWriter.scala 161:29 AvalonMMWriter.scala 162:20 AvalonMMWriter.scala 156:31]
  wire  _GEN_38 = _T_35 | _GEN_37; // @[AvalonMMWriter.scala 159:42 AvalonMMWriter.scala 160:20]
  wire [31:0] _T_52 = wr_duration + 32'h1; // @[AvalonMMWriter.scala 166:32]
  assign io_address = _T_29 ? cur_addr : 32'h0; // @[AvalonMMWriter.scala 124:28 AvalonMMWriter.scala 125:16 AvalonMMWriter.scala 127:16]
  assign io_write = state != 2'h0; // @[AvalonMMWriter.scala 130:21]
  assign io_writedata = io_data_data; // @[AvalonMMWriter.scala 135:16]
  assign io_burstcount = state == 2'h1 ? _T_31 : 8'h0; // @[AvalonMMWriter.scala 118:28 AvalonMMWriter.scala 119:19 AvalonMMWriter.scala 121:19]
  assign io_data_init = state == 2'h0 & io_ctrl_start; // @[AvalonMMWriter.scala 133:35]
  assign io_data_inc = _T_33 & _T_8; // @[AvalonMMWriter.scala 134:34]
  assign io_stats_resp_cntr = resp_cntr_reg; // @[AvalonMMWriter.scala 140:22]
  assign io_stats_done = state_prev != 2'h0 & _T_34; // @[AvalonMMWriter.scala 153:41]
  assign io_stats_duration = wr_duration; // @[AvalonMMWriter.scala 157:21]
  always @(posedge clock) begin
    if (_T) begin // @[Conditional.scala 40:58]
      if (io_ctrl_start) begin // @[AvalonMMWriter.scala 73:27]
        cur_addr <= io_ctrl_addr; // @[AvalonMMWriter.scala 74:18]
      end
    end else if (!(_T_7)) begin // @[Conditional.scala 39:67]
      if (_T_14) begin // @[Conditional.scala 39:67]
        if (_T_8) begin // @[AvalonMMWriter.scala 96:29]
          cur_addr <= _GEN_14;
        end
      end
    end
    if (_T) begin // @[Conditional.scala 40:58]
      if (io_ctrl_start) begin // @[AvalonMMWriter.scala 73:27]
        rem_tot_len_bytes <= _T_2; // @[AvalonMMWriter.scala 75:27]
      end
    end else if (_T_7) begin // @[Conditional.scala 39:67]
      rem_tot_len_bytes <= _GEN_7;
    end else if (_T_14) begin // @[Conditional.scala 39:67]
      rem_tot_len_bytes <= _GEN_7;
    end
    rem_cyc_len_words <= _GEN_30[7:0];
    if (reset) begin // @[AvalonMMWriter.scala 69:22]
      state <= 2'h0; // @[AvalonMMWriter.scala 69:22]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_ctrl_start) begin // @[AvalonMMWriter.scala 73:27]
        state <= 2'h1; // @[AvalonMMWriter.scala 81:15]
      end
    end else if (_T_7) begin // @[Conditional.scala 39:67]
      if (~io_waitrequest) begin // @[AvalonMMWriter.scala 85:29]
        state <= _GEN_5;
      end
    end else if (_T_14) begin // @[Conditional.scala 39:67]
      state <= _GEN_18;
    end
    if (_T_35) begin // @[AvalonMMWriter.scala 142:42]
      resp_cntr_reg <= 32'h0; // @[AvalonMMWriter.scala 143:19]
    end else if (_T_33) begin // @[AvalonMMWriter.scala 144:31]
      if (io_writeresponsevalid & io_response == 2'h0) begin // @[AvalonMMWriter.scala 145:56]
        resp_cntr_reg <= _T_45; // @[AvalonMMWriter.scala 146:21]
      end
    end
    state_prev <= state; // @[AvalonMMWriter.scala 152:27]
    if (reset) begin // @[AvalonMMWriter.scala 155:28]
      wr_duration <= 32'h0; // @[AvalonMMWriter.scala 155:28]
    end else if (wr_duration_en) begin // @[AvalonMMWriter.scala 165:24]
      wr_duration <= _T_52; // @[AvalonMMWriter.scala 166:17]
    end else if (_T_35) begin // @[AvalonMMWriter.scala 167:48]
      wr_duration <= 32'h0; // @[AvalonMMWriter.scala 168:17]
    end
    if (reset) begin // @[AvalonMMWriter.scala 156:31]
      wr_duration_en <= 1'h0; // @[AvalonMMWriter.scala 156:31]
    end else begin
      wr_duration_en <= _GEN_38;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  cur_addr = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  rem_tot_len_bytes = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  rem_cyc_len_words = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  state = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  resp_cntr_reg = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  state_prev = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  wr_duration = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  wr_duration_en = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AvalonMMReader(
  input          clock,
  input          reset,
  output [31:0]  io_address,
  output         io_read,
  input  [511:0] io_readdata,
  input  [1:0]   io_response,
  input          io_waitrequest,
  input          io_readdatavalid,
  output [7:0]   io_burstcount,
  input  [31:0]  io_ctrl_addr,
  input  [31:0]  io_ctrl_len_bytes,
  input          io_ctrl_start,
  output         io_data_init,
  output         io_data_inc,
  output [511:0] io_data_data,
  output [31:0]  io_stats_resp_cntr,
  output         io_stats_done,
  output [31:0]  io_stats_duration
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] cur_addr; // @[AvalonMMReader.scala 63:21]
  reg [31:0] rem_tot_len_bytes; // @[AvalonMMReader.scala 64:30]
  reg [7:0] rem_cyc_len_words; // @[AvalonMMReader.scala 65:30]
  reg [1:0] state; // @[AvalonMMReader.scala 68:22]
  wire  _T = 2'h0 == state; // @[Conditional.scala 37:30]
  wire [31:0] _T_2 = io_ctrl_len_bytes - 32'h40; // @[AvalonMMReader.scala 74:48]
  wire [31:0] _T_4 = io_ctrl_len_bytes / 32'h40; // @[AvalonMMReader.scala 78:51]
  wire [31:0] _T_6 = _T_4 - 32'h1; // @[AvalonMMReader.scala 78:70]
  wire [31:0] _GEN_0 = io_ctrl_len_bytes > 32'h1000 ? 32'h3f : _T_6; // @[AvalonMMReader.scala 75:65 AvalonMMReader.scala 76:29 AvalonMMReader.scala 78:29]
  wire [31:0] _GEN_3 = io_ctrl_start ? _GEN_0 : {{24'd0}, rem_cyc_len_words}; // @[AvalonMMReader.scala 72:27 AvalonMMReader.scala 65:30]
  wire  _T_7 = 2'h1 == state; // @[Conditional.scala 37:30]
  wire  _T_9 = rem_cyc_len_words == 8'h0; // @[AvalonMMReader.scala 85:32]
  wire [1:0] _GEN_5 = rem_cyc_len_words == 8'h0 ? 2'h0 : 2'h2; // @[AvalonMMReader.scala 85:41 AvalonMMReader.scala 86:17 AvalonMMReader.scala 88:17]
  wire  _T_10 = 2'h2 == state; // @[Conditional.scala 37:30]
  wire [7:0] _T_12 = rem_cyc_len_words - 8'h1; // @[AvalonMMReader.scala 94:48]
  wire [31:0] _T_14 = rem_tot_len_bytes - 32'h40; // @[AvalonMMReader.scala 95:48]
  wire [31:0] _T_18 = cur_addr + 32'h1000; // @[AvalonMMReader.scala 101:34]
  wire [31:0] _T_20 = rem_tot_len_bytes / 32'h40; // @[AvalonMMReader.scala 105:55]
  wire [31:0] _T_22 = _T_20 - 32'h1; // @[AvalonMMReader.scala 105:74]
  wire [31:0] _GEN_7 = rem_tot_len_bytes >= 32'h1000 ? 32'h3f : _T_22; // @[AvalonMMReader.scala 102:70 AvalonMMReader.scala 103:33 AvalonMMReader.scala 105:33]
  wire [1:0] _GEN_8 = rem_tot_len_bytes == 32'h0 ? 2'h0 : 2'h1; // @[AvalonMMReader.scala 97:43 AvalonMMReader.scala 98:19 AvalonMMReader.scala 100:19]
  wire [31:0] _GEN_9 = rem_tot_len_bytes == 32'h0 ? cur_addr : _T_18; // @[AvalonMMReader.scala 97:43 AvalonMMReader.scala 63:21 AvalonMMReader.scala 101:22]
  wire [31:0] _GEN_10 = rem_tot_len_bytes == 32'h0 ? {{24'd0}, _T_12} : _GEN_7; // @[AvalonMMReader.scala 97:43 AvalonMMReader.scala 94:27]
  wire [1:0] _GEN_11 = _T_9 ? _GEN_8 : state; // @[AvalonMMReader.scala 96:41 AvalonMMReader.scala 68:22]
  wire [31:0] _GEN_12 = _T_9 ? _GEN_9 : cur_addr; // @[AvalonMMReader.scala 96:41 AvalonMMReader.scala 63:21]
  wire [31:0] _GEN_13 = _T_9 ? _GEN_10 : {{24'd0}, _T_12}; // @[AvalonMMReader.scala 96:41 AvalonMMReader.scala 94:27]
  wire [31:0] _GEN_14 = io_readdatavalid ? _GEN_13 : {{24'd0}, rem_cyc_len_words}; // @[AvalonMMReader.scala 93:30 AvalonMMReader.scala 65:30]
  wire [1:0] _GEN_16 = io_readdatavalid ? _GEN_11 : state; // @[AvalonMMReader.scala 93:30 AvalonMMReader.scala 68:22]
  wire [31:0] _GEN_18 = _T_10 ? _GEN_14 : {{24'd0}, rem_cyc_len_words}; // @[Conditional.scala 39:67 AvalonMMReader.scala 65:30]
  wire [31:0] _GEN_23 = _T_7 ? {{24'd0}, rem_cyc_len_words} : _GEN_18; // @[Conditional.scala 39:67 AvalonMMReader.scala 65:30]
  wire [31:0] _GEN_28 = _T ? _GEN_3 : _GEN_23; // @[Conditional.scala 40:58]
  wire  _T_23 = state == 2'h1; // @[AvalonMMReader.scala 113:14]
  wire [7:0] _T_25 = rem_cyc_len_words + 8'h1; // @[AvalonMMReader.scala 114:40]
  wire  _T_28 = state == 2'h0; // @[AvalonMMReader.scala 130:25]
  wire  _T_29 = state == 2'h0 & io_ctrl_start; // @[AvalonMMReader.scala 130:35]
  wire  _T_30 = state != 2'h0; // @[AvalonMMReader.scala 131:24]
  reg [31:0] resp_cntr_reg; // @[AvalonMMReader.scala 135:26]
  wire [31:0] _T_38 = resp_cntr_reg + 32'h1; // @[AvalonMMReader.scala 142:38]
  reg [1:0] state_prev; // @[AvalonMMReader.scala 148:27]
  reg [31:0] rd_duration; // @[AvalonMMReader.scala 151:28]
  reg  rd_duration_en; // @[AvalonMMReader.scala 152:31]
  wire  _GEN_35 = io_stats_done ? 1'h0 : rd_duration_en; // @[AvalonMMReader.scala 157:29 AvalonMMReader.scala 158:20 AvalonMMReader.scala 152:31]
  wire  _GEN_36 = _T_29 | _GEN_35; // @[AvalonMMReader.scala 155:42 AvalonMMReader.scala 156:20]
  wire [31:0] _T_45 = rd_duration + 32'h1; // @[AvalonMMReader.scala 162:32]
  assign io_address = _T_23 ? cur_addr : 32'h0; // @[AvalonMMReader.scala 119:27 AvalonMMReader.scala 120:16 AvalonMMReader.scala 122:16]
  assign io_read = state == 2'h1; // @[AvalonMMReader.scala 125:20]
  assign io_burstcount = state == 2'h1 ? _T_25 : 8'h0; // @[AvalonMMReader.scala 113:27 AvalonMMReader.scala 114:19 AvalonMMReader.scala 116:19]
  assign io_data_init = state == 2'h0 & io_ctrl_start; // @[AvalonMMReader.scala 130:35]
  assign io_data_inc = state != 2'h0 & io_readdatavalid; // @[AvalonMMReader.scala 131:34]
  assign io_data_data = io_readdata; // @[AvalonMMReader.scala 129:16]
  assign io_stats_resp_cntr = resp_cntr_reg; // @[AvalonMMReader.scala 136:22]
  assign io_stats_done = state_prev != 2'h0 & _T_28; // @[AvalonMMReader.scala 149:41]
  assign io_stats_duration = rd_duration; // @[AvalonMMReader.scala 153:21]
  always @(posedge clock) begin
    if (_T) begin // @[Conditional.scala 40:58]
      if (io_ctrl_start) begin // @[AvalonMMReader.scala 72:27]
        cur_addr <= io_ctrl_addr; // @[AvalonMMReader.scala 73:18]
      end
    end else if (!(_T_7)) begin // @[Conditional.scala 39:67]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (io_readdatavalid) begin // @[AvalonMMReader.scala 93:30]
          cur_addr <= _GEN_12;
        end
      end
    end
    if (_T) begin // @[Conditional.scala 40:58]
      if (io_ctrl_start) begin // @[AvalonMMReader.scala 72:27]
        rem_tot_len_bytes <= _T_2; // @[AvalonMMReader.scala 74:27]
      end
    end else if (!(_T_7)) begin // @[Conditional.scala 39:67]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (io_readdatavalid) begin // @[AvalonMMReader.scala 93:30]
          rem_tot_len_bytes <= _T_14; // @[AvalonMMReader.scala 95:27]
        end
      end
    end
    rem_cyc_len_words <= _GEN_28[7:0];
    if (reset) begin // @[AvalonMMReader.scala 68:22]
      state <= 2'h0; // @[AvalonMMReader.scala 68:22]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_ctrl_start) begin // @[AvalonMMReader.scala 72:27]
        state <= 2'h1; // @[AvalonMMReader.scala 80:15]
      end
    end else if (_T_7) begin // @[Conditional.scala 39:67]
      if (~io_waitrequest) begin // @[AvalonMMReader.scala 84:29]
        state <= _GEN_5;
      end
    end else if (_T_10) begin // @[Conditional.scala 39:67]
      state <= _GEN_16;
    end
    if (_T_29) begin // @[AvalonMMReader.scala 138:42]
      resp_cntr_reg <= 32'h0; // @[AvalonMMReader.scala 139:19]
    end else if (_T_30) begin // @[AvalonMMReader.scala 140:31]
      if (io_readdatavalid & io_response == 2'h0) begin // @[AvalonMMReader.scala 141:51]
        resp_cntr_reg <= _T_38; // @[AvalonMMReader.scala 142:21]
      end
    end
    state_prev <= state; // @[AvalonMMReader.scala 148:27]
    if (reset) begin // @[AvalonMMReader.scala 151:28]
      rd_duration <= 32'h0; // @[AvalonMMReader.scala 151:28]
    end else if (rd_duration_en) begin // @[AvalonMMReader.scala 161:24]
      rd_duration <= _T_45; // @[AvalonMMReader.scala 162:17]
    end else if (_T_29) begin // @[AvalonMMReader.scala 163:48]
      rd_duration <= 32'h0; // @[AvalonMMReader.scala 164:17]
    end
    if (reset) begin // @[AvalonMMReader.scala 152:31]
      rd_duration_en <= 1'h0; // @[AvalonMMReader.scala 152:31]
    end else begin
      rd_duration_en <= _GEN_36;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  cur_addr = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  rem_tot_len_bytes = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  rem_cyc_len_words = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  state = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  resp_cntr_reg = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  state_prev = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  rd_duration = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  rd_duration_en = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PatternGen(
  input          clock,
  input          reset,
  input          io_data_init,
  input          io_data_inc,
  output [511:0] io_out_walk1,
  output [511:0] io_out_walk0,
  output [511:0] io_out_alt,
  output [511:0] io_out_8bit_cntr,
  output [511:0] io_out_32bit_cntr,
  output [511:0] io_out_128bit_cntr
);
`ifdef RANDOMIZE_REG_INIT
  reg [511:0] _RAND_0;
  reg [511:0] _RAND_1;
  reg [511:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [127:0] _RAND_83;
  reg [127:0] _RAND_84;
  reg [127:0] _RAND_85;
  reg [127:0] _RAND_86;
`endif // RANDOMIZE_REG_INIT
  reg [511:0] data_reg_walk1; // @[PatternGen.scala 42:27]
  reg [511:0] data_reg_walk0; // @[PatternGen.scala 43:27]
  reg [511:0] data_reg_alt; // @[PatternGen.scala 44:25]
  reg [7:0] data_reg_8bit_cntr_vec_0; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_1; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_2; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_3; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_4; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_5; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_6; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_7; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_8; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_9; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_10; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_11; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_12; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_13; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_14; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_15; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_16; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_17; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_18; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_19; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_20; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_21; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_22; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_23; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_24; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_25; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_26; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_27; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_28; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_29; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_30; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_31; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_32; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_33; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_34; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_35; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_36; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_37; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_38; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_39; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_40; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_41; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_42; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_43; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_44; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_45; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_46; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_47; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_48; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_49; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_50; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_51; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_52; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_53; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_54; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_55; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_56; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_57; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_58; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_59; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_60; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_61; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_62; // @[PatternGen.scala 45:39]
  reg [7:0] data_reg_8bit_cntr_vec_63; // @[PatternGen.scala 45:39]
  reg [31:0] data_reg_32bit_cntr_vec_0; // @[PatternGen.scala 46:40]
  reg [31:0] data_reg_32bit_cntr_vec_1; // @[PatternGen.scala 46:40]
  reg [31:0] data_reg_32bit_cntr_vec_2; // @[PatternGen.scala 46:40]
  reg [31:0] data_reg_32bit_cntr_vec_3; // @[PatternGen.scala 46:40]
  reg [31:0] data_reg_32bit_cntr_vec_4; // @[PatternGen.scala 46:40]
  reg [31:0] data_reg_32bit_cntr_vec_5; // @[PatternGen.scala 46:40]
  reg [31:0] data_reg_32bit_cntr_vec_6; // @[PatternGen.scala 46:40]
  reg [31:0] data_reg_32bit_cntr_vec_7; // @[PatternGen.scala 46:40]
  reg [31:0] data_reg_32bit_cntr_vec_8; // @[PatternGen.scala 46:40]
  reg [31:0] data_reg_32bit_cntr_vec_9; // @[PatternGen.scala 46:40]
  reg [31:0] data_reg_32bit_cntr_vec_10; // @[PatternGen.scala 46:40]
  reg [31:0] data_reg_32bit_cntr_vec_11; // @[PatternGen.scala 46:40]
  reg [31:0] data_reg_32bit_cntr_vec_12; // @[PatternGen.scala 46:40]
  reg [31:0] data_reg_32bit_cntr_vec_13; // @[PatternGen.scala 46:40]
  reg [31:0] data_reg_32bit_cntr_vec_14; // @[PatternGen.scala 46:40]
  reg [31:0] data_reg_32bit_cntr_vec_15; // @[PatternGen.scala 46:40]
  reg [127:0] data_reg_128bit_cntr_vec_0; // @[PatternGen.scala 47:41]
  reg [127:0] data_reg_128bit_cntr_vec_1; // @[PatternGen.scala 47:41]
  reg [127:0] data_reg_128bit_cntr_vec_2; // @[PatternGen.scala 47:41]
  reg [127:0] data_reg_128bit_cntr_vec_3; // @[PatternGen.scala 47:41]
  wire [510:0] hi = data_reg_walk1[510:0]; // @[PatternGen.scala 63:41]
  wire  lo = data_reg_walk1[511]; // @[PatternGen.scala 63:72]
  wire [511:0] _T_3 = {hi,lo}; // @[Cat.scala 30:58]
  wire [510:0] hi_1 = data_reg_walk0[510:0]; // @[PatternGen.scala 64:41]
  wire  lo_1 = data_reg_walk0[511]; // @[PatternGen.scala 64:72]
  wire [511:0] _T_4 = {hi_1,lo_1}; // @[Cat.scala 30:58]
  wire [511:0] _T_6 = data_reg_alt ^ 512'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
    ; // @[PatternGen.scala 65:34]
  wire [7:0] _T_8 = data_reg_8bit_cntr_vec_0 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_10 = data_reg_8bit_cntr_vec_1 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_12 = data_reg_8bit_cntr_vec_2 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_14 = data_reg_8bit_cntr_vec_3 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_16 = data_reg_8bit_cntr_vec_4 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_18 = data_reg_8bit_cntr_vec_5 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_20 = data_reg_8bit_cntr_vec_6 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_22 = data_reg_8bit_cntr_vec_7 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_24 = data_reg_8bit_cntr_vec_8 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_26 = data_reg_8bit_cntr_vec_9 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_28 = data_reg_8bit_cntr_vec_10 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_30 = data_reg_8bit_cntr_vec_11 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_32 = data_reg_8bit_cntr_vec_12 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_34 = data_reg_8bit_cntr_vec_13 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_36 = data_reg_8bit_cntr_vec_14 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_38 = data_reg_8bit_cntr_vec_15 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_40 = data_reg_8bit_cntr_vec_16 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_42 = data_reg_8bit_cntr_vec_17 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_44 = data_reg_8bit_cntr_vec_18 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_46 = data_reg_8bit_cntr_vec_19 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_48 = data_reg_8bit_cntr_vec_20 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_50 = data_reg_8bit_cntr_vec_21 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_52 = data_reg_8bit_cntr_vec_22 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_54 = data_reg_8bit_cntr_vec_23 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_56 = data_reg_8bit_cntr_vec_24 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_58 = data_reg_8bit_cntr_vec_25 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_60 = data_reg_8bit_cntr_vec_26 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_62 = data_reg_8bit_cntr_vec_27 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_64 = data_reg_8bit_cntr_vec_28 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_66 = data_reg_8bit_cntr_vec_29 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_68 = data_reg_8bit_cntr_vec_30 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_70 = data_reg_8bit_cntr_vec_31 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_72 = data_reg_8bit_cntr_vec_32 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_74 = data_reg_8bit_cntr_vec_33 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_76 = data_reg_8bit_cntr_vec_34 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_78 = data_reg_8bit_cntr_vec_35 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_80 = data_reg_8bit_cntr_vec_36 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_82 = data_reg_8bit_cntr_vec_37 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_84 = data_reg_8bit_cntr_vec_38 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_86 = data_reg_8bit_cntr_vec_39 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_88 = data_reg_8bit_cntr_vec_40 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_90 = data_reg_8bit_cntr_vec_41 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_92 = data_reg_8bit_cntr_vec_42 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_94 = data_reg_8bit_cntr_vec_43 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_96 = data_reg_8bit_cntr_vec_44 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_98 = data_reg_8bit_cntr_vec_45 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_100 = data_reg_8bit_cntr_vec_46 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_102 = data_reg_8bit_cntr_vec_47 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_104 = data_reg_8bit_cntr_vec_48 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_106 = data_reg_8bit_cntr_vec_49 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_108 = data_reg_8bit_cntr_vec_50 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_110 = data_reg_8bit_cntr_vec_51 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_112 = data_reg_8bit_cntr_vec_52 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_114 = data_reg_8bit_cntr_vec_53 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_116 = data_reg_8bit_cntr_vec_54 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_118 = data_reg_8bit_cntr_vec_55 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_120 = data_reg_8bit_cntr_vec_56 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_122 = data_reg_8bit_cntr_vec_57 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_124 = data_reg_8bit_cntr_vec_58 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_126 = data_reg_8bit_cntr_vec_59 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_128 = data_reg_8bit_cntr_vec_60 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_130 = data_reg_8bit_cntr_vec_61 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_132 = data_reg_8bit_cntr_vec_62 + 8'h40; // @[PatternGen.scala 67:62]
  wire [7:0] _T_134 = data_reg_8bit_cntr_vec_63 + 8'h40; // @[PatternGen.scala 67:62]
  wire [31:0] _T_136 = data_reg_32bit_cntr_vec_0 + 32'h10; // @[PatternGen.scala 70:64]
  wire [31:0] _T_138 = data_reg_32bit_cntr_vec_1 + 32'h10; // @[PatternGen.scala 70:64]
  wire [31:0] _T_140 = data_reg_32bit_cntr_vec_2 + 32'h10; // @[PatternGen.scala 70:64]
  wire [31:0] _T_142 = data_reg_32bit_cntr_vec_3 + 32'h10; // @[PatternGen.scala 70:64]
  wire [31:0] _T_144 = data_reg_32bit_cntr_vec_4 + 32'h10; // @[PatternGen.scala 70:64]
  wire [31:0] _T_146 = data_reg_32bit_cntr_vec_5 + 32'h10; // @[PatternGen.scala 70:64]
  wire [31:0] _T_148 = data_reg_32bit_cntr_vec_6 + 32'h10; // @[PatternGen.scala 70:64]
  wire [31:0] _T_150 = data_reg_32bit_cntr_vec_7 + 32'h10; // @[PatternGen.scala 70:64]
  wire [31:0] _T_152 = data_reg_32bit_cntr_vec_8 + 32'h10; // @[PatternGen.scala 70:64]
  wire [31:0] _T_154 = data_reg_32bit_cntr_vec_9 + 32'h10; // @[PatternGen.scala 70:64]
  wire [31:0] _T_156 = data_reg_32bit_cntr_vec_10 + 32'h10; // @[PatternGen.scala 70:64]
  wire [31:0] _T_158 = data_reg_32bit_cntr_vec_11 + 32'h10; // @[PatternGen.scala 70:64]
  wire [31:0] _T_160 = data_reg_32bit_cntr_vec_12 + 32'h10; // @[PatternGen.scala 70:64]
  wire [31:0] _T_162 = data_reg_32bit_cntr_vec_13 + 32'h10; // @[PatternGen.scala 70:64]
  wire [31:0] _T_164 = data_reg_32bit_cntr_vec_14 + 32'h10; // @[PatternGen.scala 70:64]
  wire [31:0] _T_166 = data_reg_32bit_cntr_vec_15 + 32'h10; // @[PatternGen.scala 70:64]
  wire [127:0] _T_168 = data_reg_128bit_cntr_vec_0 + 128'h4; // @[PatternGen.scala 73:66]
  wire [127:0] _T_170 = data_reg_128bit_cntr_vec_1 + 128'h4; // @[PatternGen.scala 73:66]
  wire [127:0] _T_172 = data_reg_128bit_cntr_vec_2 + 128'h4; // @[PatternGen.scala 73:66]
  wire [127:0] _T_174 = data_reg_128bit_cntr_vec_3 + 128'h4; // @[PatternGen.scala 73:66]
  wire [63:0] lo_lo_lo = {data_reg_8bit_cntr_vec_7,data_reg_8bit_cntr_vec_6,data_reg_8bit_cntr_vec_5,
    data_reg_8bit_cntr_vec_4,data_reg_8bit_cntr_vec_3,data_reg_8bit_cntr_vec_2,data_reg_8bit_cntr_vec_1,
    data_reg_8bit_cntr_vec_0}; // @[PatternGen.scala 80:52]
  wire [127:0] lo_lo = {data_reg_8bit_cntr_vec_15,data_reg_8bit_cntr_vec_14,data_reg_8bit_cntr_vec_13,
    data_reg_8bit_cntr_vec_12,data_reg_8bit_cntr_vec_11,data_reg_8bit_cntr_vec_10,data_reg_8bit_cntr_vec_9,
    data_reg_8bit_cntr_vec_8,lo_lo_lo}; // @[PatternGen.scala 80:52]
  wire [63:0] lo_hi_lo = {data_reg_8bit_cntr_vec_23,data_reg_8bit_cntr_vec_22,data_reg_8bit_cntr_vec_21,
    data_reg_8bit_cntr_vec_20,data_reg_8bit_cntr_vec_19,data_reg_8bit_cntr_vec_18,data_reg_8bit_cntr_vec_17,
    data_reg_8bit_cntr_vec_16}; // @[PatternGen.scala 80:52]
  wire [255:0] lo_2 = {data_reg_8bit_cntr_vec_31,data_reg_8bit_cntr_vec_30,data_reg_8bit_cntr_vec_29,
    data_reg_8bit_cntr_vec_28,data_reg_8bit_cntr_vec_27,data_reg_8bit_cntr_vec_26,data_reg_8bit_cntr_vec_25,
    data_reg_8bit_cntr_vec_24,lo_hi_lo,lo_lo}; // @[PatternGen.scala 80:52]
  wire [63:0] hi_lo_lo = {data_reg_8bit_cntr_vec_39,data_reg_8bit_cntr_vec_38,data_reg_8bit_cntr_vec_37,
    data_reg_8bit_cntr_vec_36,data_reg_8bit_cntr_vec_35,data_reg_8bit_cntr_vec_34,data_reg_8bit_cntr_vec_33,
    data_reg_8bit_cntr_vec_32}; // @[PatternGen.scala 80:52]
  wire [127:0] hi_lo = {data_reg_8bit_cntr_vec_47,data_reg_8bit_cntr_vec_46,data_reg_8bit_cntr_vec_45,
    data_reg_8bit_cntr_vec_44,data_reg_8bit_cntr_vec_43,data_reg_8bit_cntr_vec_42,data_reg_8bit_cntr_vec_41,
    data_reg_8bit_cntr_vec_40,hi_lo_lo}; // @[PatternGen.scala 80:52]
  wire [63:0] hi_hi_lo = {data_reg_8bit_cntr_vec_55,data_reg_8bit_cntr_vec_54,data_reg_8bit_cntr_vec_53,
    data_reg_8bit_cntr_vec_52,data_reg_8bit_cntr_vec_51,data_reg_8bit_cntr_vec_50,data_reg_8bit_cntr_vec_49,
    data_reg_8bit_cntr_vec_48}; // @[PatternGen.scala 80:52]
  wire [255:0] hi_2 = {data_reg_8bit_cntr_vec_63,data_reg_8bit_cntr_vec_62,data_reg_8bit_cntr_vec_61,
    data_reg_8bit_cntr_vec_60,data_reg_8bit_cntr_vec_59,data_reg_8bit_cntr_vec_58,data_reg_8bit_cntr_vec_57,
    data_reg_8bit_cntr_vec_56,hi_hi_lo,hi_lo}; // @[PatternGen.scala 80:52]
  wire [255:0] lo_3 = {data_reg_32bit_cntr_vec_7,data_reg_32bit_cntr_vec_6,data_reg_32bit_cntr_vec_5,
    data_reg_32bit_cntr_vec_4,data_reg_32bit_cntr_vec_3,data_reg_32bit_cntr_vec_2,data_reg_32bit_cntr_vec_1,
    data_reg_32bit_cntr_vec_0}; // @[PatternGen.scala 81:54]
  wire [255:0] hi_3 = {data_reg_32bit_cntr_vec_15,data_reg_32bit_cntr_vec_14,data_reg_32bit_cntr_vec_13,
    data_reg_32bit_cntr_vec_12,data_reg_32bit_cntr_vec_11,data_reg_32bit_cntr_vec_10,data_reg_32bit_cntr_vec_9,
    data_reg_32bit_cntr_vec_8}; // @[PatternGen.scala 81:54]
  wire [255:0] lo_4 = {data_reg_128bit_cntr_vec_1,data_reg_128bit_cntr_vec_0}; // @[PatternGen.scala 82:56]
  wire [255:0] hi_4 = {data_reg_128bit_cntr_vec_3,data_reg_128bit_cntr_vec_2}; // @[PatternGen.scala 82:56]
  assign io_out_walk1 = data_reg_walk1; // @[PatternGen.scala 77:16]
  assign io_out_walk0 = data_reg_walk0; // @[PatternGen.scala 78:16]
  assign io_out_alt = data_reg_alt; // @[PatternGen.scala 79:14]
  assign io_out_8bit_cntr = {hi_2,lo_2}; // @[PatternGen.scala 80:52]
  assign io_out_32bit_cntr = {hi_3,lo_3}; // @[PatternGen.scala 81:54]
  assign io_out_128bit_cntr = {hi_4,lo_4}; // @[PatternGen.scala 82:56]
  always @(posedge clock) begin
    if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_walk1 <= 512'h1; // @[PatternGen.scala 50:20]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_walk1 <= _T_3; // @[PatternGen.scala 63:20]
    end
    if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_walk0 <= 512'hfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe
        ; // @[PatternGen.scala 51:20]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_walk0 <= _T_4; // @[PatternGen.scala 64:20]
    end
    if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_alt <= 512'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
        ; // @[PatternGen.scala 52:18]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_alt <= _T_6; // @[PatternGen.scala 65:18]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_0 <= 8'h0; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_0 <= 8'h0; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_0 <= _T_8; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_1 <= 8'h1; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_1 <= 8'h1; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_1 <= _T_10; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_2 <= 8'h2; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_2 <= 8'h2; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_2 <= _T_12; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_3 <= 8'h3; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_3 <= 8'h3; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_3 <= _T_14; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_4 <= 8'h4; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_4 <= 8'h4; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_4 <= _T_16; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_5 <= 8'h5; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_5 <= 8'h5; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_5 <= _T_18; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_6 <= 8'h6; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_6 <= 8'h6; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_6 <= _T_20; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_7 <= 8'h7; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_7 <= 8'h7; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_7 <= _T_22; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_8 <= 8'h8; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_8 <= 8'h8; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_8 <= _T_24; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_9 <= 8'h9; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_9 <= 8'h9; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_9 <= _T_26; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_10 <= 8'ha; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_10 <= 8'ha; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_10 <= _T_28; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_11 <= 8'hb; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_11 <= 8'hb; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_11 <= _T_30; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_12 <= 8'hc; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_12 <= 8'hc; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_12 <= _T_32; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_13 <= 8'hd; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_13 <= 8'hd; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_13 <= _T_34; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_14 <= 8'he; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_14 <= 8'he; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_14 <= _T_36; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_15 <= 8'hf; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_15 <= 8'hf; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_15 <= _T_38; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_16 <= 8'h10; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_16 <= 8'h10; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_16 <= _T_40; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_17 <= 8'h11; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_17 <= 8'h11; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_17 <= _T_42; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_18 <= 8'h12; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_18 <= 8'h12; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_18 <= _T_44; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_19 <= 8'h13; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_19 <= 8'h13; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_19 <= _T_46; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_20 <= 8'h14; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_20 <= 8'h14; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_20 <= _T_48; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_21 <= 8'h15; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_21 <= 8'h15; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_21 <= _T_50; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_22 <= 8'h16; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_22 <= 8'h16; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_22 <= _T_52; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_23 <= 8'h17; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_23 <= 8'h17; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_23 <= _T_54; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_24 <= 8'h18; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_24 <= 8'h18; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_24 <= _T_56; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_25 <= 8'h19; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_25 <= 8'h19; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_25 <= _T_58; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_26 <= 8'h1a; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_26 <= 8'h1a; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_26 <= _T_60; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_27 <= 8'h1b; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_27 <= 8'h1b; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_27 <= _T_62; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_28 <= 8'h1c; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_28 <= 8'h1c; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_28 <= _T_64; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_29 <= 8'h1d; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_29 <= 8'h1d; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_29 <= _T_66; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_30 <= 8'h1e; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_30 <= 8'h1e; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_30 <= _T_68; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_31 <= 8'h1f; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_31 <= 8'h1f; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_31 <= _T_70; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_32 <= 8'h20; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_32 <= 8'h20; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_32 <= _T_72; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_33 <= 8'h21; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_33 <= 8'h21; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_33 <= _T_74; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_34 <= 8'h22; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_34 <= 8'h22; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_34 <= _T_76; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_35 <= 8'h23; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_35 <= 8'h23; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_35 <= _T_78; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_36 <= 8'h24; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_36 <= 8'h24; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_36 <= _T_80; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_37 <= 8'h25; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_37 <= 8'h25; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_37 <= _T_82; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_38 <= 8'h26; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_38 <= 8'h26; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_38 <= _T_84; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_39 <= 8'h27; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_39 <= 8'h27; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_39 <= _T_86; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_40 <= 8'h28; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_40 <= 8'h28; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_40 <= _T_88; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_41 <= 8'h29; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_41 <= 8'h29; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_41 <= _T_90; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_42 <= 8'h2a; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_42 <= 8'h2a; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_42 <= _T_92; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_43 <= 8'h2b; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_43 <= 8'h2b; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_43 <= _T_94; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_44 <= 8'h2c; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_44 <= 8'h2c; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_44 <= _T_96; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_45 <= 8'h2d; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_45 <= 8'h2d; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_45 <= _T_98; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_46 <= 8'h2e; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_46 <= 8'h2e; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_46 <= _T_100; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_47 <= 8'h2f; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_47 <= 8'h2f; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_47 <= _T_102; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_48 <= 8'h30; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_48 <= 8'h30; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_48 <= _T_104; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_49 <= 8'h31; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_49 <= 8'h31; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_49 <= _T_106; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_50 <= 8'h32; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_50 <= 8'h32; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_50 <= _T_108; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_51 <= 8'h33; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_51 <= 8'h33; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_51 <= _T_110; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_52 <= 8'h34; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_52 <= 8'h34; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_52 <= _T_112; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_53 <= 8'h35; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_53 <= 8'h35; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_53 <= _T_114; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_54 <= 8'h36; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_54 <= 8'h36; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_54 <= _T_116; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_55 <= 8'h37; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_55 <= 8'h37; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_55 <= _T_118; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_56 <= 8'h38; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_56 <= 8'h38; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_56 <= _T_120; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_57 <= 8'h39; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_57 <= 8'h39; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_57 <= _T_122; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_58 <= 8'h3a; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_58 <= 8'h3a; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_58 <= _T_124; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_59 <= 8'h3b; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_59 <= 8'h3b; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_59 <= _T_126; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_60 <= 8'h3c; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_60 <= 8'h3c; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_60 <= _T_128; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_61 <= 8'h3d; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_61 <= 8'h3d; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_61 <= _T_130; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_62 <= 8'h3e; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_62 <= 8'h3e; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_62 <= _T_132; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 45:39]
      data_reg_8bit_cntr_vec_63 <= 8'h3f; // @[PatternGen.scala 45:39]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_8bit_cntr_vec_63 <= 8'h3f; // @[PatternGen.scala 54:33]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_8bit_cntr_vec_63 <= _T_134; // @[PatternGen.scala 67:33]
    end
    if (reset) begin // @[PatternGen.scala 46:40]
      data_reg_32bit_cntr_vec_0 <= 32'h0; // @[PatternGen.scala 46:40]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_32bit_cntr_vec_0 <= 32'h0; // @[PatternGen.scala 57:34]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_32bit_cntr_vec_0 <= _T_136; // @[PatternGen.scala 70:34]
    end
    if (reset) begin // @[PatternGen.scala 46:40]
      data_reg_32bit_cntr_vec_1 <= 32'h1; // @[PatternGen.scala 46:40]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_32bit_cntr_vec_1 <= 32'h1; // @[PatternGen.scala 57:34]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_32bit_cntr_vec_1 <= _T_138; // @[PatternGen.scala 70:34]
    end
    if (reset) begin // @[PatternGen.scala 46:40]
      data_reg_32bit_cntr_vec_2 <= 32'h2; // @[PatternGen.scala 46:40]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_32bit_cntr_vec_2 <= 32'h2; // @[PatternGen.scala 57:34]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_32bit_cntr_vec_2 <= _T_140; // @[PatternGen.scala 70:34]
    end
    if (reset) begin // @[PatternGen.scala 46:40]
      data_reg_32bit_cntr_vec_3 <= 32'h3; // @[PatternGen.scala 46:40]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_32bit_cntr_vec_3 <= 32'h3; // @[PatternGen.scala 57:34]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_32bit_cntr_vec_3 <= _T_142; // @[PatternGen.scala 70:34]
    end
    if (reset) begin // @[PatternGen.scala 46:40]
      data_reg_32bit_cntr_vec_4 <= 32'h4; // @[PatternGen.scala 46:40]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_32bit_cntr_vec_4 <= 32'h4; // @[PatternGen.scala 57:34]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_32bit_cntr_vec_4 <= _T_144; // @[PatternGen.scala 70:34]
    end
    if (reset) begin // @[PatternGen.scala 46:40]
      data_reg_32bit_cntr_vec_5 <= 32'h5; // @[PatternGen.scala 46:40]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_32bit_cntr_vec_5 <= 32'h5; // @[PatternGen.scala 57:34]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_32bit_cntr_vec_5 <= _T_146; // @[PatternGen.scala 70:34]
    end
    if (reset) begin // @[PatternGen.scala 46:40]
      data_reg_32bit_cntr_vec_6 <= 32'h6; // @[PatternGen.scala 46:40]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_32bit_cntr_vec_6 <= 32'h6; // @[PatternGen.scala 57:34]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_32bit_cntr_vec_6 <= _T_148; // @[PatternGen.scala 70:34]
    end
    if (reset) begin // @[PatternGen.scala 46:40]
      data_reg_32bit_cntr_vec_7 <= 32'h7; // @[PatternGen.scala 46:40]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_32bit_cntr_vec_7 <= 32'h7; // @[PatternGen.scala 57:34]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_32bit_cntr_vec_7 <= _T_150; // @[PatternGen.scala 70:34]
    end
    if (reset) begin // @[PatternGen.scala 46:40]
      data_reg_32bit_cntr_vec_8 <= 32'h8; // @[PatternGen.scala 46:40]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_32bit_cntr_vec_8 <= 32'h8; // @[PatternGen.scala 57:34]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_32bit_cntr_vec_8 <= _T_152; // @[PatternGen.scala 70:34]
    end
    if (reset) begin // @[PatternGen.scala 46:40]
      data_reg_32bit_cntr_vec_9 <= 32'h9; // @[PatternGen.scala 46:40]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_32bit_cntr_vec_9 <= 32'h9; // @[PatternGen.scala 57:34]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_32bit_cntr_vec_9 <= _T_154; // @[PatternGen.scala 70:34]
    end
    if (reset) begin // @[PatternGen.scala 46:40]
      data_reg_32bit_cntr_vec_10 <= 32'ha; // @[PatternGen.scala 46:40]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_32bit_cntr_vec_10 <= 32'ha; // @[PatternGen.scala 57:34]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_32bit_cntr_vec_10 <= _T_156; // @[PatternGen.scala 70:34]
    end
    if (reset) begin // @[PatternGen.scala 46:40]
      data_reg_32bit_cntr_vec_11 <= 32'hb; // @[PatternGen.scala 46:40]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_32bit_cntr_vec_11 <= 32'hb; // @[PatternGen.scala 57:34]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_32bit_cntr_vec_11 <= _T_158; // @[PatternGen.scala 70:34]
    end
    if (reset) begin // @[PatternGen.scala 46:40]
      data_reg_32bit_cntr_vec_12 <= 32'hc; // @[PatternGen.scala 46:40]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_32bit_cntr_vec_12 <= 32'hc; // @[PatternGen.scala 57:34]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_32bit_cntr_vec_12 <= _T_160; // @[PatternGen.scala 70:34]
    end
    if (reset) begin // @[PatternGen.scala 46:40]
      data_reg_32bit_cntr_vec_13 <= 32'hd; // @[PatternGen.scala 46:40]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_32bit_cntr_vec_13 <= 32'hd; // @[PatternGen.scala 57:34]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_32bit_cntr_vec_13 <= _T_162; // @[PatternGen.scala 70:34]
    end
    if (reset) begin // @[PatternGen.scala 46:40]
      data_reg_32bit_cntr_vec_14 <= 32'he; // @[PatternGen.scala 46:40]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_32bit_cntr_vec_14 <= 32'he; // @[PatternGen.scala 57:34]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_32bit_cntr_vec_14 <= _T_164; // @[PatternGen.scala 70:34]
    end
    if (reset) begin // @[PatternGen.scala 46:40]
      data_reg_32bit_cntr_vec_15 <= 32'hf; // @[PatternGen.scala 46:40]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_32bit_cntr_vec_15 <= 32'hf; // @[PatternGen.scala 57:34]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_32bit_cntr_vec_15 <= _T_166; // @[PatternGen.scala 70:34]
    end
    if (reset) begin // @[PatternGen.scala 47:41]
      data_reg_128bit_cntr_vec_0 <= 128'h0; // @[PatternGen.scala 47:41]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_128bit_cntr_vec_0 <= 128'h0; // @[PatternGen.scala 60:35]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_128bit_cntr_vec_0 <= _T_168; // @[PatternGen.scala 73:35]
    end
    if (reset) begin // @[PatternGen.scala 47:41]
      data_reg_128bit_cntr_vec_1 <= 128'h1; // @[PatternGen.scala 47:41]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_128bit_cntr_vec_1 <= 128'h1; // @[PatternGen.scala 60:35]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_128bit_cntr_vec_1 <= _T_170; // @[PatternGen.scala 73:35]
    end
    if (reset) begin // @[PatternGen.scala 47:41]
      data_reg_128bit_cntr_vec_2 <= 128'h2; // @[PatternGen.scala 47:41]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_128bit_cntr_vec_2 <= 128'h2; // @[PatternGen.scala 60:35]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_128bit_cntr_vec_2 <= _T_172; // @[PatternGen.scala 73:35]
    end
    if (reset) begin // @[PatternGen.scala 47:41]
      data_reg_128bit_cntr_vec_3 <= 128'h3; // @[PatternGen.scala 47:41]
    end else if (io_data_init) begin // @[PatternGen.scala 49:22]
      data_reg_128bit_cntr_vec_3 <= 128'h3; // @[PatternGen.scala 60:35]
    end else if (io_data_inc) begin // @[PatternGen.scala 62:27]
      data_reg_128bit_cntr_vec_3 <= _T_174; // @[PatternGen.scala 73:35]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {16{`RANDOM}};
  data_reg_walk1 = _RAND_0[511:0];
  _RAND_1 = {16{`RANDOM}};
  data_reg_walk0 = _RAND_1[511:0];
  _RAND_2 = {16{`RANDOM}};
  data_reg_alt = _RAND_2[511:0];
  _RAND_3 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_0 = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_1 = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_2 = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_3 = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_4 = _RAND_7[7:0];
  _RAND_8 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_5 = _RAND_8[7:0];
  _RAND_9 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_6 = _RAND_9[7:0];
  _RAND_10 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_7 = _RAND_10[7:0];
  _RAND_11 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_8 = _RAND_11[7:0];
  _RAND_12 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_9 = _RAND_12[7:0];
  _RAND_13 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_10 = _RAND_13[7:0];
  _RAND_14 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_11 = _RAND_14[7:0];
  _RAND_15 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_12 = _RAND_15[7:0];
  _RAND_16 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_13 = _RAND_16[7:0];
  _RAND_17 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_14 = _RAND_17[7:0];
  _RAND_18 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_15 = _RAND_18[7:0];
  _RAND_19 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_16 = _RAND_19[7:0];
  _RAND_20 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_17 = _RAND_20[7:0];
  _RAND_21 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_18 = _RAND_21[7:0];
  _RAND_22 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_19 = _RAND_22[7:0];
  _RAND_23 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_20 = _RAND_23[7:0];
  _RAND_24 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_21 = _RAND_24[7:0];
  _RAND_25 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_22 = _RAND_25[7:0];
  _RAND_26 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_23 = _RAND_26[7:0];
  _RAND_27 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_24 = _RAND_27[7:0];
  _RAND_28 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_25 = _RAND_28[7:0];
  _RAND_29 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_26 = _RAND_29[7:0];
  _RAND_30 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_27 = _RAND_30[7:0];
  _RAND_31 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_28 = _RAND_31[7:0];
  _RAND_32 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_29 = _RAND_32[7:0];
  _RAND_33 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_30 = _RAND_33[7:0];
  _RAND_34 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_31 = _RAND_34[7:0];
  _RAND_35 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_32 = _RAND_35[7:0];
  _RAND_36 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_33 = _RAND_36[7:0];
  _RAND_37 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_34 = _RAND_37[7:0];
  _RAND_38 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_35 = _RAND_38[7:0];
  _RAND_39 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_36 = _RAND_39[7:0];
  _RAND_40 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_37 = _RAND_40[7:0];
  _RAND_41 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_38 = _RAND_41[7:0];
  _RAND_42 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_39 = _RAND_42[7:0];
  _RAND_43 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_40 = _RAND_43[7:0];
  _RAND_44 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_41 = _RAND_44[7:0];
  _RAND_45 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_42 = _RAND_45[7:0];
  _RAND_46 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_43 = _RAND_46[7:0];
  _RAND_47 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_44 = _RAND_47[7:0];
  _RAND_48 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_45 = _RAND_48[7:0];
  _RAND_49 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_46 = _RAND_49[7:0];
  _RAND_50 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_47 = _RAND_50[7:0];
  _RAND_51 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_48 = _RAND_51[7:0];
  _RAND_52 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_49 = _RAND_52[7:0];
  _RAND_53 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_50 = _RAND_53[7:0];
  _RAND_54 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_51 = _RAND_54[7:0];
  _RAND_55 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_52 = _RAND_55[7:0];
  _RAND_56 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_53 = _RAND_56[7:0];
  _RAND_57 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_54 = _RAND_57[7:0];
  _RAND_58 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_55 = _RAND_58[7:0];
  _RAND_59 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_56 = _RAND_59[7:0];
  _RAND_60 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_57 = _RAND_60[7:0];
  _RAND_61 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_58 = _RAND_61[7:0];
  _RAND_62 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_59 = _RAND_62[7:0];
  _RAND_63 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_60 = _RAND_63[7:0];
  _RAND_64 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_61 = _RAND_64[7:0];
  _RAND_65 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_62 = _RAND_65[7:0];
  _RAND_66 = {1{`RANDOM}};
  data_reg_8bit_cntr_vec_63 = _RAND_66[7:0];
  _RAND_67 = {1{`RANDOM}};
  data_reg_32bit_cntr_vec_0 = _RAND_67[31:0];
  _RAND_68 = {1{`RANDOM}};
  data_reg_32bit_cntr_vec_1 = _RAND_68[31:0];
  _RAND_69 = {1{`RANDOM}};
  data_reg_32bit_cntr_vec_2 = _RAND_69[31:0];
  _RAND_70 = {1{`RANDOM}};
  data_reg_32bit_cntr_vec_3 = _RAND_70[31:0];
  _RAND_71 = {1{`RANDOM}};
  data_reg_32bit_cntr_vec_4 = _RAND_71[31:0];
  _RAND_72 = {1{`RANDOM}};
  data_reg_32bit_cntr_vec_5 = _RAND_72[31:0];
  _RAND_73 = {1{`RANDOM}};
  data_reg_32bit_cntr_vec_6 = _RAND_73[31:0];
  _RAND_74 = {1{`RANDOM}};
  data_reg_32bit_cntr_vec_7 = _RAND_74[31:0];
  _RAND_75 = {1{`RANDOM}};
  data_reg_32bit_cntr_vec_8 = _RAND_75[31:0];
  _RAND_76 = {1{`RANDOM}};
  data_reg_32bit_cntr_vec_9 = _RAND_76[31:0];
  _RAND_77 = {1{`RANDOM}};
  data_reg_32bit_cntr_vec_10 = _RAND_77[31:0];
  _RAND_78 = {1{`RANDOM}};
  data_reg_32bit_cntr_vec_11 = _RAND_78[31:0];
  _RAND_79 = {1{`RANDOM}};
  data_reg_32bit_cntr_vec_12 = _RAND_79[31:0];
  _RAND_80 = {1{`RANDOM}};
  data_reg_32bit_cntr_vec_13 = _RAND_80[31:0];
  _RAND_81 = {1{`RANDOM}};
  data_reg_32bit_cntr_vec_14 = _RAND_81[31:0];
  _RAND_82 = {1{`RANDOM}};
  data_reg_32bit_cntr_vec_15 = _RAND_82[31:0];
  _RAND_83 = {4{`RANDOM}};
  data_reg_128bit_cntr_vec_0 = _RAND_83[127:0];
  _RAND_84 = {4{`RANDOM}};
  data_reg_128bit_cntr_vec_1 = _RAND_84[127:0];
  _RAND_85 = {4{`RANDOM}};
  data_reg_128bit_cntr_vec_2 = _RAND_85[127:0];
  _RAND_86 = {4{`RANDOM}};
  data_reg_128bit_cntr_vec_3 = _RAND_86[127:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DataDriver(
  input          clock,
  input          reset,
  input  [3:0]   io_ctrl_mode,
  input          io_data_init,
  input          io_data_inc,
  output [511:0] io_data_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  mod_pattern_gen_clock; // @[DataDriver.scala 52:31]
  wire  mod_pattern_gen_reset; // @[DataDriver.scala 52:31]
  wire  mod_pattern_gen_io_data_init; // @[DataDriver.scala 52:31]
  wire  mod_pattern_gen_io_data_inc; // @[DataDriver.scala 52:31]
  wire [511:0] mod_pattern_gen_io_out_walk1; // @[DataDriver.scala 52:31]
  wire [511:0] mod_pattern_gen_io_out_walk0; // @[DataDriver.scala 52:31]
  wire [511:0] mod_pattern_gen_io_out_alt; // @[DataDriver.scala 52:31]
  wire [511:0] mod_pattern_gen_io_out_8bit_cntr; // @[DataDriver.scala 52:31]
  wire [511:0] mod_pattern_gen_io_out_32bit_cntr; // @[DataDriver.scala 52:31]
  wire [511:0] mod_pattern_gen_io_out_128bit_cntr; // @[DataDriver.scala 52:31]
  reg [3:0] mode_reg; // @[DataDriver.scala 50:25]
  wire  _T = 4'h0 == mode_reg; // @[Conditional.scala 37:30]
  wire  _T_1 = 4'h1 == mode_reg; // @[Conditional.scala 37:30]
  wire  _T_3 = 4'h2 == mode_reg; // @[Conditional.scala 37:30]
  wire  _T_4 = 4'h3 == mode_reg; // @[Conditional.scala 37:30]
  wire  _T_5 = 4'h4 == mode_reg; // @[Conditional.scala 37:30]
  wire  _T_6 = 4'h5 == mode_reg; // @[Conditional.scala 37:30]
  wire  _T_7 = 4'h6 == mode_reg; // @[Conditional.scala 37:30]
  wire  _T_8 = 4'h7 == mode_reg; // @[Conditional.scala 37:30]
  wire [511:0] _GEN_0 = _T_8 ? mod_pattern_gen_io_out_128bit_cntr : 512'h0; // @[Conditional.scala 39:67 DataDriver.scala 66:28 DataDriver.scala 56:16]
  wire [511:0] _GEN_1 = _T_7 ? mod_pattern_gen_io_out_32bit_cntr : _GEN_0; // @[Conditional.scala 39:67 DataDriver.scala 65:28]
  wire [511:0] _GEN_2 = _T_6 ? mod_pattern_gen_io_out_8bit_cntr : _GEN_1; // @[Conditional.scala 39:67 DataDriver.scala 64:28]
  wire [511:0] _GEN_3 = _T_5 ? mod_pattern_gen_io_out_alt : _GEN_2; // @[Conditional.scala 39:67 DataDriver.scala 63:28]
  wire [511:0] _GEN_4 = _T_4 ? mod_pattern_gen_io_out_walk0 : _GEN_3; // @[Conditional.scala 39:67 DataDriver.scala 62:28]
  wire [511:0] _GEN_5 = _T_3 ? mod_pattern_gen_io_out_walk1 : _GEN_4; // @[Conditional.scala 39:67 DataDriver.scala 61:28]
  wire [511:0] _GEN_6 = _T_1 ? 512'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
     : _GEN_5; // @[Conditional.scala 39:67 DataDriver.scala 60:28]
  PatternGen mod_pattern_gen ( // @[DataDriver.scala 52:31]
    .clock(mod_pattern_gen_clock),
    .reset(mod_pattern_gen_reset),
    .io_data_init(mod_pattern_gen_io_data_init),
    .io_data_inc(mod_pattern_gen_io_data_inc),
    .io_out_walk1(mod_pattern_gen_io_out_walk1),
    .io_out_walk0(mod_pattern_gen_io_out_walk0),
    .io_out_alt(mod_pattern_gen_io_out_alt),
    .io_out_8bit_cntr(mod_pattern_gen_io_out_8bit_cntr),
    .io_out_32bit_cntr(mod_pattern_gen_io_out_32bit_cntr),
    .io_out_128bit_cntr(mod_pattern_gen_io_out_128bit_cntr)
  );
  assign io_data_data = _T ? 512'h0 : _GEN_6; // @[Conditional.scala 40:58 DataDriver.scala 59:28]
  assign mod_pattern_gen_clock = clock;
  assign mod_pattern_gen_reset = reset;
  assign mod_pattern_gen_io_data_init = io_data_init; // @[DataDriver.scala 53:32]
  assign mod_pattern_gen_io_data_inc = io_data_inc; // @[DataDriver.scala 54:31]
  always @(posedge clock) begin
    mode_reg <= io_ctrl_mode; // @[DataDriver.scala 50:25]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  mode_reg = _RAND_0[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DataChecker(
  input          clock,
  input          reset,
  input  [3:0]   io_ctrl_mode,
  input          io_data_init,
  input          io_data_inc,
  input  [511:0] io_data_data,
  output [31:0]  io_check_tot,
  output [31:0]  io_check_ok
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  wire  mod_pattern_gen_clock; // @[DataChecker.scala 55:31]
  wire  mod_pattern_gen_reset; // @[DataChecker.scala 55:31]
  wire  mod_pattern_gen_io_data_init; // @[DataChecker.scala 55:31]
  wire  mod_pattern_gen_io_data_inc; // @[DataChecker.scala 55:31]
  wire [511:0] mod_pattern_gen_io_out_walk1; // @[DataChecker.scala 55:31]
  wire [511:0] mod_pattern_gen_io_out_walk0; // @[DataChecker.scala 55:31]
  wire [511:0] mod_pattern_gen_io_out_alt; // @[DataChecker.scala 55:31]
  wire [511:0] mod_pattern_gen_io_out_8bit_cntr; // @[DataChecker.scala 55:31]
  wire [511:0] mod_pattern_gen_io_out_32bit_cntr; // @[DataChecker.scala 55:31]
  wire [511:0] mod_pattern_gen_io_out_128bit_cntr; // @[DataChecker.scala 55:31]
  reg [3:0] mode_reg; // @[DataChecker.scala 53:25]
  wire  _T = 4'h0 == mode_reg; // @[Conditional.scala 37:30]
  wire  _T_1 = 4'h1 == mode_reg; // @[Conditional.scala 37:30]
  wire  _T_3 = 4'h2 == mode_reg; // @[Conditional.scala 37:30]
  wire  _T_4 = 4'h3 == mode_reg; // @[Conditional.scala 37:30]
  wire  _T_5 = 4'h4 == mode_reg; // @[Conditional.scala 37:30]
  wire  _T_6 = 4'h5 == mode_reg; // @[Conditional.scala 37:30]
  wire  _T_7 = 4'h6 == mode_reg; // @[Conditional.scala 37:30]
  wire  _T_8 = 4'h7 == mode_reg; // @[Conditional.scala 37:30]
  wire [511:0] _GEN_0 = _T_8 ? mod_pattern_gen_io_out_128bit_cntr : 512'h0; // @[Conditional.scala 39:67 DataChecker.scala 71:27 DataChecker.scala 61:15]
  wire [511:0] _GEN_1 = _T_7 ? mod_pattern_gen_io_out_32bit_cntr : _GEN_0; // @[Conditional.scala 39:67 DataChecker.scala 70:27]
  wire [511:0] _GEN_2 = _T_6 ? mod_pattern_gen_io_out_8bit_cntr : _GEN_1; // @[Conditional.scala 39:67 DataChecker.scala 69:27]
  wire [511:0] _GEN_3 = _T_5 ? mod_pattern_gen_io_out_alt : _GEN_2; // @[Conditional.scala 39:67 DataChecker.scala 68:27]
  wire [511:0] _GEN_4 = _T_4 ? mod_pattern_gen_io_out_walk0 : _GEN_3; // @[Conditional.scala 39:67 DataChecker.scala 67:27]
  wire [511:0] _GEN_5 = _T_3 ? mod_pattern_gen_io_out_walk1 : _GEN_4; // @[Conditional.scala 39:67 DataChecker.scala 66:27]
  wire [511:0] _GEN_6 = _T_1 ? 512'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
     : _GEN_5; // @[Conditional.scala 39:67 DataChecker.scala 65:27]
  wire [511:0] data_to_cmp = _T ? 512'h0 : _GEN_6; // @[Conditional.scala 40:58 DataChecker.scala 64:27]
  reg [31:0] check_tot_reg; // @[DataChecker.scala 75:26]
  reg [31:0] check_ok_reg; // @[DataChecker.scala 76:25]
  reg  REG; // @[DataChecker.scala 80:15]
  reg  REG_1; // @[DataChecker.scala 83:21]
  wire [31:0] _T_10 = check_tot_reg + 32'h1; // @[DataChecker.scala 84:36]
  reg  REG_2; // @[DataChecker.scala 85:17]
  wire [31:0] _T_13 = check_ok_reg + 32'h1; // @[DataChecker.scala 86:36]
  PatternGen mod_pattern_gen ( // @[DataChecker.scala 55:31]
    .clock(mod_pattern_gen_clock),
    .reset(mod_pattern_gen_reset),
    .io_data_init(mod_pattern_gen_io_data_init),
    .io_data_inc(mod_pattern_gen_io_data_inc),
    .io_out_walk1(mod_pattern_gen_io_out_walk1),
    .io_out_walk0(mod_pattern_gen_io_out_walk0),
    .io_out_alt(mod_pattern_gen_io_out_alt),
    .io_out_8bit_cntr(mod_pattern_gen_io_out_8bit_cntr),
    .io_out_32bit_cntr(mod_pattern_gen_io_out_32bit_cntr),
    .io_out_128bit_cntr(mod_pattern_gen_io_out_128bit_cntr)
  );
  assign io_check_tot = check_tot_reg; // @[DataChecker.scala 77:16]
  assign io_check_ok = check_ok_reg; // @[DataChecker.scala 78:15]
  assign mod_pattern_gen_clock = clock;
  assign mod_pattern_gen_reset = reset;
  assign mod_pattern_gen_io_data_init = io_data_init; // @[DataChecker.scala 56:32]
  assign mod_pattern_gen_io_data_inc = io_data_inc; // @[DataChecker.scala 57:31]
  always @(posedge clock) begin
    mode_reg <= io_ctrl_mode; // @[DataChecker.scala 53:25]
    if (REG) begin // @[DataChecker.scala 80:31]
      check_tot_reg <= 32'h0; // @[DataChecker.scala 81:19]
    end else if (REG_1) begin // @[DataChecker.scala 83:36]
      check_tot_reg <= _T_10; // @[DataChecker.scala 84:19]
    end
    if (REG) begin // @[DataChecker.scala 80:31]
      check_ok_reg <= 32'h0; // @[DataChecker.scala 82:18]
    end else if (REG_1) begin // @[DataChecker.scala 83:36]
      if (REG_2) begin // @[DataChecker.scala 85:49]
        check_ok_reg <= _T_13; // @[DataChecker.scala 86:20]
      end
    end
    REG <= io_data_init; // @[DataChecker.scala 80:15]
    REG_1 <= io_data_inc; // @[DataChecker.scala 83:21]
    REG_2 <= data_to_cmp == io_data_data; // @[DataChecker.scala 85:30]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  mode_reg = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  check_tot_reg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  check_ok_reg = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  REG = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  REG_1 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  REG_2 = _RAND_5[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MemChecker(
  input          clock,
  input          reset,
  output [31:0]  io_mem_address,
  output [63:0]  io_mem_byteenable,
  output         io_mem_read,
  input  [511:0] io_mem_readdata,
  input  [1:0]   io_mem_response,
  output         io_mem_write,
  output [511:0] io_mem_writedata,
  input          io_mem_waitrequest,
  input          io_mem_readdatavalid,
  input          io_mem_writeresponsevalid,
  output [7:0]   io_mem_burstcount,
  output         io_ctrl_AW_ready,
  input          io_ctrl_AW_valid,
  input  [7:0]   io_ctrl_AW_bits_addr,
  input  [2:0]   io_ctrl_AW_bits_prot,
  output         io_ctrl_W_ready,
  input          io_ctrl_W_valid,
  input  [31:0]  io_ctrl_W_bits_wdata,
  input  [3:0]   io_ctrl_W_bits_wstrb,
  input          io_ctrl_B_ready,
  output         io_ctrl_B_valid,
  output [1:0]   io_ctrl_B_bits,
  output         io_ctrl_AR_ready,
  input          io_ctrl_AR_valid,
  input  [7:0]   io_ctrl_AR_bits_addr,
  input  [2:0]   io_ctrl_AR_bits_prot,
  input          io_ctrl_R_ready,
  output         io_ctrl_R_valid,
  output [31:0]  io_ctrl_R_bits_rdata,
  output [1:0]   io_ctrl_R_bits_rresp
);
  wire  mod_axi_slave_clock; // @[MemChecker.scala 41:29]
  wire  mod_axi_slave_reset; // @[MemChecker.scala 41:29]
  wire  mod_axi_slave_io_ctrl_AW_ready; // @[MemChecker.scala 41:29]
  wire  mod_axi_slave_io_ctrl_AW_valid; // @[MemChecker.scala 41:29]
  wire [7:0] mod_axi_slave_io_ctrl_AW_bits_addr; // @[MemChecker.scala 41:29]
  wire  mod_axi_slave_io_ctrl_W_ready; // @[MemChecker.scala 41:29]
  wire  mod_axi_slave_io_ctrl_W_valid; // @[MemChecker.scala 41:29]
  wire [31:0] mod_axi_slave_io_ctrl_W_bits_wdata; // @[MemChecker.scala 41:29]
  wire  mod_axi_slave_io_ctrl_B_ready; // @[MemChecker.scala 41:29]
  wire  mod_axi_slave_io_ctrl_B_valid; // @[MemChecker.scala 41:29]
  wire  mod_axi_slave_io_ctrl_AR_ready; // @[MemChecker.scala 41:29]
  wire  mod_axi_slave_io_ctrl_AR_valid; // @[MemChecker.scala 41:29]
  wire [7:0] mod_axi_slave_io_ctrl_AR_bits_addr; // @[MemChecker.scala 41:29]
  wire  mod_axi_slave_io_ctrl_R_ready; // @[MemChecker.scala 41:29]
  wire  mod_axi_slave_io_ctrl_R_valid; // @[MemChecker.scala 41:29]
  wire [31:0] mod_axi_slave_io_ctrl_R_bits_rdata; // @[MemChecker.scala 41:29]
  wire  mod_axi_slave_io_ctrl_dir; // @[MemChecker.scala 41:29]
  wire [2:0] mod_axi_slave_io_ctrl_mode; // @[MemChecker.scala 41:29]
  wire [63:0] mod_axi_slave_io_read_addr; // @[MemChecker.scala 41:29]
  wire [31:0] mod_axi_slave_io_read_len; // @[MemChecker.scala 41:29]
  wire  mod_axi_slave_io_read_start; // @[MemChecker.scala 41:29]
  wire [31:0] mod_axi_slave_io_rd_stats_resp_cntr; // @[MemChecker.scala 41:29]
  wire  mod_axi_slave_io_rd_stats_done; // @[MemChecker.scala 41:29]
  wire [31:0] mod_axi_slave_io_rd_stats_duration; // @[MemChecker.scala 41:29]
  wire [63:0] mod_axi_slave_io_write_addr; // @[MemChecker.scala 41:29]
  wire [31:0] mod_axi_slave_io_write_len; // @[MemChecker.scala 41:29]
  wire  mod_axi_slave_io_write_start; // @[MemChecker.scala 41:29]
  wire [31:0] mod_axi_slave_io_wr_stats_resp_cntr; // @[MemChecker.scala 41:29]
  wire  mod_axi_slave_io_wr_stats_done; // @[MemChecker.scala 41:29]
  wire [31:0] mod_axi_slave_io_wr_stats_duration; // @[MemChecker.scala 41:29]
  wire [31:0] mod_axi_slave_io_check_tot; // @[MemChecker.scala 41:29]
  wire [31:0] mod_axi_slave_io_check_ok; // @[MemChecker.scala 41:29]
  wire  mod_avalon_wr_clock; // @[MemChecker.scala 49:29]
  wire  mod_avalon_wr_reset; // @[MemChecker.scala 49:29]
  wire [31:0] mod_avalon_wr_io_address; // @[MemChecker.scala 49:29]
  wire [1:0] mod_avalon_wr_io_response; // @[MemChecker.scala 49:29]
  wire  mod_avalon_wr_io_write; // @[MemChecker.scala 49:29]
  wire [511:0] mod_avalon_wr_io_writedata; // @[MemChecker.scala 49:29]
  wire  mod_avalon_wr_io_waitrequest; // @[MemChecker.scala 49:29]
  wire  mod_avalon_wr_io_writeresponsevalid; // @[MemChecker.scala 49:29]
  wire [7:0] mod_avalon_wr_io_burstcount; // @[MemChecker.scala 49:29]
  wire [31:0] mod_avalon_wr_io_ctrl_addr; // @[MemChecker.scala 49:29]
  wire [31:0] mod_avalon_wr_io_ctrl_len_bytes; // @[MemChecker.scala 49:29]
  wire  mod_avalon_wr_io_ctrl_start; // @[MemChecker.scala 49:29]
  wire  mod_avalon_wr_io_data_init; // @[MemChecker.scala 49:29]
  wire  mod_avalon_wr_io_data_inc; // @[MemChecker.scala 49:29]
  wire [511:0] mod_avalon_wr_io_data_data; // @[MemChecker.scala 49:29]
  wire [31:0] mod_avalon_wr_io_stats_resp_cntr; // @[MemChecker.scala 49:29]
  wire  mod_avalon_wr_io_stats_done; // @[MemChecker.scala 49:29]
  wire [31:0] mod_avalon_wr_io_stats_duration; // @[MemChecker.scala 49:29]
  wire  mod_avalon_rd_clock; // @[MemChecker.scala 50:29]
  wire  mod_avalon_rd_reset; // @[MemChecker.scala 50:29]
  wire [31:0] mod_avalon_rd_io_address; // @[MemChecker.scala 50:29]
  wire  mod_avalon_rd_io_read; // @[MemChecker.scala 50:29]
  wire [511:0] mod_avalon_rd_io_readdata; // @[MemChecker.scala 50:29]
  wire [1:0] mod_avalon_rd_io_response; // @[MemChecker.scala 50:29]
  wire  mod_avalon_rd_io_waitrequest; // @[MemChecker.scala 50:29]
  wire  mod_avalon_rd_io_readdatavalid; // @[MemChecker.scala 50:29]
  wire [7:0] mod_avalon_rd_io_burstcount; // @[MemChecker.scala 50:29]
  wire [31:0] mod_avalon_rd_io_ctrl_addr; // @[MemChecker.scala 50:29]
  wire [31:0] mod_avalon_rd_io_ctrl_len_bytes; // @[MemChecker.scala 50:29]
  wire  mod_avalon_rd_io_ctrl_start; // @[MemChecker.scala 50:29]
  wire  mod_avalon_rd_io_data_init; // @[MemChecker.scala 50:29]
  wire  mod_avalon_rd_io_data_inc; // @[MemChecker.scala 50:29]
  wire [511:0] mod_avalon_rd_io_data_data; // @[MemChecker.scala 50:29]
  wire [31:0] mod_avalon_rd_io_stats_resp_cntr; // @[MemChecker.scala 50:29]
  wire  mod_avalon_rd_io_stats_done; // @[MemChecker.scala 50:29]
  wire [31:0] mod_avalon_rd_io_stats_duration; // @[MemChecker.scala 50:29]
  wire  mod_data_drv_clock; // @[MemChecker.scala 52:28]
  wire  mod_data_drv_reset; // @[MemChecker.scala 52:28]
  wire [3:0] mod_data_drv_io_ctrl_mode; // @[MemChecker.scala 52:28]
  wire  mod_data_drv_io_data_init; // @[MemChecker.scala 52:28]
  wire  mod_data_drv_io_data_inc; // @[MemChecker.scala 52:28]
  wire [511:0] mod_data_drv_io_data_data; // @[MemChecker.scala 52:28]
  wire  mod_data_chk_clock; // @[MemChecker.scala 53:28]
  wire  mod_data_chk_reset; // @[MemChecker.scala 53:28]
  wire [3:0] mod_data_chk_io_ctrl_mode; // @[MemChecker.scala 53:28]
  wire  mod_data_chk_io_data_init; // @[MemChecker.scala 53:28]
  wire  mod_data_chk_io_data_inc; // @[MemChecker.scala 53:28]
  wire [511:0] mod_data_chk_io_data_data; // @[MemChecker.scala 53:28]
  wire [31:0] mod_data_chk_io_check_tot; // @[MemChecker.scala 53:28]
  wire [31:0] mod_data_chk_io_check_ok; // @[MemChecker.scala 53:28]
  MemCheckerAxiSlave mod_axi_slave ( // @[MemChecker.scala 41:29]
    .clock(mod_axi_slave_clock),
    .reset(mod_axi_slave_reset),
    .io_ctrl_AW_ready(mod_axi_slave_io_ctrl_AW_ready),
    .io_ctrl_AW_valid(mod_axi_slave_io_ctrl_AW_valid),
    .io_ctrl_AW_bits_addr(mod_axi_slave_io_ctrl_AW_bits_addr),
    .io_ctrl_W_ready(mod_axi_slave_io_ctrl_W_ready),
    .io_ctrl_W_valid(mod_axi_slave_io_ctrl_W_valid),
    .io_ctrl_W_bits_wdata(mod_axi_slave_io_ctrl_W_bits_wdata),
    .io_ctrl_B_ready(mod_axi_slave_io_ctrl_B_ready),
    .io_ctrl_B_valid(mod_axi_slave_io_ctrl_B_valid),
    .io_ctrl_AR_ready(mod_axi_slave_io_ctrl_AR_ready),
    .io_ctrl_AR_valid(mod_axi_slave_io_ctrl_AR_valid),
    .io_ctrl_AR_bits_addr(mod_axi_slave_io_ctrl_AR_bits_addr),
    .io_ctrl_R_ready(mod_axi_slave_io_ctrl_R_ready),
    .io_ctrl_R_valid(mod_axi_slave_io_ctrl_R_valid),
    .io_ctrl_R_bits_rdata(mod_axi_slave_io_ctrl_R_bits_rdata),
    .io_ctrl_dir(mod_axi_slave_io_ctrl_dir),
    .io_ctrl_mode(mod_axi_slave_io_ctrl_mode),
    .io_read_addr(mod_axi_slave_io_read_addr),
    .io_read_len(mod_axi_slave_io_read_len),
    .io_read_start(mod_axi_slave_io_read_start),
    .io_rd_stats_resp_cntr(mod_axi_slave_io_rd_stats_resp_cntr),
    .io_rd_stats_done(mod_axi_slave_io_rd_stats_done),
    .io_rd_stats_duration(mod_axi_slave_io_rd_stats_duration),
    .io_write_addr(mod_axi_slave_io_write_addr),
    .io_write_len(mod_axi_slave_io_write_len),
    .io_write_start(mod_axi_slave_io_write_start),
    .io_wr_stats_resp_cntr(mod_axi_slave_io_wr_stats_resp_cntr),
    .io_wr_stats_done(mod_axi_slave_io_wr_stats_done),
    .io_wr_stats_duration(mod_axi_slave_io_wr_stats_duration),
    .io_check_tot(mod_axi_slave_io_check_tot),
    .io_check_ok(mod_axi_slave_io_check_ok)
  );
  AvalonMMWriter mod_avalon_wr ( // @[MemChecker.scala 49:29]
    .clock(mod_avalon_wr_clock),
    .reset(mod_avalon_wr_reset),
    .io_address(mod_avalon_wr_io_address),
    .io_response(mod_avalon_wr_io_response),
    .io_write(mod_avalon_wr_io_write),
    .io_writedata(mod_avalon_wr_io_writedata),
    .io_waitrequest(mod_avalon_wr_io_waitrequest),
    .io_writeresponsevalid(mod_avalon_wr_io_writeresponsevalid),
    .io_burstcount(mod_avalon_wr_io_burstcount),
    .io_ctrl_addr(mod_avalon_wr_io_ctrl_addr),
    .io_ctrl_len_bytes(mod_avalon_wr_io_ctrl_len_bytes),
    .io_ctrl_start(mod_avalon_wr_io_ctrl_start),
    .io_data_init(mod_avalon_wr_io_data_init),
    .io_data_inc(mod_avalon_wr_io_data_inc),
    .io_data_data(mod_avalon_wr_io_data_data),
    .io_stats_resp_cntr(mod_avalon_wr_io_stats_resp_cntr),
    .io_stats_done(mod_avalon_wr_io_stats_done),
    .io_stats_duration(mod_avalon_wr_io_stats_duration)
  );
  AvalonMMReader mod_avalon_rd ( // @[MemChecker.scala 50:29]
    .clock(mod_avalon_rd_clock),
    .reset(mod_avalon_rd_reset),
    .io_address(mod_avalon_rd_io_address),
    .io_read(mod_avalon_rd_io_read),
    .io_readdata(mod_avalon_rd_io_readdata),
    .io_response(mod_avalon_rd_io_response),
    .io_waitrequest(mod_avalon_rd_io_waitrequest),
    .io_readdatavalid(mod_avalon_rd_io_readdatavalid),
    .io_burstcount(mod_avalon_rd_io_burstcount),
    .io_ctrl_addr(mod_avalon_rd_io_ctrl_addr),
    .io_ctrl_len_bytes(mod_avalon_rd_io_ctrl_len_bytes),
    .io_ctrl_start(mod_avalon_rd_io_ctrl_start),
    .io_data_init(mod_avalon_rd_io_data_init),
    .io_data_inc(mod_avalon_rd_io_data_inc),
    .io_data_data(mod_avalon_rd_io_data_data),
    .io_stats_resp_cntr(mod_avalon_rd_io_stats_resp_cntr),
    .io_stats_done(mod_avalon_rd_io_stats_done),
    .io_stats_duration(mod_avalon_rd_io_stats_duration)
  );
  DataDriver mod_data_drv ( // @[MemChecker.scala 52:28]
    .clock(mod_data_drv_clock),
    .reset(mod_data_drv_reset),
    .io_ctrl_mode(mod_data_drv_io_ctrl_mode),
    .io_data_init(mod_data_drv_io_data_init),
    .io_data_inc(mod_data_drv_io_data_inc),
    .io_data_data(mod_data_drv_io_data_data)
  );
  DataChecker mod_data_chk ( // @[MemChecker.scala 53:28]
    .clock(mod_data_chk_clock),
    .reset(mod_data_chk_reset),
    .io_ctrl_mode(mod_data_chk_io_ctrl_mode),
    .io_data_init(mod_data_chk_io_data_init),
    .io_data_inc(mod_data_chk_io_data_inc),
    .io_data_data(mod_data_chk_io_data_data),
    .io_check_tot(mod_data_chk_io_check_tot),
    .io_check_ok(mod_data_chk_io_check_ok)
  );
  assign io_mem_address = mod_axi_slave_io_ctrl_dir ? mod_avalon_wr_io_address : mod_avalon_rd_io_address; // @[MemChecker.scala 104:35 MemChecker.scala 105:20 MemChecker.scala 108:20]
  assign io_mem_byteenable = 64'hffffffffffffffff; // @[MemChecker.scala 58:21]
  assign io_mem_read = mod_avalon_rd_io_read; // @[MemChecker.scala 80:15]
  assign io_mem_write = mod_avalon_wr_io_write; // @[MemChecker.scala 59:16]
  assign io_mem_writedata = mod_avalon_wr_io_writedata; // @[MemChecker.scala 60:20]
  assign io_mem_burstcount = mod_axi_slave_io_ctrl_dir ? mod_avalon_wr_io_burstcount : mod_avalon_rd_io_burstcount; // @[MemChecker.scala 104:35 MemChecker.scala 106:23 MemChecker.scala 109:23]
  assign io_ctrl_AW_ready = mod_axi_slave_io_ctrl_AW_ready; // @[MemChecker.scala 55:11]
  assign io_ctrl_W_ready = mod_axi_slave_io_ctrl_W_ready; // @[MemChecker.scala 55:11]
  assign io_ctrl_B_valid = mod_axi_slave_io_ctrl_B_valid; // @[MemChecker.scala 55:11]
  assign io_ctrl_B_bits = 2'h0; // @[MemChecker.scala 55:11]
  assign io_ctrl_AR_ready = mod_axi_slave_io_ctrl_AR_ready; // @[MemChecker.scala 55:11]
  assign io_ctrl_R_valid = mod_axi_slave_io_ctrl_R_valid; // @[MemChecker.scala 55:11]
  assign io_ctrl_R_bits_rdata = mod_axi_slave_io_ctrl_R_bits_rdata; // @[MemChecker.scala 55:11]
  assign io_ctrl_R_bits_rresp = 2'h0; // @[MemChecker.scala 55:11]
  assign mod_axi_slave_clock = clock;
  assign mod_axi_slave_reset = reset;
  assign mod_axi_slave_io_ctrl_AW_valid = io_ctrl_AW_valid; // @[MemChecker.scala 55:11]
  assign mod_axi_slave_io_ctrl_AW_bits_addr = io_ctrl_AW_bits_addr; // @[MemChecker.scala 55:11]
  assign mod_axi_slave_io_ctrl_W_valid = io_ctrl_W_valid; // @[MemChecker.scala 55:11]
  assign mod_axi_slave_io_ctrl_W_bits_wdata = io_ctrl_W_bits_wdata; // @[MemChecker.scala 55:11]
  assign mod_axi_slave_io_ctrl_B_ready = io_ctrl_B_ready; // @[MemChecker.scala 55:11]
  assign mod_axi_slave_io_ctrl_AR_valid = io_ctrl_AR_valid; // @[MemChecker.scala 55:11]
  assign mod_axi_slave_io_ctrl_AR_bits_addr = io_ctrl_AR_bits_addr; // @[MemChecker.scala 55:11]
  assign mod_axi_slave_io_ctrl_R_ready = io_ctrl_R_ready; // @[MemChecker.scala 55:11]
  assign mod_axi_slave_io_rd_stats_resp_cntr = mod_avalon_rd_io_stats_resp_cntr; // @[MemChecker.scala 89:39]
  assign mod_axi_slave_io_rd_stats_done = mod_avalon_rd_io_stats_done; // @[MemChecker.scala 90:34]
  assign mod_axi_slave_io_rd_stats_duration = mod_avalon_rd_io_stats_duration; // @[MemChecker.scala 91:38]
  assign mod_axi_slave_io_wr_stats_resp_cntr = mod_avalon_wr_io_stats_resp_cntr; // @[MemChecker.scala 68:39]
  assign mod_axi_slave_io_wr_stats_done = mod_avalon_wr_io_stats_done; // @[MemChecker.scala 69:34]
  assign mod_axi_slave_io_wr_stats_duration = mod_avalon_wr_io_stats_duration; // @[MemChecker.scala 70:38]
  assign mod_axi_slave_io_check_tot = mod_data_chk_io_check_tot; // @[MemChecker.scala 100:30]
  assign mod_axi_slave_io_check_ok = mod_data_chk_io_check_ok; // @[MemChecker.scala 101:29]
  assign mod_avalon_wr_clock = clock;
  assign mod_avalon_wr_reset = reset;
  assign mod_avalon_wr_io_response = io_mem_response; // @[MemChecker.scala 61:29]
  assign mod_avalon_wr_io_waitrequest = io_mem_waitrequest; // @[MemChecker.scala 62:32]
  assign mod_avalon_wr_io_writeresponsevalid = io_mem_writeresponsevalid; // @[MemChecker.scala 63:39]
  assign mod_avalon_wr_io_ctrl_addr = mod_axi_slave_io_write_addr[31:0]; // @[MemChecker.scala 65:30]
  assign mod_avalon_wr_io_ctrl_len_bytes = mod_axi_slave_io_write_len; // @[MemChecker.scala 66:35]
  assign mod_avalon_wr_io_ctrl_start = mod_axi_slave_io_write_start; // @[MemChecker.scala 67:31]
  assign mod_avalon_wr_io_data_data = mod_data_drv_io_data_data; // @[MemChecker.scala 77:30]
  assign mod_avalon_rd_clock = clock;
  assign mod_avalon_rd_reset = reset;
  assign mod_avalon_rd_io_readdata = io_mem_readdata; // @[MemChecker.scala 81:29]
  assign mod_avalon_rd_io_response = io_mem_response; // @[MemChecker.scala 82:29]
  assign mod_avalon_rd_io_waitrequest = io_mem_waitrequest; // @[MemChecker.scala 83:32]
  assign mod_avalon_rd_io_readdatavalid = io_mem_readdatavalid; // @[MemChecker.scala 84:34]
  assign mod_avalon_rd_io_ctrl_addr = mod_axi_slave_io_read_addr[31:0]; // @[MemChecker.scala 86:30]
  assign mod_avalon_rd_io_ctrl_len_bytes = mod_axi_slave_io_read_len; // @[MemChecker.scala 87:35]
  assign mod_avalon_rd_io_ctrl_start = mod_axi_slave_io_read_start; // @[MemChecker.scala 88:31]
  assign mod_data_drv_clock = clock;
  assign mod_data_drv_reset = reset;
  assign mod_data_drv_io_ctrl_mode = {{1'd0}, mod_axi_slave_io_ctrl_mode}; // @[MemChecker.scala 73:29]
  assign mod_data_drv_io_data_init = mod_avalon_wr_io_data_init; // @[MemChecker.scala 75:29]
  assign mod_data_drv_io_data_inc = mod_avalon_wr_io_data_inc; // @[MemChecker.scala 76:28]
  assign mod_data_chk_clock = clock;
  assign mod_data_chk_reset = reset;
  assign mod_data_chk_io_ctrl_mode = {{1'd0}, mod_axi_slave_io_ctrl_mode}; // @[MemChecker.scala 94:29]
  assign mod_data_chk_io_data_init = mod_avalon_rd_io_data_init; // @[MemChecker.scala 96:29]
  assign mod_data_chk_io_data_inc = mod_avalon_rd_io_data_inc; // @[MemChecker.scala 97:28]
  assign mod_data_chk_io_data_data = mod_avalon_rd_io_data_data; // @[MemChecker.scala 98:29]
endmodule
