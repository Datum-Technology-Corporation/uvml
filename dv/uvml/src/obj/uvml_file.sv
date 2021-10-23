// Copyright 2021 Datum Technology Corporation
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_FILE_SV__
`define __UVML_FILE_SV__


/**
 * Models a standard OS File with read/write functionality.
 */
class uvml_file_c extends uvm_object;
   
   // Properties
   uvml_file_base_dir_enum  base_dir; ///< 
   string                   path    ; ///< 
   
   // IO
   protected bit           fhandle_valid      ; ///< 
   protected int unsigned  fhandle            ; ///< 
   protected uvm_access_e  current_access_type; ///< 
   
   protected static string  base_dir_paths[uvml_file_base_dir_enum]; ///< Dictionary of all paths obtained from CLI args
   
   
   `uvm_object_utils_begin(uvml_file_c)
      `uvm_field_enum  (uvml_file_base_dir_enum, base_dir, UVM_DEFAULT)
      `uvm_field_string(                         path    , UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvml_file");
   
   /**
    * TODO Describe uvml_file_c::open()
    */
   extern function bit open(uvm_access_e access_type, string path="default");
   
   /**
    * TODO Describe uvml_file_c::open()
    */
   extern function bit close();
   
   /**
    * TODO Describe uvml_file_c::read_line()
    */
   extern function string read_line();
   
   /**
    * TODO Describe uvml_file_c::write()
    */
   extern function void write(string text);
   
   /**
    * TODO Describe uvml_file_c::write_line()
    */
   extern function void write_line(string text);
   
   /**
    * TODO Describe uvml_file_c::get_full_path()
    */
   extern function string get_full_path();
   
   /**
    * TODO Describe uvml_file_c::is_open()
    */
   extern function bit is_open();
   
   /**
    * TODO Describe uvml_file_c::is_eof()
    */
   extern function bit is_eof();
   
   /**
    * TODO Describe uvml_file_c::set_base_dir()
    */
   extern function void set_base_dir(uvml_file_base_dir_enum val);
   
   /**
    * TODO Describe uvml_file_c::get_base_dir()
    */
   extern function uvml_file_base_dir_enum get_base_dir();
   
   /**
    * TODO Describe uvml_file_c::get_path()
    */
   extern function void set_path(string val);
   
   /**
    * TODO Describe uvml_file_c::get_path()
    */
   extern function string get_path();
   
   /**
    * 
    */
   extern static function string get_cli_path(uvml_file_base_dir_enum base_dir);
   
   /**
    * 
    */
   extern static function string get_cli_arg(uvml_file_base_dir_enum base_dir);
   
   /**
    * TODO Describe uvml_file_c::get_sim_dir_path()
    */
   extern static function string get_sim_dir_path();
   
   /**
    * TODO Describe uvml_file_c::get_tb_dir_path()
    */
   extern static function string get_tb_dir_path();
   
   /**
    * TODO Describe uvml_file_c::get_tests_dir_path()
    */
   extern static function string get_tests_dir_path();
   
   /**
    * TODO Describe uvml_file_c::get_test_results_dir_path()
    */
   extern static function string get_test_results_dir_path();
   
   /**
    * TODO Describe uvml_file_c::get_dv_dir_path()
    */
   extern static function string get_dv_dir_path();
   
   /**
    * TODO Describe uvml_file_c::get_rtl_dir_path()
    */
   extern static function string get_rtl_dir_path();
   
endclass : uvml_file_c


function uvml_file_c::new(string name="uvml_file");
   
   super.new(name);
   base_dir      = UVML_FILE_BASE_DIR_DEFAULT;
   fhandle_valid = 0;
   fhandle       = 0;
   path          = name;
   
endfunction : new


function bit uvml_file_c::open(uvm_access_e access_type, string path="default");
   
   string  access_str = "";
   
   if (is_open()) begin
      `uvm_warning("UVML_FILE", $sformatf("Trying to open file that is already open: %s", get_full_path()))
   end
   else begin
      case (access_type)
         UVM_READ : access_str = "r";
         UVM_WRITE: access_str = "w+";
         
         default: begin
            `uvm_warning("UVML_FILE", $sformatf("Invalid access_type: %s", access_type.name()))
            return 0;
         end
      endcase
      current_access_type = access_type;
      if (path != "default") begin
         this.path = path;
      end
      if (base_dir == UVML_FILE_BASE_DIR_DEFAULT) begin
         case (access_type)
            UVM_READ : base_dir = UVML_FILE_BASE_DIR_TESTS       ;
            UVM_WRITE: base_dir = UVML_FILE_BASE_DIR_TEST_RESULTS;
         endcase
      end
      fhandle = $fopen(get_full_path(), access_str);
      fhandle_valid = (fhandle != 0);
   end
   
   return fhandle_valid;
   
endfunction : open


function bit uvml_file_c::close();
   
   if (!is_open()) begin
      `uvm_warning("UVML_FILE", $sformatf("Trying to close file that is not open: %s", get_full_path()))
   end
   else begin
      $fclose(fhandle);
      fhandle_valid = 0;
   end
   
   return !fhandle_valid;
   
endfunction : close


function string uvml_file_c::read_line();
   
   int  return_val;
   
   if (!is_open()) begin
      `uvm_error("UVML_FILE", $sformatf("Attempting to read from file that isn't open: %s", get_full_path()))
   end
   else begin
      if (current_access_type == UVM_READ) begin
         if (!is_eof()) begin
            return_val = $fgets(read_line, fhandle);
         end
         else begin
            `uvm_warning("UVML_FILE", $sformatf("Trying to read past end of file: %s", get_full_path()))
            read_line = "";
         end
      end
      else begin
         `uvm_warning("UVML_FILE", $sformatf("Trying to read from file in write mode: %s", get_full_path()))
      end
   end
   
endfunction : read_line


function void uvml_file_c::write(string text);
   
   if (!is_open()) begin
      `uvm_warning("UVML_FILE", $sformatf("Attempting to write to file that isn't open: %s", get_full_path()))
   end
   else begin
      if (current_access_type == UVM_WRITE) begin
         $fwrite(fhandle, text);
      end
      else begin
         `uvm_warning("UVML_FILE", $sformatf("Trying to write to file in write mode: %s", get_full_path()))
      end
   end
   
endfunction : write


function void uvml_file_c::write_line(string text);
   
   write({text, "\n"});
   
endfunction : write_line


function string uvml_file_c::get_full_path();
   
   if (base_dir == UVML_FILE_BASE_DIR_CUSTOM) begin
      get_full_path = path;
   end
   else begin
      get_full_path = {uvml_file_c::get_cli_path(base_dir), "/", path};
   end
   
endfunction : get_full_path


function bit uvml_file_c::is_open();
   
   return fhandle_valid;
   
endfunction : is_open


function bit uvml_file_c::is_eof();
   
   if (is_open()) begin
      return $feof(fhandle);
   end
   else begin
      return 0;
   end
   
endfunction : is_eof


function void uvml_file_c::set_base_dir(uvml_file_base_dir_enum val);
   
   base_dir = val;
   
endfunction : set_base_dir


function uvml_file_base_dir_enum uvml_file_c::get_base_dir();
   
   return base_dir;
   
endfunction : get_base_dir


function void uvml_file_c::set_path(string val);
   
   path = val;
   
endfunction : set_path


function string uvml_file_c::get_path();
   
   return path;
   
endfunction : get_path


function string uvml_file_c::get_cli_path(uvml_file_base_dir_enum base_dir);
   
   if (base_dir == UVML_FILE_BASE_DIR_CUSTOM) begin
      get_cli_path = "";
   end
   else begin
      if (!base_dir_paths.exists(base_dir)) begin
         base_dir_paths[base_dir] = get_cli_arg(base_dir);
      end
      get_cli_path = base_dir_paths[base_dir];
      //get_cli_path = "/home/dpoulin/git/uvml/sim/results/uvmt_st_traffic_test_1";
   end
   
endfunction : get_cli_path


function string uvml_file_c::get_cli_arg(uvml_file_base_dir_enum base_dir);
   
   string  cli_arg_name = "";
   string  cli_arg_val  = "";
   string  final_arg    = "";
   
   // Grab CLI arg name string from constants
   if (!uvml_file_cli_args.exists(base_dir)) begin
      `uvm_warning("FILE", $sformatf("Invalid base_dir type: %s", base_dir.name()))
      return "";
   end
   else begin
      cli_arg_name = uvml_file_cli_args[base_dir];
   end
   
   // Use uvm_cmdLine_proc to get the arg value
   final_arg = {cli_arg_name, "=%s"};
   // NOTE None of the standard code below works with vivado, so we have to hardcode each call to $value$plusargs
   //if (uvm_cmdline_proc.get_arg_value({"+", cli_arg_name, "="}, cli_arg_val)) begin
   //if ($value$plusargs(final_arg, cli_arg_val)) begin
   //   `uvm_info("FILE", $sformatf("Value for %s is %s", final_arg, cli_arg_val), UVM_NONE/*UVM_DEBUG*/)
   //end
   //else begin
   //   `uvm_warning("FILE", $sformatf("Could not find %s", final_arg))
   //end
   
   case (base_dir)
     UVML_FILE_BASE_DIR_SIM : begin
         if ($value$plusargs(`UVML_FILE_CLI_ARG_BASE_DIR_SIM, cli_arg_val)) begin
            `uvm_info("FILE", $sformatf("Value for %s is %s", final_arg, cli_arg_val), UVM_DEBUG)
         end
         else begin
            `uvm_warning("FILE", $sformatf("Could not find %s", final_arg))
         end
      end
      
     UVML_FILE_BASE_DIR_TB : begin
         if ($value$plusargs(`UVML_FILE_CLI_ARG_BASE_DIR_TB, cli_arg_val)) begin
            `uvm_info("FILE", $sformatf("Value for %s is %s", final_arg, cli_arg_val), UVM_DEBUG)
         end
         else begin
            `uvm_warning("FILE", $sformatf("Could not find %s", final_arg))
         end
      end
      
     UVML_FILE_BASE_DIR_TESTS : begin
         if ($value$plusargs(`UVML_FILE_CLI_ARG_BASE_DIR_TESTS, cli_arg_val)) begin
            `uvm_info("FILE", $sformatf("Value for %s is %s", final_arg, cli_arg_val), UVM_DEBUG)
         end
         else begin
            `uvm_warning("FILE", $sformatf("Could not find %s", final_arg))
         end
      end
      
     UVML_FILE_BASE_DIR_TEST_RESULTS : begin
         if ($value$plusargs(`UVML_FILE_CLI_ARG_BASE_DIR_TEST_RESULTS, cli_arg_val)) begin
            `uvm_info("FILE", $sformatf("Value for %s is %s", final_arg, cli_arg_val), UVM_DEBUG)
         end
         else begin
            `uvm_warning("FILE", $sformatf("Could not find %s", final_arg))
         end
      end
      
     UVML_FILE_BASE_DIR_DV : begin
         if ($value$plusargs(`UVML_FILE_CLI_ARG_BASE_DIR_DV, cli_arg_val)) begin
            `uvm_info("FILE", $sformatf("Value for %s is %s", final_arg, cli_arg_val), UVM_DEBUG)
         end
         else begin
            `uvm_warning("FILE", $sformatf("Could not find %s", final_arg))
         end
      end
      
     UVML_FILE_BASE_DIR_RTL : begin
         if ($value$plusargs(`UVML_FILE_CLI_ARG_BASE_DIR_RTL, cli_arg_val)) begin
            `uvm_info("FILE", $sformatf("Value for %s is %s", final_arg, cli_arg_val), UVM_DEBUG)
         end
         else begin
            `uvm_warning("FILE", $sformatf("Could not find %s", final_arg))
         end
      end
   endcase
   
   return cli_arg_val;
   
endfunction : get_cli_arg


function string uvml_file_c::get_sim_dir_path();
   
   return get_cli_path(UVML_FILE_BASE_DIR_SIM);
   
endfunction : get_sim_dir_path


function string uvml_file_c::get_tb_dir_path();
   
   return get_cli_path(UVML_FILE_BASE_DIR_TB);
   
endfunction : get_tb_dir_path


function string uvml_file_c::get_tests_dir_path();
   
   return get_cli_path(UVML_FILE_BASE_DIR_TESTS);
   
endfunction : get_tests_dir_path


function string uvml_file_c::get_test_results_dir_path();
   
   return get_cli_path(UVML_FILE_BASE_DIR_TEST_RESULTS);
   
endfunction : get_test_results_dir_path


function string uvml_file_c::get_dv_dir_path();
   
   return get_cli_path(UVML_FILE_BASE_DIR_DV);
   
endfunction : get_dv_dir_path


function string uvml_file_c::get_rtl_dir_path();
   
   return get_cli_path(UVML_FILE_BASE_DIR_RTL);
   
endfunction : get_rtl_dir_path


`endif // __UVML_FILE_SV__
