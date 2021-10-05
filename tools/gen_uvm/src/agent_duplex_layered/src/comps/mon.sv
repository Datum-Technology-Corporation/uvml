// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_MON_SV__
`define __UVMA_${name_uppercase}_MON_SV__


/**
 * Component encapsulating the layer(s) and adapter(s) that monitor ${name_normal_case} virtual interface(s).
 */
class uvma_${name}_mon_c extends uvm_monitor;
  
  // Objects
  uvma_${name}_cfg_c    cfg;
  uvma_${name}_cntxt_c  cntxt;
  
  // TLM
  uvm_analysis_port#(uvma_${name}_mon_trn_c)  ${direction_rx}_ap;
  uvm_analysis_port#(uvma_${name}_mon_trn_c)  ${direction_tx}_ap;
  uvm_analysis_port#(uvma_${name}_layer_mon_trn_${layer_name}_c)  ${direction_rx}_${layer_name}_ap;
  uvm_analysis_port#(uvma_${name}_layer_mon_trn_${layer_name}_c)  ${direction_tx}_${layer_name}_ap;
  
  // Layers
  uvma_${name}_layer_mon_${layer_name}_c  ${layer_name}_layer;
  
  // Adapters
  uvma_${name}_adptr_mon_${layer_name}_c  ${layer_name}_adptr;
  // Ex: Additional layer named 'abc'
  //     uvma_${name}_adptr_mon_abc_c  abc_adptr;
  
  // Layer loggers
  uvma_${name}_layer_mon_trn_${layer_name}_logger_c  ${direction_rx}_${layer_name}_layer_logger;
  uvma_${name}_layer_mon_trn_${layer_name}_logger_c  ${direction_tx}_${layer_name}_layer_logger;
  // Ex: Additional layer named 'abc'
  //     uvma_${name}_layer_mon_trn_abc_logger_c  ${direction_rx}_abc_layer_logger;
  //     uvma_${name}_layer_mon_trn_abc_logger_c  ${direction_tx}_abc_layer_logger;
  
  // Adapter loggers
  uvma_${name}_adptr_mon_trn_${layer_name}_logger_c  ${direction_rx}_${layer_name}_adptr_logger;
  uvma_${name}_adptr_mon_trn_${layer_name}_logger_c  ${direction_tx}_${layer_name}_adptr_logger;
  // Ex: Additional layer named 'abc'
  //     uvma_${name}_adptr_mon_trn_abc_logger_c  ${direction_rx}_abc_adptr_logger;
  //     uvma_${name}_adptr_mon_trn_abc_logger_c  ${direction_tx}_abc_adptr_logger;
  
  
  `uvm_component_utils_begin(uvma_${name}_mon_c)
    `uvm_field_object(cfg  , UVM_DEFAULT)
    `uvm_field_object(cntxt, UVM_DEFAULT)
  `uvm_component_utils_end
  
  
  /**
   * Default constructor.
   */
  extern function new(string name="uvma_${name}_mon", uvm_component parent=null);
  
  /**
   * 1. Retrieve cfg and cntxt.
   * 2. Build correct interface layer(s), adapter and logger(s).
   */
  extern virtual function void build_phase(uvm_phase phase);
  
  /**
   * 1. Connect layers to one another.
   * 2. Connect bottom layer to adapter.
   * 3. Connect loggers to layer(s) and adapter.
   */
  extern virtual function void connect_phase(uvm_phase phase);
  
endclass : uvma_${name}_mon_c


`pragma protect begin


function uvma_${name}_mon_c::new(string name="uvma_${name}_mon", uvm_component parent=null);
  
  super.new(name, parent);
  
endfunction : new


