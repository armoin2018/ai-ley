---
title: 'Selenium Web Browser Automation Testing Instructions'
description: 'Comprehensive guide for using Selenium WebDriver for automated web testing, browser automation, and end-to-end testing across multiple browsers'
category: 'Testing Tools'

tags:
  [
    'selenium',
    'webdriver',
    'browser-automation',
    'e2e-testing',
    'cross-browser',
    'web-testing',
    'automation',
  ]
version: '1.0'
last_updated: '2025-08-14'
applyTo:
  - '**/selenium/**'
  - '**/test/**/*selenium*'
  - '**/tests/**/*selenium*'
  - '**/e2e/**'
  - '**/*webdriver*'
  - '**/selenium.config.*'
---

# Selenium Web Browser Automation Testing Instructions

## Tool Overview

- **Tool Name**: Selenium WebDriver
- **Version**: 4.15+ (Latest stable with Selenium 4 features and improved performance)
- **Category**: Testing Tools - Browser Automation
- **Purpose**: Automates web browsers for testing web applications, UI validation, and end-to-end workflows
- **Prerequisites**: Programming language runtime (Java, Python, Node.js, C#), browser drivers, web application to test

## When to Use Selenium

### ✅ **Use Selenium When**

- Need cross-browser testing across Chrome, Firefox, Safari, Edge, and other browsers
- Performing end-to-end testing of complex web application workflows
- Testing legacy web applications that require comprehensive browser compatibility
- Need fine-grained control over browser behavior and interactions
- Integrating with existing test frameworks and CI/CD pipelines
- Testing web applications with complex JavaScript interactions and dynamic content
- Requiring screenshot and visual testing capabilities
- Need to test on multiple operating systems and browser versions
- Working with custom browser configurations and extensions

### ❌ **Avoid Selenium When**

- Testing simple static websites with minimal interaction
- Need fastest possible test execution (consider Playwright or Cypress)
- Working with mobile-first applications (consider Appium)
- Team lacks experience with browser automation complexity
- Testing non-web applications or APIs only
- Budget/time constraints don't allow for cross-browser testing setup
- Need simpler test authoring for non-technical team members

## AI Agent Decision Matrix

### Project Type Assessment

| Project Type           | Selenium Recommendation                        | Configuration Priority          |
| ---------------------- | ---------------------------------------------- | ------------------------------- |
| Enterprise Web App     | ✅ **Essential** - Cross-browser compliance    | High - Multi-browser + grid     |
| E-commerce Platform    | ✅ **Essential** - Critical user flows         | High - Payment + checkout flows |
| Legacy Web Application | ✅ **Essential** - Compatibility testing       | High - Older browser support    |
| SaaS Dashboard         | ✅ **Recommended** - Complex UI testing        | Medium - Major browser coverage |
| Marketing Website      | 🔄 **Consider** - Basic functionality testing  | Low - Chrome + Firefox only     |
| Internal Tool          | 🔄 **Consider** - Limited browser requirements | Low - Single browser focus      |

### Complexity Assessment

| Factor               | Low Complexity           | Medium Complexity     | High Complexity           |
| -------------------- | ------------------------ | --------------------- | ------------------------- |
| **Setup Time**       | 2 hours (single browser) | 1 day (multi-browser) | 1 week (grid + CI/CD)     |
| **Browser Coverage** | Chrome only              | Chrome + Firefox      | All major browsers        |
| **Test Environment** | Local development        | Staging + production  | Multiple environments     |
| **Integration**      | Standalone tests         | CI/CD integration     | Grid + parallel execution |

## Installation & Setup

### WebDriver Installation

#### Python Setup

```bash
# Install Selenium WebDriver
pip install selenium

# Install WebDriver Manager for automatic driver management
pip install webdriver-manager

# Verify installation
python -c "import selenium; print(selenium.__version__)"

# Install additional testing frameworks
pip install pytest pytest-html pytest-xdist  # For parallel testing
pip install allure-pytest                     # For reporting
```

#### Java Setup

````bash
# Maven dependency (add to pom.xml)
```xml
<dependency>
    <groupId>org.seleniumhq.selenium</groupId>
    <artifactId>selenium-java</artifactId>
    <version>4.15.0</version>
</dependency>
<dependency>
    <groupId>io.github.bonigarcia</groupId>
    <artifactId>webdrivermanager</artifactId>
    <version>5.6.2</version>
</dependency>
````

```bash
# Gradle dependency (add to build.gradle)
implementation 'org.seleniumhq.selenium:selenium-java:4.15.0'
implementation 'io.github.bonigarcia:webdrivermanager:5.6.2'
testImplementation 'org.testng:testng:7.8.0'
testImplementation 'org.junit.jupiter:junit-jupiter:5.10.0'
```

#### Node.js Setup

```bash
# Install Selenium WebDriver
npm install selenium-webdriver

# Install WebDriver Manager
npm install @wdio/cli @wdio/local-runner

# Install testing frameworks
npm install mocha chai                    # Mocha + Chai
npm install jest                         # Jest
npm install @wdio/mocha-framework        # WebDriverIO

# Verify installation
node -e "console.log(require('selenium-webdriver/package.json').version)"
```

#### C# Setup

```bash
# Install via NuGet Package Manager
Install-Package Selenium.WebDriver
Install-Package Selenium.WebDriver.ChromeDriver
Install-Package Selenium.WebDriver.GeckoDriver
Install-Package WebDriverManager
Install-Package NUnit
Install-Package MSTest.TestFramework
```

### Browser Driver Setup

#### Automatic Driver Management (Recommended)

```python
# Python with WebDriver Manager
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from webdriver_manager.firefox import GeckoDriverManager
from webdriver_manager.microsoft import EdgeChromiumDriverManager

# Chrome
driver = webdriver.Chrome(ChromeDriverManager().install())

# Firefox
driver = webdriver.Firefox(executable_path=GeckoDriverManager().install())

# Edge
driver = webdriver.Edge(EdgeChromiumDriverManager().install())
```

```java
// Java with WebDriverManager
import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

// Chrome
WebDriverManager.chromedriver().setup();
WebDriver driver = new ChromeDriver();

// Firefox
WebDriverManager.firefoxdriver().setup();
WebDriver driver = new FirefoxDriver();
```

#### Manual Driver Installation

```bash
# Download and install drivers manually

# Chrome Driver
wget https://chromedriver.storage.googleapis.com/LATEST_RELEASE
# Download appropriate version for your Chrome browser

# Firefox GeckoDriver
wget https://github.com/mozilla/geckodriver/releases/latest

# Edge Driver
wget https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/

# Add drivers to PATH
export PATH=$PATH:/usr/local/bin/chromedriver
export PATH=$PATH:/usr/local/bin/geckodriver
export PATH=$PATH:/usr/local/bin/msedgedriver
```

### Project Integration

```bash
# Create Selenium test project structure
mkdir selenium-tests
cd selenium-tests

# Python project structure
mkdir -p tests/{unit,integration,e2e}
mkdir -p pages
mkdir -p utils
mkdir -p reports
mkdir -p config

# Create virtual environment
python -m venv selenium-env
source selenium-env/bin/activate  # Linux/Mac
# selenium-env\Scripts\activate   # Windows

# Install dependencies
pip install -r requirements.txt

# Java project structure (Maven)
mvn archetype:generate -DgroupId=com.example.selenium \
                       -DartifactId=selenium-tests \
                       -DarchetypeArtifactId=maven-archetype-quickstart

# Node.js project structure
npm init -y
mkdir -p test/{pages,specs,utils}
mkdir -p config
```

## Configuration

### WebDriver Configuration

#### Python Configuration

```python
# config/webdriver_config.py
from selenium import webdriver
from selenium.webdriver.chrome.options import Options as ChromeOptions
from selenium.webdriver.firefox.options import Options as FirefoxOptions
from selenium.webdriver.edge.options import Options as EdgeOptions
from webdriver_manager.chrome import ChromeDriverManager
from webdriver_manager.firefox import GeckoDriverManager
from webdriver_manager.microsoft import EdgeChromiumDriverManager
import os

class WebDriverConfig:
    def __init__(self):
        self.browser = os.getenv('BROWSER', 'chrome').lower()
        self.headless = os.getenv('HEADLESS', 'false').lower() == 'true'
        self.window_size = os.getenv('WINDOW_SIZE', '1920,1080')
        self.implicit_wait = int(os.getenv('IMPLICIT_WAIT', '10'))
        self.page_load_timeout = int(os.getenv('PAGE_LOAD_TIMEOUT', '30'))

    def get_driver(self):
        if self.browser == 'chrome':
            return self._get_chrome_driver()
        elif self.browser == 'firefox':
            return self._get_firefox_driver()
        elif self.browser == 'edge':
            return self._get_edge_driver()
        else:
            raise ValueError(f"Unsupported browser: {self.browser}")

    def _get_chrome_driver(self):
        options = ChromeOptions()

        if self.headless:
            options.add_argument('--headless')

        options.add_argument(f'--window-size={self.window_size}')
        options.add_argument('--no-sandbox')
        options.add_argument('--disable-dev-shm-usage')
        options.add_argument('--disable-gpu')
        options.add_argument('--disable-extensions')
        options.add_argument('--disable-infobars')
        options.add_argument('--disable-notifications')

        driver = webdriver.Chrome(
            ChromeDriverManager().install(),
            options=options
        )

        driver.implicitly_wait(self.implicit_wait)
        driver.set_page_load_timeout(self.page_load_timeout)
        return driver

    def _get_firefox_driver(self):
        options = FirefoxOptions()

        if self.headless:
            options.add_argument('--headless')

        options.add_argument(f'--width={self.window_size.split(",")[0]}')
        options.add_argument(f'--height={self.window_size.split(",")[1]}')

        driver = webdriver.Firefox(
            executable_path=GeckoDriverManager().install(),
            options=options
        )

        driver.implicitly_wait(self.implicit_wait)
        driver.set_page_load_timeout(self.page_load_timeout)
        return driver
```

#### Java Configuration

```java
// src/main/java/config/WebDriverConfig.java
package config;

import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.edge.EdgeOptions;

import java.time.Duration;
import java.util.concurrent.TimeUnit;

public class WebDriverConfig {
    private static final String BROWSER = System.getProperty("browser", "chrome");
    private static final boolean HEADLESS = Boolean.parseBoolean(System.getProperty("headless", "false"));
    private static final int IMPLICIT_WAIT = Integer.parseInt(System.getProperty("implicit.wait", "10"));
    private static final int PAGE_LOAD_TIMEOUT = Integer.parseInt(System.getProperty("page.load.timeout", "30"));

    public static WebDriver getDriver() {
        WebDriver driver;

        switch (BROWSER.toLowerCase()) {
            case "chrome":
                driver = getChromeDriver();
                break;
            case "firefox":
                driver = getFirefoxDriver();
                break;
            case "edge":
                driver = getEdgeDriver();
                break;
            default:
                throw new IllegalArgumentException("Unsupported browser: " + BROWSER);
        }

        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(IMPLICIT_WAIT));
        driver.manage().timeouts().pageLoadTimeout(Duration.ofSeconds(PAGE_LOAD_TIMEOUT));
        driver.manage().window().maximize();

        return driver;
    }

    private static WebDriver getChromeDriver() {
        WebDriverManager.chromedriver().setup();
        ChromeOptions options = new ChromeOptions();

        if (HEADLESS) {
            options.addArguments("--headless");
        }

        options.addArguments("--no-sandbox");
        options.addArguments("--disable-dev-shm-usage");
        options.addArguments("--disable-gpu");
        options.addArguments("--window-size=1920,1080");

        return new ChromeDriver(options);
    }

    private static WebDriver getFirefoxDriver() {
        WebDriverManager.firefoxdriver().setup();
        FirefoxOptions options = new FirefoxOptions();

        if (HEADLESS) {
            options.addArguments("--headless");
        }

        return new FirefoxDriver(options);
    }
}
```

#### Environment Configuration

```bash
# .env file for test configuration
BROWSER=chrome
HEADLESS=false
WINDOW_SIZE=1920,1080
IMPLICIT_WAIT=10
PAGE_LOAD_TIMEOUT=30
EXPLICIT_WAIT=20

