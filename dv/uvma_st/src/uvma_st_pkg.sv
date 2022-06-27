// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_ST_PKG_SV__
`define __UVMA_ST_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"
`include "uvma_st_macros.svh"

// Interface(s)
`include "uvma_st_if.sv"


/**
 * Encapsulates all the types needed for an UVM agent capable of testing the Moore.io UVM Extension Library.
 */
package uvma_st_pkg;

   import uvm_pkg ::*;
   import uvml_pkg::*;

   // Constants / Structs / Enums
   `include "uvma_st_tdefs.sv"
   `include "uvma_st_constants.sv"

   // Objects
   `include "uvma_st_cfg.sv"
   `include "uvma_st_cntxt.sv"

   // High-level transactions
   `include "uvma_st_mon_trn.sv"
   `include "uvma_st_mon_trn_logger.sv"
   `include "uvma_st_seq_item.sv"
   `include "uvma_st_seq_item_logger.sv"

   // Agent components
   `include "uvma_st_cov_model.sv"
   `include "uvma_st_drv.sv"
   `include "uvma_st_mon.sv"
   `include "uvma_st_sqr.sv"
   `include "uvma_st_agent.sv"

   // Sequences
   `include "uvma_st_base_seq.sv"
   `include "uvma_st_burst_seq.sv"

endpackage : uvma_st_pkg


// Module(s) / Checker(s)
`ifdef UVMA_ST_INC_IF_CHKR
`include "uvma_st_if_chkr.sv"
`endif


`endif // __UVMA_ST_PKG_SV__