function void uvma_${name}_mon_c::build_phase(uvm_phase phase);
  
  super.build_phase(phase);
  
  void'(uvm_config_db#(uvma_${name}_cfg_c)::get(this, "", "cfg", cfg));
  if (!cfg) begin
    `uvm_fatal("CFG", "Configuration handle is null")
  end
  uvm_config_db#(uvma_${name}_cfg_c)::set(this, "*", "cfg", cfg);
  
  void'(uvm_config_db#(uvma_${name}_cntxt_c)::get(this, "", "cntxt", cntxt));
  if (!cntxt) begin
    `uvm_fatal("CNTXT", "Context handle is null")
  end
  uvm_config_db#(uvma_${name}_cntxt_c)::set(this, "*", "cntxt", cntxt);
  
  case (cfg.layer)
    UVMA_${name_uppercase}_LAYER_${layer_name_uppercase} : begin
      ${layer_name}_adptr = uvma_${name}_adptr_mon_${layer_name}_c::type_id::create("${layer_name}_adptr", this);
      
      if (cfg.logging_depth == UVMA_${name_uppercase}_LOGGING_DEPTH_FULL) begin
        ${direction_rx}_${layer_name}_adptr_logger = uvma_${name}_adptr_mon_trn_${layer_name}_logger_c::type_id::create("${direction_rx}_${layer_name}_adptr_logger", this);
        ${direction_tx}_${layer_name}_adptr_logger = uvma_${name}_adptr_mon_trn_${layer_name}_logger_c::type_id::create("${direction_tx}_${layer_name}_adptr_logger", this);
        ${direction_rx}_${layer_name}_adptr_logger.direction = UVMA_${name_uppercase}_DIRECTION_${direction_rx_uppercase};
        ${direction_tx}_${layer_name}_adptr_logger.direction = UVMA_${name_uppercase}_DIRECTION_${direction_tx_uppercase};
      end
    end
    
    // Ex: Additional layer named 'abc'
    //     UVMA_${name_uppercase}_LAYER_ABC : begin
    //       ${layer_name}_layer = uvma_${name}_layer_mon_${layer_name}_c::type_id::create("${layer_name}_layer", this);
    //       abc_adptr = uvma_${name}_adptr_mon_abc_c::type_id::create("abc_adptr" , this);
    //       
    //       if (cfg.logging_depth > UVMA_${name_uppercase}_LOGGING_DEPTH_AGENT) begin
    //         ${direction_rx}_${layer_name}_layer_logger = uvma_${name}_layer_mon_trn_${layer_name}_logger_c::type_id::create("${direction_rx}_${layer_name}_layer_logger", this);
    //         ${direction_tx}_${layer_name}_layer_logger = uvma_${name}_layer_mon_trn_${layer_name}_logger_c::type_id::create("${direction_tx}_${layer_name}_layer_logger", this);
    //         ${direction_rx}_abc_layer_logger = uvma_${name}_layer_mon_trn_abc_logger_c::type_id::create("${direction_rx}_abc_layer_logger", this);
    //         ${direction_tx}_abc_layer_logger = uvma_${name}_layer_mon_trn_abc_logger_c::type_id::create("${direction_tx}_abc_layer_logger", this);
    //       end
    //       
    //       if (cfg.logging_depth == UVMA_${name_uppercase}_LOGGING_DEPTH_FULL) begin
    //         ${direction_rx}_abc_adptr_logger = uvma_${name}_adptr_mon_trn_abc_logger_c::type_id::create("${direction_rx}_abc_adptr_logger", this);
    //         ${direction_tx}_abc_adptr_logger = uvma_${name}_adptr_mon_trn_abc_logger_c::type_id::create("${direction_tx}_abc_adptr_logger", this);
    //       end
    //     end
  endcase
  
endfunction : build_phase


