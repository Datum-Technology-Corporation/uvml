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
`include "uvml_trn_macros.sv"
`include "uvml_logs_macros.sv"
`include "uvma_reset_macros.sv"
`include "uvma_${name}_macros.sv"

// Interface(s)
`include "uvma_eth_if.sv"


/**
 * Encapsulates all the types needed for an UVM agent capable of driving and/or
 * monitoring both directions of ${name_normal_case}.
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
   `include "uvma_${name}_cfg_simplex.sv"
   `include "uvma_${name}_cfg.sv"
   `include "uvma_${name}_cntxt_simplex.sv"
   `include "uvma_${name}_cntxt.sv"
   
   // High-level transactions
   `include "uvma_${name}_mon_trn.sv"
   `include "uvma_${name}_mon_trn_logger.sv"
   `include "uvma_${name}_seq_item.sv"
   `include "uvma_${name}_seq_item_logger.sv"
   
   // Layer sequence items
   `include "uvma_${name}_layer_seq_item_${layer_name}.sv"
   `include "uvma_${name}_layer_seq_item_${layer_name}_logger.sv"
   
   // Layer sequencers
   `include "uvma_${name}_layer_sqr_base.sv"
   `include "uvma_${name}_layer_sqr_${layer_name}.sv"
   
   // Layer sequences
   `include "uvma_${name}_layer_seq_base.sv"
   `include "uvma_${name}_layer_seq_${layer_name}.sv"
   
   // Adapter sequence items
   `include "uvma_${name}_adptr_seq_item_base.sv"
   `include "uvma_${name}_adptr_seq_item_${layer_name}.sv"
   `include "uvma_${name}_adptr_seq_item_${layer_name}_logger.sv"
   
   // Adapter sequencers
   `include "uvma_${name}_adptr_sqr_base.sv"
   `include "uvma_${name}_adptr_sqr_${layer_name}.sv"
   
   // Adapter sequences
   `include "uvma_${name}_adptr_seq_base.sv"
   `include "uvma_${name}_adptr_seq_${layer_name}.sv"
   
   // Adapter drivers
   `include "uvma_${name}_adptr_drv_base.sv"
   `include "uvma_${name}_adptr_drv_${layer_name}.sv"
   
   // Monitor layer transactions
   `include "uvma_${name}_layer_mon_trn_base.sv"
   `include "uvma_${name}_layer_mon_trn_${layer_name}.sv"
   `include "uvma_${name}_layer_mon_trn_${layer_name}_logger.sv"
   
   // Monitor layers
   `include "uvma_${name}_layer_mon_base.sv"
   `include "uvma_${name}_layer_mon_${layer_name}.sv"
   
   // Monitor adapter transactions
   `include "uvma_${name}_adptr_mon_trn_base.sv"
   `include "uvma_${name}_adptr_mon_trn_${layer_name}.sv"
   `include "uvma_${name}_adptr_mon_trn_${layer_name}_logger.sv"
   
   // Monitor adapters
   `include "uvma_${name}_adptr_mon_base.sv"
   `include "uvma_${name}_adptr_mon_${layer_name}.sv"
   
   // Agent components
   `include "uvma_${name}_cov_model.sv"
   `include "uvma_${name}_drv.sv"
   `include "uvma_${name}_mon.sv"
   `include "uvma_${name}_sqr.sv"
   `include "uvma_${name}_agent.sv"
   
   // Sequences
   `include "uvma_${name}_seq_base.sv"
   
endpackage : uvma_${name}_pkg


// Module(s) / Checker(s)
`ifdef UVMA_${name_uppercase}_INC_IF_CHKR
`include "uvma_${name}_if_chkr.sv"
`endif


`endif // __UVMA_${name_uppercase}_PKG_SV__
