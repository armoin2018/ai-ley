# Pytest Testing Framework Instructions

## Tool Overview
- **Tool Name**: pytest
- **Version**: 7.4+ (Python 3.8+ required)
- **Category**: Testing Framework
- **Purpose**: Comprehensive Python testing framework for unit, integration, and functional testing
- **Prerequisites**: Python 3.8+, pip package manager

## Installation & Setup
### Package Manager Installation
```bash
# Install pytest
pip install pytest

# Install with additional plugins (recommended)
pip install pytest pytest-cov pytest-xdist pytest-mock pytest-asyncio

# Install development dependencies
pip install pytest pytest-cov pytest-xdist pytest-mock pytest-asyncio pytest-html pytest-json-report

# Verify installation
pytest --version
```

### Project Integration
```bash
# Create test directory structure
mkdir tests
touch tests/__init__.py
touch tests/conftest.py
touch tests/test_example.py

# Create pytest configuration
touch pytest.ini
# or
touch pyproject.toml  # For modern Python projects
```

## Configuration

### pytest.ini Configuration
```ini
[tool:pytest]
# Test discovery
testpaths = tests
python_files = test_*.py *_test.py
python_classes = Test*
python_functions = test_*

# Output options
addopts =
    --verbose
    --tb=short
    --strict-markers
    --strict-config
    --cov=src
    --cov-report=term-missing
    --cov-report=html
    --cov-fail-under=80

# Test markers
markers =
    unit: Unit tests
    integration: Integration tests
    slow: Slow running tests
    api: API tests
    database: Database tests
    external: Tests requiring external services

# Minimum version
minversion = 7.0

# Filter warnings
filterwarnings =
    error
    ignore::UserWarning
    ignore::DeprecationWarning
```

### pyproject.toml Configuration (Modern)
```toml
[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = ["test_*.py", "*_test.py"]
python_classes = ["Test*"]
python_functions = ["test_*"]

addopts = [
    "--verbose",
    "--tb=short",
    "--strict-markers",
    "--strict-config",
    "--cov=src",
    "--cov-report=term-missing",
    "--cov-report=html",
    "--cov-fail-under=80",
]

markers = [
    "unit: Unit tests",
    "integration: Integration tests",
    "slow: Slow running tests",
    "api: API tests",
    "database: Database tests",
    "external: Tests requiring external services",
]

filterwarnings = [
    "error",
    "ignore::UserWarning",
    "ignore::DeprecationWarning",
]
```

### conftest.py - Shared Configuration
```python
import pytest
import asyncio
from unittest.mock import Mock, AsyncMock
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from myapp.database import Base
from myapp.config import TestConfig

# Pytest plugins
pytest_plugins = ["pytest_asyncio"]

# Test database setup
@pytest.fixture(scope="session")
def test_engine():
    """Create test database engine."""
    engine = create_engine("sqlite:///test.db")
    Base.metadata.create_all(engine)
    yield engine
    Base.metadata.drop_all(engine)

@pytest.fixture(scope="function")
def db_session(test_engine):
    """Create database session for each test."""
    TestingSessionLocal = sessionmaker(bind=test_engine)
    session = TestingSessionLocal()
    try:
        yield session
    finally:
        session.rollback()
        session.close()

# Async fixtures
@pytest.fixture(scope="session")
def event_loop():
    """Create event loop for async tests."""
    loop = asyncio.new_event_loop()
    yield loop
    loop.close()

@pytest.fixture
async def async_client():
    """Create async HTTP client for API testing."""
    from httpx import AsyncClient
    from myapp.main import app

    async with AsyncClient(app=app, base_url="http://test") as client:
        yield client

# Mock fixtures
@pytest.fixture
def mock_database():
    """Mock database for unit tests."""
    return Mock()

@pytest.fixture
def mock_redis():
    """Mock Redis client."""
    return AsyncMock()

@pytest.fixture
def mock_external_api():
    """Mock external API calls."""
    with patch('myapp.services.external_api') as mock:
        yield mock

# Sample data fixtures
@pytest.fixture
def sample_user():
    """Sample user data for testing."""
    return {
        "id": "123",
        "username": "testuser",
        "email": "test@example.com",
        "is_active": True
    }

@pytest.fixture
def sample_users():
    """Multiple sample users for testing."""
    return [
        {"id": "1", "username": "user1", "email": "user1@example.com"},
        {"id": "2", "username": "user2", "email": "user2@example.com"},
        {"id": "3", "username": "user3", "email": "user3@example.com"},
    ]
```

