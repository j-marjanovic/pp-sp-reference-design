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

#include "IDT8NxQ001.h"
#include "cli.h"
#include "clock_counter.h"

#define IDT8NxQ001_I2C_ADDR (0x6e)

/*

void qsfp_dump_config(ALT_AVALON_I2C_DEV_t *i2c_dev) {
          // read IDT oscillator config
          uint8_t tx_buf[1] = {0};
          uint8_t rx_buf[16] = {0};
          ALT_AVALON_I2C_STATUS_CODE rc;

          alt_avalon_i2c_master_target_set(i2c_dev, 0x50);
          for (int i = 0; i < 16; i++) {
                  tx_buf[0] = i*16;
                  rc = alt_avalon_i2c_master_tx_rx(
                                  i2c_dev, tx_buf, 1, rx_buf, 16, 1);
                  printf("rc = %d | ", rc);
                  for (int i = 0; i < 16; i++) {
                          printf("%02x ", rx_buf[i]);
                  }
                  printf("\n");
          }
}


void blink_loop_error() {
  while (1) {
    IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, 1);
    usleep(1e5);
    IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, 0);
    usleep(1e5);
  }
}
*/

void init_leds() {
  // set LED GPIO as output
  IOWR_ALTERA_AVALON_PIO_DIRECTION(PIO_0_BASE, 0x3);
}

void init_i2cs(ALT_AVALON_I2C_DEV_t **i2c_dev_idt,
               ALT_AVALON_I2C_DEV_t **i2c_dev_qsfp0) {
  *i2c_dev_idt = alt_avalon_i2c_open(I2C_IDT_OSC_NAME);
  ALT_AVALON_I2C_MASTER_CONFIG_t i2c_idt_cfg = {
      .addr_mode = ALT_AVALON_I2C_ADDR_MODE_7_BIT,
      .speed_mode = ALT_AVALON_I2C_SPEED_STANDARD,
  };
  alt_avalon_i2c_master_config_speed_set(*i2c_dev_idt, &i2c_idt_cfg, 400000);
  alt_avalon_i2c_master_config_set(*i2c_dev_idt, &i2c_idt_cfg);

  IRQ_DATA_t irq_data_idt;
  alt_avalon_i2c_register_optional_irq_handler(*i2c_dev_idt, &irq_data_idt);

  // QSFP
  *i2c_dev_qsfp0 = alt_avalon_i2c_open(I2C_QSFP_1_NAME);
  ALT_AVALON_I2C_MASTER_CONFIG_t i2c_qsfp0_cfg = {
      .addr_mode = ALT_AVALON_I2C_ADDR_MODE_7_BIT,
      .speed_mode = ALT_AVALON_I2C_SPEED_STANDARD,
  };
  alt_avalon_i2c_master_config_speed_set(*i2c_dev_qsfp0, &i2c_qsfp0_cfg,
                                         400000);
  alt_avalon_i2c_master_config_set(*i2c_dev_qsfp0, &i2c_qsfp0_cfg);
}

int main() {
  ALT_AVALON_I2C_DEV_t *i2c_dev_idt, *i2c_dev_qsfp0;

  init_leds();
  init_i2cs(&i2c_dev_idt, &i2c_dev_qsfp0);

  while (true) {
    cli();
  }
}
