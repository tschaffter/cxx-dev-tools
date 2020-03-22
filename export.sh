# This script should be sourced, not executed.

function realpath_int() {
    wdir="$PWD"; [ "$PWD" = "/" ] && wdir=""
    arg=$1
    case "$arg" in
        /*) scriptdir="${arg}";;
        *) scriptdir="$wdir/${arg#./}";;
    esac
    scriptdir="${scriptdir%/*}"
    echo "$scriptdir"
}


function cxx_dev_tools_export_main() {
    # The file doesn't have executable permissions, so this shouldn't really happen.
    # Doing this in case someone tries to chmod +x it and execute...
    if [[ -n "${BASH_SOURCE}" && ( "${BASH_SOURCE[0]}" == "${0}" ) ]]; then
        echo "This script should be sourced, not executed:"
        echo ". ${BASH_SOURCE[0]}"
        return 1
    fi

    if [[ -z "${CXX_DEV_TOOLS_PATH}" ]]
    then
        # If using bash, try to guess CXX_DEV_TOOLS_PATH from script location
        if [[ -n "${BASH_SOURCE}" ]]
        then
            if [[ "$OSTYPE" == "darwin"* ]]; then
                script_dir="$(realpath_int $BASH_SOURCE)"
            else
                script_name="$(readlink -f $BASH_SOURCE)"
                script_dir="$(dirname $script_name)"
            fi
            export CXX_DEV_TOOLS_PATH="${script_dir}"
        else
            echo "CXX_DEV_TOOLS_PATH must be set before sourcing this script"
            return 1
        fi
    fi

    CXX_DEV_TOOLS_ADD_PATHS_EXTRAS="${CXX_DEV_TOOLS_PATH}/cmake/format"
    CXX_DEV_TOOLS_ADD_PATHS_EXTRAS="${CXX_DEV_TOOLS_ADD_PATHS_EXTRAS}:${CXX_DEV_TOOLS_PATH}/clang/format"
    export PATH="${CXX_DEV_TOOLS_ADD_PATHS_EXTRAS}:${PATH}"

    unset CXX_DEV_TOOLS_ADD_PATHS_EXTRAS
}

cxx_dev_tools_export_main

unset realpath_int
unset cxx_dev_tools_export_main
