if [[ -f "${_envFile}" ]]; then
        source "$(_envFile)"
    else
        log "ERROR" "Unable to find environment file: $_envFile"
        exit 1
    fi