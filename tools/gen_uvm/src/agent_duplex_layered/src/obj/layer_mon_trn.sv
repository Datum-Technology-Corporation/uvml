// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_LAYER_MON_TRN_${layer_name_uppercase}_SV__
`define __UVMA_${name_uppercase}_LAYER_MON_TRN_${layer_name_uppercase}_SV__


/**
 * 
 */
class uvma_${name}_layer_mon_trn_${layer_name}_c extends uvma_${name}_layer_mon_trn_base_c;
   
   
   
   
   `uvm_object_utils_begin(uvma_${name}_layer_mon_trn_${layer_name}_c)
      
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_layer_mon_trn_${layer_name}");
   
endclass : uvma_${name}_layer_mon_trn_${layer_name}_c


`pragma protect begin


function uvma_${name}_layer_mon_trn_${layer_name}_c::new(string name="uvma_${name}_layer_mon_trn_${layer_name}");
   
   super.new(name);
   
endfunction : new


`pragma protect end


`endif // __UVMA_${name_uppercase}_LAYER_MON_TRN_${layer_name_uppercase}_SV__
