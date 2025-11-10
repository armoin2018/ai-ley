---
agentMode: general
applyTo: general
author: AI-LEY
description: Establish comprehensive test environment with unit tests, profiling, health checks, and regression testing. Supports CLI and API execution with synthetic transactions and timeouts.
extensions:
  - .md
  - .py
  - .js
  - .ts
  - .go
  - .java
guidelines: Follow AI-LEY project standards and language-specific testing best practices
instructionType: general
keywords:
  [
    testing,
    unit-tests,
    health-checks,
    regression,
    profiling,
    synthetic-transactions,
    test-api,
    timeouts,
    coverage,
  ]
lastUpdated: '2025-11-10T00:00:00.000000'
summaryScore: 5.0
title: Build Unit Tests
version: 1.0.0
---

# Copilot Command: Build Unit Tests

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

- See the `.ai-ley/shared/global-instructions.md` file for global instructions that apply to all commands.
- **CRITICAL**: Follow all testing requirements from `.ai-ley/shared/global-instructions.md` including:
  - Unit test coverage requirements (≥80%)
  - Integration test standards and CRUD validation
  - Test organization and documentation requirements
  - Arrange-Act-Assert (AAA) pattern for test structure
  - Cleanup, rollback, and transaction handling requirements
- Reference applicable personas in `{{folders.personas}}` and instructions in `{{folders.instructions}}` as needed.
- Reference testing frameworks from `.ai-ley/shared/indexes/tech-stack.md`
- In the event of conflicting information utilize the `.ai-ley/shared/conflict-resolution.md` guidelines.

## Goal

Given:

- Project structure and technology stack from `{{files.plan}}`, lockfiles, or build files
- Existing code and components to be tested
- Optional mode parameter: `plan` (analyze only), `apply` (default - generate tests), or `dry-run` (preview)

Produce:

- Comprehensive test environment with idiomatic tooling for detected language/stack
- Unit tests following **Arrange-Act-Assert (AAA)** pattern with ≥80% code coverage
- Integration tests with CRUD validation, realistic scenarios, and proper cleanup
- Regression tests, health checks, and synthetic transaction tests
- **Test organization** following `{{folders.tests}}` structure with version tracking
- Test Control API with OpenAPI specification
- CLI commands for running all test suites
- Coverage collection with quality thresholds (≥80% as per global-instructions.md)
- Test dashboard under `.project/dashboard/tests/`
- CI/CD integration with caching and parallelization
- Timeouts, retries, and watchdog mechanisms for reliability
- Transaction-based database tests with rollback support
- Security vulnerability testing and performance benchmarks
- Non-destructive generation with `-generated` suffix for new files
- Complete documentation in `{{folders.tests}}/README.md` as per `{{files.tests}}`

## Command

You are an expert test automation engineer, quality assurance architect, and DevOps specialist with deep expertise in testing frameworks, CI/CD pipelines, performance profiling, and reliability engineering across multiple programming languages.

### Step 1: Environment Detection and Analysis

**Parse command parameters**:

- Extract `mode` parameter: `plan`, `apply` (default), or `dry-run`
- Determine scope: full project or specific components

**Detect primary technology stack**:

1. **Check `.project/PLAN.md`** for technology decisions
2. **Scan for lockfiles and build files**:

   - Python: `requirements.txt`, `pyproject.toml`, `Pipfile`, `poetry.lock`
   - Node.js: `package.json`, `package-lock.json`, `yarn.lock`, `pnpm-lock.yaml`
   - Go: `go.mod`, `go.sum`
   - Java: `pom.xml`, `build.gradle`, `build.gradle.kts`
   - Ruby: `Gemfile`, `Gemfile.lock`
   - .NET: `*.csproj`, `*.sln`
   - Rust: `Cargo.toml`, `Cargo.lock`

3. **Identify existing test infrastructure**:

   - Check for existing `tests/`, `test/`, `__tests__/` directories
   - Identify current test framework if present
   - Detect coverage tools already configured

4. **Analyze project structure**:
   - Map source code directories (`src/`, `lib/`, `app/`, etc.)
   - Identify components requiring tests (services, utilities, APIs, models)
   - Determine integration points (databases, APIs, queues, caches)

**Select idiomatic testing tools by language**:

**Python**:

- Test framework: `pytest` (with plugins)
- Plugins: `pytest-timeout`, `pytest-xdist` (parallel), `pytest-rerunfailures`, `pytest-cov`
- Coverage: `coverage.py` or `pytest-cov`
- Profiling: `pyinstrument`, `cProfile`, `py-spy`
- Mocking: `unittest.mock`, `pytest-mock`

**Node.js / TypeScript**:

- Test framework: `vitest` (modern, fast) or `jest`
- TypeScript support: `ts-node`, `ts-jest` (if jest), or vitest native TS support
- Coverage: Built-in (Vitest/Jest)
- Profiling: `node --prof`, `clinic`, `0x` (flamegraphs)
- Mocking: `vitest` mocks or `jest` mocks

**Go**:

- Test framework: Built-in `go test`
- Timeout: `-timeout` flag
- Coverage: `go test -cover`, `go tool cover`
- Profiling: `pprof` (CPU, memory, blocking)
- Benchmarking: `go test -bench`
- Mocking: `gomock`, `testify/mock`

**Java**:

- Test framework: JUnit 5 (Jupiter)
- Build integration: Maven Surefire / Gradle Test
- Benchmarking: JMH (Java Microbenchmark Harness)
- Coverage: JaCoCo
- Profiling: JFR (Java Flight Recorder), async-profiler
- Mocking: Mockito, PowerMock

**Ruby**:

- Test framework: RSpec or Minitest
- Coverage: SimpleCov
- Profiling: ruby-prof, stackprof
- Mocking: RSpec mocks or Mocha

**.NET / C#**:

- Test framework: xUnit, NUnit, or MSTest
- Coverage: coverlet, dotCover
- Profiling: dotTrace, PerfView
- Mocking: Moq, NSubstitute

**Rust**:

- Test framework: Built-in `cargo test`
- Coverage: `cargo-tarpaulin`, `grcov`
- Benchmarking: Criterion.rs
- Profiling: `cargo flamegraph`, perf

### Step 2: Test Structure Planning

**Define test directory structure** (per `{{folders.tests}}` from global-instructions.md):

```
{{folders.tests}}/
├── README.md                  # Documentation: commands, structure, timeouts
├── conftest.py               # Pytest fixtures (Python)
├── setup.ts                  # Test setup (TypeScript)
├── coverage-policy.md        # Coverage thresholds (≥80% per global-instructions.md)
├── waivers.yaml             # Temporary coverage waivers with expiry
├── registry.yaml            # Component → test mapping with version tracking
├── unit/                    # Unit tests (fast, isolated, AAA pattern)
│   ├── services/
│   ├── utilities/
│   ├── models/
│   └── controllers/
├── integration/             # Integration tests (DB, API, external services)
│   ├── database/           # CRUD tests with transaction rollback
│   ├── api/
│   └── messaging/
├── regression/              # Regression tests with golden files
│   └── golden/             # Expected outputs for comparison
├── health/                  # Health check tests
│   ├── service-health.test.*
│   ├── database-health.test.*
│   └── cache-health.test.*
├── synthetic/               # End-to-end synthetic transactions
│   ├── journeys/
│   └── fixtures/
├── performance/             # Performance and security tests
│   ├── benchmarks/
│   └── security/
└── fixtures/                # Shared test data and mocks
    ├── data/
    └── mocks/
```

