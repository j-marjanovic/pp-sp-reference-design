/*
 * mini_i2cdetect.c
 *
 *  Created on: Sep 19, 2020
 *      Author: jan
 */


#include "mini_i2cdetect.h"

void mini_i2cdetect(ALT_AVALON_I2C_DEV_t* i2c_dev, uint16_t start_addr, uint16_t stop_addr) {
  uint8_t rx_buf[1];
  printf(" %04x | ", 0);
  for (int i = 0; i < (start_addr % 16); i++) {
	  printf("   ");
  }

  for (int addr = start_addr; addr < stop_addr; addr++) {
	  if ((addr % 16) == 0) {
		  printf("\n %04x | ", addr);
	  }

	  alt_avalon_i2c_master_target_set(i2c_dev, addr);
	  ALT_AVALON_I2C_STATUS_CODE rc = alt_avalon_i2c_master_receive(
			  i2c_dev, rx_buf, 1, ALT_AVALON_I2C_NO_RESTART, ALT_AVALON_I2C_STOP);
	  if (rc == ALT_AVALON_I2C_SUCCESS) {
		  printf("%02x ", addr);
	  } else {
		  printf("-- ");
	  }
	  usleep(1000);
  }
  printf("\n");
}