## Core Features

### Basic Test Structure
- **Purpose**: Write clear, maintainable tests with consistent structure
- **Usage**: Follow AAA (Arrange, Act, Assert) pattern
- **Example**:
```python
import pytest
from myapp.services import UserService
from myapp.models import User

class TestUserService:
    """Test suite for UserService."""

    def test_create_user_success(self, db_session, sample_user):
        """Test successful user creation."""
        # Arrange
        service = UserService(db_session)
        user_data = sample_user

        # Act
        result = service.create_user(user_data)

        # Assert
        assert result.id == user_data["id"]
        assert result.username == user_data["username"]
        assert result.email == user_data["email"]
        assert result.is_active is True

    def test_create_user_duplicate_email(self, db_session, sample_user):
        """Test user creation with duplicate email fails."""
        # Arrange
        service = UserService(db_session)
        service.create_user(sample_user)  # Create first user

        # Act & Assert
        with pytest.raises(ValueError, match="Email already exists"):
            service.create_user(sample_user)  # Try to create duplicate

    @pytest.mark.parametrize("email,is_valid", [
        ("valid@example.com", True),
        ("invalid-email", False),
        ("", False),
        ("test@", False),
        ("@example.com", False),
    ])
    def test_validate_email(self, email, is_valid):
        """Test email validation with various inputs."""
        service = UserService(None)

        if is_valid:
            assert service.validate_email(email) is True
        else:
            assert service.validate_email(email) is False
```

### Async Testing
- **Purpose**: Test asynchronous code with async/await patterns
- **Usage**: Use pytest-asyncio for async test support
- **Example**:
```python
import pytest
import asyncio
from httpx import AsyncClient
from myapp.services import AsyncUserService

class TestAsyncUserService:
    """Test suite for async user operations."""

    @pytest.mark.asyncio
    async def test_fetch_user_by_id(self, mock_database, sample_user):
        """Test async user fetching."""
        # Arrange
        mock_database.fetch_one.return_value = sample_user
        service = AsyncUserService(mock_database)

        # Act
        result = await service.get_user_by_id("123")

        # Assert
        assert result["id"] == "123"
        mock_database.fetch_one.assert_called_once_with(
            "SELECT * FROM users WHERE id = $1", "123"
        )

    @pytest.mark.asyncio
    async def test_api_endpoint_create_user(self, async_client, sample_user):
        """Test API endpoint for user creation."""
        # Arrange
        user_data = sample_user

        # Act
        response = await async_client.post("/users", json=user_data)

        # Assert
        assert response.status_code == 201
        data = response.json()
        assert data["username"] == user_data["username"]
        assert data["email"] == user_data["email"]

    @pytest.mark.asyncio
    async def test_concurrent_user_creation(self, async_client):
        """Test concurrent user creation."""
        # Arrange
        users = [
            {"username": f"user{i}", "email": f"user{i}@example.com"}
            for i in range(5)
        ]

        # Act
        tasks = [
            async_client.post("/users", json=user)
            for user in users
        ]
        responses = await asyncio.gather(*tasks)

        # Assert
        for response in responses:
            assert response.status_code == 201
```

### Fixtures and Dependency Injection
- **Purpose**: Provide reusable test data and mock objects
- **Usage**: Use fixtures for setup, teardown, and data provision
- **Example**:
```python
import pytest
from unittest.mock import Mock, patch
import tempfile
import os

@pytest.fixture(scope="session")
def test_config():
    """Test configuration that persists across test session."""
    return {
        "database_url": "sqlite:///test.db",
        "redis_url": "redis://localhost:6379/1",
        "secret_key": "test-secret-key"
    }

@pytest.fixture(scope="function")
def temp_file():
    """Create temporary file for each test."""
    fd, path = tempfile.mkstemp()
    yield path
    os.close(fd)
    os.unlink(path)

@pytest.fixture
def mock_file_system():
    """Mock file system operations."""
    with patch('builtins.open') as mock_open, \
         patch('os.path.exists') as mock_exists, \
         patch('os.makedirs') as mock_makedirs:

        mock_exists.return_value = True
        yield {
            'open': mock_open,
            'exists': mock_exists,
            'makedirs': mock_makedirs
        }

@pytest.fixture(autouse=True)
def reset_singletons():
    """Automatically reset singleton instances after each test."""
    yield
    # Reset any singleton instances here
    from myapp.services import UserService
    UserService._instance = None

class TestFileOperations:
    def test_read_file(self, temp_file):
        """Test file reading with real temporary file."""
        # Arrange
        test_content = "Hello, World!"
        with open(temp_file, 'w') as f:
            f.write(test_content)

        # Act
        with open(temp_file, 'r') as f:
            content = f.read()

        # Assert
        assert content == test_content

    def test_file_operations_mocked(self, mock_file_system):
        """Test file operations with mocked filesystem."""
        # Arrange
        mock_file_system['open'].return_value.__enter__.return_value.read.return_value = "mocked content"

        # Act
        from myapp.utils import read_config_file
        content = read_config_file("config.json")

        # Assert
        assert content == "mocked content"
        mock_file_system['open'].assert_called_once_with("config.json", 'r')
```