**Test organization principles** (per global-instructions.md):

- **Unit tests**: Fast (<100ms each), isolated, no external dependencies, **AAA pattern** (Arrange-Act-Assert), descriptive names explaining scenario being tested
- **Integration tests**: Moderate speed (<5s each), real dependencies or testcontainers, **transaction-based** for database tests with **proper cleanup and rollback**, **CRUD validation** (Create, Read, Update, Delete all tested with sample data validation)
- **Regression tests**: Validate against golden files/snapshots to detect format/behavior drift
- **Health checks**: Quick validation of system components (database, cache, queue, filesystem)
- **Synthetic tests**: Full end-to-end journeys covering critical user workflows
- **Performance tests**: Benchmarks for critical components with SLA validation
- **Security tests**: Vulnerability scanning and compliance validation
- **Version tracking**: Tests relate to specific versions and builds for traceability
- **Documentation**: All tests documented with clear purpose in `{{folders.tests}}/README.md` as per `{{files.tests}}`
- **Continuous improvement**: Monitor and improve test coverage and quality over time
- **Edge cases**: Include tests for error conditions and boundary cases
  │ ├── database-health.test._
  │ └── cache-health.test._
  ├── synthetic/ # End-to-end synthetic transactions
  │ ├── journeys/
  │ └── fixtures/
  └── fixtures/ # Shared test data and mocks
  ├── data/
  └── mocks/

````

**Test organization principles**:

- **Unit tests**: Fast (<100ms each), isolated, no external dependencies
- **Integration tests**: Moderate speed (<5s each), real dependencies or testcontainers
- **Regression tests**: Validate against golden files/snapshots
- **Health checks**: Quick validation of system components
- **Synthetic tests**: Full end-to-end journeys with real-world scenarios

### Step 3: Test Configuration and Tooling Setup

**Create test configuration files**:

#### Python (pytest)

Create `pytest.ini`:

```ini
[pytest]
minversion = 7.0
testpaths = tests
python_files = test_*.py *_test.py
python_classes = Test*
python_functions = test_*
addopts =
    --verbose
    --strict-markers
    --tb=short
    --cov=src
    --cov-report=html:artifacts/coverage/html
    --cov-report=json:artifacts/coverage/coverage.json
    --cov-report=term-missing
    --timeout=60
    --maxfail=5
    -n auto
markers =
    unit: Unit tests (fast, isolated)
    integration: Integration tests (external dependencies)
    regression: Regression tests (golden files)
    health: Health check tests
    synthetic: Synthetic transaction tests
    slow: Tests that take >5 seconds
    flaky: Tests known to be flaky (retry enabled)
timeout = 60
````

Create `pyproject.toml` (testing section):

```toml
[tool.pytest.ini_options]
minversion = "7.0"
testpaths = ["tests"]
timeout = 60

[tool.coverage.run]
source = ["src"]
omit = [
    "*/tests/*",
    "*/test_*.py",
    "*/__pycache__/*",
    "*/venv/*",
]

[tool.coverage.report]
precision = 2
show_missing = true
skip_covered = false
fail_under = 80

[tool.coverage.html]
directory = "artifacts/coverage/html"
```

#### Node.js / TypeScript (Vitest)

Create `vitest.config.ts`:

```typescript
import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    globals: true,
    environment: 'node',
    include: ['tests/**/*.test.{ts,js}'],
    exclude: ['tests/fixtures/**', 'node_modules/**'],
    testTimeout: 60000,
    hookTimeout: 60000,
    teardownTimeout: 10000,
    retry: 0, // Override with 2 for flaky tests
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html', 'lcov'],
      reportsDirectory: './artifacts/coverage',
      include: ['src/**/*.{ts,js}'],
      exclude: ['src/**/*.test.{ts,js}', 'src/**/*.spec.{ts,js}', 'src/**/__tests__/**'],
      thresholds: {
        lines: 80,
        functions: 70,
        branches: 70,
        statements: 80,
      },
    },
  },
});
```

#### Go

Create `Makefile` test targets:

```makefile
.PHONY: test test-unit test-integration test-health test-coverage

TEST_TIMEOUT ?= 60s
TEST_FLAGS ?= -v -race -timeout $(TEST_TIMEOUT)

test: test-unit test-integration

test-unit:
	@echo "Running unit tests..."
	go test $(TEST_FLAGS) ./... -short

test-integration:
	@echo "Running integration tests..."
	go test $(TEST_FLAGS) ./... -run Integration

test-health:
	@echo "Running health checks..."
	go test $(TEST_FLAGS) ./tests/health/...

test-coverage:
	@echo "Running tests with coverage..."
	go test $(TEST_FLAGS) -coverprofile=artifacts/coverage/coverage.out ./...
	go tool cover -html=artifacts/coverage/coverage.out -o artifacts/coverage/coverage.html
	go tool cover -func=artifacts/coverage/coverage.out
```

#### Java (Maven + JUnit 5)

Add to `pom.xml`:

```xml
<build>
  <plugins>
    <plugin>
      <groupId>org.apache.maven.plugins</groupId>
      <artifactId>maven-surefire-plugin</artifactId>
      <version>3.0.0</version>
      <configuration>
        <timeout>60</timeout>
        <parallel>methods</parallel>
        <threadCount>4</threadCount>
        <rerunFailingTestsCount>2</rerunFailingTestsCount>
        <includes>
          <include>**/*Test.java</include>
          <include>**/*Tests.java</include>
        </includes>
      </configuration>
    </plugin>
    <plugin>
      <groupId>org.jacoco</groupId>
      <artifactId>jacoco-maven-plugin</artifactId>
      <version>0.8.10</version>
      <executions>
        <execution>
          <goals>
            <goal>prepare-agent</goal>
          </goals>
        </execution>
        <execution>
          <id>report</id>
          <phase>test</phase>
          <goals>
            <goal>report</goal>
          </goals>
          <configuration>
            <outputDirectory>artifacts/coverage</outputDirectory>
          </configuration>
        </execution>
      </executions>
    </plugin>
  </plugins>
</build>
```

### Step 4: Core Testing Infrastructure

**Create base test utilities and helpers**:

#### Python Example - `tests/conftest.py`

```python
"""
Pytest configuration and shared fixtures.
Generated by: ai-ley build-unit-tests | timestamp: 2025-11-10T00:00:00Z
"""
import pytest
import os
from typing import Generator

# Test timeout configuration
TEST_TIMEOUT = int(os.getenv('TEST_TIMEOUT_MS', '60000')) / 1000  # Convert to seconds
pytest.timeout = min(TEST_TIMEOUT, 60)  # Cap at 60 seconds

@pytest.fixture(scope="session")
def test_config():
    """Shared test configuration."""
    return {
        "timeout": TEST_TIMEOUT,
        "retries": 2,
        "parallel": True,
    }

@pytest.fixture
def temp_directory(tmp_path):
    """Provide temporary directory for test artifacts."""
    yield tmp_path
    # Cleanup handled automatically by tmp_path

@pytest.fixture
def mock_database():
    """Mock database connection for testing."""
    # Setup mock database
    db = create_mock_db()
    yield db
    # Teardown
    db.close()

# Retry configuration for flaky tests
def pytest_configure(config):
    """Configure pytest with custom markers and settings."""
    config.addinivalue_line(
        "markers", "flaky: mark test as flaky (will retry up to 2 times)"
    )
```

#### TypeScript Example - `tests/setup.ts`

```typescript
/**
 * Vitest global setup and utilities
 * Generated by: ai-ley build-unit-tests | timestamp: 2025-11-10T00:00:00Z
 */