function void uvma_${name}_mon_c::connect_phase(uvm_phase phase);
  
  super.connect_phase(phase);
  
  // Connect FIFOs
  case (cfg.layer)
    // Ex: Additional layer named 'abc'
    //     UVMA_${name_uppercase}_LAYER_ABC : begin
    //       ${layer_name}_layer.${direction_rx}_in_fifo = abc_adptr.${direction_rx}_out_fifo;
    //       ${layer_name}_layer.${direction_tx}_in_fifo = abc_adptr.${direction_tx}_out_fifo;
    //     end
  endcase
  
  // Connect analysis ports
  case (cfg.layer)
    UVMA_${name_uppercase}_LAYER_${layer_name_uppercase} : begin
      ${direction_rx}_ap = ${layer_name}_adptr.${direction_rx}_out_ap;
      ${direction_tx}_ap = ${layer_name}_adptr.${direction_tx}_out_ap;
    end
    
    // Ex: Additional layer named 'abc'
    //     UVMA_${name_uppercase}_LAYER_ABC : begin
    //       ${direction_rx}_ap = ${layer_name}_layer.${direction_rx}_ap;
    //       ${direction_tx}_ap = ${layer_name}_layer.${direction_tx}_ap;
    //       ${direction_rx}_${layer_name}_ap = ${layer_name}_layer.${direction_rx}_${layer_name}_ap;
    //       ${direction_tx}_${layer_name}_ap = ${layer_name}_layer.${direction_tx}_${layer_name}_ap;
    //       ${direction_rx}_abc_ap = abc_adptr.${direction_rx}_out_ap;
    //       ${direction_tx}_abc_ap = abc_adptr.${direction_tx}_out_ap;
    //     end
  endcase
  
  // Connect transaction loggers
  case (cfg.layer)
    UVMA_${name_uppercase}_LAYER_${layer_name_uppercase} : begin
      if (cfg.logging_depth == UVMA_${name_uppercase}_LOGGING_DEPTH_FULL) begin
        ${direction_rx}_${layer_name}_adptr_logger.name = ".${direction_rx}.${layer_name}.adptr";
        ${direction_tx}_${layer_name}_adptr_logger.name = ".${direction_tx}.${layer_name}.adptr";
        ${layer_name}_adptr.${direction_rx}_in_ap.connect(${direction_rx}_${layer_name}_adptr_logger.analysis_export);
        ${layer_name}_adptr.${direction_tx}_in_ap.connect(${direction_tx}_${layer_name}_adptr_logger.analysis_export);
      end
    end
    
    // Ex: Additional layer named 'abc'
    //     UVMA_${name_uppercase}_LAYER_ABC : begin
    //       if (cfg.logging_depth > UVMA_${name_uppercase}_LOGGING_DEPTH_AGENT) begin
    //         ${direction_rx}_${layer_name}_layer_logger.name = ".${direction_rx}.${layer_name}.layer";
    //         tx_${layer_name}_layer_logger.name = ".tx.${layer_name}.layer";
    //         ${direction_rx}_${layer_name}_ap.connect(${direction_rx}_${layer_name}_layer_logger.analysis_export);
    //         tx_${layer_name}_ap.connect(tx_${layer_name}_layer_logger.analysis_export);
    //         
    //         ${direction_rx}_abc_layer_logger.name = ".${direction_rx}.abc.layer";
    //         tx_abc_layer_logger.name = ".tx.abc.layer";
    //         ${direction_rx}_abc_ap.connect(${direction_rx}_abc_layer_logger.analysis_export);
    //         tx_abc_ap.connect(tx_abc_layer_logger.analysis_export);
    //       end
    //       
    //       if (cfg.logging_depth == UVMA_${name_uppercase}_LOGGING_DEPTH_FULL) begin
    //         ${direction_rx}_abc_adptr_logger.name = ".${direction_rx}.abc.adptr";
    //         tx_abc_adptr_logger.name = ".tx.abc.adptr";
    //         abc_adptr.${direction_rx}_in_ap.connect(${direction_rx}_abc_adptr_logger.analysis_export);
    //         abc_adptr.tx_in_ap.connect(tx_abc_adptr_logger.analysis_export);
    //       end
    //     end
  endcase
  
endfunction : connect_phase


`pragma protect end


`endif // __UVMA_${name_uppercase}_MON_SV__
