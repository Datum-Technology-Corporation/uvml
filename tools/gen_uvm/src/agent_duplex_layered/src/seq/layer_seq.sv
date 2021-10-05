// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_LAYER_SEQ_${layer_name_uppercase}_SV__
`define __UVMA_${name_uppercase}_LAYER_SEQ_${layer_name_uppercase}_SV__


/**
 * 
 */
class uvma_${name}_layer_seq_${layer_name}_c extends uvma_${name}_layer_seq_base_c#(
   .T_IN (uvma_${name}_seq_item_c              ),
   .T_OUT(uvma_${name}_layer_seq_item_fs_pyld_c),
   .T_SQR(uvma_${name}_layer_sqr_${layer_name}_c)
);
   
   `uvm_object_utils(uvma_${name}_layer_seq_${layer_name}_c)
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_layer_seq_${layer_name}");
   
   /**
    * TODO Describe uvma_${name}_layer_seq_${layer_name}_c::body()
    */
   extern task body();
   
endclass : uvma_${name}_layer_seq_${layer_name}_c


`pragma protect begin


function uvma_${name}_layer_seq_${layer_name}_c::new(string name="uvma_${name}_layer_seq_${layer_name}");
   
   super.new(name);
   
endfunction : new


task uvma_${name}_layer_seq_${layer_name}_c::body();
   
   super.body();
   
   forever begin
      p_sequencer.upstrm_sqr.get_next_item(trn_in);
      p_sequencer.in_ap.write             (trn_in);
      
      // ...
      // p_sequencer.ap.write(req);
      
      p_sequencer.upstrm_sqr.item_done();
   end
   
endtask : body


`pragma protect end


`endif // __UVMA_${name_uppercase}_LAYER_SEQ_${layer_name_uppercase}_SV__