# Test environment URLs
BASE_URL=https://example.com
STAGING_URL=https://staging.example.com
PRODUCTION_URL=https://production.example.com

# Test data
TEST_USERNAME=testuser@example.com
TEST_PASSWORD=testpassword123

# Selenium Grid (if using)
SELENIUM_HUB_URL=http://localhost:4444/wd/hub
SELENIUM_GRID=false

# Reporting
ALLURE_RESULTS_DIR=allure-results
SCREENSHOT_DIR=screenshots
VIDEO_RECORDING=false
```

### Test Framework Configuration

#### pytest Configuration (Python)

```ini
# pytest.ini
[tool:pytest]
testpaths = tests
python_files = test_*.py *_test.py
python_classes = Test* *Test
python_functions = test_*
addopts =
    --strict-markers
    --disable-warnings
    --html=reports/report.html
    --self-contained-html
    --junitxml=reports/junit.xml
    --maxfail=5
    --tb=short
    -v
markers =
    smoke: marks tests as smoke tests
    regression: marks tests as regression tests
    slow: marks tests as slow running
    api: marks tests as API tests
    ui: marks tests as UI tests
    critical: marks tests as critical path
```

#### TestNG Configuration (Java)

```xml
<!-- testng.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<suite name="SeleniumTestSuite" parallel="methods" thread-count="3">
    <listeners>
        <listener class-name="utils.TestListener"/>
        <listener class-name="utils.ScreenshotListener"/>
    </listeners>

    <test name="SmokeTests">
        <groups>
            <run>
                <include name="smoke"/>
            </run>
        </groups>
        <classes>
            <class name="tests.LoginTest"/>
            <class name="tests.NavigationTest"/>
        </classes>
    </test>

    <test name="RegressionTests">
        <groups>
            <run>
                <include name="regression"/>
            </run>
        </groups>
        <packages>
            <package name="tests.*"/>
        </packages>
    </test>