## Common Commands
```bash
# Basic test execution
pytest                              # Run all tests
pytest tests/                       # Run tests in directory
pytest tests/test_users.py          # Run specific test file
pytest tests/test_users.py::test_create_user  # Run specific test

# Test discovery and collection
pytest --collect-only              # Show which tests would run
pytest --collect-only -q           # Quiet collection output

# Output and reporting
pytest -v                          # Verbose output
pytest -s                          # Show print statements
pytest --tb=short                  # Short traceback format
pytest --tb=long                   # Long traceback format
pytest --tb=no                     # No traceback

# Parallel execution
pytest -n auto                     # Auto-detect CPU cores
pytest -n 4                       # Use 4 processes
pytest --dist=loadscope           # Distribute by test scope

# Coverage reporting
pytest --cov=src                  # Generate coverage report
pytest --cov=src --cov-report=html  # HTML coverage report
pytest --cov=src --cov-report=xml   # XML coverage report

# Test selection
pytest -k "user"                  # Run tests matching pattern
pytest -m "unit"                  # Run tests with specific marker
pytest -m "not slow"              # Exclude tests with marker
pytest --maxfail=1                # Stop after first failure

# Advanced options
pytest --pdb                      # Drop into debugger on failure
pytest --pdbcls=IPython.terminal.debugger:Pdb  # Use IPython debugger
pytest --durations=10             # Show 10 slowest tests
pytest --setup-show               # Show fixture setup/teardown
```

## Advanced Testing Patterns

### Parametrized Testing
```python
import pytest
from myapp.utils import calculate_tax, validate_phone

class TestParametrizedTests:
    """Examples of parametrized testing patterns."""

    @pytest.mark.parametrize("amount,rate,expected", [
        (100.0, 0.10, 10.0),
        (250.0, 0.08, 20.0),
        (0.0, 0.15, 0.0),
        (1000.0, 0.0, 0.0),
    ])
    def test_tax_calculation(self, amount, rate, expected):
        """Test tax calculation with various inputs."""
        result = calculate_tax(amount, rate)
        assert result == expected

    @pytest.mark.parametrize("phone,country,is_valid", [
        ("+1-555-123-4567", "US", True),
        ("+44-20-7946-0958", "UK", True),
        ("555-123-4567", "US", False),  # Missing country code
        ("invalid-phone", "US", False),
        ("", "US", False),
    ])
    def test_phone_validation(self, phone, country, is_valid):
        """Test phone number validation for different countries."""
        result = validate_phone(phone, country)
        assert result == is_valid

    @pytest.mark.parametrize("user_data", [
        {"username": "valid_user", "email": "user@example.com"},
        {"username": "another_user", "email": "another@example.com"},
    ], ids=["standard_user", "alternate_user"])
    def test_user_creation_multiple_valid_users(self, user_data, db_session):
        """Test user creation with multiple valid user datasets."""
        service = UserService(db_session)
        user = service.create_user(user_data)
        assert user.username == user_data["username"]
        assert user.email == user_data["email"]
```

