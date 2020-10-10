
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


const uint32_t FORTYGIG_ETH_VERSION = 0x00e01400; // 0x00E01310;

void fortygig_eth_get_info(uint32_t base){

	uint32_t version = IORD_32DIRECT(base, 0);
	printf("40G Eth: version = %08lx (%s)\n", version, version == FORTYGIG_ETH_VERSION ? "OK" : "ERROR");

	IOWR_32DIRECT(base, 4, 0xABCD1234);
	uint32_t scratch = IORD_32DIRECT(base, 4);
	printf("40G Eth: scratch reg, written 0xABCD1234, read back %08lx\n", scratch);

	IOWR_32DIRECT(base, 4, 0xFFFFFFFF);
	scratch = IORD_32DIRECT(base, 4);
	printf("40G Eth: scratch reg, written 0xFFFFFFFF, read back %08lx\n", scratch);

	IOWR_32DIRECT(base, 4, 0x01020304);
	scratch = IORD_32DIRECT(base, 4);
	printf("40G Eth: scratch reg, written 0x01020304, read back %08lx\n", scratch);

	uint32_t clk_txs = IORD_32DIRECT(base, 8);
	uint32_t clk_rxs = IORD_32DIRECT(base, 12);
	uint32_t clk_txc = IORD_32DIRECT(base, 16);
	uint32_t clk_rxc = IORD_32DIRECT(base, 20);

	printf("40G Eth: TX serial clk rate = %ld kHz\n", clk_txs);
	printf("40G Eth: RX serial clk rate = %ld kHz\n", clk_rxs);
	printf("40G Eth: TX core clk rate = %ld kHz\n", clk_txc);
	printf("40G Eth: RX core clk rate = %ld kHz\n", clk_rxc);

	uint32_t io_locks = IORD_32DIRECT(base, 0x10*4);
	uint32_t io_locks_tx_pll = (io_locks >> 6) & 0x1;
	uint32_t io_locks_rx_cdr = (io_locks >> 2) & 0xF;
	printf("40G Eth: TX PLL lock = %ld, RX CDR lock = 0x%lx\n", io_locks_tx_pll, io_locks_rx_cdr);

	uint32_t pcs_hw_err = IORD_32DIRECT(base, 0x17*4);
	printf("40G Eth: PCS HW error = 0x%lx\n", pcs_hw_err);
}


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

  IRQ_DATA_t irq_data_idt;
  alt_avalon_i2c_register_optional_irq_handler(i2c_dev_idt, &irq_data_idt);


  // QSFP
  ALT_AVALON_I2C_DEV_t *i2c_dev_qsfp0 = alt_avalon_i2c_open(I2C_QSFP_1_NAME);
  ALT_AVALON_I2C_MASTER_CONFIG_t i2c_qsfp0_cfg = {
      .addr_mode = ALT_AVALON_I2C_ADDR_MODE_7_BIT,
      .speed_mode = ALT_AVALON_I2C_SPEED_STANDARD,
  };
  alt_avalon_i2c_master_config_speed_set(i2c_dev_qsfp0, &i2c_qsfp0_cfg, 400000);
  alt_avalon_i2c_master_config_set(i2c_dev_qsfp0, &i2c_qsfp0_cfg);

  IRQ_DATA_t irq_data_qsfp0;
  alt_avalon_i2c_register_optional_irq_handler(i2c_dev_qsfp0, &irq_data_qsfp0);

  qsfp_dump_config(i2c_dev_qsfp0);

  // read IDT oscillator config
  uint8_t idt_tx_buf[1] = {0};
  uint8_t idt_rx_buf[IDT8NXQ001_REG_SIZE] = {0};

  alt_avalon_i2c_master_target_set(i2c_dev_idt, IDT8NxQ001_I2C_ADDR);
  ALT_AVALON_I2C_STATUS_CODE rc = alt_avalon_i2c_master_tx_rx(
      i2c_dev_idt, idt_tx_buf, 1, idt_rx_buf, IDT8NXQ001_REG_SIZE, 1);
  if (rc != 0) {
    printf("ERROR reading from IDT over I2C (err code = %ld)\n", rc);
    blink_loop_error();
  }

  // print the IDT oscillator config
  struct idt8nxq001_conf conf;
  idt8nxq001_decode_conf(idt_rx_buf, &conf);
  idt8nxq001_conf_print(&conf);

  IOWR_ALTERA_AVALON_PIO_DATA(PIO_40G_ETH_RESET_BASE, 0x7);
  usleep(1e5);
  IOWR_ALTERA_AVALON_PIO_DATA(PIO_40G_ETH_RESET_BASE, 0x0);
  usleep(1e5);

  while (1) {
    uint32_t cc_idt_clk_freq = clock_counter_get_freq(CLOCK_COUNTER_0_BASE, 1);
    printf("Clock frequency [X]: %ld MHz\n", cc_idt_clk_freq);

    fortygig_eth_get_info(FORTYGIG_ETH_STATUS_BASE);

    IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, 1);
    usleep(5e5);
    IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, 0);
    usleep(5e5);
  }
}
