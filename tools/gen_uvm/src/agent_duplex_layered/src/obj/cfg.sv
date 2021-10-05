// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_CFG_SV__
`define __UVMA_${name_uppercase}_CFG_SV__


/**
 * Object encapsulating all parameters for creating, connecting and running all
 * ${name_normal_case} agent (uvma_${name}_agent_c) components in both directions.
 */
class uvma_${name}_cfg_c extends uvm_object;
   
   // Common
   rand bit                      enabled;
   rand uvm_active_passive_enum  is_active;
   rand uvm_sequencer_arb_mode   sqr_arb_mode;
   rand bit                      cov_model_enabled;
   rand bit                      trn_log_enabled;
   rand uvma_${name}_logging_depth_enum  logging_depth;
   
   // Protocol
   rand uvma_${name}_layer_enum  layer;
   
   // Sub-configuration objects
   rand uvma_${name}_cfg_simplex_c  ${direction_rx}_cfg;
   rand uvma_${name}_cfg_simplex_c  ${direction_tx}_cfg;
   
   
   `uvm_object_utils_begin(uvma_${name}_cfg_c)
      `uvm_field_int (                         enabled          , UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active        , UVM_DEFAULT)
      `uvm_field_enum(uvm_sequencer_arb_mode , sqr_arb_mode     , UVM_DEFAULT)
      `uvm_field_int (                         cov_model_enabled, UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled  , UVM_DEFAULT)
      `uvm_field_enum(uvma_${name}_logging_depth_enum, logging_depth    , UVM_DEFAULT)
      
      `uvm_field_enum(uvma_${name}_layer_enum, layer, UVM_DEFAULT)
      
      `uvm_field_object(${direction_rx}_cfg, UVM_DEFAULT)
      `uvm_field_object(${direction_tx}_cfg, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   constraint defaults_cons {
      soft enabled           == 1;
      soft is_active         == UVM_PASSIVE;
      soft sqr_arb_mode      == UVM_SEQ_ARB_FIFO;
      soft cov_model_enabled == 0;
      soft trn_log_enabled   == 1;
   }
   
   constraint limits_cons {
      if (enabled == 0) {
         ${direction_rx}_cfg.enabled == 0;
         ${direction_tx}_cfg.enabled == 0;
      }
      
      if (is_active == UVM_ACTIVE) {
         ${direction_rx}_cfg.is_active == UVM_PASSIVE;
         ${direction_tx}_cfg.is_active == UVM_ACTIVE;
      }
      else if (is_active == UVM_PASSIVE) {
         ${direction_rx}_cfg.is_active == UVM_PASSIVE;
         ${direction_tx}_cfg.is_active == UVM_PASSIVE;
      }
   }
   
   
   /**
    * Creates sub-configuration objects.
    */
   extern function new(string name="uvma_${name}_cfg");
   
endclass : uvma_${name}_cfg_c


`pragma protect begin


function uvma_${name}_cfg_c::new(string name="uvma_${name}_cfg");
   
   super.new(name);
   
   ${direction_rx}_cfg = uvma_${name}_cfg_simplex_c::type_id::create("${direction_rx}_cfg");
   ${direction_tx}_cfg = uvma_${name}_cfg_simplex_c::type_id::create("${direction_tx}_cfg");
   
   ${direction_rx}_cfg.parent_cfg = this;
   ${direction_tx}_cfg.parent_cfg = this;
   
endfunction : new


`pragma protect end


`endif // __UVMA_${name_uppercase}_CFG_SV__