### Exception Testing
```python
import pytest
from myapp.exceptions import ValidationError, NotFoundError
from myapp.services import UserService

class TestExceptionHandling:
    """Test exception handling and error conditions."""

    def test_user_not_found_raises_exception(self, db_session):
        """Test that getting non-existent user raises NotFoundError."""
        service = UserService(db_session)

        with pytest.raises(NotFoundError) as exc_info:
            service.get_user_by_id("nonexistent-id")

        assert "User not found" in str(exc_info.value)
        assert exc_info.value.user_id == "nonexistent-id"

    def test_invalid_email_raises_validation_error(self, db_session):
        """Test that invalid email raises ValidationError."""
        service = UserService(db_session)
        user_data = {"username": "test", "email": "invalid-email"}

        with pytest.raises(ValidationError, match="Invalid email format"):
            service.create_user(user_data)

    def test_multiple_exceptions_in_context(self, db_session):
        """Test handling multiple potential exceptions."""
        service = UserService(db_session)

        # Test that the correct exception is raised
        with pytest.raises((ValidationError, NotFoundError)) as exc_info:
            service.update_user("invalid-id", {"email": "bad-email"})

        # Check which specific exception was raised
        assert isinstance(exc_info.value, (ValidationError, NotFoundError))
```

### Database Testing
```python
import pytest
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from myapp.database import Base, User
from myapp.services import UserService

class TestDatabaseIntegration:
    """Integration tests with real database."""

    @pytest.fixture(scope="class")
    def engine(self):
        """Create test database engine for class."""
        engine = create_engine("sqlite:///test_class.db")
        Base.metadata.create_all(engine)
        yield engine
        Base.metadata.drop_all(engine)

    @pytest.fixture
    def session(self, engine):
        """Create fresh database session for each test."""
        SessionLocal = sessionmaker(bind=engine)
        session = SessionLocal()
        try:
            yield session
        finally:
            session.rollback()
            session.close()

    def test_user_crud_operations(self, session):
        """Test complete CRUD operations for users."""
        service = UserService(session)

        # Create
        user_data = {"username": "testuser", "email": "test@example.com"}
        user = service.create_user(user_data)
        assert user.id is not None

        # Read
        retrieved_user = service.get_user_by_id(user.id)
        assert retrieved_user.username == "testuser"

        # Update
        updated_user = service.update_user(user.id, {"username": "newname"})
        assert updated_user.username == "newname"

        # Delete
        result = service.delete_user(user.id)
        assert result is True

        # Verify deletion
        with pytest.raises(NotFoundError):
            service.get_user_by_id(user.id)

    def test_database_constraints(self, session):
        """Test database constraints and validations."""
        service = UserService(session)

        # Create first user
        user1_data = {"username": "user1", "email": "unique@example.com"}
        service.create_user(user1_data)

        # Try to create user with duplicate email
        user2_data = {"username": "user2", "email": "unique@example.com"}
        with pytest.raises(ValidationError, match="Email already exists"):
            service.create_user(user2_data)
```

## Performance and Load Testing
```python
import pytest
import time
import asyncio
from concurrent.futures import ThreadPoolExecutor

class TestPerformance:
    """Performance and load testing examples."""

    @pytest.mark.slow
    def test_large_dataset_processing(self, db_session):
        """Test processing large datasets."""
        service = UserService(db_session)

        # Create large dataset
        users_data = [
            {"username": f"user{i}", "email": f"user{i}@example.com"}
            for i in range(1000)
        ]

        # Measure execution time
        start_time = time.time()
        users = service.bulk_create_users(users_data)
        end_time = time.time()

        # Assert performance expectations
        execution_time = end_time - start_time
        assert execution_time < 5.0  # Should complete within 5 seconds
        assert len(users) == 1000

    @pytest.mark.asyncio
    @pytest.mark.slow
    async def test_concurrent_api_requests(self, async_client):
        """Test API under concurrent load."""
        async def make_request(user_id):
            response = await async_client.get(f"/users/{user_id}")
            return response.status_code

        # Create concurrent requests
        tasks = [make_request(i) for i in range(100)]

        start_time = time.time()
        results = await asyncio.gather(*tasks)
        end_time = time.time()

        # Assert all requests succeeded
        assert all(status == 200 for status in results)

        # Assert performance requirements
        execution_time = end_time - start_time
        assert execution_time < 2.0  # 100 requests in under 2 seconds

    def test_memory_usage(self):
        """Test memory usage patterns."""
        import psutil
        import os

        process = psutil.Process(os.getpid())
        initial_memory = process.memory_info().rss

        # Perform memory-intensive operation
        large_list = [i for i in range(1000000)]

        current_memory = process.memory_info().rss
        memory_increase = current_memory - initial_memory

        # Clean up
        del large_list

        # Assert memory usage is within expected bounds
        assert memory_increase < 100 * 1024 * 1024  # Less than 100MB
```

