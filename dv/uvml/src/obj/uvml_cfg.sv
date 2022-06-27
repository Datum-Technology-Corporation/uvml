// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_CFG_SV__
`define __UVML_CFG_SV__


/**
 * TODO Describe uvml_cfg_c
 */
class uvml_cfg_c extends uvm_object;

   // Fields



   `uvm_object_utils_begin(uvml_cfg_c)
      // UVM Field Util Macros
   `uvm_object_utils_end


   // Constraints



   /**
    * Default constructor.
    */
   extern function new(string name="uvml_cfg");

   // Methods


endclass : uvml_cfg_c


function uvml_cfg_c::new(string name="uvml_cfg");

   super.new(name);

endfunction : new


`endif // __UVML_CFG_SV__
