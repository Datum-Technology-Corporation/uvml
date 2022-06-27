// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_ST_SB_SV__
`define __UVME_ST_SB_SV__


/**
 * Component implementing transaction-based software model of Moore.io UVM Extension Library
 */
class uvme_st_sb_c extends uvm_scoreboard;
   
   // Objects
   uvme_st_cfg_c    cfg;
   uvme_st_cntxt_c  cntxt;
   
   // TLM
   uvm_analysis_export  #(uvma_st_mon_trn_c)  exp_export;
   uvm_tlm_analysis_fifo#(uvma_st_mon_trn_c)  exp_fifo  ;
   uvm_analysis_export  #(uvma_st_mon_trn_c)  act_export;
   uvm_tlm_analysis_fifo#(uvma_st_mon_trn_c)  act_fifo  ;
   
   
   `uvm_component_utils_begin(uvme_st_sb_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_st_sb", uvm_component parent=null);
   
   /**
    * TODO Describe uvme_st_sb_c::build_phase()
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_st_sb_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_st_sb_c::run_phase()
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_st_sb_c::check_phase()
    */
   extern virtual function void check_phase(uvm_phase phase);
   
endclass : uvme_st_sb_c


function uvme_st_sb_c::new(string name="uvme_st_sb", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_st_sb_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvme_st_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvme_st_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
   // Build TLM objects
   exp_export  = new("exp_export", this);
   exp_fifo    = new("exp_fifo"  , this);
   act_export  = new("act_export", this);
   act_fifo    = new("act_fifo"  , this);
   
endfunction : build_phase


function void uvme_st_sb_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   // Connect TLM objects
   exp_export.connect(exp_fifo.analysis_export);
   act_export.connect(act_fifo.analysis_export);
   
endfunction: connect_phase


task uvme_st_sb_c::run_phase(uvm_phase phase);
   
   uvma_st_mon_trn_c  exp_trn, act_trn;
   
   super.run_phase(phase);
   
   if (cfg.scoreboarding_enabled) begin
      fork
         begin
            exp_fifo.get(exp_trn);
            `uvm_info("ST_SB", $sformatf("Got new expected transaction:\n%s", exp_trn.sprint()), UVM_MEDIUM)
            cntxt.sb_exp_q.push_back(exp_trn);
         end
         
         begin
            forever begin
               act_fifo.get(act_trn);
               `uvm_info("ST_SB", $sformatf("Got new actual transaction:\n%s", act_trn.sprint()), UVM_MEDIUM)
               exp_trn = cntxt.sb_exp_q.pop_front();
               if (exp_trn.compare(act_trn)) begin
                  `uvm_info("ST_SB", $sformatf("Match! exp:\n%s\nact:\n%s", exp_trn.sprint(), act_trn.sprint()), UVM_MEDIUM)
                  cntxt.sb_num_matches++;
               end
               else begin
                  `uvm_error("ST_SB", $sformatf("No match! exp:\n%s\nact:\n%s", exp_trn.sprint(), act_trn.sprint()))
               end
            end
         end
      join
   end
   
endtask: run_phase


function void uvme_st_sb_c::check_phase(uvm_phase phase);
   
   super.check_phase(phase);
   
   if (cfg.scoreboarding_enabled) begin
      if (cntxt.sb_num_matches == 0) begin
         `uvm_error("ST_SB", "Scoreboard did not see any matches during simulation")
      end
   end
   
endfunction : check_phase


`endif // __UVME_ST_SB_SV__
