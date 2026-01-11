---
name: 'Selenium Web Browser Automation Testing Instructions'
description: 'Comprehensive guide for using Selenium WebDriver for automated web testing,'
keywords: [api, (maven), assessment, browser, **avoid, agent, **use, automation, appropriate, build.gradle)]
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

See [example-1](./examples/selenium/example-1.bash)

#### Java Setup

`See [example-2](./examples/selenium/example-2.bash)xml
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
`See [example-3](./examples/selenium/example-3.txt)bash
# Gradle dependency (add to build.gradle)
implementation 'org.seleniumhq.selenium:selenium-java:4.15.0'
implementation 'io.github.bonigarcia:webdrivermanager:5.6.2'
testImplementation 'org.testng:testng:7.8.0'
testImplementation 'org.junit.jupiter:junit-jupiter:5.10.0'
See [example-4](./examples/selenium/example-4.txt)bash
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
See [example-5](./examples/selenium/example-5.txt)bash
# Install via NuGet Package Manager
Install-Package Selenium.WebDriver
Install-Package Selenium.WebDriver.ChromeDriver
Install-Package Selenium.WebDriver.GeckoDriver
Install-Package WebDriverManager
Install-Package NUnit
Install-Package MSTest.TestFramework
See [example-6](./examples/selenium/example-6.txt)python
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
See [example-7](./examples/selenium/example-7.txt)java
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
See [example-8](./examples/selenium/example-8.txt)bash
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
See [example-9](./examples/selenium/example-9.txt)bash
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
See [example-10](./examples/selenium/example-10.txt)python
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
See [example-11](./examples/selenium/example-11.txt)java
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

*Content optimized for conciseness. See source history or external references for full details.*

---
version: 1.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
