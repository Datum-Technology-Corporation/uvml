// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_AGENT_SV__
`define __UVMA_${name_uppercase}_AGENT_SV__


/**
 * Top-level component that encapsulates, builds and connects all others.
 * Capable of driving/monitoring all ${name_normal_case} interfaces in both directions.
 */
class uvma_${name}_agent_c extends uvm_agent;
   
   // Objects
   uvma_${name}_cfg_c    cfg;
   uvma_${name}_cntxt_c  cntxt;
   
   // Components
   uvma_${name}_drv_c             driver;
   uvma_${name}_mon_c             monitor;
   uvma_${name}_sqr_c             sequencer;
   uvma_${name}_cov_model_c       cov_model;
   uvma_${name}_mon_trn_logger_c  mon_${direction_rx}_logger;
   uvma_${name}_mon_trn_logger_c  mon_${direction_tx}_logger;
   
   // TLM
   uvm_analysis_port#(uvma_${name}_mon_trn_c)  mon_${direction_rx}_ap;
   uvm_analysis_port#(uvma_${name}_mon_trn_c)  mon_${direction_tx}_ap;
   
   
   `uvm_component_utils_begin(uvma_${name}_agent_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_agent", uvm_component parent=null);
   
   /**
    * 1. Ensures cfg & cntxt handles are not null
    * 2. Builds all components
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * 1. Links analysis ports to components'
    * 2. Connects coverage and loggers
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
endclass : uvma_${name}_agent_c


`pragma protect begin


function uvma_${name}_agent_c::new(string name="uvma_${name}_agent", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_${name}_agent_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvma_${name}_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   else begin
      `uvm_info("CFG", $sformatf("Found configuration handle:\n%s", cfg.sprint()), UVM_DEBUG)
      uvm_config_db#(uvma_${name}_cfg_c)::set(this, "*", "cfg", cfg);
   end
   
   if (cfg.enabled) begin
      void'(uvm_config_db#(uvma_${name}_cntxt_c)::get(this, "", "cntxt", cntxt));
      if (!cntxt) begin
         `uvm_info("CNTXT", "Context handle is null; creating.", UVM_DEBUG)
         cntxt = uvma_${name}_cntxt_c::type_id::create("cntxt");
      end
      uvm_config_db#(uvma_${name}_cntxt_c)::set(this, "*", "cntxt", cntxt);
      
      case (cfg.layer)
         UVMA_${name_uppercase}_LAYER_${layer_name_uppercase}: begin
            if (!uvm_config_db#(virtual uvma_${name}_${layer_name}_if)::get(this, "", "vif", cntxt.${layer_name}_vif)) begin
               `uvm_fatal("VIF", $sformatf("Could not find vif handle of type %s in uvm_config_db", $typename(cntxt.${layer_name}_vif)))
            end
            else begin
               `uvm_info("VIF", $sformatf("Found vif handle of type %s in uvm_config_db", $typename(cntxt.${layer_name}_vif)), UVM_DEBUG)
            end
         end
         
         // Ex: Additional layer named 'abc'
         //     UVMA_${name_uppercase}_LAYER_ABC: begin
         //        if (!uvm_config_db#(virtual uvma_${name}_abc_if)::get(this, "", "vif", cntxt.abc_vif)) begin
         //           `uvm_fatal("VIF", $sformatf("Could not find vif handle of type %s in uvm_config_db", $typename(cntxt.abc_vif)))
         //        end
         //        else begin
         //           `uvm_info("VIF", $sformatf("Found vif handle of type %s in uvm_config_db", $typename(cntxt.abc_vif)), UVM_DEBUG)
         //        end
         //     end
         
         default: begin
            `uvm_fatal("${name_uppercase}_AGENT", $sformatf("Invalid cfg.layer: %d", cfg.layer))
         end
      endcase
      
      monitor = uvma_${name}_mon_c::type_id::create("monitor", this);
      if (cfg.is_active) begin
         sequencer = uvma_${name}_sqr_c::type_id::create("sequencer", this);
         driver    = uvma_${name}_drv_c::type_id::create("driver"   , this);
      end
      
      if (cfg.cov_model_enabled) begin
         cov_model = uvma_${name}_cov_model_c::type_id::create("cov_model", this);
      end
      
      if (cfg.trn_log_enabled) begin
         mon_${direction_rx}_logger = uvma_${name}_mon_trn_logger_c::type_id::create("mon_${direction_rx}_logger", this);
         mon_${direction_tx}_logger = uvma_${name}_mon_trn_logger_c::type_id::create("mon_${direction_tx}_logger", this);
         mon_${direction_rx}_logger.direction = UVMA_${name_uppercase}_DIRECTION_${direction_rx_uppercase};
         mon_${direction_tx}_logger.direction = UVMA_${name_uppercase}_DIRECTION_${direction_tx_uppercase};
      end
   end
   
endfunction : build_phase


function void uvma_${name}_agent_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   if (cfg.enabled) begin
      mon_${direction_rx}_ap = monitor.${direction_rx}_ap;
      mon_${direction_tx}_ap = monitor.${direction_tx}_ap;
      
      if (cfg.is_active == UVM_ACTIVE) begin
         sequencer.set_arbitration(cfg.sqr_arb_mode);
         
         case (cfg.layer)
            UVMA_${name_uppercase}_LAYER_${layer_name_uppercase} : driver.${layer_name}_adptr.seq_item_port.connect(sequencer.${layer_name}_adptr.seq_item_export);
            // Ex: Additional layer named 'abc'
            //     UVMA_${name_uppercase}_LAYER_ABC : driver.abc_adptr.seq_item_port.connect(sequencer.abc_adptr.seq_item_export);
            
            default: begin
               `uvm_fatal("${name_uppercase}_AGENT", $sformatf("Invalid cfg.layer: %d", cfg.layer))
            end
         endcase
         
         drv_ap = driver.ap;
      end
      
      if (cfg.cov_model_enabled) begin
         mon_${direction_rx}_ap.connect(cov_model.mon_${direction_rx}_trn_fifo.analysis_export);
         mon_${direction_tx}_ap.connect(cov_model.mon_${direction_tx}_trn_fifo.analysis_export);
         if (cfg.is_active == UVM_ACTIVE) begin
            drv_ap.connect(cov_model.seq_item_fifo.analysis_export);
         end
      end
      
      if (cfg.trn_log_enabled) begin
         mon_${direction_rx}_logger.name = ".${direction_rx}";
         mon_${direction_tx}_logger.name = ".${direction_tx}";
         mon_${direction_rx}_ap.connect(mon_${direction_rx}_logger.analysis_export);
         mon_${direction_tx}_ap.connect(mon_${direction_tx}_logger.analysis_export);
      end
   end
   
endfunction: connect_phase


`pragma protect end


`endif // __UVMA_${name_uppercase}_AGENT_SV__
