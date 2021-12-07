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


typedef bit            uvml_bit_array_t [];
typedef byte unsigned  uvml_byte_array_t[];
typedef int            uvml_int_array_t [];

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


/**
 * List of possible field types.  Essentially a listing of UVM's field utility macros.
 */
typedef enum {
   UVML_FIELD_INT          , ///< 
   UVML_FIELD_OBJECT       , ///< 
   UVML_FIELD_STRING       , ///< 
   UVML_FIELD_ENUM         , ///< 
   UVML_FIELD_REAL         , ///< 
   UVML_FIELD_SARRAY_INT   , ///< 
   UVML_FIELD_SARRAY_OBJECT, ///< 
   UVML_FIELD_SARRAY_STRING, ///< 
   UVML_FIELD_SARRAY_ENUM  , ///< 
   UVML_FIELD_SARRAY_REAL  , ///< 
   UVML_FIELD_ARRAY_INT    , ///< 
   UVML_FIELD_ARRAY_OBJECT , ///< 
   UVML_FIELD_ARRAY_STRING , ///< 
   UVML_FIELD_ARRAY_ENUM   , ///< 
   UVML_FIELD_ARRAY_REAL   , ///< 
   UVML_FIELD_QUEUE_INT    , ///< 
   UVML_FIELD_QUEUE_OBJECT , ///< 
   UVML_FIELD_QUEUE_STRING , ///< 
   UVML_FIELD_QUEUE_ENUM   , ///< 
   UVML_FIELD_QUEUE_REAL   , ///< 
   UVML_FIELD_AA_INT       , ///< 
   UVML_FIELD_AA_OBJECT    , ///< 
   UVML_FIELD_AA_STRING    , ///< 
   UVML_FIELD_AA_ENUM      , ///< 
   UVML_FIELD_AA_REAL        ///< 
} uvml_field_enum;


/**
 * 
 */
typedef enum {
   UVML_TEXT_ALIGN_LEFT  , ///< 
   UVML_TEXT_ALIGN_CENTER, ///< 
   UVML_TEXT_ALIGN_RIGHT   ///< 
} uvml_text_align_enum;


/**
 * Encapsulates a field of metadata for an object.
 */
typedef struct {
   int unsigned          index    ; ///< 
   string                value    ; ///< 
   string                col_name ; ///< 
   int unsigned          col_width; ///< 
   uvml_text_align_enum  col_align; ///< 
   uvml_field_enum       data_type; ///< 
} uvml_metadata_field_t;


/**
 * Encapsulates all the metadata for an object.
 */
typedef uvml_metadata_field_t  uvml_metadata_t[$];


`endif // __UVML_TDEFS_SV__
