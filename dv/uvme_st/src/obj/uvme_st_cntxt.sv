// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_ST_CNTXT_SV__
`define __UVME_ST_CNTXT_SV__


/**
 * Object encapsulating all state variables for Moore.io UVM Extension Library Self-Testing environment
 * (uvme_st_env_c) components.
 */
class uvme_st_cntxt_c extends uvml_cntxt_c;
   
   // Agent context handles
   uvma_st_cntxt_c  tx_cntxt; ///< 
   uvma_st_cntxt_c  rx_cntxt; ///< 
   
   uvma_st_mon_trn_c  sb_exp_q[$]   ; ///< 
   int unsigned       sb_num_matches; ///< 
   
   // Events
   uvm_event  sample_cfg_e  ; ///< 
   uvm_event  sample_cntxt_e; ///< 
   
   
   `uvm_object_utils_begin(uvme_st_cntxt_c)
      `uvm_field_object(tx_cntxt, UVM_DEFAULT)
      `uvm_field_object(rx_cntxt, UVM_DEFAULT)
      
      `uvm_field_queue_object(sb_exp_q      , UVM_DEFAULT)
      `uvm_field_int         (sb_num_matches, UVM_DEFAULT)
      
      `uvm_field_event(sample_cfg_e  , UVM_DEFAULT)
      `uvm_field_event(sample_cntxt_e, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Builds events and sub-context objects.
    */
   extern function new(string name="uvme_st_cntxt");
   
   /**
    * TODO Describe uvme_st_cntxt_c::reset()
    */
   extern function void reset();
   
endclass : uvme_st_cntxt_c


function uvme_st_cntxt_c::new(string name="uvme_st_cntxt");
   
   super.new(name);
   
   sb_num_matches = 0;
   
   tx_cntxt = uvma_st_cntxt_c::type_id::create("tx_cntxt");
   rx_cntxt = uvma_st_cntxt_c::type_id::create("rx_cntxt");
   
   sample_cfg_e   = new("sample_cfg_e"  );
   sample_cntxt_e = new("sample_cntxt_e");
   
endfunction : new


function void uvme_st_cntxt_c::reset();
   
   tx_cntxt.reset();
   rx_cntxt.reset();
   
endfunction : reset


`endif // __UVME_ST_CNTXT_SV__
