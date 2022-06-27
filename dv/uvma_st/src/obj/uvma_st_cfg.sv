// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_ST_CFG_SV__
`define __UVMA_ST_CFG_SV__


/**
 * Object encapsulating all parameters for creating, connecting and running all Extension Library Self-Test agent
 * (uvma_st_agent_c) components.
 */
class uvma_st_cfg_c extends uvml_cfg_c;
   
   // Generic options
   rand bit                      enabled          ; ///< 
   rand uvm_active_passive_enum  is_active        ; ///< 
   rand uvml_reset_type_enum     reset_type       ; ///< 
   rand uvm_sequencer_arb_mode   sqr_arb_mode     ; ///< 
   rand bit                      cov_model_enabled; ///< 
   rand bit                      trn_log_enabled  ; ///< 
   
   
   `uvm_object_utils_begin(uvma_st_cfg_c)
      `uvm_field_int (                         enabled          , UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active        , UVM_DEFAULT)
      `uvm_field_enum(uvml_reset_type_enum   , reset_type       , UVM_DEFAULT)
      `uvm_field_enum(uvm_sequencer_arb_mode , sqr_arb_mode     , UVM_DEFAULT)
      `uvm_field_int (                         cov_model_enabled, UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled  , UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   constraint defaults_cons {
      soft enabled           == 1;
      soft is_active         == UVM_PASSIVE;
      soft reset_type        == UVML_RESET_TYPE_SYNCHRONOUS;
      soft sqr_arb_mode      == UVM_SEQ_ARB_FIFO;
      soft cov_model_enabled == 0;
      soft trn_log_enabled   == 1;
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_st_cfg");
   
endclass : uvma_st_cfg_c


function uvma_st_cfg_c::new(string name="uvma_st_cfg");
   
   super.new(name);
   
endfunction : new


`endif // __UVMA_ST_CFG_SV__
