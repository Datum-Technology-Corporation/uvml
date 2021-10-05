// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVME_${name_uppercase}_PRD_SV__
`define __UVME_${name_uppercase}_PRD_SV__


/**
 * Component implementing transaction-based software model of ${name_normal_case} DUT.
 */
class uvme_${name}_prd_c extends uvm_component;
   
   // Objects
   uvme_${name}_cfg_c    cfg;
   uvme_${name}_cntxt_c  cntxt;
   
   // Input TLM
   uvm_analysis_export  #(uvma_${clk_agent_type}_mon_trn_c)  ${clk_agent_name}_export;
   uvm_tlm_analysis_fifo#(uvma_${clk_agent_type}_mon_trn_c)  ${clk_agent_name}_fifo;
   uvm_analysis_export  #(uvma_${reset_agent_type}_mon_trn_c)  ${reset_agent_name}_export;
   uvm_tlm_analysis_fifo#(uvma_${reset_agent_type}_mon_trn_c)  ${reset_agent_name}_fifo;
   uvm_analysis_export  #(uvma_${ral_agent_type}_mon_trn_c)  ${ral_agent_name}_export;
   uvm_tlm_analysis_fifo#(uvma_${ral_agent_type}_mon_trn_c)  ${ral_agent_name}_fifo;
   
   // Output TLM
   // TODO Add TLM outputs to uvme_${name}_prd_c
   //      Ex: uvm_analysis_port#(uvma_packet_trn_c)  pkts_out_ap;
   
   
   `uvm_component_utils_begin(uvme_${name}_prd_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_${name}_prd", uvm_component parent=null);
   
   /**
    * TODO Describe uvme_${name}_prd_c::build_phase()
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_${name}_prd_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_${name}_prd_c::run_phase()
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_${name}_prd_c::process_${clk_agent_name}()
    */
   extern task process_${clk_agent_name}();
   
   /**
    * TODO Describe uvme_${name}_prd_c::process_${reset_agent_name}()
    */
   extern task process_${reset_agent_name}();
   
   /**
    * TODO Describe uvme_${name}_prd_c::process_${ral_agent_name}()
    */
   extern task process_${ral_agent_name}();
   
endclass : uvme_${name}_prd_c


`pragma protect begin


function uvme_${name}_prd_c::new(string name="uvme_${name}_prd", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_${name}_prd_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvme_${name}_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvme_${name}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
   // Build Input TLM objects
   ${clk_agent_name}_export = new("${clk_agent_name}_export", this);
   ${clk_agent_name}_fifo   = new("${clk_agent_name}_fifo"  , this);
   ${reset_agent_name}_export = new("${reset_agent_name}_export", this);
   ${reset_agent_name}_fifo   = new("${reset_agent_name}_fifo"  , this);
   ${ral_agent_name}_export = new("${ral_agent_name}_export", this);
   ${ral_agent_name}_fifo   = new("${ral_agent_name}_fifo"  , this);
   
   // Build Output TLM objects
   // TODO Create Output TLM objects for uvme_${name}_prd_c
   //      Ex: pkts_out_ap = new("pkts_out_ap", this);
   
endfunction : build_phase


function void uvme_${name}_prd_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   // Connect TLM objects
   ${clk_agent_name}_export.connect(${clk_agent_name}_fifo.analysis_export);
   ${reset_agent_name}_export.connect(${reset_agent_name}_fifo.analysis_export);
   ${ral_agent_type}_export.connect(${ral_agent_type}_fifo.analysis_export);
   
endfunction: connect_phase


task uvme_${name}_prd_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
   
   fork
      process_${clk_agent_name}();
      process_${reset_agent_name}();
      process_${ral_agent_name}();
   join_none
   
endtask: run_phase


task uvme_${name}_prd_c::process_${clk_agent_name}();
   
   uvma_${clk_agent_type}_mon_trn_c  ${clk_agent_name}_trn;
   
   forever begin
      ${clk_agent_name}_fifo.get(${clk_agent_name}_trn);
      
      // TODO Implement uvme_${name}_prd_c::process_${clk_agent_name}()
   end
   
endtask : process_${clk_agent_name}


task uvme_${name}_prd_c::process_${reset_agent_name}();
   
   uvma_${reset_agent_type}_mon_trn_c  ${reset_agent_name}_trn;
   
   forever begin
      ${reset_agent_name}_fifo.get(${reset_agent_name}_trn);
      
      // TODO Implement uvme_${name}_prd_c::process_${reset_agent_name}()
   end
   
endtask : process_${reset_agent_name}


task uvme_${name}_prd_c::process_${ral_agent_type}();
   
   uvma_${ral_agent_type}_mon_trn_c  ${ral_agent_type}_trn;
   
   forever begin
      ${ral_agent_type}_fifo.get(${ral_agent_type}_trn);
      
      // TODO Implement uvme_${name}_prd_c::process_${ral_agent_type}()
   end
   
endtask : process_${ral_agent_type}


`pragma protect end


`endif // __UVME_${name_uppercase}_PRD_SV__
