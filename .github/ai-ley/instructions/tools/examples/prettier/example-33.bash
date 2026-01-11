# Use cache for repeated runs (experimental)
prettier --write . --cache

# Limit file patterns for better performance
prettier --write "src/**/*.{js,ts,jsx,tsx}"

# Use ignore patterns effectively
prettier --write . --ignore-path .gitignore