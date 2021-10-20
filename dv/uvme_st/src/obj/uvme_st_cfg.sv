// Copyright 2021 Datum Technology Corporation
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_ST_CFG_SV__
`define __UVME_ST_CFG_SV__


/**
 * Object encapsulating all parameters for creating, connecting and running Moore.io UVM Extension Library Self-Testing
 * Environment (uvme_st_env_c) components.
 */
class uvme_st_cfg_c extends uvml_cfg_c;
   
   // Integrals
   rand bit                      enabled              ; ///< 
   rand uvm_active_passive_enum  is_active            ; ///< 
   rand bit                      scoreboarding_enabled; ///< 
   rand bit                      cov_model_enabled    ; ///< 
   rand bit                      trn_log_enabled      ; ///< 
   rand uvml_reset_type_enum     reset_type           ; //< 
   
   // Objects
   rand uvma_st_cfg_c  tx_cfg; ///< 
   rand uvma_st_cfg_c  rx_cfg; ///< 
   
   
   `uvm_object_utils_begin(uvme_st_cfg_c)
      `uvm_field_int (                         enabled              , UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active            , UVM_DEFAULT)
      `uvm_field_int (                         scoreboarding_enabled, UVM_DEFAULT)
      `uvm_field_int (                         cov_model_enabled    , UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled      , UVM_DEFAULT)
      
      `uvm_field_object(tx_cfg, UVM_DEFAULT)
      `uvm_field_object(rx_cfg, UVM_DEFAULT)
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
         tx_cfg.enabled == 1;
         rx_cfg.enabled == 1;
      }
      else {
         tx_cfg.enabled == 0;
         rx_cfg.enabled == 0;
      }
      
      if (is_active == UVM_ACTIVE) {
         tx_cfg.is_active == UVM_ACTIVE ;
         rx_cfg.is_active == UVM_PASSIVE;
      }
      else {
         tx_cfg.is_active == UVM_PASSIVE;
         rx_cfg.is_active == UVM_PASSIVE;
      }
      
      if (trn_log_enabled) {
         /*soft*/ tx_cfg.trn_log_enabled == 1;
         /*soft*/ rx_cfg.trn_log_enabled == 1;
      }
      else {
         tx_cfg.trn_log_enabled == 0;
         rx_cfg.trn_log_enabled == 0;
      }
      
      if (cov_model_enabled) {
         /*soft*/ tx_cfg.cov_model_enabled == 1;
         /*soft*/ rx_cfg.cov_model_enabled == 1;
      }
      else {
         tx_cfg.cov_model_enabled == 0;
         rx_cfg.cov_model_enabled == 0;
      }
      
      tx_cfg.reset_type == reset_type;
      rx_cfg.reset_type == reset_type;
   }
   
   
   /**
    * Creates sub-configuration objects.
    */
   extern function new(string name="uvme_st_cfg");
   
endclass : uvme_st_cfg_c


function uvme_st_cfg_c::new(string name="uvme_st_cfg");
   
   super.new(name);
   
   tx_cfg  = uvma_st_cfg_c::type_id::create("tx_cfg");
   rx_cfg  = uvma_st_cfg_c::type_id::create("rx_cfg");
   
endfunction : new


`endif // __UVME_ST_CFG_SV__
