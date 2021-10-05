// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMT_${name_uppercase}_ST_TEST_CFG_SV__
`define __UVMT_${name_uppercase}_ST_TEST_CFG_SV__


/**
 * Object encapsulating configuration parameters common to most if not all tests
 * extending from uvmt_${name}_st_base_test_c.
 */
class uvmt_${name}_st_test_cfg_c extends uvm_object;
   
   // Knobs
   rand int unsigned  clk_period        ; // Specified in picoseconds (ps)
   rand int unsigned  reset_period      ; // Specified in nanoseconds (ns)
   rand int unsigned  startup_timeout   ; // Specified in nanoseconds (ns)
   rand int unsigned  heartbeat_period  ; // Specified in nanoseconds (ns)
   rand int unsigned  simulation_timeout; // Specified in nanoseconds (ns)
   
   // Command line arguments
   // TODO Add command line argument descriptors
   //      Ex: string        cli_num_pkts_str      = "NPKTS";
   //          bit           cli_num_pkts_override = 0;
   //          int unsigned  cli_num_pkts_parsed;
   
   
   `uvm_object_utils_begin(uvmt_${name}_st_test_cfg_c)
      `uvm_field_int(clk_period        , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(reset_period      , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(startup_timeout   , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(heartbeat_period  , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(simulation_timeout, UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end
   
   
   constraint defaults_cons {
      soft clk_period         == uvmt_${name}_st_default_clk_period        ;
      soft reset_period       == uvmt_${name}_st_default_reset_period      ;
      soft startup_timeout    == uvmt_${name}_st_default_startup_timeout   ;
      soft heartbeat_period   == uvmt_${name}_st_default_heartbeat_period  ;
      soft simulation_timeout == uvmt_${name}_st_default_simulation_timeout;
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvmt_${name}_st_test_cfg");
   
   /**
    * TODO Describe uvmt_${name}_st_test_cfg_c::process_cli_args()
    */
   extern function void process_cli_args();
   
endclass : uvmt_${name}_st_test_cfg_c


function uvmt_${name}_st_test_cfg_c::new(string name="uvmt_${name}_st_test_cfg");
   
   super.new(name);
   
endfunction : new


function void uvmt_${name}_st_test_cfg_c::process_cli_args();
   
   // TODO Process command line arguments
   //      Ex: string  cli_num_pkts_parsed_str  = "";
   //          if (uvm_cmdline_proc.get_arg_value({"+", cli_num_pkts_str, "="}, cli_num_pkts_parsed_str)) begin
   //             if (cli_num_pkts_parsed_str != "") begin
   //                cli_num_pkts_override = 1;
   //                cli_num_pkts_parsed = cli_num_pkts_parsed_str.atoi();
   //             end
   //             else begin
   //                cli_num_pkts_override = 0;
   //             end
   //          end
   //          else begin
   //             cli_num_pkts_override = 0;
   //          end
   
endfunction : process_cli_args


`endif // __UVMT_${name_uppercase}_ST_TEST_CFG_SV__
