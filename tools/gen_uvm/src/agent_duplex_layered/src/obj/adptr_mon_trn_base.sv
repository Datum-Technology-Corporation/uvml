// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_ADPTR_MON_TRN_BASE_SV__
`define __UVMA_${name_uppercase}_ADPTR_MON_TRN_BASE_SV__


/**
 * Object from which all other ${name_normal_case} adapter monitor transactions must extend.
 */
class uvma_${name}_adptr_mon_trn_base_c extends uvm_trn_mon_trn_c;
   
   // Data
   
   
   // Metadata
   uvma_${name}_direction_enum  direction;
   
   
   `uvm_object_utils_begin(uvma_${name}_adptr_mon_trn_base_c)
      `uvm_field_enum(uvma_${name}_direction_enum, direction, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_adptr_mon_trn_base");
   
endclass : uvma_${name}_adptr_mon_trn_base_c


`pragma protect begin


function uvma_${name}_adptr_mon_trn_base_c::new(string name="uvma_${name}_adptr_mon_trn_base");
   
   super.new(name);
   
endfunction : new


`pragma protect end


`endif // __UVMA_${name_uppercase}_ADPTR_MON_TRN_BASE_SV__
