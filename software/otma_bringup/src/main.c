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
#include <stdint.h>
#include <string.h>
#include <unistd.h>

#include "altera_avalon_i2c.h"
#include "altera_avalon_pio_regs.h"
#include "io.h"
#include "sys/alt_stdio.h"
#include "system.h"

#include "cli.h"
#include "devices.h"

void blink_loop_error() {
  while (1) {
    IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, 1);
    usleep(1e5);
    IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, 0);
    usleep(1e5);
  }
}

void init_leds() {
  // set LED GPIO as output
  IOWR_ALTERA_AVALON_PIO_DIRECTION(PIO_0_BASE, 0x3);
}

void init_i2c_single(ALT_AVALON_I2C_DEV_t **i2c_dev, const char *name) {
  int rc;

  *i2c_dev = alt_avalon_i2c_open(name);
  if (*i2c_dev == NULL) {
    alt_printf("init_i2c_single: error - could not open device %s\n", name);
    blink_loop_error();
  }

  ALT_AVALON_I2C_MASTER_CONFIG_t i2c_idt_cfg = {
      .addr_mode = ALT_AVALON_I2C_ADDR_MODE_7_BIT,
      .speed_mode = ALT_AVALON_I2C_SPEED_STANDARD,
  };

  rc = alt_avalon_i2c_master_config_speed_set(*i2c_dev, &i2c_idt_cfg, 400000);
  if (rc != ALT_AVALON_I2C_SUCCESS) {
    alt_printf("init_i2c_single: error - config speed set failed\n");
    blink_loop_error();
  }
  alt_avalon_i2c_master_config_set(*i2c_dev, &i2c_idt_cfg);
}

void init_i2cs(void) {

  init_i2c_single(&devices.i2c_dev_idt, I2C_IDT_OSC_NAME);
  init_i2c_single(&devices.i2c_dev_qsfp0, I2C_QSFP_0_NAME);
  init_i2c_single(&devices.i2c_dev_qsfp1, I2C_QSFP_1_NAME);
  init_i2c_single(&devices.i2c_dev_mon, I2C_MON_NAME);
}

int main() {
  init_leds();
  init_i2cs();

  alt_printf("\n");
  while (true) {
    cli();
  }
}
