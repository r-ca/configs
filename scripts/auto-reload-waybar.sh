#!/bin/bash

# Get script path
SCRIPT_PATH=$(realpath $0)

# Include logger
source ${SCRIPT_PATH%/*}/logger.sh

# Include utils
source ${SCRIPT_PATH%/*}/utils.sh

# Check command
check_command inotifywait

function _parse_error() {
    if [[ "$1" =~ "Bar need to run under Wayland" ]]; then
        error_c "Please run this script under Wayland. (Result: $1)"
        info "Tips: Cannot run this script under VSCode terminal."
        exit 1
    else
        error "Unknown error: $1. (Continue)"
    fi
}

function _reload_waybar() {
    info `killall waybar` # TODO: 結果をチェックする
    result=$(waybar & disown)
    _parse_error "${result}"
}

while true; do
    info "Starting"
    inotifywait -s -e modify ~/.config/waybar/config ~/.config/waybar/style.css &> /dev/null #TODO: チェックする
    info "File modified. Reloading waybar..."
    _reload_waybar
    succ "Waybar reloaded."
done
