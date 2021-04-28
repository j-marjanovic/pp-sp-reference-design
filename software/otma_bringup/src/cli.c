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

#include <stdbool.h>
#include <string.h>
#include <unistd.h>

#include "sys/alt_stdio.h"
#include "system.h"

#include "clock_counter.h"

#define CLI_PROMPT ("pp_sp_example > ")
#define CLI_BUFFER_SIZE (32)

typedef void (*cli_func_ptr)(char *, char *, char *);

struct cmd {
  const char *cmd;
  const char *help;
  cli_func_ptr func;
};

void cmd_hello(char *cmd, char *arg1, char *arg2);
void cmd_help(char *cmd, char *arg1, char *arg2);
void cmd_i2cdetect(char *cmd, char *arg1, char *arg2);
void cmd_clock_counter(char *cmd, char *arg1, char *arg2);

struct cmd cmds[] = {
    {"hello", "Says hello", cmd_hello},
    {"help", "Prints help", cmd_help},
    {"i2cdetect", "Scans I2C bus", cmd_i2cdetect},
    {"clk_counter", "Print clock frequencies", cmd_clock_counter},
};

void cmd_hello(char *cmd, char *arg1, char *arg2) { alt_printf("hello\n"); }

void cmd_help(char *cmd, char *arg1, char *arg2) {
  alt_printf("Available commands:\n");
  for (int i = 0; i < sizeof(cmds) / sizeof(cmds[0]); i++) {
    alt_printf("  %s - %s\n", cmds[i].cmd, cmds[i].help);
  }
}

void cmd_i2cdetect(char *cmd, char *arg1, char *arg2) {
  // TODO: logic
  alt_printf("I2C arg1 = %s\n", arg1);
  alt_printf("I2C arg2 = %s\n", arg2);
}

void cmd_clock_counter(char *cmd, char *arg1, char *arg2) {
  // read clock counter ID and version
  uint32_t cc_ident_reg, cc_version;
  clock_counter_get_info(CLOCK_COUNTER_0_BASE, &cc_ident_reg, &cc_version);
  alt_printf("Clock counter: ident = 0x%x, version = 0x%x\n", cc_ident_reg,
             cc_version);

  for (int i = 0; i < 8; i++) {
    uint32_t clk_freq = clock_counter_get_freq(CLOCK_COUNTER_0_BASE, i);
    alt_printf("Clock frequency [%x]: 0x%x Hz\n", i, clk_freq);
  }
}

void simple_sscanf(char *cmd_args, char *cmd, char *arg1, char *arg2) {
  char *dests[] = {cmd, arg1, arg2};
  int dest_sel = 0;

  while (*cmd_args) {
    if (*cmd_args == ' ') {
      if (dest_sel < sizeof(dests) / sizeof(dests[0])) {
        dest_sel++;
      } else {
        return;
      }
    } else {
      *(dests[dest_sel]) = *cmd_args;
      dests[dest_sel]++;
    }
    cmd_args++;
  }
}

void cli(void) {

  // read clock counter ID and version
  char cmd_buf[CLI_BUFFER_SIZE] = {0};
  int pos = 0;

  alt_printf(CLI_PROMPT);
  while (1) {
    char recv_char = alt_getchar();

    // echo
    alt_putchar(recv_char);

    // check if end of the command
    if (recv_char == '\n') {

      // split the string into individual parts (command + arguments)
      char cmd[CLI_BUFFER_SIZE] = {0};
      char arg1[CLI_BUFFER_SIZE] = {0};
      char arg2[CLI_BUFFER_SIZE] = {0};
      simple_sscanf(cmd_buf, cmd, arg1, arg2);

      // traverse all commands
      bool matched = false;
      for (int i = 0; i < sizeof(cmds) / sizeof(cmds[0]); i++) {
        if (strcmp(cmd, cmds[i].cmd) == 0) {
          matched = true;

          cmds[i].func(cmd, arg1, arg2);
        }
      }

      // user command did not match any command in the command array
      if (!matched) {
        alt_printf("unknown command: %s\n", cmd_buf);
      }

      // clean-up and print prompt
      memset(cmd_buf, 0, sizeof(cmd_buf));
      pos = 0;
      alt_printf(CLI_PROMPT);
    } else {
      cmd_buf[pos] = recv_char;
      pos++;
    }

    // handle the case when we filled the buffer before seeing a new line
    if (pos >= sizeof(cmd_buf) - 1) {
      alt_printf("unknown command: %s\n", cmd_buf);
      memset(cmd_buf, 0, sizeof(cmd_buf));
      pos = 0;
      alt_printf(CLI_PROMPT);
    }
  }
}
