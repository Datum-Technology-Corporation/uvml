// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMT_${name_uppercase}_ST_PKG_SV__
`define __UVMT_${name_uppercase}_ST_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_hrtbt_macros.sv"
`include "uvml_logs_macros.sv"
`include "uvml_sb_macros.sv"
`include "uvml_trn_macros.sv"
`include "uvma_${name}_macros.sv"
`include "uvme_${name}_st_macros.sv"
`include "uvmt_${name}_st_macros.sv"

// Time units and precision for this test bench
timeunit       1ns;
timeprecision  1ps;

// Interface(s)
`include "uvmt_${name}_clknrst_gen_if.sv"


/**
 * Encapsulates all the types and test cases for self-testing an
 * ${name_normal_case} VIP.
 */
package uvmt_${name}_st_pkg;
   
   import uvm_pkg       ::*;
   import uvml_hrtbt_pkg::*;
   import uvml_logs_pkg ::*;
   import uvml_sb_pkg   ::*;
   import uvml_trn_pkg  ::*;
   import uvma_${name}_pkg::*;
   import uvme_${name}_st_pkg::*;
   
   // Constants / Structs / Enums
   `include "uvmt_${name}_st_constants.sv"
   `include "uvmt_${name}_st_tdefs.sv"
   
   // Sequences
   
   // Base test
   `include "uvmt_${name}_st_test_cfg.sv"
   `include "uvmt_${name}_st_base_test.sv"
   
   // TODO Add tests
   //      Ex: `include "uvmt_${name}_st_sanity_test.sv"
   
endpackage : uvmt_${name}_st_pkg


// Module(s) / Checker(s)
`include "uvmt_${name}_st_dut_wrap.sv"
`include "uvmt_${name}_st_dut_chkr.sv"
`include "uvmt_${name}_st_tb.sv"


`endif // __UVMT_${name_uppercase}_ST_PKG_SV__
