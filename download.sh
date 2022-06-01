#!/usr/bin/env bash

# Create a local datalad dataset

# load pre.sh
DIR=$(dirname $(readlink -f $0))
source ${DIR}/pre.sh

cd ${dir}
log_info "Building dataset"
datalad create -d . -D "${name}" --force
# should maybe be in ".cryo-data" sub-folder, or stored somewhere else?
git add cryo-data.yaml
git add cryo-data-download.*
git commit cryo-data.yaml cryo-data-download.* -m "cryo-data meta and download"
if [[ -e cryo-data-download.sh ]]; then ./cryo-data-download.sh; fi
if [[ -e cryo-data-download.py ]]; then ./cryo-data-download.py; fi
cd ${CWD}
