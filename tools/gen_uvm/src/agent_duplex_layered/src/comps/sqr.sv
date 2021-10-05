// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_SQR_SV__
`define __UVMA_${name_uppercase}_SQR_SV__


/**
 * Component encapsulating the ${name_normal_case} layer and adapter sequencer(s) and sequence(s).
 */
class uvma_${name}_sqr_c extends uvm_sequencer#(
   .REQ(uvma_${name}_seq_item_c),
   .RSP(uvma_${name}_seq_item_c)
);
   
   // Objects
   uvma_${name}_cfg_c    cfg;
   uvma_${name}_cntxt_c  cntxt;
   
   // Layers
   uvma_${name}_layer_sqr_${layer_name}_c  ${layer_name}_layer;
   
   // Layer sequences
   uvma_${name}_layer_seq_${layer_name}_c  ${layer_name}_layer_seq;
   
   // Adapters
   uvma_${name}_adptr_sqr_${layer_name}_c  ${layer_name}_adptr;
   
   // Adapter sequences
   uvma_${name}_adptr_seq_${layer_name}_c  ${layer_name}_adptr_seq;
   
   // Loggers
   uvma_${name}_seq_item_logger_c  seq_item_logger;
   
   
   `uvm_component_utils_begin(uvma_${name}_sqr_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_sqr", uvm_component parent=null);
   
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
   
   /**
    * Start default layer and adapter sequences.
    */
   extern virtual task run_phase(uvm_phase phase);
   
endclass : uvma_${name}_sqr_c


`pragma protect begin


function uvma_${name}_sqr_c::new(string name="uvma_${name}_sqr", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_${name}_sqr_c::build_phase(uvm_phase phase);
   
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
   
   seq_item_logger = uvma_${name}_seq_item_logger_c::type_id::create("seq_item_logger", this);
   case (cfg.layer)
      UVMA_${name_uppercase}_LAYER_${layer_name_uppercase} : begin
         ${layer_name}_adptr = uvma_${name}_adptr_sqr_${layer_name}_c::type_id::create("${layer_name}_adptr", this);
      end
      
      // Ex: Additional layer named 'abc'
      // UVMA_${name_uppercase}_LAYER_ABC : begin
      //    ${layer_name}_layer = uvma_${name}_layer_sqr_${layer_name}_c::type_id::create("${layer_name}_layer", this);
      //    abc_adptr = uvma_${name}_adptr_sqr_abc_c::type_id::create("abc_adptr", this);
      //    
      //    if (cfg.logging_depth > UVMA_${name_uppercase}_LOGGING_DEPTH_AGENT) begin
      //       ${layer_name}_logger = uvma_${name}_layer_seq_item_${layer_name}_logger_c::type_id::create("${layer_name}_logger", this);
      //       abc_logger = uvma_${name}_layer_seq_item_abc_logger_c::type_id::create("abc_logger", this);
      //    end
      // end
   endcase
   
endfunction : build_phase


function void uvma_${name}_sqr_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   // Connect sequencers
   case (cfg.layer)
      UVMA_${name_uppercase}_LAYER_${layer_name_uppercase} : begin
         ${layer_name}_adptr.upstrm_sqr = this;
      end
      
      // Ex: Additional layer named 'abc'
      //     UVMA_${name_uppercase}_LAYER_ABC : begin
      //        ${layer_name}_layer.upstrm_sqr = this;
      //        abc_adptr.upstrm_sqr = ${layer_name}_layer;
      //     end
   endcase
   
   // Connect loggers
   case (cfg.layer)
      UVMA_${name_uppercase}_LAYER_${layer_name_uppercase} : begin
         ${layer_name}_adptr.in_ap.connect(seq_item_logger.analysis_export);
      end
      
      // Ex: Additional layer named 'abc'
      //     UVMA_${name_uppercase}_LAYER_ABC : begin
      //        ${layer_name}_layer.in_ap.connect(seq_item_logger.analysis_export);
      //        
      //        if (cfg.logging_depth > UVMA_${name_uppercase}_LOGGING_DEPTH_AGENT) begin
      //           ${layer_name}_logger.name = "${layer_name}";
      //           ${layer_name}_layer.${layer_name}_ap.connect(${layer_name}_logger.analysis_export);
      //           
      //           abc_logger.name = "abc";
      //           ${layer_name}_layer.ap.connect(abc_logger.analysis_export);
      //        end
      //     end
   endcase
   
endfunction : connect_phase


task uvma_${name}_sqr_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
   
   case (cfg.layer)
      UVMA_${name_uppercase}_LAYER_${layer_name_uppercase} : begin
         fork
            begin
               ${layer_name}_adptr_seq = uvma_${name}_adptr_seq_${layer_name}_c::type_id::create("${layer_name}_adptr_seq");
               ${layer_name}_adptr_seq.start(${layer_name}_adptr);
            end
         join_none
      end
      
      // Ex: Additional layer named 'abc'
      //     UVMA_${name_uppercase}_LAYER_ABC : begin
      //        fork
      //           begin
      //              ${layer_name}_layer_seq = uvma_${name}_layer_seq_${layer_name}_c::type_id::create("${layer_name}_layer_seq");
      //              ${layer_name}_layer_seq.start(${layer_name}_layer);
      //           end
      //           begin
      //              abc_adptr_seq = uvma_${name}_adptr_seq_abc_c::type_id::create("abc_adptr_seq");
      //              abc_adptr_seq.start(abc_adptr);
      //           end
      //        join_none
      //     end
   endcase
   
endtask : run_phase


`pragma protect end


`endif // __UVMA_${name_uppercase}_SQR_SV__
