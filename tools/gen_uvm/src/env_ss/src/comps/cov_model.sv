// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVME_${name_uppercase}_COV_MODEL_SV__
`define __UVME_${name_uppercase}_COV_MODEL_SV__


/**
 * Component encapsulating ${name_normal_case} environment's functional coverage model.
 */
class uvme_${name}_cov_model_c extends uvm_component;
   
   // Objects
   uvme_${name}_cfg_c    cfg;
   uvme_${name}_cntxt_c  cntxt;
   // TODO Add covergoup sampling variable(s)
   //      Ex: uvma_${ral_agent_type}_mon_trn_c  ${ral_agent_type}_trn;
   
   // Input TLM
   // TODO Add Input TLM to uvme_${name}_cov_model_c
   //      Ex: uvm_analysis_port    #(uvma_${ral_agent_type}_mon_trn_c)  ${ral_agent_type}_export;
   //          uvm_tlm_analysis_fifo#(uvma_${ral_agent_type}_mon_trn_c)  ${ral_agent_type}_fifo;
   
   
   `uvm_component_utils_begin(uvme_${name}_cov_model_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   // TODO Add covergroup(s) to uvme_${name}_cov_model_c
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
   //          covergroup ${ral_agent_type}_trn_cg;
   //             address : coverpoint ${ral_agent_type}_trn.address {
   //                bins low   = {32'h0000_0000, 32'h4FFF_FFFF};
   //                bins med   = {32'h5000_0000, 32'h9FFF_FFFF};
   //                bins high  = {32'hA000_0000, 32'hFFFF_FFFF};
   //             }
   //          endgroup : ${ral_agent_type}_trn_cg
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_${name}_cov_model", uvm_component parent=null);
   
   /**
    * Ensures cfg & cntxt handles are not null.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Describe uvme_${name}_cov_model_c::run_phase()
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_${name}_cov_model_c::sample_cfg()
    */
   extern function void sample_cfg();
   
   /**
    * TODO Describe uvme_${name}_cov_model_c::sample_cntxt()
    */
   extern function void sample_cntxt();
   
   // TODO Add coverage functions to uvme_${name}_cov_model_c
   //      Ex: /**
   //           * Samples trn via ${ral_agent_type}_cg
   //           */
   //          extern function void sample_${ral_agent_type}();
   
endclass : uvme_${name}_cov_model_c


`pragma protect begin


function uvme_${name}_cov_model_c::new(string name="uvme_${name}_cov_model", uvm_component parent=null);
   
   super.new(name, parent);
   
   // TODO Create coverage groups for uvme_${name}_cov_model_c
   //      Ex: ${ral_agent_type}_cg = new();
   
endfunction : new


function void uvme_${name}_cov_model_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvme_${name}_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvme_${name}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
   // TODO Build Input TLM
   //      Ex: ${ral_agent_type}_export = new("${ral_agent_type}_export", this);
   //          ${ral_agent_type}_fifo   = new("${ral_agent_type}_fifo"  , this);
   
endfunction : build_phase


task uvme_${name}_cov_model_c::run_phase(uvm_phase phase);
   
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
      
      // TODO Implement uvme_${name}_cov_model_c::run_phase()
      //      Ex: forever begin
      //             ${ral_agent_type}_fifo.get(${ral_agent_type}_trn);
      //             sample_${ral_agent_type}();
      //          end
   join_none
   
endtask : run_phase


function void uvme_${name}_cov_model_c::sample_cfg();
   
   // TODO Implement uvme_${name}_cov_model_c::sample_cfg();
   //      Ex: ${name}_cfg_cg.sample();
   
endfunction : sample_cfg


function void uvme_${name}_cov_model_c::sample_cntxt();
   
   // TODO Implement uvme_${name}_cov_model_c::sample_cntxt();
   //      Ex: ${name}_cntxt_cg.sample();
   
endfunction : sample_cntxt


// TODO Implement coverage function(s) to uvme_${name}_cov_model_c
//      Ex: function void uvme_${name}_cov_model_c::sample_${ral_agent_type}();
//             
//             ${ral_agent_type}_trn_cg.sample();
//             
//          endfunction : sample_${ral_agent_type}


`pragma protect end


`endif // __UVME_${name_uppercase}_COV_MODEL_SV__
