// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_ST_TRAFFIC_TEST_SV__
`define __UVMT_ST_TRAFFIC_TEST_SV__


/**
 * TODO Describe uvmt_st_traffic_test_c
 */
class uvmt_st_traffic_test_c extends uvmt_st_base_test_c;
   
   rand uvme_st_traffic_vseq_c  traffic_vseq; ///< TODO Describe uvmt_st_traffic_test_c::traffic_vseq
   
   
   `uvm_component_utils(uvmt_st_traffic_test_c)
   
   
   /**
    * Creates traffic_vseq.
    */
   extern function new(string name="uvmt_st_traffic_test", uvm_component parent=null);
   
   /**
    * Runs traffic_vseq on vsequencer.
    */
   extern virtual task main_phase(uvm_phase phase);
   
endclass : uvmt_st_traffic_test_c


function uvmt_st_traffic_test_c::new(string name="uvmt_st_traffic_test", uvm_component parent=null);
   
   super.new(name, parent);
   traffic_vseq = uvme_st_traffic_vseq_c::type_id::create("traffic_vseq");
   
endfunction : new


task uvmt_st_traffic_test_c::main_phase(uvm_phase phase);
   
   super.main_phase(phase);
   
   phase.raise_objection(this);
   `uvm_info("TEST", $sformatf("Starting traffic virtual sequence:\n%s", traffic_vseq.sprint()), UVM_NONE)
   traffic_vseq.start(vsequencer);
   `uvm_info("TEST", $sformatf("Finished traffic virtual sequence:\n%s", traffic_vseq.sprint()), UVM_NONE)
   phase.drop_objection(this);
   
endtask : main_phase


`endif // __UVMT_ST_TRAFFIC_TEST_SV__
