// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_DRV_SV__
`define __UVML_DRV_SV__


/**
 * TODO Describe uvml_drv_c
 */
class uvml_drv_c #(
   type REQ = uvm_sequence_item,
   type RSP = uvm_sequence_item
) extends uvm_driver #(
   .REQ(REQ),
   .RSP(RSP)
);
   
   // Fields
   
   
   
   `uvm_component_param_utils_begin(uvml_drv_c#(.REQ(REQ), .RSP(RSP)))
      // UVM Field Util Macros
   `uvm_component_utils_end
   
   
   // Constraints
   
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvml_drv", uvm_component parent=null);
   
   // Methods
   
   
endclass : uvml_drv_c


function uvml_drv_c::new(string name="uvml_drv", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


`endif // __UVML_DRV_SV__
