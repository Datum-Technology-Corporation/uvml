// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_ENV_SV__
`define __UVML_ENV_SV__


/**
 * TODO Describe uvml_env_c
 */
class uvml_env_c extends uvm_env;
   
   // Fields
   
   
   
   `uvm_component_utils_begin(uvml_env_c)
      // UVM Field Util Macros
   `uvm_component_utils_end
   
   
   // Constraints
   
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvml_env", uvm_component parent=null);
   
   // Methods
   
   
endclass : uvml_env_c


function uvml_env_c::new(string name="uvml_env", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


`endif // __UVML_ENV_SV__
