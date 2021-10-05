// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_DRV_SV__
`define __UVMA_${name_uppercase}_DRV_SV__


/**
 * Component encapsulating the adapter(s) that drive any ${name_normal_case} virtual interface.
 */
class uvma_${name}_drv_c extends uvm_component;
   
   // Objects
   uvma_${name}_cfg_c    cfg;
   uvma_${name}_cntxt_c  cntxt;
   
   // Components
   uvma_${name}_adptr_drv_${layer_name}_c  ${layer_name}_adptr;
   
   // Loggers
   uvma_${name}_adptr_seq_item_${layer_name}_logger_c  ${layer_name}_logger;
   
   
   `uvm_component_utils_begin(uvma_${name}_drv_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_drv", uvm_component parent=null);
   
   /**
    * 1. Retrieve cfg and cntxt.
    * 2. Build correct interface adapter and logger.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Connect logger to adapter's analysis port.
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
endclass : uvma_${name}_drv_c


`pragma protect begin


function uvma_${name}_drv_c::new(string name="uvma_${name}_drv", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_${name}_drv_c::build_phase(uvm_phase phase);
   
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
         ${layer_name}_adptr = uvma_${name}_adptr_drv_${layer_name}_c::type_id::create("${layer_name}_adptr", this);
         
         if (cfg.logging_depth == UVMA_${name_uppercase}_LOGGING_DEPTH_FULL) begin
            ${layer_name}_logger = uvma_${name}_adptr_seq_item_${layer_name}_logger_c::type_id::create("${layer_name}_logger", this);
         end
      end
      
      // Ex: Additional layer named 'abc'
      //     UVMA_${name_uppercase}_LAYER_ABC : begin
      //        abc_adptr = uvma_${name}_adptr_drv_abc_c::type_id::create("abc_adptr", this);
      //        
      //        if (cfg.logging_depth == UVMA_${name_uppercase}_LOGGING_DEPTH_FULL) begin
      //           abc_logger = uvma_${name}_adptr_seq_item_abc_logger_c::type_id::create("abc_logger", this);
      //        end
      //     end
   endcase
   
endfunction : build_phase


function void uvma_${name}_drv_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   // Connect loggers
   case (cfg.layer)
      UVMA_${name_uppercase}_LAYER_${layer_name_uppercase} : begin
         if (cfg.logging_depth == UVMA_${name_uppercase}_LOGGING_DEPTH_FULL) begin
            ${layer_name}_logger.name = ".${layer_name}";
            ${layer_name}_adptr.ap.connect(${layer_name}_logger.analysis_export);
         end
      end
      
      // Ex: Additional layer named 'abc'
      //     UVMA_${name_uppercase}_LAYER_ABC : begin
      //        if (cfg.logging_depth == UVMA_${name_uppercase}_LOGGING_DEPTH_FULL) begin
      //           abc_logger.name = ".abc";
      //           abc_adptr.ap.connect(abc_logger.analysis_export);
      //        end
      //     end
   endcase
   
endfunction : connect_phase


`pragma protect end


`endif // __UVMA_${name_uppercase}_DRV_SV__
