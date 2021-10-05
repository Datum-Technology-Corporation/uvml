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


`ifndef __UVME_ST_COV_MODEL_SV__
`define __UVME_ST_COV_MODEL_SV__


/**
 * Component encapsulating Moore.io UVM Extension Library Self-Test Environment functional coverage model.
 */
class uvme_st_cov_model_c extends uvm_component;
   
   // Coverage targets
   uvme_st_cfg_c       cfg        ; ///< 
   uvme_st_cntxt_c     cntxt      ; ///< 
   uvma_st_seq_item_c  tx_seq_item; ///< 
   uvma_st_mon_trn_c   tx_mon_trn ; ///< 
   uvma_st_mon_trn_c   rx_mon_trn ; ///< 
   
   // TLM
   uvm_analysis_export  #(uvma_st_seq_item_c)  tx_seq_item_export; ///< 
   uvm_analysis_export  #(uvma_st_mon_trn_c )  tx_mon_trn_export ; ///< 
   uvm_analysis_export  #(uvma_st_mon_trn_c )  rx_mon_trn_export ; ///< 
   uvm_tlm_analysis_fifo#(uvma_st_seq_item_c)  tx_seq_item_fifo  ; ///< 
   uvm_tlm_analysis_fifo#(uvma_st_mon_trn_c )  tx_mon_trn_fifo   ; ///< 
   uvm_tlm_analysis_fifo#(uvma_st_mon_trn_c )  rx_mon_trn_fifo   ; ///< 
   
   
   `uvm_component_utils_begin(uvme_st_cov_model_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   covergroup st_cfg_cg;
      // TODO Implement st_cfg_cg
      //      Ex: tx_cpt : coverpoint cfg.tx;
      //          rx_cpt : coverpoint cfg.rx;
   endgroup : st_cfg_cg
   
   covergroup st_cntxt_cg;
      // TODO Implement st_cntxt_cg
      //      Ex: tx_cpt : coverpoint cntxt.tx;
      //          rx_cpt : coverpoint cntxt.rx;
   endgroup : st_cntxt_cg
   
   covergroup st_tx_seq_item_cg;
      // TODO Implement st_tx_seq_item_cg
      //      Ex: tx_cpt : coverpoint tx_seq_item.tx;
      //          rx_cpt : coverpoint tx_seq_item.rx;
   endgroup : st_tx_seq_item_cg
   
   covergroup st_tx_mon_trn_cg;
      // TODO Implement st_tx_mon_trn_cg
      //      Ex: tx_cpt : coverpoint tx_mon_trn.tx;
      //          rx_cpt : coverpoint tx_mon_trn.rx;
   endgroup : st_tx_mon_trn_cg
   
   covergroup st_rx_mon_trn_cg;
      // TODO Implement st_rx_mon_trn_cg
      //      Ex: tx_cpt : coverpoint rx_mon_trn.tx;
      //          rx_cpt : coverpoint rx_mon_trn.rx;
   endgroup : st_rx_mon_trn_cg
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_st_cov_model", uvm_component parent=null);
   
   /**
    * Ensures cfg & cntxt handles are not null.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_st_cov_model_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
   /**
    * Describe uvme_st_cov_model_c::run_phase()
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_st_cov_model_c::sample_cfg()
    */
   extern function void sample_cfg();
   
   /**
    * TODO Describe uvme_st_cov_model_c::sample_cntxt()
    */
   extern function void sample_cntxt();
   
   /**
    * TODO Describe uvme_st_cov_model_c::sample_tx_seq_item()
    */
   extern function void sample_tx_seq_item();
   
   /**
    * TODO Describe uvme_st_cov_model_c::sample_tx_mon_trn()
    */
   extern function void sample_tx_mon_trn();
   
   /**
    * TODO Describe uvme_st_cov_model_c::sample_rx_mon_trn()
    */
   extern function void sample_rx_mon_trn();
   
endclass : uvme_st_cov_model_c


function uvme_st_cov_model_c::new(string name="uvme_st_cov_model", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_st_cov_model_c::build_phase(uvm_phase phase);
   
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
   tx_seq_item_export = new("tx_seq_item_export", this);
   tx_mon_trn_export  = new("tx_mon_trn_export" , this);
   rx_mon_trn_export  = new("rx_mon_trn_export" , this);
   tx_seq_item_fifo   = new("tx_seq_item_fifo"  , this);
   tx_mon_trn_fifo    = new("tx_mon_trn_fifo"   , this);
   rx_mon_trn_fifo    = new("rx_mon_trn_fifo"   , this);
   
endfunction : build_phase


function void uvme_st_cov_model_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   // Connect TLM objects
   tx_seq_item_export.connect(tx_seq_item_fifo.analysis_export);
   tx_mon_trn_export .connect(tx_mon_trn_fifo .analysis_export);
   rx_mon_trn_export .connect(rx_mon_trn_fifo .analysis_export);
   
endfunction : connect_phase


task uvme_st_cov_model_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
  
  fork
    // Configuration
    forever begin
      cntxt.sample_cfg_e.wait_trigger();
      sample_cfg();
    end
    
    // Context
    forever begin
      cntxt.sample_cntxt_e.wait_trigger();
      sample_cntxt();
    end
    
    // tx sequence item coverage
    forever begin
       tx_seq_item_fifo.get(tx_seq_item);
       sample_tx_seq_item();
    end
    
    // tx monitored transaction coverage
    forever begin
       tx_mon_trn_fifo.get(tx_mon_trn);
       sample_tx_mon_trn();
    end
    
    // rx monitored transaction coverage
    forever begin
       rx_mon_trn_fifo.get(rx_mon_trn);
       sample_rx_mon_trn();
    end
  join_none
   
endtask : run_phase


function void uvme_st_cov_model_c::sample_cfg();
   
  st_cfg_cg.sample();
   
endfunction : sample_cfg


function void uvme_st_cov_model_c::sample_cntxt();
   
   st_cntxt_cg.sample();
   
endfunction : sample_cntxt


function void uvme_st_cov_model_c::sample_tx_seq_item();
   
   st_tx_seq_item_cg.sample();
   
endfunction : sample_tx_seq_item


function void uvme_st_cov_model_c::sample_tx_mon_trn();
   
   st_tx_mon_trn_cg.sample();
   
endfunction : sample_tx_mon_trn


function void uvme_st_cov_model_c::sample_rx_mon_trn();
   
   st_rx_mon_trn_cg.sample();
   
endfunction : sample_rx_mon_trn


`endif // __UVME_ST_COV_MODEL_SV__
