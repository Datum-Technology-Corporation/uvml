// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_TEST_SV__
`define __UVML_TEST_SV__


/**
 * TODO Describe uvml_test_c
 */
class uvml_test_c /*#(
   type T_TEST_CFG ,
   type T_ENV_CFG  ,
   type T_ENV_CNTXT
)*/ extends uvm_test;
   
   // Objects
   /*rand T_TEST_CFG   test_cfg ; ///< 
   rand T_ENV_CFG    env_cfg  ; ///< 
        T_ENV_CNTXT  env_cntxt;*/ ///< 
   
   
   `uvm_component_utils_begin(uvml_test_c/*#(.T_TEST_CFG(T_TEST_CFG), .T_ENV_CFG(T_ENV_CFG), .T_ENV_CNTXT(T_ENV_CNTXT))*/)
      //`uvm_field_object(test_cfg , UVM_DEFAULT)
      //`uvm_field_object(env_cfg  , UVM_DEFAULT)
      //`uvm_field_object(env_cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvml_test", uvm_component parent=null);
   
   /**
    * TODO Describe uvml_test_c::phase_started()
    */
   extern function void phase_started(uvm_phase phase);
   
   /**
    * TODO Describe uvml_test_c::phase_ended()
    */
   extern function void phase_ended(uvm_phase phase);
   
   /**
    * TODO Describe uvml_test_c::print_banner()
    */
   extern function void print_banner(string text);
   
endclass : uvml_test_c


function uvml_test_c::new(string name="uvml_test", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvml_test_c::phase_started(uvm_phase phase);
   
   super.phase_started(phase);
   print_banner($sformatf("start of %s phase", phase.get_name()));
   
endfunction : phase_started


function void uvml_test_c::phase_ended(uvm_phase phase);
   
   super.phase_ended(phase);
   
   if (phase.is(uvm_final_phase::get())) begin
      uvm_config_db#(bit)::set(null, "", "sim_finished", 1);
      print_banner("test finished");
   end
   
endfunction : phase_ended


function void uvml_test_c::print_banner(string text);
   
   $display("");
   $display("*******************************************************************************");
   $display(text.toupper());
   $display("*******************************************************************************");
   
endfunction : print_banner


`endif // __UVML_TEST_SV__
