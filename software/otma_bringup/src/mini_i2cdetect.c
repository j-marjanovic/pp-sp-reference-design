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

#include <stdio.h>
#include <unistd.h>

#include "altera_avalon_i2c.h"
#include "sys/alt_stdio.h"

#include "mini_i2cdetect.h"

void mini_i2cdetect(ALT_AVALON_I2C_DEV_t *i2c_dev, uint16_t start_addr,
                    uint16_t stop_addr) {

  const int LINE_LEN = 16;
  uint8_t rx_buf[1];

  // print header for the first line (if not aligned to LINE_LEN
  if ((start_addr % LINE_LEN) != 0) {
    if (start_addr < LINE_LEN) {
      alt_printf(" ");
    }
    alt_printf(" %x | ", 0);
  }
  // print empty spaces for alignment
  for (int i = 0; i < (start_addr % LINE_LEN); i++) {
    alt_printf("   ");
  }

  // scan the addresses
  for (int addr = start_addr; addr < stop_addr; addr++) {
    if ((addr % LINE_LEN) == 0) {
      alt_printf("\n %x | ", addr);
    }

    alt_avalon_i2c_master_target_set(i2c_dev, addr);
    ALT_AVALON_I2C_STATUS_CODE rc = alt_avalon_i2c_master_receive(
        i2c_dev, rx_buf, 1, ALT_AVALON_I2C_NO_RESTART, ALT_AVALON_I2C_STOP);
    if (rc == ALT_AVALON_I2C_SUCCESS) {
      alt_printf("%x ", addr);
    } else {
      alt_printf("-- ");
    }
  }
  alt_printf("\n");
}

void mini_i2cdump(ALT_AVALON_I2C_DEV_t *i2c_dev, uint8_t addr) {
  uint8_t tx_buf[1] = {0};
  uint8_t rx_buf[16] = {0};
  ALT_AVALON_I2C_STATUS_CODE rc;

  // set address
  alt_avalon_i2c_master_target_set(i2c_dev, addr);

  for (int i = 0; i < 16; i++) {

    // read 16 bytes at a time
    tx_buf[0] = i * 16;
    rc = alt_avalon_i2c_master_tx_rx(i2c_dev, tx_buf, 1, rx_buf, 16, 0);
    if (rc != ALT_AVALON_I2C_SUCCESS) {
      alt_printf("mini_i2cdump: I2C read error (-0x%x)\n", -rc);
      return;
    }

    // print address part
    if (i == 0) {
      alt_printf(" ");
    }
    alt_printf(" %x | ", i * 16);

    // print line (hex part)
    for (int i = 0; i < 16; i++) {
      if (rx_buf[i] < 16) {
        alt_printf("0");
      }
      alt_printf("%x ", rx_buf[i]);
    }

    // print line (char part)
    alt_printf("| ");
    for (int i = 0; i < 16; i++) {
      if (rx_buf[i] >= 20 && rx_buf[i] < 127) {
        alt_printf("%c", rx_buf[i]);
      } else {
        alt_printf(".");
      }
    }

    // next line
    alt_printf("\n");
  }
}
