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
#include <unistd.h>

#include "io.h"
#include "sys/alt_stdio.h"

#include "mem_checker.h"
#include "mem_checker_regs.h"

// clang-format off
const char* mem_check_mode_str[8] = {
    "all 0s",
    "all 1s",
    "walking 1",
    "walking 0",
    "alternate",
    "8-bit counter",
    "32-bit counter",
    "128-bit counter"
};
// clang-format on

static void _mem_check_get_id(uint32_t base, uint32_t* id, uint32_t* ver)
{
    *id = IORD_32DIRECT(base, ADDR_ID);
    *ver = IORD_32DIRECT(base, ADDR_VERSION);
}

static void _mem_check_ctrl(uint32_t base, bool write_not_read, enum mem_check_mode mode)
{
    IOWR_32DIRECT(base, ADDR_CTRL, (mode << 8) | write_not_read);
}

static void _mem_check_write_start(uint32_t base, uint64_t mem_address,
    uint32_t mem_size)
{
    IOWR_32DIRECT(base, ADDR_WRITE_ADDR_LO, mem_address);
    IOWR_32DIRECT(base, ADDR_WRITE_ADDR_HI, mem_address >> 32);
    IOWR_32DIRECT(base, ADDR_WRITE_LEN, mem_size);
    IOWR_32DIRECT(base, ADDR_WRITE_CTRL, 1);
}

static int _mem_check_wait_done(uint32_t base, uint32_t reg_addr)
{
    uint32_t status;

    for (int i = 0; i < 10000; i++) {
        status = IORD_32DIRECT(base, reg_addr);
        if (status & 1) {
            return 0;
        }
        usleep(1000);
    }

    return -1;
}

static int _mem_check_write_wait_done(uint32_t base)
{
    return _mem_check_wait_done(base, ADDR_WRITE_STATUS);
}

static int _mem_check_read_wait_done(uint32_t base)
{
    return _mem_check_wait_done(base, ADDR_READ_STATUS);
}

static void _mem_check_write_clear(uint32_t base)
{
    IOWR_32DIRECT(base, ADDR_WRITE_STATUS, 1);
}

static void _mem_check_read_start(uint32_t base, uint64_t mem_address,
    uint32_t mem_size)
{
    IOWR_32DIRECT(base, ADDR_READ_ADDR_LO, mem_address);
    IOWR_32DIRECT(base, ADDR_READ_ADDR_HI, mem_address >> 32);
    IOWR_32DIRECT(base, ADDR_READ_LEN, mem_size);
    IOWR_32DIRECT(base, ADDR_READ_CTRL, 1);
}

static void _mem_check_read_clear(uint32_t base)
{
    IOWR_32DIRECT(base, ADDR_READ_STATUS, 1);
}

static void _mem_check_get_stats(uint32_t base, uint32_t* read_duration,
    uint32_t* write_duration, uint32_t* check_tot,
    uint32_t* check_ok)
{
    *read_duration = IORD_32DIRECT(base, ADDR_READ_DURATION);
    *write_duration = IORD_32DIRECT(base, ADDR_WRITE_DURATION);
    *check_tot = IORD_32DIRECT(base, ADDR_CHECK_TOT);
    *check_ok = IORD_32DIRECT(base, ADDR_CHECK_OK);
}

static int _mem_check_print_stats(uint32_t base, uint32_t mem_size)
{
    uint32_t read_duration, write_duration, check_tot, check_ok;
    _mem_check_get_stats(base, &read_duration, &write_duration, &check_tot,
        &check_ok);

    int write_througput_mbps = mem_size * 200ULL / write_duration;
    int read_througput_mbps = mem_size * 200ULL / read_duration;

    bool mem_check_pass = (check_tot == mem_size / 64) && (check_tot == check_ok);

    alt_printf("[mem check]   results = %s (%x / %x)\n",
        mem_check_pass ? "PASS" : "FAIL", check_ok, check_tot);

    alt_printf("[mem check]   write throughput = 0x%x MB/s\n",
        write_througput_mbps);
    alt_printf("[mem check]   read throughput = 0x%x MB/s\n", read_througput_mbps);
    return mem_check_pass ? 0 : -2;
}

static void _mem_check_get_conf(uint32_t base, unsigned int* avalon_width_bytes,
    unsigned int* avalon_burst_len)
{
    uint32_t cfg = IORD_32DIRECT(base, ADDR_CONF);
    *avalon_width_bytes = cfg & 0xFF;
    *avalon_burst_len = (cfg >> 8) & 0xFF;
}

int mem_check_write(uint32_t base, uint64_t mem_address, uint32_t mem_size, enum mem_check_mode mode)
{
    int rc;
    _mem_check_ctrl(base, true, mode);
    _mem_check_write_start(base, mem_address, mem_size);
    rc = _mem_check_write_wait_done(base);
    if (rc) {
        alt_printf("[mem check] ERROR: timeout on write procedure\n");
        return rc;
    }
    _mem_check_write_clear(base);

    return 0;
}

int mem_check_read_and_check(uint32_t base, uint64_t mem_address, uint32_t mem_size, enum mem_check_mode mode)
{
    int rc;
    _mem_check_ctrl(base, false, mode);
    _mem_check_read_start(base, mem_address, mem_size);
    rc = _mem_check_read_wait_done(base);
    if (rc) {
        alt_printf("[mem check] ERROR: timeout on read procedure\n");
        return rc;
    }

    rc = _mem_check_print_stats(base, mem_size);
    if (rc) {
        return rc;
    }

    _mem_check_read_clear(base);

    return 0;
}

int mem_check_full(uint32_t base, uint64_t mem_address, uint32_t mem_size)
{
    int rc;

    uint32_t id, ver;
    _mem_check_get_id(base, &id, &ver);

    alt_printf("[mem check] =================================================\n");
    alt_printf("[mem check] IP id = 0x%x, version = %x\n", id, ver);

    unsigned int avalon_width_bytes, avalon_burst_len;
    _mem_check_get_conf(base, &avalon_width_bytes, &avalon_burst_len);
    alt_printf("[mem check] Avalon width = 0x%x bytes, burst len = 0x%x\n",
        avalon_width_bytes, avalon_burst_len);

    for (int mode = 0; mode < 8; mode++) {
        alt_printf("[mem check] mode = %s\n", mem_check_mode_str[mode]);

        rc = mem_check_write(base, mem_address, mem_size, mode);
        if (rc) {
            return rc;
        }

        rc = mem_check_read_and_check(base, mem_address, mem_size, mode);
        if (rc) {
            return rc;
        }
    }

    return 0;
}
