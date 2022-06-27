// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_VERSION_SV__
`define __UVML_VERSION_SV__


/**
 * Object describing a version with major and minor indices.
 */
class uvml_version_c extends uvm_object;
   
   // Fields
   rand int unsigned  major;
   rand int unsigned  minor;
   
   
   `uvm_object_utils_begin(uvml_version_c)
      `uvm_field_int(major, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(minor, UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvml_version");
   
   /**
    * TODO Describe uvml_version_c::convert2string()
    */
   extern function string convert2string();
   
endclass : uvml_version_c


function uvml_version_c::new(string name="uvml_version");
   
   super.new(name);
   
endfunction : new


function string uvml_version_c::convert2string();
   
   convert2string = $sformatf("%0d.%0d", major, minor);
   
endfunction : convert2string


`endif // __UVML_VERSION_SV__
