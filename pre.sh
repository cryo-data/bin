
set -o errexit
set -o nounset
set -o pipefail
# set -x

function print_usage() {
  echo ""
  echo "$0 path/to/dataset [-h -d -v]"
  echo "  -h|--help: Print this help"
  echo "  -d|--debug: Print debug messages"
  echo "  -v|--verbose: Be verbose"
  echo ""
}

red='\033[0;31m'; orange='\033[0;33m'; green='\033[0;32m'; nc='\033[0m' # No Color
log_info() { echo -e "${green}[$(date --iso-8601=seconds)] [INFO] ${@}${nc}"; }
log_warn() { echo -e "${orange}[$(date --iso-8601=seconds)] [WARN] ${@}${nc}"; }
log_err() { echo -e "${red}[$(date --iso-8601=seconds)] [ERR] ${@}${nc}" 1>&2; }
debug() { if [[ ${debug:-} == 1 ]]; then log_warn "Debug: $@"; fi; }

trap ctrl_c INT # trap ctrl-c and call ctrl_c()
ctrl_c() {
  log_err "CTRL-C caught"
  log_err "No cleaning..."
  # [[ -d ${dest} ]] && (cd ${dest}; rm *_x.tif)
}

CWD=$(pwd)
log_info "Recording working directory as ${CWD}"

while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -h|--help)
      print_usage; exit 1;;
    -d|--debug)
      debug=1; debug "Activating debug messages..."; shift;;
    -v|--verbose)
      verbose=1; set -o xtrace; shift;;
    *)    # unknown option
      dir+=("$1") # save it in an array for later.
      log_info "Working in ${dir}"
      shift
      ;;
  esac
done


name=$(yq '.cryo_data_name' ${dir}/cryo-data/meta.yaml)
log_info "Extracting name: ${name}"
