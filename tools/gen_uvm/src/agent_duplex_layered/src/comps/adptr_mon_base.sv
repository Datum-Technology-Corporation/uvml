// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_ADPTR_MON_BASE_SV__
`define __UVMA_${name_uppercase}_ADPTR_MON_BASE_SV__


/**
 * Abstract component from which all other ${name_normal_case} adapter monitors must extend.
 * Manages the run_phase() for both ${direction_rx_normal_case} and ${direction_tx_normal_case}.
 */
class uvma_${name}_adptr_mon_base_c#(
   type T_TRN_IN  = uvm_sequence_item,
   type T_TRN_OUT = uvm_sequence_item
) extends uvm_monitor;
   
   // Objects
   uvma_${name}_cfg_c    cfg;
   uvma_${name}_cntxt_c  cntxt;
   
   // TLM
   uvm_analysis_port    #(T_TRN_IN )  ${direction_rx}_in_ap;
   uvm_analysis_port    #(T_TRN_IN )  ${direction_tx}_in_ap;
   uvm_analysis_port    #(T_TRN_OUT)  ${direction_rx}_out_ap;
   uvm_analysis_port    #(T_TRN_OUT)  ${direction_tx}_out_ap;
   uvm_tlm_analysis_fifo#(T_TRN_OUT)  ${direction_rx}_out_fifo;
   uvm_tlm_analysis_fifo#(T_TRN_OUT)  ${direction_tx}_out_fifo;
   
   
   `uvm_component_param_utils_begin(uvma_${name}_adptr_mon_base_c#(T_TRN_IN, T_TRN_OUT))
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_adptr_mon_base", uvm_component parent=null);
   
   /**
    * 1. Check for cfg and cntxt.
    * 2. Build TLM objects.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Oversees monitoring, depending on the reset state, by calling mon_<${direction_rx}|${direction_tx}>_<pre|in|post>_reset() tasks.
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * Pure virtual hook forked off by run_phase().
    * Responsible for updating the context's reset state.
    */
   extern virtual task observe_reset();
   
   /**
    * Pure virtual hook called by run_phase() while agent is in pre-reset state.
    */
   extern virtual task mon_${direction_rx}_pre_reset();
   
   /**
    * Pure virtual hook called by run_phase() while agent is in pre-reset state.
    */
   extern virtual task mon_${direction_tx}_pre_reset();
   
   /**
    * Pure virtual hook called by run_phase() while agent is in reset state.
    */
   extern virtual task mon_${direction_rx}_in_reset();
   
   /**
    * Pure virtual hook called by run_phase() while agent is in reset state.
    */
   extern virtual task mon_${direction_tx}_in_reset();
   
   /**
    * Oversees the process of sampling and processing transactions from the vif.
    * Called by run_phase() while agent is in post-reset state.
    */
   extern virtual task mon_${direction_rx}_post_reset();
   
   /**
    * Oversees the process of sampling and processing transactions from the virtual interface (vif).
    * Called by run_phase() while agent is in post-reset state.
    */
   extern virtual task mon_${direction_tx}_post_reset();
   
   /**
    * Pure virtual hook called by mon_${direction_rx}_post_reset().
    * Responsible for creating trn by sampling the virtual interface's (vif) ${direction_rx_normal_case} signals.
    */
   extern virtual task sample_${direction_rx}_traffic(ref T_TRN_IN trn);
   
   /**
    * Pure virtual hook called by mon_${direction_tx}_post_reset().
    * Responsible for creating trn by sampling the virtual interface's (vif) ${direction_tx_normal_case} signals.
    */
   extern virtual task sample_${direction_tx}_traffic(ref T_TRN_IN trn);
   
   /**
    * Pure virtual hook called by mon_${direction_tx}_post_reset().
    * Responsible for checking trn as well as creating and sending (via send_${direction_rx}_out_trn()) upper-layer traffic.
    */
   extern virtual task process_${direction_rx}_traffic(ref T_TRN_IN trn);
   
   /**
    * Pure virtual hook called by mon_${direction_tx}_post_reset().
    * Responsible for checking trn as well as creating and sending (via
    * send_${direction_tx}_out_trn()) upper-layer traffic.
    */
   extern virtual task process_${direction_tx}_traffic(ref T_TRN_IN trn);
   
   /**
    * Sends transaction to next (above) layer in ${direction_rx_normal_case} direction.
    * Must be used by subclass rather than using ap/fifo directly.
    */
   extern task send_${direction_rx}_out_trn(output T_TRN_OUT trn);
   
   /**
    * Sends transaction to next (above) layer in ${direction_tx_normal_case} direction.
    * Must be used by subclass rather than using ap/fifo directly.
    */
   extern task send_${direction_tx}_out_trn(output T_TRN_OUT trn);
   
endclass : uvma_${name}_adptr_mon_base_c


`pragma protect begin


function uvma_${name}_adptr_mon_base_c::new(string name="uvma_${name}_adptr_mon_base", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_${name}_adptr_mon_base_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvma_${name}_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvma_${name}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
   ${direction_rx}_in_ap = new("${direction_rx}_in_ap", this);
   ${direction_tx}_in_ap = new("${direction_tx}_in_ap", this);
   ${direction_rx}_out_ap = new("${direction_rx}_out_ap", this);
   ${direction_tx}_out_ap = new("${direction_tx}_out_ap", this);
   ${direction_rx}_out_fifo = new("${direction_rx}_out_fifo", this);
   ${direction_tx}_out_fifo = new("${direction_tx}_out_fifo", this);
   
endfunction : build_phase


task uvma_${name}_adptr_mon_base_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
   
   fork
      begin
         observe_reset();
      end
      
      // ${direction_rx_normal_case}
      begin
         if (cfg.${direction_rx}_cfg.enabled) begin
            forever begin
               case (cntxt.reset_state)
                  UVMA_${name_uppercase}_RESET_STATE_PRE_RESET :  mon_${direction_rx}_pre_reset ();
                  UVMA_${name_uppercase}_RESET_STATE_IN_RESET  :  mon_${direction_rx}_in_reset  ();
                  UVMA_${name_uppercase}_RESET_STATE_POST_RESET:  mon_${direction_rx}_post_reset();
               endcase
            end
         end
      end
      
      // ${direction_tx_normal_case}
      begin
         if (cfg.${direction_tx}_cfg.enabled) begin
            forever begin
               case (cntxt.reset_state)
                  UVMA_${name_uppercase}_RESET_STATE_PRE_RESET :  mon_${direction_tx}_pre_reset ();
                  UVMA_${name_uppercase}_RESET_STATE_IN_RESET  :  mon_${direction_tx}_in_reset  ();
                  UVMA_${name_uppercase}_RESET_STATE_POST_RESET:  mon_${direction_tx}_post_reset();
               endcase
            end
         end
      end
   join_none
   
endtask : run_phase


task uvma_${name}_adptr_mon_base_c::observe_reset();
   
   `uvm_fatal("${name_uppercase}_MON", "Call to pure virtual task")
   
endtask : observe_reset


task uvma_${name}_adptr_mon_base_c::mon_${direction_rx}_pre_reset();
   
   `uvm_fatal("${name_uppercase}_MON_${direction_rx_uppercase}", "Call to pure virtual task")
   
endtask : mon_${direction_rx}_pre_reset


task uvma_${name}_adptr_mon_base_c::mon_${direction_tx}_pre_reset();
   
   `uvm_fatal("${name_uppercase}_MON_${direction_tx_uppercase}", "Call to pure virtual task")
   
endtask : mon_${direction_tx}_pre_reset


task uvma_${name}_adptr_mon_base_c::mon_${direction_rx}_in_reset();
   
   `uvm_fatal("${name_uppercase}_MON_${direction_rx_uppercase}", "Call to pure virtual task")
   
endtask : mon_${direction_rx}_in_reset


task uvma_${name}_adptr_mon_base_c::mon_${direction_tx}_in_reset();
   
   `uvm_fatal("${name_uppercase}_MON_${direction_tx_uppercase}", "Call to pure virtual task")
   
endtask : mon_${direction_tx}_in_reset


task uvma_${name}_adptr_mon_base_c::mon_${direction_rx}_post_reset();
   
   T_TRN_IN  trn;
   
   // Sample values from vif into transaction
   sample_${direction_rx}_traffic(trn);
   
   // Send transaction out onto the analysis port
   ${direction_rx}_in_ap.write(trn);
   
   // Process transaction (parsing, error checking, etc.)
   process_${direction_rx}_traffic(trn);
   
endtask : mon_${direction_rx}_post_reset


task uvma_${name}_adptr_mon_base_c::mon_${direction_tx}_post_reset();
   
   T_TRN_IN  trn;
   
   // Sample values from vif into transaction
   sample_${direction_tx}_traffic(trn);
   
   // Process transaction (parsing, error checking, etc.)
   process_${direction_tx}_traffic(trn);
   
   // Send transaction out onto the analysis port
   ${direction_tx}_in_ap.write(trn);
   
endtask : mon_${direction_tx}_post_reset


task uvma_${name}_adptr_mon_base_c::sample_${direction_rx}_traffic(ref T_TRN_IN trn);
   
   `uvm_fatal("${name_uppercase}_MON_${direction_rx_uppercase}", "Call to pure virtual task")
   
endtask : sample_${direction_rx}_traffic


task uvma_${name}_adptr_mon_base_c::sample_${direction_tx}_traffic(ref T_TRN_IN trn);
   
   `uvm_fatal("${name_uppercase}_MON_${direction_tx_uppercase}", "Call to pure virtual task")
   
endtask : sample_${direction_tx}_traffic


task uvma_${name}_adptr_mon_base_c::process_${direction_rx}_traffic(ref T_TRN_IN trn);
   
   `uvm_fatal("${name_uppercase}_MON_${direction_rx_uppercase}", "Call to pure virtual task")
   
endtask : process_${direction_rx}_traffic


task uvma_${name}_adptr_mon_base_c::process_${direction_tx}_traffic(ref T_TRN_IN trn);
   
   `uvm_fatal("${name_uppercase}_MON_${direction_tx_uppercase}", "Call to pure virtual task")
   
endtask : process_${direction_tx}_traffic


task uvma_${name}_adptr_mon_base_c::send_${direction_rx}_out_trn(output T_TRN_OUT trn);
   
   ${direction_rx}_out_ap  .write(trn);
   ${direction_rx}_out_fifo.write(trn);
   
endtask : send_${direction_rx}_out_trn


task uvma_${name}_adptr_mon_base_c::send_${direction_tx}_out_trn(output T_TRN_OUT trn);
   
   ${direction_tx}_out_ap  .write(trn);
   ${direction_tx}_out_fifo.write(trn);
   
endtask : send_${direction_tx}_out_trn


`pragma protect end


`endif // __UVMA_${name_uppercase}_ADPTR_MON_BASE_SV__
