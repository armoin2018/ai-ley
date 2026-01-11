# Test execution
jest                              # Run all tests
jest user.test.js                 # Run specific test file
jest --testPathPattern=user       # Run tests matching pattern
jest --testNamePattern="should add" # Run tests with specific name

# Watch modes
jest --watch                      # Watch mode (git files)
jest --watchAll                   # Watch all files
jest --watch --verbose            # Watch with verbose output

# Coverage reporting
jest --coverage                   # Generate coverage report
jest --coverage --watchAll        # Coverage in watch mode
jest --collectCoverageFrom="src/**/*.js" # Specific coverage files

# Debug and development
jest --verbose                    # Detailed test output
jest --silent                     # Minimal output
jest --no-cache                   # Disable cache
jest --clearCache                 # Clear Jest cache

# Specific test runs
jest --runInBand                  # Run tests serially
jest --maxWorkers=4               # Limit concurrent workers
jest --bail                       # Stop on first failure
jest --passWithNoTests            # Don't fail when no tests found

# Configuration and setup
jest --init                       # Initialize Jest configuration
jest --showConfig                 # Show resolved configuration
jest --listTests                  # List all test files
jest --findRelatedTests file.js   # Find tests related to files

# Snapshot testing
jest --updateSnapshot             # Update snapshots
jest --updateSnapshot --testPathPattern=component # Update specific snapshots

# CI/CD options
jest --ci                         # Optimize for CI environments
jest --forceExit                  # Force Jest to exit
jest --detectOpenHandles          # Detect handles preventing exit