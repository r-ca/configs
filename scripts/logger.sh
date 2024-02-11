#!/bin/bash

# logger

# Env
IS_DEBUG=true
WITH_TIMESTAMP=true
TIMESTAMP_WITH_DATE=false

# Internal functions
function _make_timestamp() {
    if [ "${TIMESTAMP_WITH_DATE}" = "true" ]; then
        echo -e "\e[90m[$(date '+%Y-%m-%d %H:%M:%S')]\e[00m"
    else
        echo -e "\e[90m[$(date '+%H:%M:%S')]\e[00m"
    fi
}

function _make_tag() {
    if [ "$1" = "err_c" ]; then
        echo -e "\e[41m ERROR \e[00m\n"
    elif [ "$1" = "err" ]; then
        echo -e "\e[31m ERROR \e[00m\n"
    elif [ "$1" = "warn" ]; then
        echo -e "\e[33m WARN  \e[00m\n"
    elif [ "$1" = "info" ]; then
        echo -e "\e[34m INFO  \e[00m\n"
    elif [ "$1" = "succ" ]; then
        echo -e "\e[32m SUCC  \e[00m\n"
    elif [ "$1" = "debug" ]; then
        echo -e "\e[90m DEBUG \e[00m\n"
    else
        echo -e "$1\n"
    fi
}

function _make_head() {
    _TEMP_HEAD=""
    if [ "${WITH_TIMESTAMP}" = "true" ]; then
        _TEMP_HEAD="$(_make_timestamp) "
    fi
    if [ "${SCRIPT_PATH}" != "" ]; then
        _TEMP_HEAD="${_TEMP_HEAD}($(basename ${SCRIPT_PATH})) "
    fi
    _TEMP_HEAD="${_TEMP_HEAD}$(_make_tag $1)"

    echo -e "${_TEMP_HEAD}"
}

function _make_log() {
    if [ "${IS_DEBUG}" = "false" ]; then
        return
    fi

    head=$(_make_head $1)
    if [ "${1}" = "debug" ]; then
        echo -e "${head} : \e[90m${2}\e[00m"
    else
        echo -e "${head} : ${2}"
    fi
}

# Public functions

function error() {
    _make_log "err" "$1"
}

function error_c() {
    _make_log "err_c" "$1"
}

function warn() {
    _make_log "warn" "$1"
}

function info() {
    _make_log "info" "$1"
}

function succ() {
    _make_log "succ" "$1"
}

function debug() {
    _make_log "debug" "$1"
}
