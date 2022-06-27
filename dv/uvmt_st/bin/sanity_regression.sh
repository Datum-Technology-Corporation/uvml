#! /bin/bash
########################################################################################################################
## Copyright 2021 Datum Technology Corporation
## SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
########################################################################################################################


# Launched from uvml project sim dir
python ./setup_project.py
source ./setup_terminal.sh
../tools/.imports/mio/src/__main__.py cpel uvmt_st
../tools/.imports/mio/src/__main__.py sim uvmt_st -t traffic -s 1 -c
../tools/.imports/mio/src/__main__.py sim uvmt_st -t file_read -s 1 -c
../tools/.imports/mio/src/__main__.py sim uvmt_st -t file_write -s 1 -c
../tools/.imports/mio/src/__main__.py sim uvmt_st -t vector_file -s 1 -c
../tools/.imports/mio/src/__main__.py results uvmt_st results
../tools/.imports/mio/src/__main__.py cov uvmt_st
