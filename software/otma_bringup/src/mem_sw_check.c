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

#include "mem_sw_check.h"

#include <stdbool.h>
#include <stdint.h>

#include "io.h"
#include "system.h"

static int mem_sw_check_get_nr_pages(void) {
  uint32_t addr_bit_diff = ADDRESS_SPAN_EXTENDER_0_CNTL_MASTER_ADDRESS_WIDTH -
                           ADDRESS_SPAN_EXTENDER_0_CNTL_SLAVE_ADDRESS_WIDTH -
                           ADDRESS_SPAN_EXTENDER_0_CNTL_SLAVE_ADDRESS_SHIFT;

  return 1 << addr_bit_diff;
}

static uint32_t mem_sw_check_get_page_size_bytes(void) {
  uint32_t slave_addr_size = ADDRESS_SPAN_EXTENDER_0_CNTL_SLAVE_ADDRESS_WIDTH +
                             ADDRESS_SPAN_EXTENDER_0_CNTL_SLAVE_ADDRESS_SHIFT;

  return 1 << slave_addr_size;
}

static void mem_sw_check_set_page(uint32_t page) {
  uint32_t addr_offs = page
                       << (ADDRESS_SPAN_EXTENDER_0_CNTL_SLAVE_ADDRESS_WIDTH +
                           ADDRESS_SPAN_EXTENDER_0_CNTL_SLAVE_ADDRESS_SHIFT);
  IOWR_32DIRECT(ADDRESS_SPAN_EXTENDER_0_CNTL_BASE, 0, addr_offs);
  IOWR_32DIRECT(ADDRESS_SPAN_EXTENDER_0_CNTL_BASE, 4, 0);
}

typedef struct {
  uint32_t data[4];
} uint128_t;

static void uint128_inc(uint128_t *x) {
  uint32_t carry[5] = {1, 0, 0, 0, 0};

  for (int i = 0; i < 4; i++) {
    if ((x->data[i] == 0xFFFFFFFFUL) && (carry[0] != 0)) {
      carry[i + 1] = 1;
    }
    x->data[i] += carry[i];
  }
}

static void uint128_print(uint128_t *x) {
  for (int i = 0; i < 4; i++) {
    alt_printf("%x%s", x->data[i], i == 3 ? "" : " ");
  }
}

static bool uint128_eq(uint128_t *a, uint128_t *b) {
  for (int i = 0; i < 4; i++) {
    if (a->data[i] != b->data[i]) {
      return false;
    }
  }
  return true;
}

static uint32_t min_u32(uint32_t a, uint32_t b) {
  if (a < b) {
    return a;
  }

  return b;
}

void mem_sw_check_128b_cntr(uint32_t size_bytes) {
  uint128_t ref = {.data = {0}};

  alt_printf("check 128b cntr: [");
  for (int i = 0; i < mem_sw_check_get_nr_pages(); i++) {
    mem_sw_check_set_page(i);
    volatile uint128_t *ptr =
        (volatile uint128_t *)ADDRESS_SPAN_EXTENDER_0_WINDOWED_SLAVE_BASE;

    alt_printf("==");
    uint32_t lim = min_u32(mem_sw_check_get_page_size_bytes(), size_bytes);
    size_bytes -= lim;
    for (int j = 0; j < lim; j += 16) {
      bool eq = uint128_eq(ptr, &ref);
      if (!eq) {
        alt_printf("ERROR at 0x%x, 0x%x\n", i, j);
        alt_printf("  recv = ");
        uint128_print(ptr);
        alt_printf(", exp = ");
        uint128_print(&ref);
        alt_printf("\n");
        return;
      }
      ptr++;
      uint128_inc(&ref);
    }
  }
  alt_printf("]\n");
}

void mem_sw_write_32b_cntr(uint32_t size_bytes) {
  uint32_t cntr = 0;

  alt_printf("write 32b cntr: [");
  for (int i = 0; i < mem_sw_check_get_nr_pages(); i++) {
    mem_sw_check_set_page(i);
    volatile uint32_t *ptr =
        (volatile uint32_t *)ADDRESS_SPAN_EXTENDER_0_WINDOWED_SLAVE_BASE;

    alt_printf("==");
    uint32_t lim = min_u32(mem_sw_check_get_page_size_bytes(), size_bytes);
    size_bytes -= lim;
    for (int j = 0; j < lim; j += 4) {
      ptr[j] = cntr;
      cntr++;
    }
  }
  alt_printf("]\n");
}

void mem_sw_inj_err(void) {
  uint32_t cntr = 0;

  alt_printf("inj err: [");
  for (int i = 0; i < mem_sw_check_get_nr_pages(); i++) {
    mem_sw_check_set_page(i);
    volatile uint32_t *ptr =
        (volatile uint32_t *)ADDRESS_SPAN_EXTENDER_0_WINDOWED_SLAVE_BASE;

    alt_printf("==");
    ptr[i] ^= 0x1;
  }
  alt_printf("]\n");
}