import { beforeAll, afterAll, beforeEach, afterEach } from 'vitest';

// Global test timeout from environment
const TEST_TIMEOUT = Math.min(
  parseInt(process.env.TEST_TIMEOUT_MS || '60000', 10),
  60000, // Cap at 60 seconds
);

// Global setup
beforeAll(async () => {
  // Initialize test environment
  console.log('Setting up test environment...');
});

// Global teardown
afterAll(async () => {
  // Cleanup test environment
  console.log('Tearing down test environment...');
});

// Per-test cleanup
afterEach(() => {
  // Clear mocks
  vi.clearAllMocks();
});

// Shared test utilities
export const waitFor = async (
  condition: () => boolean | Promise<boolean>,
  timeout = 5000,
): Promise<void> => {
  const start = Date.now();
  while (!(await condition())) {
    if (Date.now() - start > timeout) {
      throw new Error('Timeout waiting for condition');
    }
    await new Promise((resolve) => setTimeout(resolve, 100));
  }
};

export const mockFetch = (data: any, status = 200) => {
  global.fetch = vi.fn(() =>
    Promise.resolve({
      ok: status >= 200 && status < 300,
      status,
      json: async () => data,
    } as Response),
  );
};
```

### Step 5: Unit Test Generation

**Generate unit tests for existing code** following global-instructions.md requirements:

**Analysis approach**:

1. **Scan source files** in `src/`, `lib/`, `app/` directories
2. **Identify testable units**: Functions, classes, methods, modules (all new functions must have tests)
3. **Analyze dependencies**: Determine what needs mocking
4. **Generate test cases**: Happy path, edge cases, error conditions, boundary cases
5. **Ensure AAA pattern**: Arrange-Act-Assert structure for all tests
6. **Descriptive naming**: Test names must explain the scenario being tested

**Test template structure** (AAA pattern per global-instructions.md):

```python
# Python unit test example: {{folders.tests}}/unit/services/user_service_test.py
"""
Unit tests for UserService
Generated by: ai-ley build-unit-tests | timestamp: 2025-11-10T00:00:00Z
Purpose: Validate UserService CRUD operations and business logic
"""
import pytest
from unittest.mock import Mock, patch
from src.services.user_service import UserService

class TestUserService:
    """Unit tests for UserService class following AAA (Arrange-Act-Assert) pattern."""

    @pytest.fixture
    def service(self):
        """Create UserService instance for testing."""
        return UserService()

    @pytest.mark.unit
    def test_create_user_success(self, service):
        """Test successful user creation with valid data."""
        # Arrange: Prepare test data
        user_data = {"name": "John Doe", "email": "john@example.com"}

        # Act: Execute the operation
        result = service.create_user(user_data)

        # Assert: Verify the outcome
        assert result is not None
        assert result.name == "John Doe"
        assert result.email == "john@example.com"

    @pytest.mark.unit
    def test_create_user_invalid_email(self, service):
        """Test user creation fails with invalid email format."""
        # Arrange: Prepare invalid test data
        user_data = {"name": "John Doe", "email": "invalid-email"}

        # Act & Assert: Verify exception is raised
        with pytest.raises(ValueError, match="Invalid email"):
            service.create_user(user_data)

    @pytest.mark.unit
    def test_create_user_missing_required_field(self, service):
        """Test user creation fails when required field is missing (edge case)."""
        # Arrange: Prepare incomplete data
        user_data = {"email": "john@example.com"}

        # Act & Assert: Verify validation error
        with pytest.raises(ValueError, match="Name is required"):
            service.create_user(user_data)

    @pytest.mark.unit
    @pytest.mark.timeout(1)  # Fast test, 1 second timeout
    def test_get_user_by_id(self, service):
        """Test retrieving user by ID with mocked database."""
        # Arrange: Mock database response
        with patch.object(service, 'db') as mock_db:
            mock_db.get.return_value = {"id": 1, "name": "John"}

            # Act: Retrieve user
            result = service.get_user_by_id(1)

            # Assert: Verify result and call
            assert result["name"] == "John"
            mock_db.get.assert_called_once_with(1)
```

**CRUD Test Requirements** (per global-instructions.md):

For database operations, **test all four CRUD actions** with sample data validation:

```python
# {{folders.tests}}/integration/database/user_repository_test.py
"""
Integration tests for UserRepository CRUD operations with transaction rollback.
Purpose: Validate database interactions with proper cleanup
"""
import pytest
from src.repositories.user_repository import UserRepository

class TestUserRepositoryCRUD:
    """Test all CRUD operations with transaction rollback (per global-instructions.md)."""

    @pytest.fixture
    def repository(self, db_transaction):
        """Create repository with transaction-based cleanup."""
        return UserRepository(db_transaction)

    @pytest.fixture
    def db_transaction(self, db_session):
        """Provide database transaction that auto-rolls back after test."""
        transaction = db_session.begin_nested()
        yield db_session
        transaction.rollback()  # Ensure proper cleanup

    @pytest.mark.integration
    def test_crud_create(self, repository):
        """Test CREATE operation with sample data validation."""
        # Arrange
        user_data = {"name": "Test User", "email": "test@example.com"}

        # Act
        created_user = repository.create(user_data)

        # Assert: Validate created user
        assert created_user.id is not None
        assert created_user.name == "Test User"
        assert created_user.email == "test@example.com"
        assert created_user.created_at is not None

    @pytest.mark.integration
    def test_crud_read(self, repository):
        """Test READ operation retrieves correct data."""
        # Arrange: Create test user
        user_data = {"name": "Test User", "email": "test@example.com"}
        created_user = repository.create(user_data)

        # Act: Read back the user
        retrieved_user = repository.get_by_id(created_user.id)

        # Assert: Verify data matches
        assert retrieved_user.id == created_user.id
        assert retrieved_user.name == created_user.name
        assert retrieved_user.email == created_user.email

    @pytest.mark.integration
    def test_crud_update(self, repository):
        """Test UPDATE operation modifies data correctly."""
        # Arrange: Create and then update
        user_data = {"name": "Original Name", "email": "original@example.com"}
        created_user = repository.create(user_data)

        # Act: Update the user
        updated_user = repository.update(created_user.id, {"name": "Updated Name"})

        # Assert: Verify update
        assert updated_user.id == created_user.id
        assert updated_user.name == "Updated Name"
        assert updated_user.email == "original@example.com"  # Unchanged

    @pytest.mark.integration
    def test_crud_delete(self, repository):
        """Test DELETE operation removes data completely."""
        # Arrange: Create user to delete
        user_data = {"name": "To Delete", "email": "delete@example.com"}
        created_user = repository.create(user_data)
        user_id = created_user.id

        # Act: Delete the user
        repository.delete(user_id)

        # Assert: Verify deletion
        deleted_user = repository.get_by_id(user_id)
        assert deleted_user is None
```

### Step 6: Health Check Tests

**Create health check tests for all components**:

#### Python Health Check Example - `tests/health/service_health_test.py`

```python
"""
Health check tests for system components.
Generated by: ai-ley build-unit-tests | timestamp: 2025-11-10T00:00:00Z
"""
import pytest
import time
import json
from src.health import HealthChecker

