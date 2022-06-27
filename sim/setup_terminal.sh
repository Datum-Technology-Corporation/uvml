#! /bin/bash
########################################################################################################################
## Copyright 2021 Datum Technology Corporation
## SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
########################################################################################################################


### Project ###
export PROJECT_ROOT_DIR=$(pwd)/..
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
export MIO_HOME=${PROJECT_TOOLS_DIR}/.imports/mio
alias mio="${MIO_HOME}/src/__main__.py"


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

# PATH
export PATH=${PATH}:${MIO_HOME}/src/src
