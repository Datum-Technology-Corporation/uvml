// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVME_${name_uppercase}_${clk_agent_name_uppercase}_VSEQ_SV__
`define __UVME_${name_uppercase}_${clk_agent_name_uppercase}_VSEQ_SV__



/**
 * Virtual sequence responsible for starting clocks for the ${name_normal_case} DUT.
 */
class uvme_${name}_${clk_agent_name}_vseq_c extends uvme_${name}_base_vseq_c;
   
   // TODO Add clk sequence to uvme_${name}_${clk_agent_name}_vseq_c
   //      Ex: rand uvma_${clk_agent_type}_simple_seq_c  ${clk_agent_name}_seq;
   
   `uvm_object_utils_begin(uvme_${name}_${clk_agent_name}_vseq_c)
      // TODO Add sub-sequence(s) utility macros
      //      Ex: `uvm_field_object(${clk_agent_name}_seq, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   // TODO Add constraint(s) to uvme_${name}_${clk_agent_name}_vseq_c
   //      Ex: constraint ${clk_agent_name}_seq_cons {
   //             ${clk_agent_name}_seq.duration == 123;
   //          }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_${name}_${clk_agent_name}_vseq_c");
   
   /**
    * TODO Describe uvme_${name}_${clk_agent_name}_vseq_c::body()
    */
   extern virtual task body();
   
endclass : uvme_${name}_${clk_agent_name}_vseq_c


`pragma protect begin


function uvme_${name}_${clk_agent_name}_vseq_c::new(string name="uvme_${name}_${clk_agent_name}_vseq_c");
   
   super.new(name);
   
   // TODO Create sub-sequence(s)
   //      Ex: ${clk_agent_name}_seq = uvma_${clk_agent_type}_simple_seq_c::type_id::create("${clk_agent_name}_seq");
   
endfunction : new


task uvme_${name}_${clk_agent_name}_vseq_c::body();
   
   // TODO Implement uvme_${name}_${clk_agent_name}_vseq_c::body()
   //      Ex: `uvm_do_with(${clk_agent_name}_seq, p_sequencer.${clk_agent_name}_sequencer)
   
endtask : body


`pragma protect end


`endif // __UVME_${name_uppercase}_${${clk_agent_name}_agent_name_uppercase}_VSEQ_SV__
