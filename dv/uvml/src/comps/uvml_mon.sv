// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_MON_SV__
`define __UVML_MON_SV__


/**
 * TODO Describe uvml_mon_c
 */
class uvml_mon_c extends uvm_monitor;
   
   // Fields
   
   
   
   `uvm_component_utils_begin(uvml_mon_c)
      // UVM Field Util Macros
   `uvm_component_utils_end
   
   
   // Constraints
   
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvml_mon", uvm_component parent=null);
   
   // Methods
   
   
endclass : uvml_mon_c


function uvml_mon_c::new(string name="uvml_mon", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


`endif // __UVML_MON_SV__
