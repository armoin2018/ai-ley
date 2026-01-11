---
name: 'Bash.Instructions'
description: 'Development guidelines and best practices for Bash.Instructions'
keywords: [arrays, cleanup, $(...), advanced, bash.instructions, argument, command, comments, avoid, complex]
---



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
    See [example-1](./examples/bash/example-1.bash)

## Function body
- Use descriptive names for functions that convey their purpose.
- Keep functions small and focused on a single task.

## Optimizations
- Use lightest weight subprocess to perform function (eg. cut, sort, uniq, sed, awk)

## Avoid Useless Use of echo
- Instead of using echo with a pipe, directly pass the string to the command.
    See [example-2](./examples/bash/example-2.bash)

## Sourcing Components
- Use source to include external scripts or libraries:
    See [example-3](./examples/bash/example-3.bash)
- Organize reusable functions in separate files for better maintainability.

## Variable Naming
- Use uppercase letters for environment variables and constants:
    See [example-4](./examples/bash/example-4.bash)

- Use lowercase letters for global variables:
    See [example-5](./examples/bash/example-5.bash)

- Use prefix of _ for local variables
    See [example-6](./examples/bash/example-6.bash)

- Use prefix of __ for local variables in nested function calls
    See [example-7](./examples/bash/example-7.bash)

## Use [[ ... ]] or Conditionals
- Prefer [[ ... ]] over [ ... ] for better syntax and fewer pitfalls.
    See [example-8](./examples/bash/example-8.bash)

## Quote Variables
- Always quote variables to prevent word splitting and globbing.
    See [example-9](./examples/bash/example-9.bash)

## Variable Handling
- Set defaults before conditionals rather than using an else when possible

## String Output handling
- Rather than running multiple echo statements run a single echo and use a the line wrap \
- Rather than appending multiple strings to a variable use a the line wrap \ when possible

## Use Arrays for Complex Data
- Use arrays instead of strings for handling lists of items.
    See [example-10](./examples/bash/example-10.bash)

## Avoid Deprecated Syntax
- Replace declare -a with ( for arrays.
    See [example-11](./examples/bash/example-11.bash)

## Use declare for Local Variables in Functions
- Declare variables as local within functions to avoid polluting the global namespace.
    See [example-12](./examples/bash/example-12.bash)
## Avoid Hardcoding Paths
- Use variables of paths and configuration to make the script portable
    See [example-13](./examples/bash/example-13.bash)

- Resolve current paths
    See [example-14](./examples/bash/example-14.bash)

## Sourcing files
- Always make sure to validate files exist prior to using them.
- If files are not available, appropriately log the error
    See [example-15](./examples/bash/example-15.bash)

## Use $(...) for Command Substitution
- Replace backticks (command) with $(command) for better readability and nesting.
    See [example-16](./examples/bash/example-16.bash)

## Utilize case statements
- When it makes sense utilize case statements

## Input argument handling
- When using arguments support prefixing argument with -- or -
- When arguments are set utilize =
- Use a loop to handle multiple arguments
    See [example-17](./examples/bash/example-17.bash)

## Handle Errors Gracefully
- Use set for Better Error Handling by adding "set -euo pipefail" at the top of the script
    See [example-18](./examples/bash/example-18.bash)

- Provide meaningful error messages and exit codes when something goes wrong
    See [example-19](./examples/bash/example-19.bash)
## User Documentation
- help function utilizes a function that parses scripts to extract documentation starting with #~ followed by markdown code.

## Quoting
- Always quote and mustache variables to prevent word splitting and globbing
    See [example-20](./examples/bash/example-20.bash)

## In Code Comments
- Use comments to explain complex logic or decisions:
    See [example-21](./examples/bash/example-21.bash)
## Logging
- Logging should utilize a common log function leading with LEVEL and Message
    See [example-22](./examples/bash/example-22.bash)

## Error Handling
- Implement error handling using 'trap*:
    See [example-23](./examples/bash/example-23.bash)

## Cleanup Temporary Files
- Ensure temporary files are cleaned up in a finally or trap block
    See [example-24](./examples/bash/example-24.bash)
## Use trap for Signal Handling
- Use trap to handle signals like SIGINT or SIGTERM and perform cleanup
    See [example-25](./examples/bash/example-25.bash)

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
