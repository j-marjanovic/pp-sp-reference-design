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

#pragma once

#include <stdbool.h>
#include <stdint.h>

#define IDT8NXQ001_NR_CH (4)
#define IDT8NXQ001_REG_SIZE (24)

struct idt8nxq001_conf {
  uint8_t MINT[IDT8NXQ001_NR_CH];
  uint32_t MFRAC[IDT8NXQ001_NR_CH];
  uint8_t N[IDT8NXQ001_NR_CH];
  uint8_t P[IDT8NXQ001_NR_CH];
  bool DG[IDT8NXQ001_NR_CH];
  uint8_t DSM[IDT8NXQ001_NR_CH];
  bool DSM_ENA[IDT8NXQ001_NR_CH];
  bool LF[IDT8NXQ001_NR_CH];
  uint8_t CP[IDT8NXQ001_NR_CH];
  uint8_t FSEL;
  bool nPLL_BYP;
  bool ADC_ENA;
};

enum IDT8NXQ001_FREQ {
  IDT8NXQ001_FREQ_100M = 0,
  IDT8NXQ001_FREQ_125M,
  IDT8NXQ001_FREQ_156p25M,
  IDT8NXQ001_FREQ_200M,
  IDT8NXQ001_FREQ_300M,
  IDT8NXQ001_FREQ_312p5M,
  IDT8NXQ001_FREQ_COUNT
};

void idt8nxq001_decode_conf(const uint8_t conf_bytes[IDT8NXQ001_REG_SIZE],
                            struct idt8nxq001_conf *conf);

void idt8nxq001_encode_conf(const struct idt8nxq001_conf *conf,
                            uint8_t conf_bytes[IDT8NXQ001_REG_SIZE]);

void idt8nxq001_conf_print(const struct idt8nxq001_conf *conf);

void idt8nxq001_set_freq(struct idt8nxq001_conf *conf, unsigned int ch_sel,
                         enum IDT8NXQ001_FREQ freq);

void idt8nxq001_set_fsel(struct idt8nxq001_conf *conf, uint8_t fsel);
