#! /bin/bash
########################################################################################################################
## Copyright 2021-2022 Datum Technology Corporation
## SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
########################################################################################################################


# Launched from uvml project sim dir
shopt -s expand_aliases
source ~/.bashrc
mio cpel    uvmt_st
mio sim     uvmt_st -t traffic     -c
mio sim     uvmt_st -t file_read   -c
mio sim     uvmt_st -t file_write  -c
mio sim     uvmt_st -t vector_file -c
mio results uvmt_st results
mio cov     uvmt_st
