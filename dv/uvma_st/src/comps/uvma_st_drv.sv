// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_ST_DRV_SV__
`define __UVMA_ST_DRV_SV__


/**
 * Component driving a Extension Library Self-Test virtual interface (uvma_st_if).
 */
class uvma_st_drv_c extends uvml_drv_c #(
   .REQ(uvma_st_seq_item_c),
   .RSP(uvma_st_seq_item_c)
);
   
   virtual uvma_st_if.drv_mp  mp; ///< Handle to virtual interface modport
   
   // Objects
   uvma_st_cfg_c    cfg  ; ///< 
   uvma_st_cntxt_c  cntxt; ///< 
   
   // TLM
   uvm_analysis_port #(uvma_st_seq_item_c)  ap; ///< 
   
   
   `uvm_component_utils_begin(uvma_st_drv_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_st_drv", uvm_component parent=null);
   
   /**
    * 1. Ensures cfg & cntxt handles are not null.
    * 2. Builds ap.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Oversees driving, depending on the reset state, by calling drv_<pre|in|post>_reset() tasks.
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * Called by run_phase() while agent is in pre-reset state.
    */
   extern virtual task drv_pre_reset(uvm_phase phase);
   
   /**
    * Called by run_phase() while agent is in reset state.
    */
   extern virtual task drv_in_reset(uvm_phase phase);
   
   /**
    * Called by run_phase() while agent is in post-reset state.
    */
   extern virtual task drv_post_reset(uvm_phase phase);
   
   /**
    * Drives the virtual interface's (cntxt.vif) signals using req's contents.
    */
   extern virtual task drv_req(ref uvma_st_seq_item_c req);
   
endclass : uvma_st_drv_c


function uvma_st_drv_c::new(string name="uvma_st_drv", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_st_drv_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvma_st_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   uvm_config_db#(uvma_st_cfg_c)::set(this, "*", "cfg", cfg);
   
   void'(uvm_config_db#(uvma_st_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   uvm_config_db#(uvma_st_cntxt_c)::set(this, "*", "cntxt", cntxt);
   
   ap = new("ap", this);
   mp = cntxt.vif.drv_mp;
   
endfunction : build_phase


task uvma_st_drv_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
   
   if (cfg.enabled && cfg.is_active) begin
      forever begin
         case (cntxt.reset_state)
            UVML_RESET_STATE_PRE_RESET : drv_pre_reset (phase);
            UVML_RESET_STATE_IN_RESET  : drv_in_reset  (phase);
            UVML_RESET_STATE_POST_RESET: drv_post_reset(phase);
         endcase
      end
   end
   
endtask : run_phase


task uvma_st_drv_c::drv_pre_reset(uvm_phase phase);
   
   @(mp.drv_cb);
   
endtask : drv_pre_reset


task uvma_st_drv_c::drv_in_reset(uvm_phase phase);
   
   @(mp.drv_cb);
   
endtask : drv_in_reset


task uvma_st_drv_c::drv_post_reset(uvm_phase phase);
   
   seq_item_port.get_next_item(req);
   `uvml_hrtbt()
   
   drv_req (req);
   ap.write(req);
   seq_item_port.item_done();
   
endtask : drv_post_reset


task uvma_st_drv_c::drv_req(ref uvma_st_seq_item_c req);
   
   @(mp.drv_cb);
   mp.drv_cb.enable <= 1'b1;
   foreach (req.payload[ii]) begin
      mp.drv_cb.data <= req.payload[ii];
      @(mp.drv_cb);
   end
   mp.drv_cb.enable <= 1'b0;
   mp.drv_cb.data   <=    0;
   @(mp.drv_cb);
   
endtask : drv_req


`endif // __UVMA_ST_DRV_SV__
