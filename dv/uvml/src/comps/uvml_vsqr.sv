// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
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
