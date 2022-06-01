#!/usr/bin/env bash

# Create a local datalad dataset

# load pre.sh
DIR=$(dirname $(readlink -f $0))
source ${DIR}/pre.sh

cd ${dir}
log_info "Creating dataset"
datalad create -d . -D "${name}" --force
log_info "Saving cryo-data files in git"
git add cryo-data
git commit cryo-data -m "cryo data folder"
log_info "Starting download..."
if [[ -e ./cryo-data/download.sh ]]; then ./cryo-data/download.sh; fi
if [[ -e ./cryo-data/download.py ]]; then ./cryo-data/download.py; fi
log_info "Download complete."
datalad save -m "Download"
cd ${CWD}
