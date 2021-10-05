// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_LAYER_SQR_${layer_name_uppercase}_SV__
`define __UVMA_${name_uppercase}_LAYER_SQR_${layer_name_uppercase}_SV__


typedef class uvma_${name}_sqr_c;


/**
 * TODO Describe uvma_${name}_layer_sqr_${layer_name}_c
 */
class uvma_${name}_layer_sqr_${layer_name}_c extends uvma_${name}_layer_sqr_base_c#(
   .T_IN  (uvma_${name}_seq_item_c              ),
   .T_OUT (uvma_${name}_layer_seq_item_fs_pyld_c),
   .T_USQR(uvma_${name}_sqr_c                   )
);
   
   uvm_analysis_port#(uvma_${name}_seq_item_c          )  in_ap;
   uvm_analysis_port#(uvma_${name}_layer_seq_item_${layer_name}_c)  ${layer_name}_ap;
   
   
   `uvm_component_utils(uvma_${name}_layer_sqr_${layer_name}_c)
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_layer_sqr_${layer_name}", uvm_component parent=null);
   
   /**
    * TODO Describe uvma_${name}_layer_sqr_${layer_name}_c::build_phase()
    */
   extern virtual function void build_phase(uvm_phase phase);
   
endclass : uvma_${name}_layer_sqr_${layer_name}_c


`pragma protect begin


function uvma_${name}_layer_sqr_${layer_name}_c::new(string name="uvma_${name}_layer_sqr_${layer_name}", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_${name}_layer_sqr_${layer_name}_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   in_ap = new("in_ap", this);
   ${layer_name}_ap = new("${layer_name}_ap", this);
   
endfunction : build_phase


`pragma protect end


`endif // __UVMA_${name_uppercase}_LAYER_SQR_${layer_name_uppercase}_SV__
