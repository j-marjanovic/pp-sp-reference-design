
#include <stdint.h>
#include <stdio.h>
#include <unistd.h>

#include "altera_avalon_i2c.h"
#include "altera_avalon_pio_regs.h"
#include "io.h"
#include "system.h"

#include "IDT8NxQ001.h"

#define IDT8NxQ001_I2C_ADDR (0x6e)

void clock_counter_get_info(uint32_t base, uint32_t *ident_reg,
                            uint32_t *version) {
  if (ident_reg) {
    *ident_reg = IORD_32DIRECT(base, 0);
  }

  if (version) {
    *version = IORD_32DIRECT(base, 4);
  }
}

uint32_t clock_counter_get_freq(uint32_t base, int clk_index) {
  return IORD_32DIRECT(base, 0x10 + clk_index * 4);
}

void blink_loop_error() {
  while (1) {
    IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, 1);
    usleep(1e5);
    IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, 0);
    usleep(1e5);
  }
}

int main() {
  // set LED GPIO as output
  IOWR_ALTERA_AVALON_PIO_DIRECTION(PIO_0_BASE, 0x3);

  // read clock counter ID and version
  uint32_t cc_ident_reg, cc_version;
  clock_counter_get_info(CLOCK_COUNTER_0_BASE, &cc_ident_reg, &cc_version);
  printf("Clock counter: ident = 0x%08lx, version = 0x%08lx\n", cc_ident_reg,
         cc_version);

  // configure I2C
  ALT_AVALON_I2C_DEV_t *i2c_dev_idt = alt_avalon_i2c_open(I2C_IDT_OSC_NAME);
  ALT_AVALON_I2C_MASTER_CONFIG_t i2c_idt_cfg = {
      .addr_mode = ALT_AVALON_I2C_ADDR_MODE_7_BIT,
      .speed_mode = ALT_AVALON_I2C_SPEED_STANDARD,
  };
  alt_avalon_i2c_master_config_speed_set(i2c_dev_idt, &i2c_idt_cfg, 400000);
  alt_avalon_i2c_master_config_set(i2c_dev_idt, &i2c_idt_cfg);

  IRQ_DATA_t irq_data;
  alt_avalon_i2c_register_optional_irq_handler(i2c_dev_idt, &irq_data);

  // set IDT oscillator
  uint8_t idt_tx_buf[1] = {0};
  uint8_t idt_rx_buf[IDT8NXQ001_REG_SIZE] = {0};

  alt_avalon_i2c_master_target_set(i2c_dev_idt, IDT8NxQ001_I2C_ADDR);
  ALT_AVALON_I2C_STATUS_CODE rc = alt_avalon_i2c_master_tx_rx(
      i2c_dev_idt, idt_tx_buf, 1, idt_rx_buf, IDT8NXQ001_REG_SIZE, 1);
  if (rc != 0) {
    printf("ERROR reading from IDT over I2C (err code = %ld)\n", rc);
    blink_loop_error();
  }

  // set the desired freqs
  struct idt8nxq001_conf conf;
  idt8nxq001_decode_conf(idt_rx_buf, &conf);

  idt8nxq001_set_freq(&conf, 0, IDT8NXQ001_FREQ_125M);
  idt8nxq001_set_freq(&conf, 1, IDT8NXQ001_FREQ_156p25M);
  idt8nxq001_set_freq(&conf, 2, IDT8NXQ001_FREQ_200M);
  idt8nxq001_set_freq(&conf, 3, IDT8NXQ001_FREQ_312p5M);

  conf.nPLL_BYP = 1;
  conf.ADC_ENA = 0; // using integer values only

  // select one of the freqs
  idt8nxq001_set_fsel(&conf, 1);

  // program new config
  idt8nxq001_conf_print(&conf);
  uint8_t idt_new_buf[IDT8NXQ001_REG_SIZE + 1] = {0};
  idt8nxq001_encode_conf(&conf, &idt_new_buf[1]);
  alt_avalon_i2c_master_tx(i2c_dev_idt, idt_new_buf, IDT8NXQ001_REG_SIZE + 1,
                           0);

  printf("Finished configuring IDT oscillator, entering while(1) loop...\n");

  while (1) {
    uint32_t cc_idt_clk_freq = clock_counter_get_freq(CLOCK_COUNTER_0_BASE, 5);
    printf("Clock frequency [IDT osc]: %ld MHz\n", cc_idt_clk_freq);

    IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, 1);
    usleep(5e5);
    IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, 0);
    usleep(5e5);
  }
}
