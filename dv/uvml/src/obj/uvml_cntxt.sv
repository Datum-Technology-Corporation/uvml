// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_CNTXT_SV__
`define __UVML_CNTXT_SV__


/**
 * TODO Describe uvml_cntxt_c
 */
class uvml_cntxt_c extends uvm_object;
   
   // Fields
   
   
   
   `uvm_object_utils_begin(uvml_cntxt_c)
      // UVM Field Util Macros
   `uvm_object_utils_end
   
   
   // Constraints
   
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvml_cntxt");
   
   // Methods
   
   
endclass : uvml_cntxt_c


function uvml_cntxt_c::new(string name="uvml_cntxt");
   
   super.new(name);
   
endfunction : new


`endif // __UVML_CNTXT_SV__
