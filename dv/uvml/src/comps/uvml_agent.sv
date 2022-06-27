// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_AGENT_SV__
`define __UVML_AGENT_SV__


/**
 * TODO Describe uvml_agent_c
 */
class uvml_agent_c extends uvm_agent;
   
   // Fields
   
   
   
   `uvm_component_utils_begin(uvml_agent_c)
      // UVM Field Util Macros
   `uvm_component_utils_end
   
   
   // Constraints
   
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvml_agent", uvm_component parent=null);
   
   // Methods
   
   
endclass : uvml_agent_c


function uvml_agent_c::new(string name="uvml_agent", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


`endif // __UVML_AGENT_SV__
