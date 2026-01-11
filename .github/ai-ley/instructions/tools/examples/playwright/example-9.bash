# Test execution
npx playwright test                     # Run all tests
npx playwright test login.spec.ts      # Run specific test file
npx playwright test --project=chromium # Run tests in specific browser
npx playwright test --headed           # Run in headed mode (visible browser)
npx playwright test --debug            # Run in debug mode

# Test filtering
npx playwright test --grep="login"     # Run tests matching pattern
npx playwright test --grep-invert="slow" # Skip tests matching pattern
npx playwright test tests/auth/        # Run tests in specific directory

# Browser and device testing
npx playwright test --project="Mobile Chrome"  # Run on mobile
npx playwright test --project="webkit"         # Run on Safari
npx playwright test --browser=all              # Run on all browsers

# Reporting and debugging
npx playwright show-report             # Show HTML report
npx playwright test --reporter=list    # Use list reporter
npx playwright test --trace=on         # Enable tracing
npx playwright test --video=on         # Record videos

# Code generation and inspection
npx playwright codegen https://example.com  # Generate test code
npx playwright inspector               # Open Playwright Inspector
npx playwright trace viewer            # View traces

# Browser management
npx playwright install                 # Install browsers
npx playwright install chromium        # Install specific browser
npx playwright install --with-deps     # Install with system dependencies

# Configuration and setup
npx playwright install-deps            # Install system dependencies
npx playwright check                   # Check installation
npx playwright --version              # Show version