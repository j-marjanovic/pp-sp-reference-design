/*
 * mini_i2cdetect.h
 *
 *  Created on: Sep 19, 2020
 *      Author: jan
 */

#ifndef MINI_I2CDETECT_H_
#define MINI_I2CDETECT_H_

#include <stdint.h>

#include "altera_avalon_i2c.h"


void mini_i2cdetect(ALT_AVALON_I2C_DEV_t* i2c_dev, uint16_t start_addr, uint16_t stop_addr);


#endif /* MINI_I2CDETECT_H_ */
