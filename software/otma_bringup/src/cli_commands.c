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

#include <string.h>
#include <unistd.h>

#include "altera_avalon_pio_regs.h"
#include "sys/alt_stdio.h"
#include "system.h"

#include "IDT8NxQ001.h"
#include "altera_avalon_sysid_qsys_regs.h"
#include "cli_commands.h"
#include "clock_counter.h"
#include "devices.h"
#include "mem_checker.h"
#include "mem_sw_check.h"
#include "mini_i2cdetect.h"
#include "pcie_status_amm.h"

struct cmd cmds[] = {
    {"clks", "Print clock frequencies", cmd_clks},
    {"eeprom", "Dump EEPROM", cmd_eeprom},
    {"hello", "Says hello", cmd_hello},
    {"help", "Prints help", cmd_help},
    {"i2cdetect", "Scans I2C bus", cmd_i2cdetect},
    {"idt", "Manage IDT oscillator", cmd_idt},
    {"mem_test", "Performs the DDR3 memory test", cmd_mem_test},
    {"pcie", "Report PCIe state", cmd_pcie},
    {"sys_id", "Shows system ID", cmd_sys_id},
};

size_t cmds_len = sizeof(cmds) / sizeof(cmds[0]);

void cmd_clks(char *cmd, char *arg1, char *arg2) {
  uint32_t cc_ident_reg, cc_version;
  clock_counter_get_info(CLOCK_COUNTER_0_BASE, &cc_ident_reg, &cc_version);
  alt_printf("Clock counter: ident = 0x%x, version = 0x%x\n", cc_ident_reg,
             cc_version);

  for (int i = 0; i < 8; i++) {
    uint32_t clk_freq = clock_counter_get_freq(CLOCK_COUNTER_0_BASE, i);
    alt_printf("Clock frequency [%x] = ", i);

    // poor man's %f - alt_printf does not have it
    bool first_non_zero = false;
    for (int scale = 1000000000; scale >= 1000; scale /= 10) {
      uint32_t digit = clk_freq / scale;
      clk_freq -= digit * scale;

      if ((digit != 0) || (scale == 1000000)) {
        first_non_zero = true;
      }

      if (first_non_zero) {
        alt_putchar(digit + '0');
      } else {
        alt_putchar(' ');
      }

      if (scale == 1000000) {
        alt_putchar('.');
      }
    }
    alt_printf(" MHz\n");
  }
}

void cmd_eeprom(char *cmd, char *arg1, char *arg2) {
  if (strcmp(arg1, "qsfp0") == 0) {
    mini_i2cdump(devices.i2c_dev_qsfp0, 0x50);
  } else if (strcmp(arg1, "qsfp1") == 0) {
    mini_i2cdump(devices.i2c_dev_qsfp1, 0x50);
  } else if (strcmp(arg1, "fru") == 0) {
    mini_i2cdump(devices.i2c_dev_mon, 0x51);
  } else {
    if (strlen(arg1) == 0) {
      alt_printf("eeprom (qsfp0|qsfp1|fru)\n");
    } else {
      alt_printf("Error: unknown i2c channel (%s)\n", arg1);
    }
  }
}

void cmd_hello(char *cmd, char *arg1, char *arg2) {
  alt_printf("hello from Pikes Peak/Storey Peak board\n");
}

void cmd_help(char *cmd, char *arg1, char *arg2) {
  alt_printf("Available commands:\n");
  for (int i = 0; i < sizeof(cmds) / sizeof(cmds[0]); i++) {
    alt_printf("  %s - %s\n", cmds[i].cmd, cmds[i].help);
  }
}

void cmd_i2cdetect(char *cmd, char *arg1, char *arg2) {
  if (strcmp(arg1, "idt") == 0) {
    mini_i2cdetect(devices.i2c_dev_idt, 0x8, 0x78);
  } else if (strcmp(arg1, "qsfp0") == 0) {
    mini_i2cdetect(devices.i2c_dev_qsfp0, 0x8, 0x78);
  } else if (strcmp(arg1, "qsfp1") == 0) {
    mini_i2cdetect(devices.i2c_dev_qsfp1, 0x8, 0x78);
  } else if (strcmp(arg1, "mon") == 0) {
    mini_i2cdetect(devices.i2c_dev_mon, 0x8, 0x78);
  } else {
    if (strlen(arg1) == 0) {
      alt_printf("i2cdetect (idt|qsfp0|qsfp1|mon)\n");
    } else {
      alt_printf("Error: unknown i2c channel (%s)\n", arg1);
    }
  }
}

#define IDT8NxQ001_I2C_ADDR (0x6e)

