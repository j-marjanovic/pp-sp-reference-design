
#include <stdio.h>
#include <unistd.h>

#include "altera_avalon_pio_regs.h"
#include "system.h"

int main() {

	IOWR_ALTERA_AVALON_PIO_DIRECTION(PIO_0_BASE, 0x3);

	while (1) {
		printf("hello!\n");

		IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, 1);
		usleep(5e5);
		IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, 0);
		usleep(5e5);
	}
}
