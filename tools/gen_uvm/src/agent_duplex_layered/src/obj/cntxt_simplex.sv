// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_CNTXT_SIMPLEX_SV__
`define __UVMA_${name_uppercase}_CNTXT_SIMPLEX_SV__


// Forward type declaration to parent object
typedef class uvma_${name}_cntxt_c;


/**
 * Object encapsulating all state variables for all ${name_normal_case} agent's
 * (uvma_${name}_agent_c) components in a single direction.
 * Child of uvma_${name}_cntxt_c.
 */
class uvma_${name}_cntxt_simplex_c extends uvm_object;
   
   // Handle to parent context
   uvma_${name}_cntxt_c  parent_cntxt;
   
   
   `uvm_object_utils_begin(uvma_${name}_cntxt_simplex_c)
      
   `uvm_object_utils_end
   
   
   /**
    * Build events.
    */
   extern function new(string name="uvma_${name}_cntxt_simplex");
   
   /**
    * TODO Describe uvma_${name}_cntxt_simplex_c::reset()
    */
   extern function void reset();
   
endclass : uvma_${name}_cntxt_simplex_c


`pragma protect begin


function uvma_${name}_cntxt_simplex_c::new(string name="uvma_${name}_cntxt_simplex");
   
   super.new(name);
   
endfunction : new


function void uvma_${name}_cntxt_simplex_c::reset();
   
   // TODO Implement uvma_${name}_cntxt_simplex_c::reset()
   
endfunction : reset


`pragma protect end


`endif // __UVMA_${name_uppercase}_CNTXT_SIMPLEX_SV__