class TestHealthChecks:
    """System health check tests."""

    @pytest.fixture
    def health_checker(self):
        return HealthChecker()

    @pytest.mark.health
    @pytest.mark.timeout(5)
    def test_database_health(self, health_checker):
        """Check database connectivity and responsiveness."""
        result = health_checker.check_database()

        assert result["status"] in ["healthy", "degraded", "unhealthy"]
        assert "latency_ms" in result
        assert result["latency_ms"] < 1000  # Should respond within 1s

        if result["status"] == "unhealthy":
            assert "error" in result

    @pytest.mark.health
    @pytest.mark.timeout(5)
    def test_cache_health(self, health_checker):
        """Check cache (Redis/Memcached) health."""
        result = health_checker.check_cache()

        assert result["status"] in ["healthy", "degraded", "unhealthy"]
        assert "latency_ms" in result

        # Verify cache is responsive
        if result["status"] == "healthy":
            assert result["latency_ms"] < 100

    @pytest.mark.health
    @pytest.mark.timeout(10)
    def test_all_components_health(self, health_checker):
        """Check health of all system components."""
        result = health_checker.check_all()

        assert "components" in result
        assert "overall_status" in result
        assert isinstance(result["components"], dict)

        # All components should be checked
        expected_components = ["database", "cache", "queue", "filesystem"]
        for component in expected_components:
            assert component in result["components"]
```

**Health check JSON response format**:

```json
{
  "overall_status": "healthy",
  "timestamp": "2025-11-10T12:00:00Z",
  "components": {
    "database": {
      "status": "healthy",
      "latency_ms": 45,
      "details": {
        "connections": 5,
        "pool_size": 10
      }
    },
    "cache": {
      "status": "healthy",
      "latency_ms": 12
    },
    "queue": {
      "status": "degraded",
      "latency_ms": 850,
      "error": "High message backlog: 10000 messages"
    },
    "filesystem": {
      "status": "healthy",
      "latency_ms": 8,
      "details": {
        "disk_usage_percent": 45
      }
    }
  }
}
```

### Step 7: Regression Tests with Golden Files

**Create regression test infrastructure**:

#### Python Regression Test Example

```python
"""
Regression tests using golden files for output validation.
Generated by: ai-ley build-unit-tests | timestamp: 2025-11-10T00:00:00Z
"""
import pytest
import json
from pathlib import Path
from src.report_generator import ReportGenerator

GOLDEN_DIR = Path(__file__).parent / "golden"

class TestReportRegression:
    """Regression tests for report generation."""

    @pytest.fixture
    def generator(self):
        return ReportGenerator()

    @pytest.mark.regression
    def test_sales_report_format(self, generator):
        """Verify sales report format matches golden file."""
        # Generate report with fixed test data
        test_data = load_test_data("sales_q4_2024.json")
        result = generator.generate_sales_report(test_data)

        # Load golden file
        golden_path = GOLDEN_DIR / "sales_report_q4_2024.json"
        with open(golden_path, 'r') as f:
            expected = json.load(f)

        # Compare (excluding timestamps)
        result_normalized = normalize_report(result)
        expected_normalized = normalize_report(expected)

        assert result_normalized == expected_normalized, \
            f"Report format changed. Review diff and update golden file if intentional."

    @pytest.mark.regression
    def test_csv_export_format(self, generator):
        """Verify CSV export matches expected format."""
        test_data = load_test_data("export_sample.json")
        result = generator.export_to_csv(test_data)

        golden_path = GOLDEN_DIR / "export_sample.csv"
        with open(golden_path, 'r') as f:
            expected = f.read()

        assert result == expected, \
            "CSV format changed. Review and update golden file if intentional."

def normalize_report(report: dict) -> dict:
    """Remove non-deterministic fields for comparison."""
    normalized = report.copy()
    normalized.pop('generated_at', None)
    normalized.pop('request_id', None)
    return normalized
```

**Golden file management**:

- Store expected outputs in `tests/regression/golden/`
- Version control golden files
- Update golden files only after manual review
- Document breaking changes when golden files are updated

### Step 8: Synthetic Transaction Tests

**Create end-to-end synthetic journeys**:

#### Python Synthetic Test Example

```python
"""
Synthetic transaction tests for end-to-end journeys.
Generated by: ai-ley build-unit-tests | timestamp: 2025-11-10T00:00:00Z
"""
import pytest
import uuid
import time
import json
from pathlib import Path
from src.api_client import APIClient

ARTIFACTS_DIR = Path("artifacts/synthetic")
ARTIFACTS_DIR.mkdir(parents=True, exist_ok=True)

class TestSyntheticJourneys:
    """End-to-end synthetic transaction tests."""

    @pytest.fixture
    def api_client(self):
        """Create API client for testing."""
        return APIClient(base_url="http://localhost:8000")

    @pytest.fixture
    def test_context(self):
        """Create test context with unique IDs and cleanup."""
        context = {
            "run_id": str(uuid.uuid4()),
            "user_id": f"test_user_{uuid.uuid4().hex[:8]}",
            "created_resources": []
        }
        yield context
        # Cleanup created resources
        cleanup_resources(context["created_resources"])

    @pytest.mark.synthetic
    @pytest.mark.timeout(30)
    def test_user_registration_to_purchase_journey(self, api_client, test_context):
        """
        Synthetic journey: User registration → Login → Browse → Purchase
        """
        start_time = time.time()
        journey_log = []

        # Step 1: Register user
        step_start = time.time()
        register_response = api_client.post("/auth/register", {
            "email": f"{test_context['user_id']}@example.com",
            "password": "SecurePass123!",
            "name": "Test User"
        })
        journey_log.append({
            "step": "register",
            "duration_ms": (time.time() - step_start) * 1000,
            "status": register_response.status_code,
            "request": register_response.request.body,
            "response": register_response.json()
        })
        assert register_response.status_code == 201
        test_context["created_resources"].append(("user", register_response.json()["id"]))

        # Step 2: Login
        step_start = time.time()
        login_response = api_client.post("/auth/login", {
            "email": f"{test_context['user_id']}@example.com",
            "password": "SecurePass123!"
        })
        journey_log.append({
            "step": "login",
            "duration_ms": (time.time() - step_start) * 1000,
            "status": login_response.status_code
        })
        assert login_response.status_code == 200
        token = login_response.json()["access_token"]
        api_client.set_auth_token(token)

        # Step 3: Browse products
        step_start = time.time()
        browse_response = api_client.get("/products", params={"category": "electronics"})
        journey_log.append({
            "step": "browse_products",
            "duration_ms": (time.time() - step_start) * 1000,
            "status": browse_response.status_code,
            "product_count": len(browse_response.json()["products"])
        })
        assert browse_response.status_code == 200
        products = browse_response.json()["products"]
        assert len(products) > 0

        # Step 4: Add to cart
        step_start = time.time()
        cart_response = api_client.post("/cart/items", {
            "product_id": products[0]["id"],
            "quantity": 1
        })
        journey_log.append({
            "step": "add_to_cart",
            "duration_ms": (time.time() - step_start) * 1000,
            "status": cart_response.status_code
        })
        assert cart_response.status_code == 201

        # Step 5: Checkout
        step_start = time.time()
        checkout_response = api_client.post("/orders/checkout", {
            "payment_method": "test_card",
            "shipping_address": {
                "street": "123 Test St",
                "city": "Test City",
                "zip": "12345"
            }
        })
        journey_log.append({
            "step": "checkout",
            "duration_ms": (time.time() - step_start) * 1000,
            "status": checkout_response.status_code,
            "order_id": checkout_response.json().get("order_id")
        })
        assert checkout_response.status_code == 201
        test_context["created_resources"].append(("order", checkout_response.json()["order_id"]))

        # Record complete journey
        total_duration = (time.time() - start_time) * 1000
        journey_log.append({
            "total_duration_ms": total_duration,
            "success": True
        })

        # Save journey log for drift analysis
        log_path = ARTIFACTS_DIR / f"journey_{test_context['run_id']}.json"
        with open(log_path, 'w') as f:
            json.dump(journey_log, f, indent=2)

        # Verify journey completed within acceptable time
        assert total_duration < 10000, f"Journey took {total_duration}ms, expected <10s"