void cmd_idt(char *cmd, char *arg1, char *arg2) {
  if (strcmp(arg1, "dump") == 0) {
    uint8_t idt_tx_buf[1] = {0};
    uint8_t idt_rx_buf[IDT8NXQ001_REG_SIZE] = {0};

    alt_avalon_i2c_master_target_set(devices.i2c_dev_idt, IDT8NxQ001_I2C_ADDR);

    // read from the IDT
    ALT_AVALON_I2C_STATUS_CODE rc = alt_avalon_i2c_master_tx_rx(
        devices.i2c_dev_idt, idt_tx_buf, 1, idt_rx_buf, IDT8NXQ001_REG_SIZE, 0);
    if (rc != 0) {
      alt_printf("Error: i2c error (err code = -0x%x)\n", -rc);
      return;
    }

    // print the IDT oscillator config
    struct idt8nxq001_conf conf;
    idt8nxq001_decode_conf(idt_rx_buf, &conf);

    // print conf
    idt8nxq001_conf_print(&conf);
  } else {
    if (strlen(arg1) == 0) {
      alt_printf("idt (dump)\n");
    } else {
      alt_printf("Error: unknown idt command (%s)\n", arg1);
    }
  }
}

static bool get_user_ok(const char *arg2, const char *msg) {

  bool confirm = strcmp(arg2, "-y") == 0;

  if (!confirm) {
    alt_printf("%s. Continue [yN]?\n", msg);

    char c;
    do {
      c = alt_getchar();
      // very simple, it works as long as user does not reply "nay"
      if (c == 'y' || c == 'Y') {
        confirm = true;
      }
    } while (c != '\n');
  }

  return confirm;
}

void cmd_mem_test(char *cmd, char *arg1, char *arg2) {
  if (strlen(arg1) == 0) {
    mem_check_full(MEM_CHECKER_0_BASE, 0, 4294967040);
  } else if (strcmp("sw_check", arg1) == 0) {
    bool confirm =
        get_user_ok(arg2, "SW-based memory test takes a lot of time");
    if (!confirm) {
      alt_printf("aborted by the user\n");
      return;
    }
    mem_check_write(MEM_CHECKER_0_BASE, 0, 4294967040, MEM_CHECK_MODE_CNTR_128);
    mem_sw_check_128b_cntr(4294967040);
  } else if (strcmp("sw_write", arg1) == 0) {
    bool confirm =
        get_user_ok(arg2, "SW-based memory test takes a lot of time");
    if (!confirm) {
      alt_printf("aborted by the user\n");
      return;
    }
    mem_sw_write_32b_cntr(4294967040);
    mem_check_read_and_check(MEM_CHECKER_0_BASE, 0, 4294967040,
                             MEM_CHECK_MODE_CNTR_32);
  } else if (strcmp("inj_err", arg1) == 0) {
    mem_check_write(MEM_CHECKER_0_BASE, 0, 4294967040, MEM_CHECK_MODE_CNTR_8);
    mem_sw_inj_err();
    mem_check_read_and_check(MEM_CHECKER_0_BASE, 0, 4294967040,
                             MEM_CHECK_MODE_CNTR_8);
  } else {
    alt_printf("mem_test: unknown command (%s)\n", arg1);
  }
}

void cmd_pcie(char *cmd, char *arg1, char *arg2) {
  if (strcmp("status", arg1) == 0) {

    uint32_t id_reg, version;
    pcie_status_id_version(PCIE_STATUS_AMM_0_BASE, &id_reg, &version);

    struct pcie_status status = pcie_status_get(PCIE_STATUS_AMM_0_BASE);

    alt_printf("pcie:\n");
    alt_printf("  id = %x\n", id_reg);
    alt_printf("  version = %x\n", version);
    alt_printf("  status.cur speed   = %x\n", status.currentspeed);
    alt_printf("  status.LTTSM state = %x\n", status.ltssmstate);
    alt_printf("  status.lane act    = %x\n", status.lane_act);
    alt_printf("  status.DL up       = %x\n", status.dlup);
  } else if (strcmp("reset", arg1) == 0) {
    alt_printf("pcie: asserting reset...\n");
    IOWR_ALTERA_AVALON_PIO_DATA(PIO_PCIE_NPOR_BASE, 0);
    usleep(100000);
    alt_printf("pcie: deasserted reset...\n");
    IOWR_ALTERA_AVALON_PIO_DATA(PIO_PCIE_NPOR_BASE, 1);
    alt_printf("pcie: reset deasserted\n");
  } else {
    alt_printf("pcie: unknown command (%s), try 'status' or 'reset'\n", arg1);
  }
}

void cmd_sys_id(char *cmd, char *arg1, char *arg2) {
  uint32_t sys_id = IORD_ALTERA_AVALON_SYSID_QSYS_ID(SYSID_QSYS_0_BASE);
  uint32_t timestamp =
      IORD_ALTERA_AVALON_SYSID_QSYS_TIMESTAMP(SYSID_QSYS_0_BASE);
  alt_printf("system id = 0x%x\n", sys_id);
  alt_printf("timestamp = 0x%x\n", timestamp);
}
