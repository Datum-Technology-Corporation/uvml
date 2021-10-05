// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_PKG_SV__
`define __UVMA_${name_uppercase}_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_hrtbt_macros.sv"
`include "uvma_${name}_macros.sv"

// Interface(s)
`include "uvma_${name}_if.sv"


/**
 * Encapsulates all the types needed for an UVM agent capable of driving and/or monitoring ${name_normal_case}.
 */
package uvma_${name}_pkg;
   
   import uvm_pkg       ::*;
   import uvml_hrtbt_pkg::*;
   import uvml_trn_pkg  ::*;
   import uvml_logs_pkg ::*;
   
   // Constants / Structs / Enums
   `include "uvma_${name}_constants.sv"
   `include "uvma_${name}_tdefs.sv"
   
   // Objects
   `include "uvma_${name}_cfg.sv"
   `include "uvma_${name}_cntxt.sv"
   
   // High-level transactions
   `include "uvma_${name}_mon_trn.sv"
   `include "uvma_${name}_mon_trn_logger.sv"
   `include "uvma_${name}_seq_item.sv"
   `include "uvma_${name}_seq_item_logger.sv"
   
   // Agent components
   `include "uvma_${name}_cov_model.sv"
   `include "uvma_${name}_drv.sv"
   `include "uvma_${name}_mon.sv"
   `include "uvma_${name}_sqr.sv"
   `include "uvma_${name}_agent.sv"
   
   // Sequences
   `include "uvma_${name}_base_seq.sv"
   // TODO Add sequences to uvma_${name}_pkg
   
endpackage : uvma_${name}_pkg


// Module(s) / Checker(s)
`ifdef UVMA_${name_uppercase}_INC_IF_CHKR
`include "uvma_${name}_if_chkr.sv"
`endif


`endif // __UVMA_${name_uppercase}_PKG_SV__