</suite>
```

## Core Features

### Element Location and Interaction

- **Purpose**: Find and interact with web elements using various locator strategies
- **Usage**: Foundation for all web automation and testing actions
- **Example**:

```python
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

driver = webdriver.Chrome()
wait = WebDriverWait(driver, 10)

# Various locator strategies
element_by_id = driver.find_element(By.ID, "username")
element_by_class = driver.find_element(By.CLASS_NAME, "login-button")
element_by_xpath = driver.find_element(By.XPATH, "//input[@type='password']")
element_by_css = driver.find_element(By.CSS_SELECTOR, "button.submit")

# Wait for element to be clickable
clickable_element = wait.until(
    EC.element_to_be_clickable((By.ID, "submit-button"))
)

# Interact with elements
element_by_id.send_keys("testuser")
clickable_element.click()
```

### Browser Navigation and Control

- **Purpose**: Control browser navigation, windows, and tabs
- **Usage**: Essential for multi-page testing workflows and window management
- **Example**:

```python
# Navigation
driver.get("https://example.com")
driver.back()
driver.forward()
driver.refresh()

# Window and tab management
original_window = driver.current_window_handle
driver.execute_script("window.open('https://example.com/new-page')")

# Switch to new window
for window_handle in driver.window_handles:
    if window_handle != original_window:
        driver.switch_to.window(window_handle)
        break