def cleanup_resources(resources):
    """Clean up test resources created during synthetic journey."""
    # Implement cleanup logic for created users, orders, etc.
    pass
```

### Step 9: Timeout and Retry Mechanisms

**Implement timeout protection and retry logic**:

#### Timeout Watchdog Implementation

```python
# tests/timeout_watchdog.py
"""
Timeout watchdog for preventing runaway tests.
Generated by: ai-ley build-unit-tests | timestamp: 2025-11-10T00:00:00Z
"""
import signal
import os
import psutil
from contextlib import contextmanager

DEFAULT_TIMEOUT = 60  # seconds

class TimeoutError(Exception):
    """Raised when test exceeds timeout."""
    pass

@contextmanager
def timeout_guard(seconds=DEFAULT_TIMEOUT):
    """
    Context manager that kills process if execution exceeds timeout.

    Usage:
        with timeout_guard(30):
            # Test code here
            run_potentially_slow_test()
    """
    def timeout_handler(signum, frame):
        # Get process info for logging
        process = psutil.Process(os.getpid())
        memory_mb = process.memory_info().rss / 1024 / 1024

        raise TimeoutError(
            f"Test exceeded {seconds}s timeout. "
            f"Memory usage: {memory_mb:.2f}MB. "
            f"Process will be terminated."
        )

    # Set the signal handler
    old_handler = signal.signal(signal.SIGALRM, timeout_handler)
    signal.alarm(seconds)

    try:
        yield
    finally:
        # Restore original handler and cancel alarm
        signal.alarm(0)
        signal.signal(signal.SIGALRM, old_handler)

# Pytest integration
def pytest_runtest_call(item):
    """Hook to apply timeout watchdog to all tests."""
    timeout = item.config.getoption("--timeout", DEFAULT_TIMEOUT)
    with timeout_guard(timeout):
        yield
```

#### Retry Logic for Flaky Tests

```python
# tests/retry_decorator.py
"""
Retry decorator for flaky tests.
Generated by: ai-ley build-unit-tests | timestamp: 2025-11-10T00:00:00Z
"""
import time
import functools
from typing import Callable, Type, Tuple

def retry_on_failure(
    max_attempts: int = 3,
    delay: float = 1.0,
    backoff: float = 2.0,
    exceptions: Tuple[Type[Exception], ...] = (AssertionError, ConnectionError)
):
    """
    Decorator to retry flaky tests.

    Args:
        max_attempts: Maximum retry attempts (default: 3)
        delay: Initial delay between retries in seconds (default: 1.0)
        backoff: Multiplier for delay on each retry (default: 2.0)
        exceptions: Tuple of exceptions to catch and retry

    Usage:
        @retry_on_failure(max_attempts=3, delay=1.0)
        def test_flaky_api():
            # Test that may intermittently fail
            response = call_external_api()
            assert response.status_code == 200
    """
    def decorator(func: Callable) -> Callable:
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            current_delay = delay
            last_exception = None

            for attempt in range(1, max_attempts + 1):
                try:
                    return func(*args, **kwargs)
                except exceptions as e:
                    last_exception = e
                    if attempt < max_attempts:
                        print(f"[Retry {attempt}/{max_attempts}] Test failed: {e}. "
                              f"Retrying in {current_delay}s...")
                        time.sleep(current_delay)
                        current_delay *= backoff
                    else:
                        print(f"[Retry {attempt}/{max_attempts}] Test failed after all retries.")

            # All retries exhausted, raise last exception
            raise last_exception

        return wrapper
    return decorator

# Pytest marker integration
import pytest

@pytest.fixture(autouse=True)
def auto_retry_flaky_tests(request):
    """Automatically retry tests marked with @pytest.mark.flaky."""
    if 'flaky' in request.keywords:
        # Apply retry wrapper
        original_function = request.function
        request.function = retry_on_failure(max_attempts=2)(original_function)
```

### Step 10: Test Control API

**Create RESTful API for test orchestration**:

#### Flask-based Test Control API

```python
# tests/test_api/app.py
"""
Test Control API for remote test execution and monitoring.
Generated by: ai-ley build-unit-tests | timestamp: 2025-11-10T00:00:00Z

Endpoints:
- POST /api/v1/tests/run - Run tests
- GET /api/v1/tests/status/{run_id} - Get test run status
- GET /api/v1/tests/results/{run_id} - Get test results
- GET /api/v1/health - Health check
"""
from flask import Flask, request, jsonify
import subprocess
import uuid
import json
from pathlib import Path
from datetime import datetime
import threading

app = Flask(__name__)

# Test run storage
TEST_RUNS = {}
RESULTS_DIR = Path("artifacts/test-api-results")
RESULTS_DIR.mkdir(parents=True, exist_ok=True)

@app.route('/api/v1/health', methods=['GET'])
def health_check():
    """Health check endpoint."""
    return jsonify({
        "status": "healthy",
        "timestamp": datetime.utcnow().isoformat(),
        "version": "1.0.0"
    }), 200

@app.route('/api/v1/tests/run', methods=['POST'])
def run_tests():
    """
    Execute tests based on request parameters.

    Request body:
    {
      "test_type": "unit|integration|regression|health|all",
      "markers": ["optional", "marker", "list"],
      "parallel": true|false,
      "coverage": true|false,
      "timeout": 300
    }

    Response:
    {
      "run_id": "uuid",
      "status": "queued",
      "message": "Tests queued for execution"
    }
    """
    run_id = str(uuid.uuid4())
    params = request.get_json()

    # Validate request
    test_type = params.get('test_type', 'unit')
    markers = params.get('markers', [])
    parallel = params.get('parallel', True)
    coverage = params.get('coverage', False)
    timeout = min(params.get('timeout', 300), 600)  # Cap at 10 minutes

    # Build pytest command
    cmd = ['pytest']

    # Add markers
    if test_type != 'all':
        cmd.extend(['-m', test_type])
    for marker in markers:
        cmd.extend(['-m', marker])

    # Add parallelization
    if parallel:
        cmd.extend(['-n', 'auto'])

    # Add coverage
    if coverage:
        cmd.extend(['--cov=src', '--cov-report=json'])

    # Add output format
    cmd.extend([
        '--json-report',
        f'--json-report-file={RESULTS_DIR}/{run_id}.json',
        '--tb=short'
    ])

    # Store run metadata
    TEST_RUNS[run_id] = {
        "status": "queued",
        "params": params,
        "command": ' '.join(cmd),
        "created_at": datetime.utcnow().isoformat(),
        "started_at": None,
        "completed_at": None
    }

    # Execute tests in background thread
    def execute_tests():
        TEST_RUNS[run_id]["status"] = "running"
        TEST_RUNS[run_id]["started_at"] = datetime.utcnow().isoformat()

        try:
            result = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                timeout=timeout
            )
            TEST_RUNS[run_id]["status"] = "completed"
            TEST_RUNS[run_id]["exit_code"] = result.returncode
            TEST_RUNS[run_id]["completed_at"] = datetime.utcnow().isoformat()
        except subprocess.TimeoutExpired:
            TEST_RUNS[run_id]["status"] = "timeout"
            TEST_RUNS[run_id]["completed_at"] = datetime.utcnow().isoformat()
        except Exception as e:
            TEST_RUNS[run_id]["status"] = "failed"
            TEST_RUNS[run_id]["error"] = str(e)
            TEST_RUNS[run_id]["completed_at"] = datetime.utcnow().isoformat()

    thread = threading.Thread(target=execute_tests)
    thread.start()

    return jsonify({
        "run_id": run_id,
        "status": "queued",
        "message": f"Tests queued for execution. Check status at /api/v1/tests/status/{run_id}"
    }), 202

