ARGS=("$@")
    for i in "${ ARGS[@]}"; do
        case $i in
            -C=*|--c=*| -config=*|--config=*)
                _args_CONFIG="${i#*=}"
                shift
                ;;
        esac
    done