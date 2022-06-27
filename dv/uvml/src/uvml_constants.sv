// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_CONSTANTS_SV__
`define __UVML_CONSTANTS_SV__


/**
 * WARNING These are not in use because Vivado can't accept a non-hardcoded string in calls to $value$plusargs()
 */
const string  uvml_file_cli_args[uvml_file_base_dir_enum] = '{
   UVML_FILE_BASE_DIR_SIM         : `UVML_FILE_CLI_ARG_BASE_DIR_SIM         ,
   UVML_FILE_BASE_DIR_TB          : `UVML_FILE_CLI_ARG_BASE_DIR_TB          ,
   UVML_FILE_BASE_DIR_TESTS       : `UVML_FILE_CLI_ARG_BASE_DIR_TESTS       ,
   UVML_FILE_BASE_DIR_TEST_RESULTS: `UVML_FILE_CLI_ARG_BASE_DIR_TEST_RESULTS,
   UVML_FILE_BASE_DIR_DV          : `UVML_FILE_CLI_ARG_BASE_DIR_DV          ,
   UVML_FILE_BASE_DIR_RTL         : `UVML_FILE_CLI_ARG_BASE_DIR_RTL         
};

const string uvml_watchdog_cli_arg = "UVML_WATCHDOG";

const int unsigned  uvml_hrtbt_default_startup_timeout  = 10_000;
const int unsigned  uvml_hrtbt_default_heartbeat_period = 20_000;
const int unsigned  uvml_hrtbt_default_refresh_period   =  5_000;

const int unsigned  uvml_watchdog_default_timeout = 100_000_000; // 100 ms


`endif // __UVML_CONSTANTS_SV__