@app.route('/api/v1/tests/status/<run_id>', methods=['GET'])
def get_test_status(run_id):
    """Get status of a test run."""
    if run_id not in TEST_RUNS:
        return jsonify({"error": "Test run not found"}), 404

    return jsonify(TEST_RUNS[run_id]), 200

@app.route('/api/v1/tests/results/<run_id>', methods=['GET'])
def get_test_results(run_id):
    """Get detailed results of a completed test run."""
    if run_id not in TEST_RUNS:
        return jsonify({"error": "Test run not found"}), 404

    run_info = TEST_RUNS[run_id]
    if run_info["status"] != "completed":
        return jsonify({
            "error": f"Test run not completed. Current status: {run_info['status']}"
        }), 400

    # Load results file
    results_file = RESULTS_DIR / f"{run_id}.json"
    if not results_file.exists():
        return jsonify({"error": "Results file not found"}), 404

    with open(results_file, 'r') as f:
        results = json.load(f)

    return jsonify({
        "run_info": run_info,
        "results": results
    }), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5555, debug=False)
```

**Test API CLI Client**:

```bash
# tests/test_api/client.sh
#!/bin/bash
# CLI client for Test Control API

API_BASE="http://localhost:5555/api/v1"

case "$1" in
  run)
    curl -X POST "$API_BASE/tests/run" \
      -H "Content-Type: application/json" \
      -d "{
        \"test_type\": \"${2:-unit}\",
        \"parallel\": true,
        \"coverage\": ${3:-false}
      }"
    ;;

  status)
    curl -X GET "$API_BASE/tests/status/$2"
    ;;

  results)
    curl -X GET "$API_BASE/tests/results/$2"
    ;;

  health)
    curl -X GET "$API_BASE/health"
    ;;

  *)
    echo "Usage: $0 {run|status|results|health} [args]"
    exit 1
    ;;
esac
```

### Step 11: CLI Test Commands

**Create convenience CLI commands for developers**:

#### Makefile Commands

```makefile
# Makefile
# Test commands for developers
# Generated by: ai-ley build-unit-tests | timestamp: 2025-11-10T00:00:00Z

.PHONY: test test-unit test-integration test-health test-regression test-all
.PHONY: test-watch test-coverage test-profile test-api

# Quick unit tests (default)
test: test-unit

# Unit tests only
test-unit:
	@echo "Running unit tests..."
	pytest -m unit --tb=short -v

# Integration tests
test-integration:
	@echo "Running integration tests..."
	pytest -m integration --tb=short -v

# Health check tests
test-health:
	@echo "Running health check tests..."
	pytest -m health --tb=short -v

# Regression tests
test-regression:
	@echo "Running regression tests..."
	pytest -m regression --tb=short -v

# All tests
test-all:
	@echo "Running all tests..."
	pytest --tb=short -v

# Watch mode (re-run on file changes)
test-watch:
	@echo "Running tests in watch mode..."
	pytest-watch -- -m unit

# Coverage report
test-coverage:
	@echo "Running tests with coverage..."
	pytest --cov=src --cov-report=html --cov-report=term-missing
	@echo "Coverage report: htmlcov/index.html"

# Performance profiling
test-profile:
	@echo "Running tests with profiling..."
	pytest --profile --profile-svg
	@echo "Profile output: prof/combined.svg"

# Start Test Control API
test-api:
	@echo "Starting Test Control API on :5555..."
	python tests/test_api/app.py

# Parallel execution with coverage
test-parallel:
	@echo "Running tests in parallel with coverage..."
	pytest -n auto --cov=src --cov-report=html

# Fast fail mode
test-fast:
	@echo "Running tests (fail fast mode)..."
	pytest -x --tb=line
```

#### Package.json Scripts (Node.js)

```json
{
  "scripts": {
    "test": "vitest run",
    "test:unit": "vitest run --reporter=verbose",
    "test:integration": "vitest run src/**/*.integration.test.ts",
    "test:watch": "vitest watch",
    "test:coverage": "vitest run --coverage",
    "test:ui": "vitest --ui",
    "test:health": "vitest run src/**/*.health.test.ts",
    "test:regression": "vitest run src/**/*.regression.test.ts",
    "test:profile": "vitest run --reporter=verbose --outputFile=test-profile.json",
    "test:api": "node tests/test-api/server.js",
    "test:parallel": "vitest run --threads",
    "test:debug": "vitest run --inspect-brk --pool=forks"
  }
}
```

### Step 12: Coverage Policy and Dashboards

**Enforce coverage thresholds and create reporting dashboards** (per global-instructions.md ≥80% requirement):

#### Coverage Configuration - `.coveragerc`

```ini
# .coveragerc
# Coverage configuration per global-instructions.md
# Generated by: ai-ley build-unit-tests | timestamp: 2025-11-10T00:00:00Z

