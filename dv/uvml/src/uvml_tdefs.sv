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


`ifndef __UVML_TDEFS_SV__
`define __UVML_TDEFS_SV__


typedef enum {
   UVML_FILE_BASE_DIR_DEFAULT     ,
   UVML_FILE_BASE_DIR_CUSTOM      ,
   UVML_FILE_BASE_DIR_SIM         ,
   UVML_FILE_BASE_DIR_TB          ,
   UVML_FILE_BASE_DIR_TESTS       ,
   UVML_FILE_BASE_DIR_TEST_RESULTS,
   UVML_FILE_BASE_DIR_DV          ,
   UVML_FILE_BASE_DIR_RTL         
} uvml_file_base_dir_enum;

typedef enum {
   UVML_FILE_ACCESS_READ ,
   UVML_FILE_ACCESS_WRITE
} uvml_file_access_enum;

typedef enum bit {
   UVML_RESET_TYPE_SYNCHRONOUS   = 1,
   UVML_RESET_TYPE_ASYNCHRONOUS  = 0
} uvml_reset_type_enum;

typedef enum {
   UVML_RESET_ACTIVE_LOW ,
   UVML_RESET_ACTIVE_HIGH
} uvml_reset_polarity_enum;

typedef enum {
   UVML_RESET_STATE_PRE_RESET ,
   UVML_RESET_STATE_IN_RESET  ,
   UVML_RESET_STATE_POST_RESET
} uvml_reset_state_enum;

typedef enum bit {
   UVML_EDGE_ASSERTED   = 1,
   UVML_EDGE_DEASSERTED = 0
} uvml_edge_enum;

/**
 * Describes a component issuing a heartbeat to an instance of the heartbeat monitor (uvml_hrtbt_mon_c).
 */
typedef struct {
   uvm_component  owner    ; ///< 
   int            id       ; ///< 
   realtime       timestamp; ///< 
} uvml_hrtbt_entry_struct;


`endif // __UVML_TDEFS_SV__
