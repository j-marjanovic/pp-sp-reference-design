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

#include "cli_commands.h"

#define CLI_PROMPT ("pp_sp_example > ")
#define CLI_BUFFER_SIZE (32)

static void simple_sscanf(char *cmd_args, char *cmd, char *arg1, char *arg2) {
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
      for (int i = 0; i < cmd_len; i++) {
        if (strcmp(cmd, cmds[i].cmd) == 0) {
          matched = true;

          cmds[i].func(cmd, arg1, arg2);
        }
      }

      // user command did not match any command in the command list
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
