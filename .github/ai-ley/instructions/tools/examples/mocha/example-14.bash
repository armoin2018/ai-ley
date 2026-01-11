# Essential daily commands
npx mocha                              # Run all tests
npx mocha test/unit/**/*.test.js       # Run specific test directory
npx mocha --grep "user creation"       # Run tests matching pattern
npx mocha --watch                      # Watch mode for development

# Test filtering and selection
npx mocha --grep @smoke                # Run tests with @smoke tag
npx mocha --invert --grep @slow        # Skip tests with @slow tag
npx mocha test/integration/*.test.js   # Run specific test files
npx mocha --bail                       # Stop on first failure

# Reporting and output
npx mocha --reporter json              # JSON output
npx mocha --reporter html              # HTML report
npx mocha --reporter tap               # TAP format
npx mocha --reporter spec              # Spec format (default)
npx mocha --reporter min               # Minimal output

# Debug and development
npx mocha --inspect-brk                # Debug with Chrome DevTools
npx mocha --timeout 10000              # Set timeout (10 seconds)
npx mocha --slow 1000                  # Mark tests as slow above 1s
npx mocha --recursive                  # Run tests recursively

# Coverage and analysis
npx nyc mocha                          # Run with coverage
npx nyc --reporter=html mocha          # HTML coverage report
npx nyc --reporter=lcov mocha          # LCOV coverage report

# Configuration and setup
npx mocha --opts mocha.opts            # Use options file
npx mocha --config .mocharc.json       # Use JSON config
npx mocha --require test/setup.js      # Require setup file