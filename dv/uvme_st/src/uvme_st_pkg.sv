// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_ST_PKG_SV__
`define __UVME_ST_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"
`include "uvma_st_macros.svh"
`include "uvme_st_macros.svh"

// Interface(s)


 /**
 * Encapsulates all the types needed for an UVM environment capable of self-testing the Moore.io UVM Extension Library.
 */
package uvme_st_pkg;

   import uvm_pkg    ::*;
   import uvml_pkg   ::*;
   import uvma_st_pkg::*;

   // Constants / Structs / Enums
   `include "uvme_st_tdefs.sv"
   `include "uvme_st_constants.sv"

   // Objects
   `include "uvme_st_cfg.sv"
   `include "uvme_st_cntxt.sv"

   // Environment components
   `include "uvme_st_cov_model.sv"
   `include "uvme_st_prd.sv"
   `include "uvme_st_sb.sv"
   `include "uvme_st_vsqr.sv"
   `include "uvme_st_env.sv"

   // Sequences
   `include "uvme_st_base_vseq.sv"
   `include "uvme_st_traffic_vseq.sv"

endpackage : uvme_st_pkg


// Module(s) / Checker(s)
`ifdef UVME_ST_INC_CHKR
`include "uvme_st_chkr.sv"
`endif


`endif // __UVME_ST_PKG_SV__
