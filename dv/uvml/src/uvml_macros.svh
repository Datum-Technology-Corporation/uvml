// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_MACROS_SV__
`define __UVML_MACROS_SV__


`define uvml_stringify(x) `"x`"

`define uvml_hrtbt(ID) \
   uvml_default_hrtbt_mon.heartbeat(this, ID); \

`define uvml_hrtbt_owner(COMP) \
   uvml_default_hrtbt_mon.heartbeat(COMP); \

`define uvml_hrtbt_nowner(ID) \
   uvml_default_hrtbt_mon.heartbeat(null, ID); \

`define uvml_hrtbt_set_cfg(PARAM, VALUE) \
   uvml_default_hrtbt_mon.PARAM = VALUE; \
   `uvm_info("TIME", {"Default heartbeat monitor field '", `uvml_stringify(PARAM), "' set to '", $sformatf("%0d", VALUE), "'"}, UVM_NONE) \

`define uvml_hrtbt_reset \
   uvml_default_hrtbt_mon.reset(); \

`define uvml_watchdog_set_cfg(PARAM, VALUE) \
   uvml_default_watchdog.PARAM = VALUE; \
   `uvm_info("TIME", {"Default watchdog field '", `uvml_stringify(PARAM), "' set to '", $sformatf("%0d", VALUE), "'"}, UVM_NONE) \


`ifndef UVML_FILE_CLI_ARG_BASE_DIR_SIM
   `define UVML_FILE_CLI_ARG_BASE_DIR_SIM "UVML_FILE_BASE_DIR_SIM=%s"
`endif
`ifndef UVML_FILE_CLI_ARG_BASE_DIR_TB
   `define UVML_FILE_CLI_ARG_BASE_DIR_TB "UVML_FILE_BASE_DIR_TB=%s"
`endif
`ifndef UVML_FILE_CLI_ARG_BASE_DIR_TESTS
   `define UVML_FILE_CLI_ARG_BASE_DIR_TESTS "UVML_FILE_BASE_DIR_TESTS=%s"
`endif
`ifndef UVML_FILE_CLI_ARG_BASE_DIR_TEST_RESULTS
   `define UVML_FILE_CLI_ARG_BASE_DIR_TEST_RESULTS "UVML_FILE_BASE_DIR_TEST_RESULTS=%s"
`endif
`ifndef UVML_FILE_CLI_ARG_BASE_DIR_DV
   `define UVML_FILE_CLI_ARG_BASE_DIR_DV "UVML_FILE_BASE_DIR_DV=%s"
`endif
`ifndef UVML_FILE_CLI_ARG_BASE_DIR_RTL
   `define UVML_FILE_CLI_ARG_BASE_DIR_RTL "UVML_FILE_BASE_DIR_RTL=%s"
`endif


`endif // __UVML_MACROS_SV__
