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

#define ADDR_ID (0x0)
#define ADDR_VERSION (0x4)
#define ADDR_CONF (0x8)
#define ADDR_CTRL (0x10)
#define ADDR_READ_STATUS (0x20)
#define ADDR_READ_CTRL (0x24)
#define ADDR_READ_ADDR_LO (0x28)
#define ADDR_READ_ADDR_HI (0x2c)
#define ADDR_READ_LEN (0x30)
#define ADDR_READ_RESP_CNTR (0x34)
#define ADDR_READ_DURATION (0x38)
#define ADDR_WRITE_STATUS (0x60)
#define ADDR_WRITE_CTRL (0x64)
#define ADDR_WRITE_ADDR_LO (0x68)
#define ADDR_WRITE_ADDR_HI (0x6c)
#define ADDR_WRITE_LEN (0x70)
#define ADDR_WRITE_RESP_CNTR (0x74)
#define ADDR_WRITE_DURATION (0x78)
#define ADDR_CHECK_TOT (0xa0)
#define ADDR_CHECK_OK (0xa4)
