
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
  IDT8NXQ001_FREQ_625M,
  IDT8NXQ001_FREQ_COUNT
};

void idt8nxq001_decode_conf(const uint8_t conf_bytes[IDT8NXQ001_REG_SIZE],
                            struct idt8nxq001_conf *conf);

void idt8nxq001_encode_conf(const struct idt8nxq001_conf *conf,
                            uint8_t conf_bytes[IDT8NXQ001_REG_SIZE]);

void idt8nxq001_conf_print(const struct idt8nxq001_conf *conf);

void idt8nxq001_set_freq(struct idt8nxq001_conf *conf, unsigned int ch_sel,
                         enum IDT8NXQ001_FREQ freq);