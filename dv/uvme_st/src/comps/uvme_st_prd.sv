// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_ST_PRD_SV__
`define __UVME_ST_PRD_SV__


/**
 * Component implementing transaction-based software model of Moore.io UVM Extension Library
 */
class uvme_st_prd_c extends uvm_component;
   
   // Objects
   uvme_st_cfg_c    cfg;
   uvme_st_cntxt_c  cntxt;
   
   // TLM
   uvm_analysis_export  #(uvma_st_mon_trn_c)  in_export;
   uvm_tlm_analysis_fifo#(uvma_st_mon_trn_c)  in_fifo  ;
   uvm_analysis_port    #(uvma_st_mon_trn_c)  out_ap   ;
   
   
   `uvm_component_utils_begin(uvme_st_prd_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_st_prd", uvm_component parent=null);
   
   /**
    * TODO Describe uvme_st_prd_c::build_phase()
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_st_prd_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_st_prd_c::run_phase()
    */
   extern virtual task run_phase(uvm_phase phase);
   
endclass : uvme_st_prd_c


function uvme_st_prd_c::new(string name="uvme_st_prd", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_st_prd_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvme_st_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvme_st_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
   // Build TLM objects
   in_export  = new("in_export", this);
   in_fifo    = new("in_fifo"  , this);
   out_ap     = new("out_ap"   , this);
   
endfunction : build_phase


function void uvme_st_prd_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   // Connect TLM objects
   in_export.connect(in_fifo.analysis_export);
   
endfunction: connect_phase


task uvme_st_prd_c::run_phase(uvm_phase phase);
   
   uvma_st_mon_trn_c  in_trn, out_trn;
   
   super.run_phase(phase);
   
   forever begin
      // Get next transaction and copy it
      in_fifo.get(in_trn);
      out_trn = uvma_st_mon_trn_c::type_id::create("out_trn");
      out_trn.copy(in_trn);
      
      if (cntxt.rx_cntxt.reset_state != UVML_RESET_STATE_POST_RESET) begin
         out_trn.set_may_drop(1);
      end
      
      // Send transaction to analysis port
      out_ap.write(out_trn);
   end
   
endtask: run_phase


`endif // __UVME_ST_PRD_SV__