# Work in new window
driver.find_element(By.ID, "new-page-element").click()

# Close new window and switch back
driver.close()
driver.switch_to.window(original_window)

# Handle alerts
alert = driver.switch_to.alert
alert_text = alert.text
alert.accept()  # or alert.dismiss()
```

### Wait Strategies and Synchronization

- **Purpose**: Handle dynamic content and asynchronous operations
- **Usage**: Critical for reliable test execution with modern web applications
- **Example**:

```python
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException

# Explicit waits (recommended)
wait = WebDriverWait(driver, 10)

# Wait for element to be present
element = wait.until(
    EC.presence_of_element_located((By.ID, "dynamic-content"))
)

# Wait for element to be clickable
button = wait.until(
    EC.element_to_be_clickable((By.CLASS_NAME, "action-button"))
)

# Wait for text to be present
wait.until(
    EC.text_to_be_present_in_element((By.ID, "status"), "Complete")
)

# Wait for page title
wait.until(EC.title_contains("Dashboard"))

# Custom wait condition
def element_has_attribute(locator, attribute):
    def _predicate(driver):
        element = driver.find_element(*locator)
        return element.get_attribute(attribute) is not None
    return _predicate

wait.until(element_has_attribute((By.ID, "result"), "data-loaded"))
```

### Screenshot and Visual Testing

- **Purpose**: Capture screenshots for debugging and visual validation
- **Usage**: Essential for test reporting and visual regression testing
- **Example**:

```python
import os
from datetime import datetime

