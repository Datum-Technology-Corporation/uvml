// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_COV_MODEL_SV__
`define __UVMA_${name_uppercase}_COV_MODEL_SV__


/**
 * Component encapsulating ${name_normal_case} functional coverage model.
 */
class uvma_${name}_cov_model_c extends uvm_component;
   
   // Objects
   uvma_${name}_cfg_c       cfg;
   uvma_${name}_cntxt_c     cntxt;
   uvma_${name}_mon_trn_c   mon_${direction_rx}_trn;
   uvma_${name}_mon_trn_c   mon_${direction_tx}_trn;
   uvma_${name}_seq_item_c  seq_item;
   
   // TLM
   uvm_tlm_analysis_fifo#(uvma_${name}_mon_trn_c )  mon_${direction_rx}_trn_fifo;
   uvm_tlm_analysis_fifo#(uvma_${name}_mon_trn_c )  mon_${direction_tx}_trn_fifo;
   uvm_tlm_analysis_fifo#(uvma_${name}_seq_item_c)  seq_item_fifo;
   
   
   `uvm_component_utils_begin(uvma_${name}_cov_model_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   // TODO Add covergroup(s)
   //      Ex: covergroup ${name}_cfg_cg;
   //             abc_cpt : coverpoint cfg.abc;
   //             xyz_cpt : coverpoint cfg.xyz;
   //          endgroup : ${name}_cfg_cg
   //          
   //          covergroup ${name}_cntxt_cg;
   //             abc_cpt : coverpoint cntxt.abc;
   //             xyz_cpt : coverpoint cntxt.xyz;
   //          endgroup : ${name}_cntxt_cg
   //          
   //          covergroup ${name}_mon_${direction_rx}_trn_cg;
   //             address : coverpoint mon_${direction_rx}_trn.address {
   //                bins low   = {16'h0000_0000, 16'h4FFF_FFFF};
   //                bins med   = {16'h5000_0000, 16'h9FFF_FFFF};
   //                bins high  = {16'hA000_0000, 16'hFFFF_FFFF};
   //             }
   //          endgroup : ${name}_mon_${direction_rx}_trn_cg
   //          
   //          covergroup ${name}_mon_${direction_tx}_trn_cg;
   //             address : coverpoint mon_${direction_tx}_trn.address {
   //                bins low   = {16'h0000_0000, 16'h5FFF_FFFF};
   //                bins med   = {16'h6000_0000, 16'hAFFF_FFFF};
   //                bins high  = {16'hB000_0000, 16'hFFFF_FFFF};
   //             }
   //          endgroup : ${name}_mon_${direction_tx}_trn_cg
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_cov_model", uvm_component parent=null);
   
   /**
    * 1. Ensures cfg & cntxt handles are not null.
    * 2. Builds fifos.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Forks all sampling loops.
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvma_${name}_cov_model_c::sample_cfg()
    */
   extern virtual function void sample_cfg();
   
   /**
    * TODO Describe uvma_${name}_cov_model_c::sample_cntxt()
    */
   extern virtual function void sample_cntxt();
   
   /**
    * TODO Describe uvma_${name}_cov_model_c::sample_mon_${direction_rx}_trn()
    */
   extern virtual function void sample_mon_${direction_rx}_trn();
   
   /**
    * TODO Describe uvma_${name}_cov_model_c::sample_mon_${direction_tx}_trn()
    */
   extern virtual function void sample_mon_${direction_tx}_trn();
   
   /**
    * TODO Describe uvma_${name}_cov_model_c::sample_seq_item()
    */
   extern virtual function void sample_seq_item();
   
endclass : uvma_${name}_cov_model_c


`pragma protect begin


function uvma_${name}_cov_model_c::new(string name="uvma_${name}_cov_model", uvm_component parent=null);
   
   super.new(name, parent);
   
   // TODO Create covergroup(s)
   //      Ex: ${name}_mon_trn_cg = new();
   
endfunction : new


function void uvma_${name}_cov_model_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvma_${name}_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvma_${name}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
   mon_${direction_rx}_trn_fifo  = new("mon_${direction_rx}_trn_fifo" , this);
   mon_${direction_tx}_trn_fifo  = new("mon_${direction_tx}_trn_fifo" , this);
   seq_item_fifo = new("seq_item_fifo", this);
   
endfunction : build_phase


task uvma_${name}_cov_model_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
   
   if (cfg.enabled && cfg.cov_model_enabled) begin
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
         
         // Monitor ${direction_rx_normal_case} transactions
         forever begin
            mon_${direction_rx}_trn_fifo.get(mon_${direction_rx}_trn);
            sample_mon_${direction_rx}_trn();
         end
         
         // Monitor ${direction_tx_normal_case} transactions
         forever begin
            mon_${direction_tx}_trn_fifo.get(mon_${direction_tx}_trn);
            sample_mon_${direction_tx}_trn();
         end
         
         // Sequence items
         forever begin
            seq_item_fifo.get(seq_item);
            sample_seq_item();
         end
       join_none
   end
   
endtask : run_phase


function void uvma_${name}_cov_model_c::sample_cfg();
   
   // TODO Implement uvma_${name}_cov_model_c::sample_cfg();
   //      Ex: ${name}_cfg_cg.sample();
   
endfunction : sample_cfg


function void uvma_${name}_cov_model_c::sample_cntxt();
   
   // TODO Implement uvma_${name}_cov_model_c::sample_cntxt();
   //      Ex: ${name}_cntxt_cg.sample();
   
endfunction : sample_cntxt


function void uvma_${name}_cov_model_c::sample_mon_${direction_rx}_trn();
   
   // TODO Implement uvma_${name}_cov_model_c::sample_mon_${direction_rx}_trn();
   //      Ex: ${name}_mon_${direction_rx}_trn_cg.sample();
   
endfunction : sample_mon_${direction_rx}_trn


function void uvma_${name}_cov_model_c::sample_mon_${direction_tx}_trn();
   
   // TODO Implement uvma_${name}_cov_model_c::sample_mon_${direction_tx}_trn();
   //      Ex: ${name}_mon_${direction_tx}_trn_cg.sample();
   
endfunction : sample_mon_${direction_tx}_trn


function void uvma_${name}_cov_model_c::sample_seq_item();
   
   // TODO Implement uvma_${name}_cov_model_c::sample_seq_item();
   //      Ex: ${name}_seq_item_cg.sample();
   
endfunction : sample_seq_item


`pragma protect end


`endif // __UVMA_${name_uppercase}_COV_MODEL_SV__
