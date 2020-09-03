
#include "seatest/seatest.h"

#include "../src/IDT8NxQ001.h"

const int IDT8NXQ001_MINT_MAX = (1 << 6) - 1;
const int IDT8NXQ001_MFRAC_MAX = (1 << 18) - 1;
const int IDT8NXQ001_N_MAX = (1 << 7) - 1;
const int IDT8NXQ001_P_MAX = (1 << 2) - 1;
const int IDT8NXQ001_DSM_MAX = (1 << 2) - 1;
const int IDT8NXQ001_CP_MAX = (1 << 2) - 1;

void test_dec_enc(void) {
  uint8_t in_bytes[IDT8NXQ001_REG_SIZE] = {
      0x06, 0x4e, 0x9e, 0xfe, 10,   20,          30,          40,
      1,    2,    3,    4,    10,   12,          14,          16,
      0,    0,    0x80, 0,    0x1f, 0x1f | 0x40, 0x1f | 0x80, 0x1f | 0xc0};
  uint8_t out_bytes[IDT8NXQ001_REG_SIZE] = {0};
  struct idt8nxq001_conf conf;

  idt8nxq001_decode_conf(in_bytes, &conf);

  idt8nxq001_conf_print(&conf);

  assert_int_equal(0x3, conf.MINT[0]);
  assert_int_equal(0x7, conf.MINT[1]);
  assert_int_equal(0xF, conf.MINT[2]);
  assert_int_equal(0x1F, conf.MINT[3]);
  assert_int_equal(10 * 512 + 1 * 2, conf.MFRAC[0]);
  assert_int_equal(20 * 512 + 2 * 2, conf.MFRAC[1]);
  assert_int_equal(30 * 512 + 3 * 2, conf.MFRAC[2]);
  assert_int_equal(40 * 512 + 4 * 2, conf.MFRAC[3]);
  assert_int_equal(10, conf.N[0]);
  assert_int_equal(12, conf.N[1]);
  assert_int_equal(14, conf.N[2]);
  assert_int_equal(16, conf.N[3]);
  assert_true(conf.ADC_ENA);
  assert_false(conf.nPLL_BYP);

  idt8nxq001_encode_conf(&conf, out_bytes);

  assert_n_array_equal(in_bytes, out_bytes, IDT8NXQ001_REG_SIZE);
}

void test_enc_dec_0() {
  struct idt8nxq001_conf in_conf = {.MINT = {12, 20, 28, 30}};
  uint8_t bytes[IDT8NXQ001_REG_SIZE] = {0};
  struct idt8nxq001_conf out_conf;

  idt8nxq001_encode_conf(&in_conf, bytes);
  idt8nxq001_decode_conf(bytes, &out_conf);

  idt8nxq001_conf_print(&out_conf);

  assert_n_array_equal(((uint8_t *)&out_conf), ((uint8_t *)&in_conf),
                       IDT8NXQ001_REG_SIZE);
}

void all_tests(void) {
  test_fixture_start();
  run_test(test_dec_enc);
  run_test(test_enc_dec_0);
  test_fixture_end();
}

int main(int argc, char **argv) {
  return seatest_testrunner(argc, argv, all_tests, NULL, NULL);
}