# Full page screenshot
screenshot_dir = "screenshots"
os.makedirs(screenshot_dir, exist_ok=True)

timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
screenshot_path = f"{screenshot_dir}/test_{timestamp}.png"
driver.save_screenshot(screenshot_path)

# Element screenshot (Selenium 4+)
element = driver.find_element(By.ID, "important-section")
element.screenshot(f"{screenshot_dir}/element_{timestamp}.png")

# Screenshot on test failure
def take_screenshot_on_failure(driver, test_name):
    try:
        screenshot_path = f"screenshots/failed_{test_name}_{timestamp}.png"
        driver.save_screenshot(screenshot_path)
        print(f"Screenshot saved: {screenshot_path}")
    except Exception as e:
        print(f"Failed to take screenshot: {e}")

# Visual comparison (with additional library)
from PIL import Image, ImageChops

def compare_screenshots(baseline_path, current_path, diff_path):
    baseline = Image.open(baseline_path)
    current = Image.open(current_path)

    diff = ImageChops.difference(baseline, current)
    diff.save(diff_path)

    # Calculate difference percentage
    histogram = diff.histogram()
    return sum(histogram) / (baseline.width * baseline.height)
```

## Common Commands

```bash
# Essential daily commands
python -m pytest tests/ -v                    # Run all tests
python -m pytest tests/test_login.py -k smoke # Run specific test type
python -m pytest --browser=chrome --headless  # Run in headless mode
python -m pytest --html=report.html           # Generate HTML report

# Java Maven commands
mvn test                                       # Run all tests
mvn test -Dbrowser=firefox                    # Run with specific browser
mvn test -Dgroups=smoke                       # Run test groups
mvn test -DsuiteXmlFile=testng.xml            # Run specific suite

# Node.js commands
npm test                                       # Run tests
npx wdio run wdio.conf.js                    # WebDriverIO
npx mocha test/**/*.js                        # Mocha tests

# Debug and analysis
python -m pytest --pdb                        # Debug with PDB
python -m pytest --capture=no                 # Show print statements
python -m pytest --lf                         # Run last failed tests
python -m pytest --maxfail=1                 # Stop on first failure

# Parallel execution
python -m pytest -n 4                         # Run with 4 workers
mvn test -Dparallel=methods -DthreadCount=3   # Java parallel execution

