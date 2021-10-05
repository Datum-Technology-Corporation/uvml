// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __${pkg_name_uppercase}_${name_uppercase}_SEQ_SV__
`define __${pkg_name_uppercase}_${name_uppercase}_SEQ_SV__


/**
 * TODO Describe ${pkg_name}_${name}_seq_c
 */
class ${pkg_name}_${name}_seq_c extends ${pkg_name}_base_seq_c;
   
   // Fields
   
   
   `uvm_object_utils_begin(${pkg_name}_${name}_seq_c)
      
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="${pkg_name}_${name}_seq");
   
   /**
    * TODO Describe ${pkg_name}_${name}_seq_c::body()
    */
   extern virtual task body();
   
endclass : ${pkg_name}_${name}_seq_c


`pragma protect begin


function ${pkg_name}_${name}_seq_c::new(string name="${pkg_name}_${name}_seq");
   
   super.new(name);
   
endfunction : new


task ${pkg_name}_${name}_seq_c::body();
   
   // TODO Implement ${pkg_name}_${name}_seq_c::body()
   
endtask : body


`pragma protect end


`endif // __${pkg_name_uppercase}_${name_uppercase}_SEQ_SV__
