// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVME_${name_uppercase}_ST_CNTXT_SV__
`define __UVME_${name_uppercase}_ST_CNTXT_SV__


/**
 * Object encapsulating all state variables for ${name_normal_case} VIP
 * Self-Testing environment (uvme_${name}_st_env_c) components.
 */
class uvme_${name}_st_cntxt_c extends uvm_object;
   
   // Agent context handles
   uvma_${name}_cntxt_c  ${name_1}_cntxt;
   uvma_${name}_cntxt_c  ${name_2}_cntxt;
   
   // Scoreboard context handles
   uvml_sb_cntxt_c  sb_${name_1}_cntxt;
   uvml_sb_cntxt_c  sb_${name_2}_cntxt;
   
   // Events
   uvm_event  sample_cfg_e  ;
   uvm_event  sample_cntxt_e;
   
   
   `uvm_object_utils_begin(uvme_${name}_st_cntxt_c)
      `uvm_field_object(${name_1}_cntxt, UVM_DEFAULT)
      `uvm_field_object(${name_2}_cntxt, UVM_DEFAULT)
      
      `uvm_field_object(sb_${name_1}_cntxt, UVM_DEFAULT)
      `uvm_field_object(sb_${name_2}_cntxt, UVM_DEFAULT)
      
      `uvm_field_event(sample_cfg_e  , UVM_DEFAULT)
      `uvm_field_event(sample_cntxt_e, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Builds events and sub-context objects.
    */
   extern function new(string name="uvme_${name}_st_cntxt");
   
   /**
    * TODO Describe uvme_${name}_cntxt_c::reset()
    */
   extern function void reset();
   
endclass : uvme_${name}_st_cntxt_c


`pragma protect begin


function uvme_${name}_st_cntxt_c::new(string name="uvme_${name}_st_cntxt");
   
   super.new(name);
   
   ${name_1}_cntxt = uvma_${name}_cntxt_c::type_id::create("${name_1}_cntxt");
   ${name_2}_cntxt = uvma_${name}_cntxt_c::type_id::create("${name_2}_cntxt");
   
   sb_${name_1}_cntxt = uvml_sb_cntxt_c::type_id::create("sb_${name_1}_cntxt");
   sb_${name_2}_cntxt = uvml_sb_cntxt_c::type_id::create("sb_${name_2}_cntxt");
   
   sample_cfg_e   = new("sample_cfg_e"  );
   sample_cntxt_e = new("sample_cntxt_e");
   
endfunction : new


function void uvme_${name}_cntxt_c::reset();
   
   ${name_1}_cntxt.reset();
   ${name_2}_cntxt.reset();
   
endfunction : reset


`pragma protect end


`endif // __UVME_${name_uppercase}_ST_CNTXT_SV__
