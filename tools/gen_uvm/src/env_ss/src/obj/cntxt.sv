// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVME_${name_uppercase}_CNTXT_SV__
`define __UVME_${name_uppercase}_CNTXT_SV__


/**
 * Object encapsulating all state variables for ${name_normal_case} environment
 * (uvme_${name}_env_c) components.
 */
class uvme_${name}_cntxt_c extends uvm_object;
   
   // TODO Add sub-environments context handles
   //      Ex: uvme_sub_env_cntxt_c  sub_env_cntxt;
   
   // Agent context handles
   uvma_${clk_agent_type}_cntxt_c  ${clk_agent_name}_cntxt;
   uvma_${reset_agent_type}_cntxt_c  ${reset_agent_name}_cntxt;
   uvma_${ral_agent_type}_cntxt_c  ${ral_agent_name}_cntxt;
   
   // TODO Add scoreboard context handles
   //      Ex: uvml_sb_cntxt_c  sb_egress_cntxt;
   //          uvml_sb_cntxt_c  sb_ingress_cntxt;
   
   // Events
   uvm_event  sample_cfg_e;
   uvm_event  sample_cntxt_e;
   
   
   `uvm_object_utils_begin(uvme_${name}_cntxt_c)
       // TODO: Add sub-environments context field macros
       //       Ex: `uvm_field_object(sub_env_cntxt, UVM_DEFAULT)
      
      `uvm_field_object(${clk_agent_name}_cntxt, UVM_DEFAULT)
      `uvm_field_object(${reset_agent_name}_cntxt, UVM_DEFAULT)
      `uvm_field_object(${ral_agent_name}_cntxt, UVM_DEFAULT)
      
      // TODO Add scoreboard context field macros
      //      Ex: `uvm_field_object(sb_egress_cntxt , UVM_DEFAULT)
      //          `uvm_field_object(sb_ingress_cntxt, UVM_DEFAULT)
      
      `uvm_field_event(sample_cfg_e  , UVM_DEFAULT)
      `uvm_field_event(sample_cntxt_e, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Builds events and sub-context objects.
    */
   extern function new(string name="uvme_${name}_cntxt");
   
   
   /**
    * TODO Describe uvme_${name}_cntxt_c::reset()
    */
   extern function void reset();
   
endclass : uvme_${name}_cntxt_c


`pragma protect begin


function uvme_${name}_cntxt_c::new(string name="uvme_${name}_cntxt");
   
   super.new(name);
   
   // TODO Create environment cntxt objects
   //      Ex: sub_env_cntxt  = uvme_sub_env_cntxt_c::type_id::create("sub_env_cntxt");
   
   ${clk_agent_name}_cntxt = uvma_${reset_agent_type}_cntxt_c::type_id::create("${clk_agent_name}_cntxt");
   ${reset_agent_name}_cntxt = uvma_${reset_agent_type}_cntxt_c::type_id::create("${reset_agent_name}_cntxt");
   ${ral_agent_name}_cntxt = uvma_${ral_agent_type}_cntxt_c::type_id::create("${ral_agent_name}_cntxt");
   
   // TODO Create uvme_${name}_cntxt_c scoreboard context objects
   //      Ex: sb_egress_cntxt  = uvml_sb_cntxt_c::type_id::create("sb_egress_cntxt" );
   //          sb_ingress_cntxt = uvml_sb_cntxt_c::type_id::create("sb_ingress_cntxt");
   
   sample_cfg_e   = new("sample_cfg_e"  );
   sample_cntxt_e = new("sample_cntxt_e");
   
endfunction : new


function void uvme_${name}_cntxt_c::reset();
   
   ${clk_agent_name}_cntxt  .reset();
   ${reset_agent_name}_cntxt.reset();
   ${ral_agent_name}_cntxt  .reset();
   
endfunction : reset


`pragma protect end


`endif // __UVME_${name_uppercase}_CNTXT_SV__
