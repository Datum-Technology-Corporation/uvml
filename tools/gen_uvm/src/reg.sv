// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __${pkg_name_uppercase}_${name_uppercase}_REG_SV__
`define __${pkg_name_uppercase}_${name_uppercase}_REG_SV__


/**
 * TODO Describe ${pkg_name}_${name}_reg_c
 */
class ${pkg_name}_${name}_reg_c extends ${base_class};
   
   // TODO Add register fields
   //      Ex: rand uvml_ral_reg_field  xyz;
   
   
   `uvm_object_utils_begin(${pkg_name}_${name}_reg_c)
      // TODO Add field macros for register fields
      //      Ex: `uvm_field_object(xyz, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="${pkg_name}_${name}_reg", int unsigned n_bits=32, int has_coverage=UVM_NO_COVERAGE);
   
   /**
    * Create and configure register fields.
    */
   extern function void build();
   
endclass : ${pkg_name}_${name}_reg_c


function ${pkg_name}_${name}_reg_c::new(string name="${pkg_name}_${name}_reg", int unsigned n_bits=32, int has_coverage=UVM_NO_COVERAGE);
   
   super.new(name, n_bits, has_coverage);
   
endfunction : new


function void ${pkg_name}_${name}_reg_c::build();
   
   // TODO Create and configure register fields
   //      Ex: xyz = uvml_ral_reg_field::type_id::create("xyz");
   //          xyz.configure(
   //             .parent                 (this),
   //             .size                   (   1),
   //             .lsb_pos                (   0),
   //             .access                 ("RW"),
   //             .volatile               (   0),
   //             .reset                  (   0),
   //             .has_reset              (   1),
   //             .is_rand                (   1),
   //             .individually_accessible(   0)
   //          );
   
endfunction: build


`endif // __${pkg_name_uppercase}_${name_uppercase}_REG_SV__