[run]
source = src
omit =
    */tests/*
    */test_*
    */__pycache__/*
    */venv/*
    */node_modules/*

[report]
# Coverage thresholds (≥80% per global-instructions.md)
fail_under = 80
precision = 2
show_missing = True
skip_covered = False

# Exclude from coverage
exclude_lines =
    pragma: no cover
    def __repr__
    raise AssertionError
    raise NotImplementedError
    if __name__ == .__main__.:
    if TYPE_CHECKING:
    @abstractmethod

[html]
directory = htmlcov
title = Test Coverage Report

[json]
output = coverage.json
```

#### Coverage Dashboard HTML Template

```html
<!-- tests/dashboard/coverage-dashboard.html -->
<!DOCTYPE html>
<html>
  <head>
    <title>Test Coverage Dashboard</title>
    <meta charset="utf-8" />
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }
      body {
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        background: #f5f5f5;
        padding: 20px;
      }
      .container {
        max-width: 1400px;
        margin: 0 auto;
      }
      header {
        background: white;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 20px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }
      h1 {
        color: #333;
        margin-bottom: 10px;
      }
      .meta {
        color: #666;
        font-size: 14px;
      }
      .grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 20px;
        margin-bottom: 20px;
      }
      .card {
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }
      .card h2 {
        font-size: 16px;
        color: #666;
        margin-bottom: 10px;
      }
      .metric {
        font-size: 48px;
        font-weight: bold;
        margin-bottom: 5px;
      }
      .metric.good {
        color: #22c55e;
      }
      .metric.warning {
        color: #f59e0b;
      }
      .metric.danger {
        color: #ef4444;
      }
      .progress-bar {
        width: 100%;
        height: 8px;
        background: #e5e7eb;
        border-radius: 4px;
        overflow: hidden;
        margin-top: 10px;
      }
      .progress-fill {
        height: 100%;
        transition: width 0.3s ease;
      }
      table {
        width: 100%;
        border-collapse: collapse;
        background: white;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }
      th,
      td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #e5e7eb;
      }
      th {
        background: #f9fafb;
        font-weight: 600;
        color: #374151;
      }
      tr:hover {
        background: #f9fafb;
      }
      .badge {
        display: inline-block;
        padding: 4px 8px;
        border-radius: 4px;
        font-size: 12px;
        font-weight: 600;
      }
      .badge.pass {
        background: #dcfce7;
        color: #166534;
      }
      .badge.fail {
        background: #fee2e2;
        color: #991b1b;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <header>
        <h1>Test Coverage Dashboard</h1>
        <div class="meta">
          Generated: <span id="timestamp"></span> | Total Tests: <span id="total-tests"></span>
        </div>
      </header>

      <div class="grid">
        <div class="card">
          <h2>Overall Coverage</h2>
          <div class="metric" id="overall-coverage">0%</div>
          <div class="progress-bar">
            <div class="progress-fill good" id="overall-progress" style="width: 0%"></div>
          </div>
        </div>

        <div class="card">
          <h2>Line Coverage</h2>
          <div class="metric" id="line-coverage">0%</div>
          <div class="progress-bar">
            <div class="progress-fill" id="line-progress" style="width: 0%"></div>
          </div>
        </div>

        <div class="card">
          <h2>Branch Coverage</h2>
          <div class="metric" id="branch-coverage">0%</div>
          <div class="progress-bar">
            <div class="progress-fill" id="branch-progress" style="width: 0%"></div>
          </div>
        </div>

        <div class="card">
          <h2>Tests Passed</h2>
          <div class="metric" id="tests-passed">0</div>
          <span id="pass-rate"></span>
        </div>
      </div>

      <div class="card">
        <h2 style="margin-bottom: 15px;">Coverage by Module</h2>
        <table id="module-coverage">
          <thead>
            <tr>
              <th>Module</th>
              <th>Statements</th>
              <th>Missing</th>
              <th>Excluded</th>
              <th>Coverage</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody id="module-tbody">
            <!-- Populated by JavaScript -->
          </tbody>
        </table>
      </div>
    </div>

    <script>
      // Load coverage data
      fetch('coverage.json')
        .then((res) => res.json())
        .then((data) => {
          // Update timestamp
          document.getElementById('timestamp').textContent = new Date().toLocaleString();

          // Update overall metrics
          const overall = data.totals.percent_covered;
          document.getElementById('overall-coverage').textContent = overall.toFixed(1) + '%';
          document.getElementById('overall-coverage').className =
            'metric ' + (overall >= 80 ? 'good' : overall >= 60 ? 'warning' : 'danger');
          document.getElementById('overall-progress').style.width = overall + '%';

          // Update line coverage
          const lineCov = (data.totals.covered_lines / data.totals.num_statements) * 100;
          document.getElementById('line-coverage').textContent = lineCov.toFixed(1) + '%';
          document.getElementById('line-progress').style.width = lineCov + '%';
          document.getElementById('line-progress').className =
            'progress-fill ' + (lineCov >= 80 ? 'good' : lineCov >= 60 ? 'warning' : 'danger');

          // Populate module table
          const tbody = document.getElementById('module-tbody');
          Object.entries(data.files).forEach(([file, stats]) => {
            const row = tbody.insertRow();
            const coverage = stats.summary.percent_covered;

            row.innerHTML = `
                        <td>${file}</td>
                        <td>${stats.summary.num_statements}</td>
                        <td>${stats.summary.missing_lines}</td>
                        <td>${stats.summary.excluded_lines}</td>
                        <td>${coverage.toFixed(1)}%</td>
                        <td><span class="badge ${coverage >= 80 ? 'pass' : 'fail'}">${
              coverage >= 80 ? 'PASS' : 'FAIL'
            }</span></td>
                    `;
          });
        });
    </script>
  </body>
</html>
```

### Step 13: CI/CD Integration

**Integrate tests into CI/CD pipelines**:

#### GitHub Actions Workflow

```yaml
# .github/workflows/test.yml
name: Test Suite

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  unit-tests:
    name: Unit Tests
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ['3.9', '3.10', '3.11']

    steps:
      - uses: actions/checkout@v3

      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: ${{ matrix.python-version }}

      - name: Cache dependencies
        uses: actions/cache@v3
        with:
          path: ~/.cache/pip
          key: ${{ runner.os }}-pip-${{ hashFiles('**/requirements.txt') }}

      - name: Install dependencies
        run: |
          pip install -r requirements.txt
          pip install pytest pytest-cov pytest-timeout pytest-xdist

      - name: Run unit tests
        run: |
          pytest -m unit \
            --cov=src \
            --cov-report=xml \
            --cov-report=html \
            --junitxml=test-results/junit.xml \
            -n auto \
            --timeout=60

      - name: Upload coverage to Codecov
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage.xml
          flags: unit
          name: unit-tests-${{ matrix.python-version }}

      - name: Publish test results
        uses: EnricoMi/publish-unit-test-result-action@v2
        if: always()
        with:
          files: test-results/junit.xml

  integration-tests:
    name: Integration Tests
    runs-on: ubuntu-latest
    needs: unit-tests

    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_PASSWORD: postgres
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5

      redis:
        image: redis:7
        options: >-
          --health-cmd "redis-cli ping"
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5

    steps:
      - uses: actions/checkout@v3

      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'

      - name: Install dependencies
        run: |
          pip install -r requirements.txt
          pip install pytest pytest-cov

      - name: Run integration tests
        env:
          DATABASE_URL: postgresql://postgres:postgres@localhost:5432/testdb
          REDIS_URL: redis://localhost:6379
        run: |
          pytest -m integration \
            --cov=src \
            --cov-report=xml \
            --timeout=120

      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage.xml
          flags: integration

  health-checks:
    name: Health Check Tests
    runs-on: ubuntu-latest
    needs: integration-tests

    steps:
      - uses: actions/checkout@v3

      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'

      - name: Install dependencies
        run: |
          pip install -r requirements.txt
          pip install pytest

      - name: Run health checks
        run: |
          pytest -m health --timeout=30 -v
```

### Step 14: Deliverables

Create the following test infrastructure (per global-instructions.md):

**File Structure** (using `{{folders.tests}}` and `{{files.tests}}`):

```
{{folders.tests}}/
├── README.md                      # Documentation per {{files.tests}}
├── conftest.py                    # Pytest configuration
├── __init__.py
├── timeout_watchdog.py            # Timeout enforcement
├── retry_decorator.py             # Flaky test retries
├── pytest.ini                     # Pytest settings (≥80% coverage)
├── registry.yaml                  # Test version and build tracking
├── unit/                          # Unit tests (AAA pattern)
│   ├── services/
│   ├── models/
│   └── utils/
├── integration/                   # Integration tests (with CRUD validation)
│   ├── api/
│   └── database/                  # Transaction-based with rollback
├── health/                        # Health check tests
│   └── service_health_test.py
├── regression/                    # Regression tests
│   ├── golden/                    # Expected outputs
│   └── *.regression.test.py
├── synthetic/                     # Synthetic journeys
│   └── *.journey.test.py
├── performance/                   # Performance tests per global-instructions.md
│   ├── benchmarks/                # Critical component benchmarks
│   └── profiles/                  # Performance profiles
├── security/                      # Security tests per global-instructions.md
│   ├── vulnerability_scans/
│   └── compliance_tests/
├── test_api/                      # Test Control API
│   ├── app.py                     # Flask API server
│   ├── openapi.yaml               # API specification
│   └── client.sh                  # CLI client
├── dashboard/                     # Coverage dashboard
│   └── coverage-dashboard.html
└── artifacts/                     # Test artifacts
    ├── synthetic/                 # Journey logs
    ├── test-api-results/          # API test results
    └── profiles/                  # Performance profiles
