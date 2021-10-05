// Copyright 2021 Datum Technology Corporation
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_VSEQ_SV__
`define __UVML_VSEQ_SV__


/**
 * TODO Describe uvml_vseq_c
 */
class uvml_vseq_c #(
   type REQ = uvm_sequence_item,
   type RSP = uvm_sequence_item
) extends uvm_sequence #(
   .REQ(REQ),
   .RSP(RSP)
);
   
   // Fields
   
   
   `uvm_object_utils_begin(uvml_vseq_c)
      
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvml_vseq");
   
   /**
    * TODO Describe uvml_vseq_c::body()
    */
   extern virtual task body();
   
endclass : uvml_vseq_c


function uvml_vseq_c::new(string name="uvml_vseq");
   
   super.new(name);
   
endfunction : new


task uvml_vseq_c::body();
   
   // TODO Implement uvml_vseq_c::body()
   
endtask : body


`endif // __UVML_VSEQ_SV__
