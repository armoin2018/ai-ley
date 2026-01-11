if [[ ! -d "${_cache_path}" ]]; then
        log "ERROR" "Cache path does not exist"
        exit 1
    fi