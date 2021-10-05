// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVME_${name_uppercase}_ST_CFG_SV__
`define __UVME_${name_uppercase}_ST_CFG_SV__


/**
 * Object encapsulating all parameters for creating, connecting and running
 * ${name_normal_case} VIP Self-Testing Environment (uvme_${name}_st_env_c)
 * components.
 */
class uvme_${name}_st_cfg_c extends uvm_object;
   
   // Integrals
   rand bit                      enabled;
   rand uvm_active_passive_enum  is_active;
   rand bit                      scoreboarding_enabled;
   rand bit                      cov_model_enabled;
   rand bit                      trn_log_enabled;
   
   // Objects
   rand uvma_${name}_cfg_c  ${name_1}_cfg;
   rand uvma_${name}_cfg_c  ${name_2}_cfg;
   rand uvml_sb_cfg_c       sb_cfg;
   
   
   `uvm_object_utils_begin(uvme_${name}_st_cfg_c)
      `uvm_field_int (                         enabled              , UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active            , UVM_DEFAULT)
      `uvm_field_int (                         scoreboarding_enabled, UVM_DEFAULT)
      `uvm_field_int (                         cov_model_enabled    , UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled      , UVM_DEFAULT)
      
      `uvm_field_object(${name_1}_cfg, UVM_DEFAULT)
      `uvm_field_object(${name_2}_cfg, UVM_DEFAULT)
      `uvm_field_object(sb_cfg       , UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   constraint defaults_cons {
      soft enabled                == 0;
      soft is_active              == UVM_PASSIVE;
      soft scoreboarding_enabled  == 1;
      soft cov_model_enabled      == 0;
      soft trn_log_enabled        == 1;
   }
   
   constraint agent_cfg_cons {
      if (enabled) {
         ${name_1}_cfg.enabled == 1;
         ${name_2}_cfg.enabled == 1;
      }
      
      if (is_active == UVM_ACTIVE) {
         ${name_1}_cfg.is_active == UVM_ACTIVE;
         ${name_2}_cfg.is_active == UVM_ACTIVE;
      }
      
      if (trn_log_enabled) {
         soft ${name_1}_cfg.trn_log_enabled == 1;
         soft ${name_2}_cfg.trn_log_enabled == 1;
      }
   }
   
   constraint sb_cfg_cons {
      if (scoreboarding_enabled) {
         soft sb_cfg.enabled == 1;
      }
      else {
         sb_cfg.enabled == 0;
      }
   }
   
   
   /**
    * Creates sub-configuration objects.
    */
   extern function new(string name="uvme_${name}_st_cfg");
   
endclass : uvme_${name}_st_cfg_c


`pragma protect begin


function uvme_${name}_st_cfg_c::new(string name="uvme_${name}_st_cfg");
   
   super.new(name);
   
   ${name_1}_cfg  = uvma_${name}_cfg_c::type_id::create("${name_1}_cfg");
   ${name_2}_cfg  = uvma_${name}_cfg_c::type_id::create("${name_2}_cfg");
   sb_cfg         = uvml_sb_cfg_c::type_id::create("sb_cfg");
   
endfunction : new


`pragma protect end


`endif // __UVME_${name_uppercase}_ST_CFG_SV__
