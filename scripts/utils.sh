#!/bin/bash

# Get script path
SCRIPT_PATH=$(realpath $0)

# Include logger
source ${SCRIPT_PATH%/*}/logger.sh

# TODO: 動くか確認
function check_command() {
    if ! command -v $1 &> /dev/null; then
        error_c "Command not found: $1. Exiting..."
        exit 1
    fi
}
