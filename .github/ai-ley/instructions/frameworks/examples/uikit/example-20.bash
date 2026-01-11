# Compile Less to CSS
lessc src/styles.less dist/styles.css

# Compile with source maps
lessc src/styles.less dist/styles.css --source-map

# Minify CSS
lessc src/styles.less dist/styles.css --compress

# Watch Less files
lessc src/styles.less dist/styles.css --watch