// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVME_${name_uppercase}_ST_PRD_SV__
`define __UVME_${name_uppercase}_ST_PRD_SV__


/**
 * Component implementing transaction-based software model of ${name_normal_case}
 * VIP Self-Testing DUT.
 */
class uvme_${name}_st_prd_c extends uvm_component;
   
   // Objects
   uvme_${name}_st_cfg_c    cfg;
   uvme_${name}_st_cntxt_c  cntxt;
   
   // TLM
   uvm_analysis_export  #(uvma_${name}_mon_trn_c)  ${name_1}_in_export;
   uvm_analysis_export  #(uvma_${name}_mon_trn_c)  ${name_2}_in_export;
   uvm_tlm_analysis_fifo#(uvma_${name}_mon_trn_c)  ${name_1}_in_fifo  ;
   uvm_tlm_analysis_fifo#(uvma_${name}_mon_trn_c)  ${name_2}_in_fifo  ;
   uvm_analysis_port    #(uvma_${name}_mon_trn_c)  ${name_1}_out_ap   ;
   uvm_analysis_port    #(uvma_${name}_mon_trn_c)  ${name_2}_out_ap   ;
   
   
   `uvm_component_utils_begin(uvme_${name}_st_prd_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_${name}_st_prd", uvm_component parent=null);
   
   /**
    * TODO Describe uvme_${name}_st_prd_c::build_phase()
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_${name}_st_prd_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_${name}_st_prd_c::run_phase()
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_${name}_st_prd_c::process_${name_1}()
    */
   extern task process_${name_1}();
   
   /**
    * TODO Describe uvme_${name}_st_prd_c::process_${name_2}()
    */
   extern task process_${name_2}();
   
endclass : uvme_${name}_st_prd_c


`pragma protect begin


function uvme_${name}_st_prd_c::new(string name="uvme_${name}_st_prd", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_${name}_st_prd_c::build_phase(uvm_phase phase);
   
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
   ${name_2}_in_export = new("${name}_1_in_export", this);
   ${name_2}_in_export = new("${name}_2_in_export", this);
   ${name_1}_in_fifo   = new("${name}_1_in_fifo"  , this);
   ${name_2}_in_fifo   = new("${name}_2_in_fifo"  , this);
   ${name_2}_in_port   = new("${name}_1_in_port"  , this);
   ${name_2}_in_port   = new("${name}_2_in_port"  , this);
   
endfunction : build_phase


function void uvme_${name}_st_prd_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   // Connect TLM objects
   ${name_1}_in_export.connect(${name_1}_fifo.analysis_export);
   ${name_2}_in_export.connect(${name_2}_fifo.analysis_export);
   
endfunction: connect_phase


task uvme_${name}_st_prd_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
   
   fork
      process_${name_1}();
      process_${name_2}();
   join_none
   
endtask: run_phase


task uvme_${name}_st_prd_c::process_${name_1}();
   
   uvma_${name}_mon_trn_c  in_trn, out_trn;
   
   forever begin
      // Get next transaction and copy it
      ${name_1}_in_fifo.get(in_trn);
      out_trn = uvma_${name}_mon_trn_c::type_id::create("out_trn");
      out_trn.copy(in_trn);
      
      // TODO Implement uvme_${name}_st_prd_c::process_${name_1}()
      
      // Send transaction to analysis port
      ${name_1}_out_ap.write(out_trn);
   end
   
endtask : process_${name_1}


task uvme_${name}_st_prd_c::process_${name_2}();
   
   uvma_${name}_mon_trn_c  in_trn, out_trn;
   
   forever begin
      // Get next transaction and copy it
      ${name_2}_in_fifo.get(in_trn);
      out_trn = uvma_${name}_mon_trn_c::type_id::create("out_trn");
      out_trn.copy(in_trn);
      
      // TODO Implement uvme_${name}_st_prd_c::process_${name_2}()
      
      // Send transaction to analysis port
      ${name_2}_out_ap.write(out_trn);
   end
   
endtask : process_${name_2}


`pragma protect end


`endif // __UVME_${name_uppercase}_ST_PRD_SV__