```

**Configuration Files**:

- `pytest.ini` or `pyproject.toml` (Python) with ≥80% coverage threshold
- `vitest.config.ts` (Node.js/TypeScript) with coverage enforcement
- `go.mod` with test dependencies (Go)
- `pom.xml` with JUnit 5 (Java)
- `.coveragerc` or `coverage.json` settings (fail_under = 80)
- `Makefile` or `package.json` scripts for all test types
- `{{folders.tests}}/registry.yaml` - Test version and build tracking

**CI/CD Integration**:

- `.github/workflows/test.yml` (GitHub Actions)
- `.gitlab-ci.yml` (GitLab CI)
- `Jenkinsfile` (Jenkins)
- `azure-pipelines.yml` (Azure DevOps)

**Documentation**:

Create `tests/README.md`:

````markdown
# Test Suite Documentation

## Quick Start

```bash
# Run all unit tests
make test-unit

# Run with coverage
make test-coverage

# Run in watch mode
make test-watch

# Run specific test type
pytest -m health
pytest -m regression
pytest -m integration
```
````

## Test Categories

- **Unit Tests** (`-m unit`): Fast, isolated tests
- **Integration Tests** (`-m integration`): Tests with external dependencies
- **Health Checks** (`-m health`): System component health validation
- **Regression Tests** (`-m regression`): Golden file comparisons
- **Synthetic Journeys** (`-m synthetic`): End-to-end user flows

## Coverage Requirements

- Overall: ≥80%
- Critical modules: ≥90%
- New code: ≥85%

## Test Control API

Start the Test API:

```bash
make test-api
```

Run tests via API:

```bash
curl -X POST http://localhost:5555/api/v1/tests/run \
  -H "Content-Type: application/json" \
  -d '{"test_type": "unit", "coverage": true}'
```

## CI/CD

Tests run automatically on:

- Every push to `main` or `develop`
- Every pull request
- Nightly scheduled runs

See `.github/workflows/test.yml` for configuration.

````

---

## Examples

### Example 1: Python Project with pytest

**Command**:
```bash
ai-ley build-unit-tests --mode=apply
````

**Generated structure**:

```
tests/
├── conftest.py                # Global fixtures
├── pytest.ini                 # Pytest configuration
├── unit/
│   └── test_calculator.py     # Example unit test
└── health/
    └── test_system_health.py  # Health checks
```

**Example test** (`tests/unit/test_calculator.py`):

```python
import pytest
from src.calculator import Calculator

class TestCalculator:
    @pytest.fixture
    def calc(self):
        return Calculator()

    @pytest.mark.unit
    def test_add(self, calc):
        assert calc.add(2, 3) == 5

    @pytest.mark.unit
    def test_divide_by_zero(self, calc):
        with pytest.raises(ZeroDivisionError):
            calc.divide(10, 0)
```

### Example 2: Node.js Project with Vitest

**Command**:

```bash
ai-ley build-unit-tests --mode=apply
```

**Generated structure**:

```
tests/
├── setup.ts                   # Global test setup
├── vitest.config.ts           # Vitest configuration
├── unit/
│   └── calculator.test.ts     # Example unit test
└── integration/
    └── api.integration.test.ts
```

**Example test** (`tests/unit/calculator.test.ts`):

```typescript
import { describe, it, expect } from 'vitest';
import { Calculator } from '@/calculator';

describe('Calculator', () => {
  it('should add two numbers', () => {
    const calc = new Calculator();
    expect(calc.add(2, 3)).toBe(5);
  });

  it('should throw on division by zero', () => {
    const calc = new Calculator();
    expect(() => calc.divide(10, 0)).toThrow('Division by zero');
  });
});
```

---

## Notes

### Compliance with global-instructions.md

This prompt implements all testing requirements from `.ai-ley/shared/global-instructions.md`:

1. **Unit Tests**:

   - ✅ All new functions have corresponding unit tests
   - ✅ ≥80% code coverage enforced (fail_under = 80)
   - ✅ Descriptive test names explaining scenarios
   - ✅ AAA pattern (Arrange-Act-Assert) for all tests

2. **Integration Tests**:

   - ✅ Cover interactions between components/systems
   - ✅ Realistic test data and scenarios
   - ✅ High coverage of critical user journeys
   - ✅ Mock external dependencies appropriately
   - ✅ Transaction-based database tests with auto-rollback
   - ✅ Performance tests for critical components
   - ✅ Security vulnerability testing
   - ✅ Automated tests in CI/CD pipelines
   - ✅ Edge cases and error conditions
   - ✅ CRUD testing (Create, Read, Update, Delete) with sample data validation
   - ✅ Proper cleanup after tests
   - ✅ Rollback mechanism support

3. **Test Organization**:
   - ✅ Tests stored in `{{folders.tests}}` directory
   - ✅ Descriptive names for test files and directories
   - ✅ Clear README.md in tests directory (`{{files.tests}}`)
   - ✅ Related tests grouped using subdirectories
   - ✅ Tests relate to specific versions and builds (registry.yaml)

### Technical Implementation

1. **Timeout Enforcement**: All tests have a hard 60-second timeout via watchdog process killer
2. **Retry Logic**: Flaky tests (marked with `@pytest.mark.flaky` or `@flaky` annotation) automatically retry up to 2 times
3. **Parallelization**: Tests run in parallel by default using `pytest-xdist` (Python), `vitest --threads` (Node.js), or `go test -parallel` (Go)
4. **Coverage Thresholds**: Enforced at 80% minimum per global-instructions.md; builds fail if coverage drops below threshold
5. **Test Isolation**: Each test runs in isolation with fresh fixtures and cleaned state
6. **Health Checks**: System health tests verify all components (database, cache, queue, filesystem) are operational
7. **Regression Protection**: Golden files stored in version control; any format changes require explicit approval
8. **Synthetic Journeys**: Full user workflows create audit logs in `artifacts/synthetic/` for drift analysis
9. **Test Control API**: Enables remote test execution, useful for integration with monitoring systems
10. **CI/CD Ready**: Generated workflow files work out-of-the-box with GitHub Actions, GitLab CI, Jenkins

### Best Practices

- Run `test-unit` frequently during development
- Run `test-all` before committing
- Review coverage reports weekly to maintain ≥80% threshold
- Update golden files only after manual review
- Monitor flaky test patterns and fix root causes
- Use health checks in production monitoring
- Archive synthetic journey logs for compliance
- Continuously monitor and improve test coverage and quality (per global-instructions.md)
- Refactor tests as needed to maintain clarity and effectiveness
- Document all tests and their purpose in `{{folders.tests}}/README.md`

---

## Troubleshooting

**Tests timeout constantly**:

- Check for infinite loops or blocking I/O
- Review watchdog logs in test output
- Consider increasing timeout for specific slow tests

**Flaky tests**:

- Use `@pytest.mark.flaky` to enable automatic retries
- Investigate timing issues and race conditions
- Consider using `time.sleep()` or `waitFor()` helpers

**Coverage not meeting threshold**:

- Run `make test-coverage` to see missing lines
- Add tests for uncovered branches
- Use `# pragma: no cover` for defensive code that can't be tested

**Test API not starting**:

- Check port 5555 is available: `lsof -i :5555`
- Review logs in `tests/test_api/app.log`
- Ensure Flask is installed: `pip install flask`
