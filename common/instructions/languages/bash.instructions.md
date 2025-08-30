# GitHub Copilot Style Guide for Advanced Bash Programming
---
applyTo: "*.sh"
---

## General Guidelines
- Use'#!/bin/bash' at the top of your scripts to specify the interpreter.
- Always use 'set -e to exit immediately if a command exits with a non-zero status.
- Use 'set -u to treat unset variables as an error when substituting.

## Version Management
- Capture version as a global of VERSION
- Help documentation should return the VERSION
- Versions should be formatted as YYYY.MM. DD. BUILD
- Version changes should be logged in the CHANGELOG.md in the root

## Use Functions for Reusability
- Encapsulate logic in functions to improve readability and reusability
    ```bash
    function_name() {
        ...
    }
    ```

## Function body
- Use descriptive names for functions that convey their purpose.
- Keep functions small and focused on a single task.

## Optimizations
- Use lightest weight subprocess to perform function (eg. cut, sort, uniq, sed, awk)

## Avoid Useless Use of echo
- Instead of using echo with a pipe, directly pass the string to the command.
    ```bash
    mycmd "$(_args)" <<< "mycmd2 ${_args2} 2>/dev/null"
    ```

## Sourcing Components
- Use source to include external scripts or libraries:
    ```bash
    source /path/to/script.sh
    ```
- Organize reusable functions in separate files for better maintainability.

## Variable Naming
- Use uppercase letters for environment variables and constants:
    ```bash
    export MY_VARIABLE="value"
    ```

- Use lowercase letters for global variables:
    ```bash
    my_variable="value"
    ```

- Use prefix of _ for local variables
    ```bash
    _my_variable="value"
    ```

- Use prefix of __ for local variables in nested function calls
    ```bash
    __my_variable="value"
    ```

## Use [[ ... ]] or Conditionals
- Prefer [[ ... ]] over [ ... ] for better syntax and fewer pitfalls.
    ```bash
    if [[ -f "${file}" ]]; then
        _file="$(_path)/$(file}.sh"
    else
        log "ERROR" "File not found: ${file}"
        exit 1
    fi
    ```

## Quote Variables
- Always quote variables to prevent word splitting and globbing.
    ```bash
    source "${__mega _WD}/arguments.sh"
    ```

## Variable Handling
- Set defaults before conditionals rather than using an else when possible

## String Output handling
- Rather than running multiple echo statements run a single echo and use a the line wrap \
- Rather than appending multiple strings to a variable use a the line wrap \ when possible

## Use Arrays for Complex Data
- Use arrays instead of strings for handling lists of items.
    ```bash
    _Formatters=($(grep -Ei "#Format:" "$_verbFile)" | sed -re "s/#Format://g" | sed -re "s,/ /g"))
    ```

## Avoid Deprecated Syntax
- Replace declare -a with ( for arrays.
    ```bash
    _tmpFormatters=($(grep -Ei "##Format:" "${__actionFile)" | sed -re "s/##Format://g" | sed -re "s/,/ /g"))
    ```

## Use declare for Local Variables in Functions
- Declare variables as local within functions to avoid polluting the global namespace.
    ```bash
    init() {
        local_envFile
        1og "INFO" "Running Default init"
    }
    ```
## Avoid Hardcoding Paths
- Use variables of paths and configuration to make the script portable
    ```bash
    source "${_mega_WD}/../etc/mega_config.sh"
    ```

- Resolve current paths
    ```bash
        THIS=$(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null || echo "$0")
        _common_WD=$(dirname "${THIS}")
    ```

## Sourcing files
- Always make sure to validate files exist prior to using them.
- If files are not available, appropriately log the error
    ```bash
    if [[ -f "${_envFile}" ]]; then
        source "$(_envFile)"
    else
        log "ERROR" "Unable to find environment file: $_envFile"
        exit 1
    fi
    ```

## Use $(...) for Command Substitution
- Replace backticks (command) with $(command) for better readability and nesting.
    ```bash
    THIS=$(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null || echo "$0")
    ```

## Utilize case statements
- When it makes sense utilize case statements

## Input argument handling
- When using arguments support prefixing argument with -- or -
- When arguments are set utilize =
- Use a loop to handle multiple arguments
    ```bash
    ARGS=("$@")
    for i in "${ ARGS[@]}"; do
        case $i in
            -C=*|--c=*| -config=*|--config=*)
                _args_CONFIG="${i#*=}"
                shift
                ;;
        esac
    done
    ```

## Handle Errors Gracefully
- Use set for Better Error Handling by adding "set -euo pipefail" at the top of the script
    ```bash
    set -euo pipefail
    ```

- Provide meaningful error messages and exit codes when something goes wrong
    ```bash
    if [[ ! -d "${_cache_path}" ]]; then
        log "ERROR" "Cache path does not exist"
        exit 1
    fi
    ```
## User Documentation
- help function utilizes a function that parses scripts to extract documentation starting with #~ followed by markdown code.

## Quoting
- Always quote and mustache variables to prevent word splitting and globbing
    ```bash
    echo "${my_variable}"
    ```

## In Code Comments
- Use comments to explain complex logic or decisions:
    ```bash
    # This function calculates the sum of two numbers
    add_numbers () {
        ...
    }
    ...
    ```
## Logging
- Logging should utilize a common log function leading with LEVEL and Message
    ```bash
    log () {
    _logging_Type="${1^^}"
    _logging_Message="$(2}"
    ```

## Error Handling
- Implement error handling using 'trap*:
    ```bash
    trap 'echo "An error occurred"; exit 1' ERR
    ```

## Cleanup Temporary Files
- Ensure temporary files are cleaned up in a finally or trap block
    ```bash
    finally() {
    log "INFO" "Cleaning up"
    rm -f "${_project_tmpfiles}"
    }
    ```
## Use trap for Signal Handling
- Use trap to handle signals like SIGINT or SIGTERM and perform cleanup
    ```bash
    trap finally EXIT
    ```