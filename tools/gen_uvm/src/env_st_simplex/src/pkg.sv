// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVME_${name_uppercase}_ST_PKG_SV__
`define __UVME_${name_uppercase}_ST_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_hrtbt_macros.sv"
`include "uvml_logs_macros.sv"
`include "uvml_trn_macros.sv"
`include "uvml_sb_macros.sv"
`include "uvma_${name}_macros.sv"
`include "uvme_${name}_st_macros.sv"

// Interface(s)


 /**
 * Encapsulates all the types needed for an UVM environment capable of
 * self-testing an ${name_normal_case} VIP.
 */
package uvme_${name}_st_pkg;
   
   import uvm_pkg       ::*;
   import uvml_hrtbt_pkg::*;
   import uvml_logs_pkg ::*;
   import uvml_trn_pkg  ::*;
   import uvml_sb_pkg   ::*;
   import uvma_${name}_pkg::*;
   
   // Constants / Structs / Enums
   `include "uvme_${name}_st_constants.sv"
   `include "uvme_${name}_st_tdefs.sv"
   
   // Objects
   `include "uvme_${name}_st_cfg.sv"
   `include "uvme_${name}_st_cntxt.sv"
   
   // Environment components
   `include "uvme_${name}_st_cov_model.sv"
   `include "uvme_${name}_st_prd.sv"
   `include "uvme_${name}_st_vsqr.sv"
   `include "uvme_${name}_st_env.sv"
   
   // Sequences
   `include "uvme_${name}_st_base_vseq.sv"
   
endpackage : uvme_${name}_st_pkg


// Module(s) / Checker(s)
`ifdef UVME_${name_uppercase}_ST_INC_CHKR
`include "uvme_${name}_st_chkr.sv"
`endif


`endif // __UVME_${name_uppercase}_ST_PKG_SV__
