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


`ifndef __UVML_PKG_SV__
`define __UVML_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"


/**
 * Encapsulates all the types needed for the Moore.io UVM Extension Library.
 */
package uvml_pkg;

   import uvm_pkg::*;

   // Constants / Structs / Enums
   `include "uvml_tdefs.sv"
   `include "uvml_constants.sv"

   // Objects
   `include "uvml_file.sv"
   `include "uvml_vector_file.sv"
   `include "uvml_version.sv"
   `include "uvml_cfg.sv"
   `include "uvml_cntxt.sv"
   `include "uvml_mon_trn.sv"
   `include "uvml_test_cfg.sv"

   // Components
   `include "uvml_hrtbt_mon.sv"
   `include "uvml_watchdog.sv"
   `include "uvml_delay.sv"
   `include "uvml_mon.sv"
   `include "uvml_sqr.sv"
   `include "uvml_vsqr.sv"
   `include "uvml_drv.sv"
   `include "uvml_agent.sv"
   `include "uvml_env.sv"
   `include "uvml_test.sv"

   // Sequences
   `include "uvml_seq_item.sv"
   `include "uvml_seq.sv"
   `include "uvml_vseq.sv"
   `include "uvml_seq_lib.sv"
   `include "uvml_vseq_lib.sv"

   // Default heartbeat monitor
   uvml_hrtbt_mon_c  uvml_default_hrtbt_mon = new("uvml_default_hrtbt_mon");
   // Default watchdog timeout
   uvml_watchdog_c   uvml_default_watchdog = new("uvml_default_watchdog");

endpackage : uvml_pkg


`endif // __UVML_PKG_SV__
