if [[ -f "${file}" ]]; then
        _file="$(_path)/$(file}.sh"
    else
        log "ERROR" "File not found: ${file}"
        exit 1
    fi