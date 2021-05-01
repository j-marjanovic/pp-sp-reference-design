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

#include "sys/alt_stdio.h"
#include "system.h"

#include "IDT8NxQ001.h"
#include "altera_avalon_sysid_qsys_regs.h"
#include "cli_commands.h"
#include "clock_counter.h"
#include "devices.h"
#include "mem_checker.h"
#include "mini_i2cdetect.h"

struct cmd cmds[] = {
    {"clks", "Print clock frequencies", cmd_clks},
    {"eeprom", "Dump EEPROM", cmd_eeprom},
    {"hello", "Says hello", cmd_hello},
    {"help", "Prints help", cmd_help},
    {"i2cdetect", "Scans I2C bus", cmd_i2cdetect},
    {"idt", "Manage IDT oscillator", cmd_idt},
    {"mem_test", "Performs the DDR3 memory test", cmd_mem_test},
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
  } else {
    if (strlen(arg1) == 0) {
      alt_printf("eeprom (qsfp0|qsfp1)\n");
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
  } else if (strcmp(arg1, "smbus") == 0) {
    alt_printf("SMBUS i2c not yet implemented\n"); // TODO
  } else {
    if (strlen(arg1) == 0) {
      alt_printf("i2cdetect (idt|qsfp0|qsfp1|smbus)\n");
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

void cmd_mem_test(char *cmd, char *arg1, char *arg2) {
  mem_check(MEM_CHECKER_0_BASE, 0, 4294967040);
}

void cmd_sys_id(char *cmd, char *arg1, char *arg2) {
  uint32_t sys_id = IORD_ALTERA_AVALON_SYSID_QSYS_ID(SYSID_QSYS_0_BASE);
  uint32_t timestamp =
      IORD_ALTERA_AVALON_SYSID_QSYS_TIMESTAMP(SYSID_QSYS_0_BASE);
  alt_printf("system id = 0x%x\n", sys_id);
  alt_printf("timestamp = 0x%x\n", timestamp);
}
