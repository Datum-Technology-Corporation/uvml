// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVME_${name_uppercase}_ST_COV_MODEL_SV__
`define __UVME_${name_uppercase}_ST_COV_MODEL_SV__


/**
 * Component encapsulating ${name_normal_case} Self-Test Environment functional
 * coverage model.
 */
class uvme_${name}_st_cov_model_c extends uvm_component;
   
   // Coverage targets
   uvme_${name}_st_cfg_c    cfg;
   uvme_${name}_st_cntxt_c  cntxt;
   uvma_${name}_seq_item_c  ${name_1}_seq_item;
   uvma_${name}_mon_trn_c   ${name_1}_mon_trn;
   uvma_${name}_mon_trn_c   ${name_2}_mon_trn;
   
   // TLM
   uvm_analysis_export  #(uvma_${name}_seq_item_c)  ${name_1}_seq_item_export;
   uvm_analysis_export  #(uvma_${name}_mon_trn_c )  ${name_1}_mon_trn_export ;
   uvm_analysis_export  #(uvma_${name}_mon_trn_c )  ${name_2}_mon_trn_export ;
   uvm_tlm_analysis_fifo#(uvma_${name}_seq_item_c)  ${name_1}_seq_item_fifo  ;
   uvm_tlm_analysis_fifo#(uvma_${name}_mon_trn_c )  ${name_1}_mon_trn_fifo   ;
   uvm_tlm_analysis_fifo#(uvma_${name}_mon_trn_c )  ${name_2}_mon_trn_fifo   ;
   
   
   `uvm_component_utils_begin(uvme_${name}_st_cov_model_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   covergroup ${name}_st_cfg_cg;
      // TODO Implement ${name}_st_cfg_cg
      //      Ex: abc_cpt : coverpoint cfg.abc;
      //          xyz_cpt : coverpoint cfg.xyz;
   endgroup : ${name}_st_cfg_cg
   
   covergroup ${name}_st_cntxt_cg;
      // TODO Implement ${name}_st_cntxt_cg
      //      Ex: abc_cpt : coverpoint cntxt.abc;
      //          xyz_cpt : coverpoint cntxt.xyz;
   endgroup : ${name}_st_cntxt_cg
   
   covergroup ${name}_st_${name_1}_seq_item_cg;
      // TODO Implement ${name}_st_${name_1}_seq_item_cg
      //      Ex: abc_cpt : coverpoint ${name_1}_seq_item.abc;
      //          xyz_cpt : coverpoint ${name_1}_seq_item.xyz;
   endgroup : ${name}_st_${name_1}_seq_item_cg
   
   covergroup ${name}_st_${name_1}_mon_trn_cg;
      // TODO Implement ${name}_st_${name_1}_mon_trn_cg
      //      Ex: abc_cpt : coverpoint ${name_1}_mon_trn.abc;
      //          xyz_cpt : coverpoint ${name_1}_mon_trn.xyz;
   endgroup : ${name}_st_${name_1}_mon_trn_cg
   
   covergroup ${name}_st_${name_2}_mon_trn_cg;
      // TODO Implement ${name}_st_${name_2}_mon_trn_cg
      //      Ex: abc_cpt : coverpoint ${name_2}_mon_trn.abc;
      //          xyz_cpt : coverpoint ${name_2}_mon_trn.xyz;
   endgroup : ${name}_st_${name_2}_mon_trn_cg
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_${name}_st_cov_model", uvm_component parent=null);
   
   /**
    * Ensures cfg & cntxt handles are not null.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_${name}_st_cov_model_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
   /**
    * Describe uvme_${name}_st_cov_model_c::run_phase()
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_${name}_st_cov_model_c::sample_cfg()
    */
   extern function void sample_cfg();
   
   /**
    * TODO Describe uvme_${name}_st_cov_model_c::sample_cntxt()
    */
   extern function void sample_cntxt();
   
   /**
    * TODO Describe uvme_${name}_st_cov_model_c::sample_${name_1}_seq_item()
    */
   extern function void sample_${name_1}_seq_item();
   
   /**
    * TODO Describe uvme_${name}_st_cov_model_c::sample_${name_1}_mon_trn()
    */
   extern function void sample_${name_1}_mon_trn();
   
   /**
    * TODO Describe uvme_${name}_st_cov_model_c::sample_${name_2}_mon_trn()
    */
   extern function void sample_${name_2}_mon_trn();
   
endclass : uvme_${name}_st_cov_model_c


`pragma protect begin


function uvme_${name}_st_cov_model_c::new(string name="uvme_${name}_st_cov_model", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_${name}_st_cov_model_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvme_${name}_st_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvme_${name}_st_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
   // Build TLM objects
   ${name_1}_seq_item_export = new("${name_1}_seq_item_export", this);
   ${name_1}_mon_trn_export  = new("${name_1}_mon_trn_export" , this);
   ${name_2}_mon_trn_export  = new("${name_2}_mon_trn_export" , this);
   ${name_1}_seq_item_fifo   = new("${name_1}_seq_item_fifo"  , this);
   ${name_1}_mon_trn_fifo    = new("${name_1}_mon_trn_fifo"   , this);
   ${name_2}_mon_trn_fifo    = new("${name_2}_mon_trn_fifo"   , this);
   
endfunction : build_phase


function void uvme_${name}_st_cov_model_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   // Connect TLM objects
   ${name_1}_seq_item_export.connect(${name_1}_seq_item_fifo.analysis_export);
   ${name_1}_mon_trn_export .connect(${name_1}_mon_trn_fifo .analysis_export);
   ${name_2}_mon_trn_export .connect(${name_2}_mon_trn_fifo .analysis_export);
   
endfunction : connect_phase


task uvme_${name}_st_cov_model_c::run_phase(uvm_phase phase);
   
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
    
    // ${name_1} sequence item coverage
    forever begin
       ${name_1}_seq_item_fifo.get(${name_1}_seq_item);
       sample_${name_1}_seq_item();
    end
    
    // ${name_1} monitored transaction coverage
    forever begin
       ${name_1}_mon_trn_fifo.get(${name_1}_mon_trn);
       sample_${name_1}_mon_trn();
    end
    
    // ${name_2} monitored transaction coverage
    forever begin
       ${name_2}_mon_trn_fifo.get(${name_2}_mon_trn);
       sample_${name_2}_mon_trn();
    end
  join_none
   
endtask : run_phase


function void uvme_${name}_st_cov_model_c::sample_cfg();
   
  ${name}_st_cfg_cg.sample();
   
endfunction : sample_cfg


function void uvme_${name}_st_cov_model_c::sample_cntxt();
   
   ${name}_st_cntxt_cg.sample();
   
endfunction : sample_cntxt


function void uvme_${name}_st_cov_model_c::sample_${name_1}_seq_item();
   
   ${name}_st_${name_1}_seq_item_cg.sample();
   
endfunction : sample_${name_1}_seq_item


function void uvme_${name}_st_cov_model_c::sample_${name_1}_mon_trn();
   
   ${name}_st_${name_1}_mon_trn_cg.sample();
   
endfunction : sample_${name_1}_mon_trn


function void uvme_${name}_st_cov_model_c::sample_${name_2}_mon_trn();
   
   ${name}_st_${name_2}_mon_trn_cg.sample();
   
endfunction : sample_${name_2}_mon_trn


`pragma protect end


`endif // __UVME_${name_uppercase}_ST_COV_MODEL_SV__
