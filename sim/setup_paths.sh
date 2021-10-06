#! /bin/bash
########################################################################################################################
## Copyright 2021 Datum Technology Corporation
########################################################################################################################
## SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
## Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
## with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
##                                        https://solderpad.org/licenses/SHL-2.1/
## Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
## an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
## specific language governing permissions and limitations under the License.
########################################################################################################################


### Project ###
export PROJECT_ROOT_DIR=$(pwd)
export PROJECT_DV_DIR=${PROJECT_ROOT_DIR}/dv
export PROJECT_DV_IMPORTS_DIR=${PROJECT_DV_DIR}/.imports
export PROJECT_RTL_DIR=${PROJECT_ROOT_DIR}/rtl
export PROJECT_SIM_DIR=${PROJECT_ROOT_DIR}/sim
export PROJECT_SIM_ARTIFACTS_DIR=${PROJECT_SIM_DIR}/out
export PROJECT_SIM_RESULTS_DIR=${PROJECT_SIM_DIR}/results
export PROJECT_TOOLS_DIR=${PROJECT_ROOT_DIR}/tools
export PROJECT_TOOLS_IMPORT_DIR=${PROJECT_TOOLS_DIR}/.imports


### Tools ###
# Local
# Imports


### RTL ###
# Local
# Imports


### DV ###
# Local
export DV_UVML_SRC_PATH=${PROJECT_DV_DIR}/uvml/src
export DV_UVMA_ST_SRC_PATH=${PROJECT_DV_DIR}/uvma_st/src
export DV_UVME_ST_SRC_PATH=${PROJECT_DV_DIR}/uvme_st/src
export DV_UVMT_ST_SRC_PATH=${PROJECT_DV_DIR}/uvmt_st/src

# Imports
export UVM_HOME=${PROJECT_DV_IMPORTS_DIR}/uvm/src
export DV_UVM_SRC_PATH=${PROJECT_DV_IMPORTS_DIR}/uvm/src
export DV_UVML_LOGS_SRC_PATH=${PROJECT_DV_IMPORTS_DIR}/uvml_logs/src
export DV_UVML_SB_SRC_PATH=${PROJECT_DV_IMPORTS_DIR}/uvml_sb/src
export DV_UVML_RAL_SRC_PATH=${PROJECT_DV_IMPORTS_DIR}/uvml_ral/src
export DV_UVMA_RESET_SRC_PATH=${PROJECT_DV_IMPORTS_DIR}/uvma_reset/src
export DV_UVME_RESET_ST_SRC_PATH=${PROJECT_DV_IMPORTS_DIR}/uvme_reset/src
export DV_UVMT_RESET_ST_SRC_PATH=${PROJECT_DV_IMPORTS_DIR}/uvmt_reset/src
export DV_UVMA_CLK_SRC_PATH=${PROJECT_DV_IMPORTS_DIR}/uvma_clk/src
export DV_UVME_CLK_ST_SRC_PATH=${PROJECT_DV_IMPORTS_DIR}/uvme_clk/src
export DV_UVMT_CLK_ST_SRC_PATH=${PROJECT_DV_IMPORTS_DIR}/uvmt_clk/src
