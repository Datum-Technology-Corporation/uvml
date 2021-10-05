// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_LAYER_MON_BASE_SV__
`define __UVMA_${name_uppercase}_LAYER_MON_BASE_SV__


/**
 * 
 */
class uvma_${name}_layer_mon_base_c#(
   type T_TRN_IN  = uvm_trn_mon_trn_c,
   type T_TRN_OUT = uvm_trn_mon_trn_c
) extends uvm_component;
   
   // Objects
   uvma_${name}_cfg_c    cfg;
   uvma_${name}_cntxt_c  cntxt;
   
   // TLM
   uvm_analysis_port    #(T_TRN_OUT)  ${direction_rx}_ap;
   uvm_tlm_analysis_fifo#(T_TRN_IN )  ${direction_rx}_in_fifo;
   uvm_tlm_analysis_fifo#(T_TRN_OUT)  ${direction_rx}_out_fifo;
   uvm_analysis_port    #(T_TRN_OUT)  ${direction_tx}_ap;
   uvm_tlm_analysis_fifo#(T_TRN_IN )  ${direction_tx}_in_fifo;
   uvm_tlm_analysis_fifo#(T_TRN_OUT)  ${direction_tx}_out_fifo;
   
   
   `uvm_component_param_utils_begin(uvma_${name}_layer_mon_base_c#(T_TRN_IN, T_TRN_OUT))
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_layer_mon_base", uvm_component parent=null);
   
   /**
    * TODO Describe uvma_${name}_layer_mon_base_c::build_phase()
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvma_${name}_layer_mon_base_c::run_phase()
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvma_${name}_layer_mon_base_c::process_${direction_rx}_traffic
    */
   extern virtual task process_${direction_rx}_traffic(ref T_TRN_IN trn);
   
   /**
    * TODO Describe uvma_${name}_layer_mon_base_c::process_${direction_tx}_traffic
    */
   extern virtual task process_${direction_tx}_traffic(ref T_TRN_IN trn);
   
   /**
    * TODO Describe uvma_${name}_layer_mon_base_c::send_${direction_rx}_traffic
    */
   extern task send_${direction_rx}_traffic(input T_TRN_OUT trn);
   
   /**
    * TODO Describe uvma_${name}_layer_mon_base_c::send_${direction_tx}_traffic
    */
   extern task send_${direction_tx}_traffic(input T_TRN_OUT trn);
   
endclass : uvma_${name}_layer_mon_base_c


`pragma protect begin


function uvma_${name}_layer_mon_base_c::new(string name="uvma_${name}_layer_mon_base", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_${name}_layer_mon_base_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvma_${name}_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvma_${name}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
   ${direction_rx}_ap       = new("${direction_rx}_ap"      , this);
   ${direction_rx}_in_fifo  = new("${direction_rx}_in_fifo" , this);
   ${direction_rx}_out_fifo = new("${direction_rx}_out_fifo", this);
   ${direction_tx}_ap       = new("${direction_tx}_ap"      , this);
   ${direction_tx}_in_fifo  = new("${direction_tx}_in_fifo" , this);
   ${direction_tx}_out_fifo = new("${direction_tx}_out_fifo", this);
   
endfunction : build_phase


task uvma_${name}_layer_mon_base_c::run_phase(uvm_phase phase);
   
   T_TRN_IN  rx_trn_in, tx_trn_in;
   
   super.run_phase(phase);
   
   fork
      begin
         if (cfg.${direction_rx}_cfg.enabled) begin
            forever begin
               ${direction_rx}_in_fifo.get    (rx_trn_in);
               process_${direction_rx}_traffic(rx_trn_in);
            end
         end
      end
      
      begin
         if (cfg.${direction_tx}_cfg.enabled) begin
            forever begin
               ${direction_rx}_in_fifo.get    (tx_trn_in);
               process_${direction_tx}_traffic(tx_trn_in);
            end
         end
      end
   join_none
   
endtask : run_phase


task uvma_${name}_layer_mon_base_c::process_${direction_rx}_traffic(ref T_TRN_IN trn);
   
   `uvm_fatal("${name_uppercase}_MON_${direction_rx_uppercase}", "Call to pure virtual task")
   
endtask : process_${direction_rx}_traffic


task uvma_${name}_layer_mon_base_c::process_${direction_tx}_traffic(ref T_TRN_IN trn);
   
   `uvm_fatal("${name_uppercase}_MON_${direction_tx_uppercase}", "Call to pure virtual task")
   
endtask : process_${direction_tx}_traffic


task uvma_${name}_layer_mon_base_c::send_${direction_rx}_traffic(input T_TRN_OUT trn);
   
   ${direction_rx}_${layer_name}_ap  .write(trn);
   ${direction_rx}_${layer_name}_fifo.put  (trn);
   
endtask : send_${direction_rx}_traffic


task uvma_${name}_layer_mon_base_c::send_${direction_tx}_traffic(input T_TRN_OUT trn);
   
   ${direction_tx}_${layer_name}_ap  .write(trn);
   ${direction_tx}_${layer_name}_fifo.put  (trn);
   
endtask : send_${direction_tx}_traffic


`pragma protect end


`endif // __UVMA_${name_uppercase}_LAYER_MON_BASE_SV__
