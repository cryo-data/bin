
# load pre.sh commands
DIR=$(dirname $(readlink -f $0))
source ${DIR}/pre.sh

if [[ -z ${dir:-} ]]; then log_err "Must supply path to dataset"; print_usage; exit 1; fi
if [[ $(which yq) == "" ]]; then log_err "yq missing. https://github.com/mikefarah/yq"; exit 1; fi


init
download
upload
configure