## Common Issues & Solutions

### Test Discovery Issues
**Problem**: pytest not finding tests
**Solution**: Check naming conventions and directory structure
```bash
# Ensure proper naming
# Files: test_*.py or *_test.py
# Functions: test_*
# Classes: Test*

# Check discovery
pytest --collect-only

# Verify configuration
pytest --markers
```

### Fixture Scope Issues
**Problem**: Fixtures not behaving as expected
**Solution**: Understand fixture scopes and dependencies
```python
# Function scope (default) - new instance per test
@pytest.fixture
def function_fixture():
    return SomeObject()

# Class scope - shared within test class
@pytest.fixture(scope="class")
def class_fixture():
    return ExpensiveObject()

# Session scope - shared across entire test session
@pytest.fixture(scope="session")
def session_fixture():
    return DatabaseConnection()
```

### Import and Path Issues
**Problem**: Import errors when running tests
**Solution**: Configure Python path and project structure
```python
# conftest.py
import sys
import os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'src'))

# Or use pytest-pythonpath plugin
# pip install pytest-pythonpath
```

### Async Test Issues
**Problem**: Async tests not running properly
**Solution**: Ensure proper async configuration
```python
# Install pytest-asyncio
# pip install pytest-asyncio

# Configure in pytest.ini or pyproject.toml
# asyncio_mode = auto

# Use proper async fixtures
@pytest.fixture
async def async_fixture():
    async with SomeAsyncContext() as context:
        yield context
```

## Integration with CI/CD

### GitHub Actions Configuration
```yaml
# .github/workflows/test.yml
name: Test Suite

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: [3.9, 3.10, 3.11, 3.12]

    steps:
    - uses: actions/checkout@v4

    - name: Set up Python ${{ matrix.python-version }}
      uses: actions/setup-python@v4
      with:
        python-version: ${{ matrix.python-version }}

    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements-dev.txt

    - name: Run tests
      run: |
        pytest --cov=src --cov-report=xml --cov-report=term-missing

    - name: Upload coverage to Codecov
      uses: codecov/codecov-action@v3
      with:
        file: ./coverage.xml
```

### Pre-commit Hook
```yaml
# .pre-commit-config.yaml
repos:
  - repo: local
    hooks:
      - id: pytest
        name: pytest
        entry: pytest
        language: system
        types: [python]
        args: ["-x", "--tb=short"]
        pass_filenames: false
```

## Useful Resources
- **Official Documentation**: https://docs.pytest.org/
- **Pytest Plugins**: https://plugincompat.herokuapp.com/
- **Best Practices**: https://docs.pytest.org/en/latest/goodpractices.html
- **pytest-asyncio**: https://pytest-asyncio.readthedocs.io/
- **pytest-cov**: https://pytest-cov.readthedocs.io/
- **pytest-mock**: https://pytest-mock.readthedocs.io/

## Version Compatibility
- **Python**: 3.8+ (pytest 7.x), 3.7+ (pytest 6.x)
- **pytest**: 7.4+ recommended, 6.x legacy support
- **Popular Plugins**: pytest-cov 4.x, pytest-xdist 3.x, pytest-asyncio 0.21+
- **Framework Integration**: FastAPI, Django, Flask, SQLAlchemy

## Troubleshooting

### Debug Mode
```bash
# Run with PDB on failure
pytest --pdb

# Use IPython debugger
pytest --pdbcls=IPython.terminal.debugger:Pdb

# Show fixture setup and teardown
pytest --setup-show

# Show why tests are skipped
pytest -rs
```

### Common Error Messages
- **Error**: `FAILED test_file.py::test_name - fixture 'fixture_name' not found`
  **Cause**: Fixture not defined or not in scope
  **Solution**: Define fixture in conftest.py or same file

- **Error**: `ImportError: attempted relative import with no known parent package`
  **Cause**: Python path issues
  **Solution**: Add project root to Python path or use absolute imports

- **Error**: `RuntimeError: There is no current event loop in thread`
  **Cause**: Async test configuration issues
  **Solution**: Install pytest-asyncio and configure properly
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

```

```
