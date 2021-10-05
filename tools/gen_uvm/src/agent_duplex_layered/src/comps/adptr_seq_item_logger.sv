// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_ADPTR_SEQ_ITEM_${layer_name_uppercase}_LOGGER_SV__
`define __UVMA_${name_uppercase}_ADPTR_SEQ_ITEM_${layer_name_uppercase}_LOGGER_SV__


/**
 * Component writing ${name_normal_case} ${layer_normal_case} adapter sequence items debug data to disk as plain text.
 */
class uvma_${name}_adptr_seq_item_${layer_name}_logger_c extends uvm_logs_mon_trn_logger_c#(
  .T_TRN  (uvma_${name}_adptr_seq_item_${layer_name}_c),
  .T_CFG  (uvma_${name}_cfg_c  ),
  .T_CNTXT(uvma_${name}_cntxt_c)
);
  
  uvma_${name}_direction_enum  direction;
  
  
  `uvm_component_utils(uvma_${name}_adptr_seq_item_${layer_name}_logger_c)
  
  
  /**
   * Default constructor.
   */
  function new(string name="uvma_${name}_adptr_seq_item_${layer_name}_logger", uvm_component parent=null);
    
    super.new(name, parent);
    
  endfunction : new
  
  /**
   * Writes contents of t to disk.
   */
  virtual function void write(uvma_${name}_adptr_seq_item_${layer_name}_c t);
    
    if (direction == UVMA_${name_uppercase}_DIRECTION_${direction_rx_uppercase}) begin
      // TODO Implement uvma_${name}_mon_trn_logger_c::write() for ${direction_rx_normal_case}
      //      Ex: fwrite($sformatf(" %011t | %07d | %08h",
      //            t.timestamp,
      //            t.abc      ,
      //            t.xyz
      //          ));
    end
    else begin
      // TODO Implement uvma_${name}_mon_trn_logger_c::write() for ${direction_tx_normal_case}
      //      Ex: fwrite($sformatf(" %011t | %07d | %08h",
      //            t.timestamp,
      //            t.abc      ,
      //            t.xyz
      //          ));
    end
    
  endfunction : write
  
  /**
   * Writes log header to disk
   */
  virtual function void print_header();
    
    if (direction == UVMA_${name_uppercase}_DIRECTION_${direction_rx_uppercase}) begin
      // TODO Implement uvma_${name}_mon_trn_logger_c::print_header() for ${direction_rx_normal_case}
      //      Ex: fwrite("---------------------------");
      //          fwrite("      TIME      | ABC | XYZ");
      //          fwrite("---------------------------");
    end
    else begin
      // TODO Implement uvma_${name}_mon_trn_logger_c::print_header() for ${direction_tx_normal_case}
      //      Ex: fwrite("---------------------------");
      //          fwrite("      TIME      | ABC | XYZ");
      //          fwrite("---------------------------");
    end
    
  endfunction : print_header
  
endclass : uvma_${name}_adptr_seq_item_${layer_name}_logger_c


/**
 * Component writing ${name_normal_case} ${layer_normal_case} adapter sequence items debug data to disk as JavaScript Object Notation (JSON).
 */
class uvma_${name}_adptr_seq_item_${layer_name}_logger_json_c extends uvma_${name}_mon_trn_logger_c;
  
  `uvm_component_utils(uvma_${name}_adptr_seq_item_${layer_name}_logger_json_c)
  
  
  /**
   * Set file extension to '.json'.
   */
  function new(string name="uvma_${name}_adptr_seq_item_${layer_name}_logger_json", uvm_component parent=null);
    
    super.new(name, parent);
    fextension = "json";
    
  endfunction : new
  
  /**
   * Writes contents of t to disk.
   */
  virtual function void write(uvma_${name}_adptr_seq_item_${layer_name}_c t);
    
    // TODO Implement uvma_${name}_mon_trn_logger_json_c::write()
    //      Ex: fwrite({"{",
    //            $sformatf("\"time\":\"%0t\",", t.timestamp),
    //            $sformatf("\"abc\":%0d,"     , t.abc      ),
    //            $sformatf("\"xyz\":%0h,"     , t.xyz      ),
    //          "},"});
    
  endfunction : write
  
  /**
   * Empty function.
   */
  virtual function void print_header();
    
    // Do nothing: JSON files do not use headers.
    
  endfunction : print_header
  
endclass : uvma_${name}_adptr_seq_item_${layer_name}_logger_json_c


`endif // __UVMA_${name_uppercase}_ADPTR_SEQ_ITEM_${layer_name_uppercase}_LOGGER_SV__
