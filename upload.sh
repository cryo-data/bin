#!/usr/bin/env bash

# Push datalad dataset to the GitHub cryo-data project

# load pre.sh
DIR=$(dirname $(readlink -f $0))
source ${DIR}/pre.sh

cd ${dir}
log_info "Upload"
# datalad create-sibling-github --dataset ./10.1594.762898 -s ${name} cryo-data/${name}
gh repo create --public -d "${name}" cryo-data/${name}
# undo: gh repo delete cryo-data/${name}
git remote add origin git@github.com:cryo-data/${name}
git push -u origin main
datalad push
cd ${CWD}
