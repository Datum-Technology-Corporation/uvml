// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_ST_CONSTANTS_SV__
`define __UVMT_ST_CONSTANTS_SV__


const int unsigned uvmt_st_default_clk_period          =    10_000; //   10 ns (100 Mhz)
const int unsigned uvmt_st_default_reset_period        =       100; //  100 ns
const int unsigned uvmt_st_default_startup_timeout     =    20_000; //   20 us
const int unsigned uvmt_st_default_heartbeat_period    =    20_000; //   20 us
const int unsigned uvmt_st_default_simulation_timeout  = 1_000_000; //    1 ms
const int unsigned uvmt_st_default_num_heartbeats      =        10;


`endif // __UVMT_ST_CONSTANTS_SV__
