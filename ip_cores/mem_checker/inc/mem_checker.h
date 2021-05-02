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

#include <stdint.h>

enum mem_check_mode {
    MEM_CHECK_MODE_ALL_0,
    MEM_CHECK_MODE_ALL_1,
    MEM_CHECK_MODE_WALK_0,
    MEM_CHECK_MODE_WALK_1,
    MEM_CHECK_MODE_ALT,
    MEM_CHECK_MODE_CNTR_8,
    MEM_CHECK_MODE_CNTR_32,
    MEM_CHECK_MODE_CNTR_128
};

int mem_check_write(uint32_t base, uint64_t mem_address, uint32_t mem_size, enum mem_check_mode mode);

int mem_check_read_and_check(uint32_t base, uint64_t mem_address, uint32_t mem_size, enum mem_check_mode mode);

int mem_check_full(uint32_t base, uint64_t mem_address, uint32_t mem_size);
