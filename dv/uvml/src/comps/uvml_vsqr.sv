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


`ifndef __UVML_VSQR_SV__
`define __UVML_VSQR_SV__


/**
 * TODO Describe uvml_vsqr_c
 */
class uvml_vsqr_c #(
   type REQ = uvm_sequence_item,
   type RSP = uvm_sequence_item
) extends uvm_sequencer #(
   .REQ(REQ),
   .RSP(RSP)
);
   
   // Fields
   
   
   
   `uvm_component_utils_begin(uvml_vsqr_c)
      // UVM Field Util Macros
   `uvm_component_utils_end
   
   
   // Constraints
   
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvml_vsqr", uvm_component parent=null);
   
   // Methods
   
   
endclass : uvml_vsqr_c


function uvml_vsqr_c::new(string name="uvml_vsqr", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


`endif // __UVML_VSQR_SV__
