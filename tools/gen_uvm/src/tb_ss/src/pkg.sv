// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMT_${name_uppercase}_PKG_SV__
`define __UVMT_${name_uppercase}_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_hrtbt_macros.sv"
`include "uvmt_${name}_macros.sv"

// Time units and precision for this test bench
timeunit       1ns;
timeprecision  1ps;

// Interface(s)
`include "uvmt_${name}_probe_if.sv"


/**
 * Encapsulates all the types and test cases for the verification of an
 * ${name_normal_case} RTL design.
 */
package uvmt_${name}_pkg;
   
   import uvm_pkg       ::*;
   import uvml_hrtbt_pkg::*;
   import uvml_logs_pkg ::*;
   import uvma_${clk_agent_type}_pkg::*;
   import uvma_${reset_agent_type}_pkg::*;
   import uvma_${ral_agent_type}_pkg::*;
   import uvme_${name}_pkg::*;
   
   // Constants / Structs / Enums
   `include "uvmt_${name}_constants.sv"
   `include "uvmt_${name}_tdefs.sv"
   
   // Sequences
   
   // Base tests
   `include "uvmt_${name}_test_cfg.sv"
   `include "uvmt_${name}_base_test.sv"
   `include "uvmt_${name}_reg_base_test.sv"
   
   // Functional tests
   `include "uvmt_${name}_reg_hw_reset_test.sv"
   `include "uvmt_${name}_reg_bit_bash_test.sv"
   
endpackage : uvmt_${name}_pkg


// Module(s) / Checker(s)
`include "uvmt_${name}_dut_wrap.sv"
`include "uvmt_${name}_dut_chkr.sv"
`include "uvmt_${name}_tb.sv"


`endif // __UVMT_${name_uppercase}_PKG_SV__