# Selenium Grid
java -jar selenium-server-4.15.0.jar hub     # Start hub
java -jar selenium-server-4.15.0.jar node    # Start node
```

## Workflow Integration

### Development Workflow

1. **Setup**: [Initial setup steps]
2. **Development**: [How to use during development]
3. **Testing**: [Integration with testing process]
4. **Pre-commit**: [Pre-commit hooks or checks]
5. **CI/CD**: [Continuous integration usage]

### Automation Scripts

```bash
# Package.json scripts (if applicable)
{
  "scripts": {
    "[script-name]": "[tool] [command]",
    "[workflow-script]": "[tool] [workflow-command]"
  }
}
```

### Git Hooks Integration

```bash
# Pre-commit hook example
#!/bin/sh
[tool] [validation-command]
```

## Best Practices

### Configuration Best Practices

- [Best practice 1 with explanation]
- [Best practice 2 with explanation]
- [Best practice 3 with explanation]

### Usage Patterns

- [Pattern 1: When and how to use]
- [Pattern 2: When and how to use]
- [Pattern 3: When and how to use]

### Performance Optimization

- [Optimization tip 1]
- [Optimization tip 2]
- [Optimization tip 3]

## Common Use Cases

### [Use Case 1]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

### [Use Case 2]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

### [Use Case 3]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

## Integration with Other Tools

### [Related Tool 1]

- **Integration Purpose**: [Why integrate]
- **Setup**: [How to configure integration]
- **Usage**: [How they work together]

### [Related Tool 2]

- **Integration Purpose**: [Why integrate]
- **Setup**: [How to configure integration]
- **Usage**: [How they work together]

## Troubleshooting

### Common Issues

#### [Issue 1]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

#### [Issue 2]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

#### [Issue 3]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

### Debug Mode

```bash
# Enable verbose/debug output
[tool] --verbose [command]
[tool] --debug [command]

# Log analysis
[tool] logs
[tool] status --detailed
```

### Performance Issues

- [Performance issue 1 and solution]
- [Performance issue 2 and solution]
- [Performance issue 3 and solution]

## Security Considerations

### Security Best Practices

- [Security practice 1]
- [Security practice 2]
- [Security practice 3]

### Sensitive Data Handling

- [How the tool handles secrets]
- [Configuration for secure usage]
- [Best practices for credentials]

### Network Security

- [Network-related security considerations]
- [Proxy and firewall configurations]
- [Certificate and SSL handling]

## Advanced Configuration

### Custom Plugins/Extensions

```[config-format]
# Plugin configuration
[plugin-config-example]
```

### Scripting and Automation

```bash
# Advanced scripting examples
[automation-script-example]
```

### Performance Tuning

```[config-format]
# Performance optimization settings
[performance-config-example]
```

## Version Management

### Version Compatibility

- **Tool Version**: [Version requirements]
- **Node.js**: [If applicable]
- **Python**: [If applicable]
- **OS Support**: [Supported operating systems]

### Migration Guides

- **From [Old Version]**: [Migration steps]
- **Breaking Changes**: [Important changes to note]
- **Deprecation Notices**: [Features being deprecated]

## Useful Resources

- **Official Documentation**: [URL]
- **GitHub Repository**: [URL]
- **Community Resources**: [URLs]
- **Tutorials**: [URLs]
- **Plugin/Extension Registry**: [URL]
- **Stack Overflow Tag**: [Tag name]

## Tool-Specific Guidelines

### Code Organization

- [How the tool affects code structure]
- [File organization recommendations]
- [Naming conventions]

### Maintenance

- [Regular maintenance tasks]
- [Update procedures]
- [Cleanup and optimization]

## Examples and Templates

### Basic Example

```[language]
// Example usage in context
[practical-example]
```

### Advanced Example

```[language]
// Advanced usage pattern
[advanced-example]
```

### Template Files

```[format]
# Template configuration
[template-example]
```

## AI Assistant Guidelines

When helping with [Tool Name]:

1. **Always suggest the most current stable version**
2. **Provide working configuration examples**
3. **Include error handling in scripts**
4. **Mention security implications when relevant**
5. **Suggest integration with development workflow**
6. **Provide troubleshooting steps for common issues**
7. **Include performance considerations**
8. **Reference official documentation**

### Code Generation Rules

- Generate configurations that follow tool best practices
- Include comments explaining important settings
- Provide multiple options when appropriate
- Include validation and error checking
- Follow the project's existing patterns and conventions
