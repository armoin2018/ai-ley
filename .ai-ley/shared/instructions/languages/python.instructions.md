---
applyTo: "**/*.py,**/*.pyw"
---

# Python Programming Instructions

Modern Python development guidelines for AI coding assistants, emphasizing Python 3.9+ features, best practices, and maintainable code patterns.

## 🧠 Context

- **Language**: Python (3.9+)
- **Environments**: CPython, PyPy, Virtual environments
- **Common Frameworks**: FastAPI, Django, Flask, Pydantic, SQLAlchemy
- **Package Managers**: pip, poetry, pipenv
- **Build Tools**: setuptools, wheel, build, hatch
- **Testing**: pytest, unittest, hypothesis, coverage
- **Type Checking**: mypy, pyright, pylance

## 📁 Project Structure

```text
src/
  controllers/      # API route handlers (FastAPI/Flask)
  services/         # Business logic layer
  repositories/     # Data access layer
  models/          # Data models and schemas
  utils/           # Utility functions and helpers
  config/          # Configuration management
  middleware/      # Application middleware
  exceptions/      # Custom exception classes
tests/
  unit/            # Unit tests
  integration/     # Integration tests
  fixtures/        # Test fixtures and data
docs/              # Documentation
scripts/           # Development and deployment scripts
migrations/        # Database migrations
```

## 🔧 General Guidelines

### Core Principles
- Write idiomatic, Pythonic code following PEP 8
- Use type hints for better code documentation and IDE support
- Prefer composition over inheritance
- Follow the principle of least surprise
- Implement proper error handling and logging
- Use context managers for resource management
- Favor explicit over implicit

### Modern Python Features
- Use type hints with `typing` module and `from __future__ import annotations`
- Leverage dataclasses and Pydantic models for data structures
- Use async/await for I/O-bound operations
- Utilize pathlib for file system operations
- Use f-strings for string formatting
- Employ match statements (Python 3.10+) when appropriate

## 📜 Code Style and Conventions

### Variable and Function Naming

```python
# ✅ Good: Use snake_case for variables, functions, and modules
user_name = "john_doe"
user_age = 25

def calculate_user_score(user: dict) -> int:
    return user["points"] * user["multiplier"]

# ✅ Good: Use PascalCase for classes
class UserManager:
    def __init__(self, database: Database) -> None:
        self.database = database

# ✅ Good: Use UPPER_SNAKE_CASE for constants
MAX_RETRY_ATTEMPTS = 3
API_BASE_URL = "https://api.example.com"

# ✅ Good: Use descriptive names with type hints
def is_user_authenticated(user_id: str) -> bool:
    return check_auth_status(user_id)

filtered_users = [user for user in users if user.is_active]
```

### Function Design with Type Hints

```python
from __future__ import annotations
from typing import Optional, Dict, List, Any, Union
from decimal import Decimal
from dataclasses import dataclass
import logging

logger = logging.getLogger(__name__)

# ✅ Good: Pure functions with clear type hints and validation
def calculate_tax(amount: Decimal, rate: Decimal) -> Decimal:
    """
    Calculate tax amount based on principal and rate.
    
    Args:
        amount: The principal amount (must be non-negative)
        rate: The tax rate as a decimal (must be between 0 and 1)
        
    Returns:
        The calculated tax amount
        
    Raises:
        ValueError: If amount is negative or rate is invalid
        TypeError: If arguments are not Decimal types
    """
    if not isinstance(amount, Decimal) or not isinstance(rate, Decimal):
        raise TypeError("Amount and rate must be Decimal types")
    
    if amount < 0:
        raise ValueError("Amount must be non-negative")
        
    if not 0 <= rate <= 1:
        raise ValueError("Rate must be between 0 and 1")
    
    return amount * rate

# ✅ Good: Data class for structured data
@dataclass
class UserProfile:
    user_id: str
    name: str
    email: str
    is_active: bool = True
    preferences: Dict[str, Any] = None
    
    def __post_init__(self) -> None:
        if self.preferences is None:
            self.preferences = {}

# ✅ Good: Async function with proper error handling
async def fetch_user_data(
    user_id: str, 
    *, 
    include_profile: bool = False,
    timeout: float = 30.0
) -> Dict[str, Any]:
    """
    Fetch user data from the API.
    
    Args:
        user_id: The unique identifier for the user
        include_profile: Whether to include profile data
        timeout: Request timeout in seconds
        
    Returns:
        Dictionary containing user data
        
    Raises:
        UserNotFoundError: When user is not found
        NetworkError: When network error occurs
    """
    try:
        async with httpx.AsyncClient(timeout=timeout) as client:
            response = await client.get(
                f"/api/users/{user_id}",
                params={"include_profile": include_profile}
            )
            response.raise_for_status()
            return response.json()
            
    except httpx.HTTPStatusError as e:
        if e.response.status_code == 404:
            raise UserNotFoundError(f"User {user_id} not found") from e
        raise NetworkError(f"HTTP {e.response.status_code}: {e.response.text}") from e
    except httpx.RequestError as e:
        raise NetworkError(f"Network error: {e}") from e
```

## 🔄 Asynchronous Programming

### Async/Await Best Practices

```python
import asyncio
from typing import List, Dict, Any, Optional
import aiohttp
import logging

logger = logging.getLogger(__name__)

# ✅ Good: Proper async context management
async def process_user_data(user_id: str) -> Dict[str, Any]:
    """Process user data with proper async patterns."""
    async with aiohttp.ClientSession() as session:
        try:
            user_task = fetch_user(session, user_id)
            profile_task = fetch_user_profile(session, user_id)
            preferences_task = fetch_user_preferences(session, user_id)
            
            user, profile, preferences = await asyncio.gather(
                user_task, profile_task, preferences_task,
                return_exceptions=True
            )
            
            # Handle individual failures gracefully
            result = {"user_id": user_id}
            
            if not isinstance(user, Exception):
                result["user"] = user
            if not isinstance(profile, Exception):
                result["profile"] = profile
            if not isinstance(preferences, Exception):
                result["preferences"] = preferences
                
            return result
            
        except Exception as e:
            logger.error(f"Error processing user data for {user_id}: {e}")
            raise ProcessingError(f"User processing failed: {e}") from e

# ✅ Good: Async iterator for streaming data
async def stream_user_updates(user_ids: List[str]) -> AsyncIterator[Dict[str, Any]]:
    """Stream user updates asynchronously."""
    semaphore = asyncio.Semaphore(10)  # Limit concurrent requests
    
    async def fetch_single_user(user_id: str) -> Optional[Dict[str, Any]]:
        async with semaphore:
            try:
                return await fetch_user_data(user_id)
            except Exception as e:
                logger.warning(f"Failed to fetch user {user_id}: {e}")
                return None
    
    tasks = [fetch_single_user(user_id) for user_id in user_ids]
    
    for task in asyncio.as_completed(tasks):
        user_data = await task
        if user_data:
            yield user_data

# ✅ Good: Async context manager
class AsyncDatabaseConnection:
    def __init__(self, connection_string: str) -> None:
        self.connection_string = connection_string
        self.connection: Optional[Any] = None
    
    async def __aenter__(self) -> "AsyncDatabaseConnection":
        self.connection = await create_connection(self.connection_string)
        return self
    
    async def __aexit__(self, exc_type, exc_val, exc_tb) -> None:
        if self.connection:
            await self.connection.close()
    
    async def execute(self, query: str, params: Dict[str, Any] = None) -> List[Dict[str, Any]]:
        if not self.connection:
            raise RuntimeError("Connection not established")
        return await self.connection.fetch(query, params or {})
```

## 🛡️ Error Handling and Logging

### Custom Exception Classes

```python
from typing import Optional, Any, Dict

class ApplicationError(Exception):
    """Base exception for application errors."""
    
    def __init__(
        self, 
        message: str, 
        *, 
        error_code: Optional[str] = None,
        context: Optional[Dict[str, Any]] = None
    ) -> None:
        super().__init__(message)
        self.error_code = error_code
        self.context = context or {}

class ValidationError(ApplicationError):
    """Raised when data validation fails."""
    
    def __init__(
        self, 
        message: str, 
        *, 
        field: Optional[str] = None,
        value: Any = None,
        **kwargs
    ) -> None:
        super().__init__(message, **kwargs)
        self.field = field
        self.value = value

class NetworkError(ApplicationError):
    """Raised when network operations fail."""
    
    def __init__(
        self, 
        message: str, 
        *, 
        status_code: Optional[int] = None,
        **kwargs
    ) -> None:
        super().__init__(message, **kwargs)
        self.status_code = status_code

# ✅ Good: Structured logging with context
import structlog

logger = structlog.get_logger()

class UserService:
    def __init__(self, database: Database, cache: Cache) -> None:
        self._database = database
        self._cache = cache
        self._logger = logger.bind(service="user_service")
    
    async def get_user(self, user_id: str) -> Optional[Dict[str, Any]]:
        """Get user with comprehensive error handling and logging."""
        log = self._logger.bind(user_id=user_id, operation="get_user")
        
        try:
            # Check cache first
            cached_user = await self._cache.get(f"user:{user_id}")
            if cached_user:
                log.info("User found in cache")
                return cached_user
            
            # Fetch from database
            log.info("Fetching user from database")
            user = await self._database.find_user_by_id(user_id)
            
            if not user:
                log.warning("User not found in database")
                return None
            
            # Cache the result
            await self._cache.set(f"user:{user_id}", user, ttl=300)
            log.info("User cached successfully")
            
            return user
            
        except DatabaseError as e:
            log.error("Database error occurred", error=str(e))
            raise
        except CacheError as e:
            log.warning("Cache error occurred, continuing without cache", error=str(e))
            # Continue without cache
            return await self._database.find_user_by_id(user_id)
        except Exception as e:
            log.error("Unexpected error occurred", error=str(e), error_type=type(e).__name__)
            raise ApplicationError(f"Failed to get user: {e}") from e
```

## 🏗️ Object-Oriented Programming

### Classes with Modern Python Features

```python
from __future__ import annotations
from typing import Protocol, ClassVar, Generic, TypeVar
from dataclasses import dataclass, field
from abc import ABC, abstractmethod
from contextlib import contextmanager

T = TypeVar('T')

# ✅ Good: Protocol for interface definition
class Cacheable(Protocol):
    def cache_key(self) -> str: ...
    def from_cache_data(self, data: Dict[str, Any]) -> Cacheable: ...

# ✅ Good: Abstract base class with proper typing
class BaseRepository(ABC, Generic[T]):
    """Abstract base repository with type safety."""
    
    model_class: ClassVar[type[T]]
    
    def __init__(self, database: Database) -> None:
        self._database = database
        self._logger = structlog.get_logger().bind(
            repository=self.__class__.__name__
        )
    
    @abstractmethod
    async def find_by_id(self, id_: str) -> Optional[T]:
        """Find entity by ID."""
        pass
    
    @abstractmethod
    async def save(self, entity: T) -> T:
        """Save entity to database."""
        pass
    
    @abstractmethod
    async def delete(self, id_: str) -> bool:
        """Delete entity by ID."""
        pass

# ✅ Good: Concrete implementation with proper encapsulation
@dataclass
class User:
    id: str
    name: str
    email: str
    is_active: bool = True
    created_at: datetime = field(default_factory=datetime.utcnow)
    preferences: Dict[str, Any] = field(default_factory=dict)
    
    def cache_key(self) -> str:
        return f"user:{self.id}"
    
    @classmethod
    def from_cache_data(cls, data: Dict[str, Any]) -> User:
        return cls(**data)
    
    def validate(self) -> None:
        """Validate user data."""
        if not self.email or "@" not in self.email:
            raise ValidationError("Invalid email address", field="email", value=self.email)
        
        if not self.name.strip():
            raise ValidationError("Name cannot be empty", field="name")

class UserRepository(BaseRepository[User]):
    model_class = User
    
    async def find_by_id(self, user_id: str) -> Optional[User]:
        """Find user by ID with caching."""
        try:
            data = await self._database.fetch_one(
                "SELECT * FROM users WHERE id = $1", user_id
            )
            
            if not data:
                return None
                
            return User(**dict(data))
            
        except Exception as e:
            self._logger.error(
                "Failed to find user", 
                user_id=user_id, 
                error=str(e)
            )
            raise
    
    async def save(self, user: User) -> User:
        """Save user with validation."""
        user.validate()
        
        query = """
            INSERT INTO users (id, name, email, is_active, preferences)
            VALUES ($1, $2, $3, $4, $5)
            ON CONFLICT (id) DO UPDATE SET
                name = EXCLUDED.name,
                email = EXCLUDED.email,
                is_active = EXCLUDED.is_active,
                preferences = EXCLUDED.preferences
            RETURNING *
        """
        
        try:
            data = await self._database.fetch_one(
                query, 
                user.id, user.name, user.email, 
                user.is_active, user.preferences
            )
            
            return User(**dict(data))
            
        except Exception as e:
            self._logger.error(
                "Failed to save user", 
                user_id=user.id, 
                error=str(e)
            )
            raise
```

## 🔧 Functional Programming Patterns

### Higher-Order Functions and Utilities

```python
from functools import wraps, lru_cache, singledispatch, partial
from operator import itemgetter, attrgetter
from itertools import chain, groupby, islice
from typing import Callable, Iterable, Iterator, TypeVar, Any

T = TypeVar('T')
U = TypeVar('U')

# ✅ Good: Decorators for common patterns
def retry(max_attempts: int = 3, delay: float = 1.0):
    """Retry decorator with exponential backoff."""
    def decorator(func: Callable[..., T]) -> Callable[..., T]:
        @wraps(func)
        async def wrapper(*args, **kwargs) -> T:
            last_exception = None
            
            for attempt in range(max_attempts):
                try:
                    return await func(*args, **kwargs)
                except Exception as e:
                    last_exception = e
                    if attempt < max_attempts - 1:
                        wait_time = delay * (2 ** attempt)
                        await asyncio.sleep(wait_time)
                    else:
                        break
            
            raise last_exception
        return wrapper
    return decorator

def validate_input(**validators):
    """Validation decorator for function inputs."""
    def decorator(func: Callable) -> Callable:
        @wraps(func)
        def wrapper(*args, **kwargs):
            # Validate keyword arguments
            for param_name, validator in validators.items():
                if param_name in kwargs:
                    value = kwargs[param_name]
                    if not validator(value):
                        raise ValidationError(
                            f"Invalid value for {param_name}: {value}",
                            field=param_name,
                            value=value
                        )
            
            return func(*args, **kwargs)
        return wrapper
    return decorator

# ✅ Good: Functional composition utilities
def pipe(*functions: Callable) -> Callable:
    """Compose functions left to right (pipe)."""
    def composed(value):
        for func in functions:
            value = func(value)
        return value
    return composed

def compose(*functions: Callable) -> Callable:
    """Compose functions right to left."""
    def composed(value):
        for func in reversed(functions):
            value = func(value)
        return value
    return composed

# ✅ Good: Data transformation pipeline
def process_users(users: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
    """Process users using functional composition."""
    return pipe(
        partial(filter, lambda u: u.get("is_active", False)),
        partial(map, lambda u: {
            **u,
            "full_name": f"{u.get('first_name', '')} {u.get('last_name', '')}".strip()
        }),
        partial(sorted, key=itemgetter("created_at")),
        list
    )(users)

# ✅ Good: Generator functions for memory efficiency
def chunked(iterable: Iterable[T], chunk_size: int) -> Iterator[List[T]]:
    """Yield chunks of specified size from iterable."""
    iterator = iter(iterable)
    while True:
        chunk = list(islice(iterator, chunk_size))
        if not chunk:
            break
        yield chunk

def flatten(nested_iterable: Iterable[Iterable[T]]) -> Iterator[T]:
    """Flatten nested iterables."""
    return chain.from_iterable(nested_iterable)

@singledispatch
def serialize(obj: Any) -> Any:
    """Generic serialization function."""
    return str(obj)

@serialize.register
def _(obj: datetime) -> str:
    return obj.isoformat()

@serialize.register
def _(obj: Decimal) -> float:
    return float(obj)

@serialize.register
def _(obj: dict) -> Dict[str, Any]:
    return {key: serialize(value) for key, value in obj.items()}
```

## 🎯 Performance Optimization

### Efficient Code Patterns

```python
from functools import lru_cache, cached_property
from contextlib import contextmanager
from typing import Dict, Any, Iterator
import weakref

# ✅ Good: Caching for expensive operations
class DataProcessor:
    def __init__(self, config: Dict[str, Any]) -> None:
        self.config = config
        self._cache: Dict[str, Any] = {}
    
    @lru_cache(maxsize=128)
    def expensive_calculation(self, value: int) -> int:
        """Cache expensive calculations."""
        # Simulate expensive operation
        return sum(i ** 2 for i in range(value))
    
    @cached_property
    def compiled_regex(self) -> re.Pattern:
        """Cache compiled regex patterns."""
        pattern = self.config.get("pattern", r"\d+")
        return re.compile(pattern)
    
    def process_with_local_cache(self, key: str, data: Any) -> Any:
        """Use local caching for method-level optimization."""
        if key in self._cache:
            return self._cache[key]
        
        result = self._process_data(data)
        self._cache[key] = result
        return result

# ✅ Good: Memory-efficient data processing
def process_large_file(file_path: str, chunk_size: int = 8192) -> Iterator[str]:
    """Process large files efficiently using generators."""
    with open(file_path, 'r', encoding='utf-8') as file:
        while True:
            chunk = file.read(chunk_size)
            if not chunk:
                break
            yield chunk.strip()

def batch_process(
    items: Iterable[T], 
    processor: Callable[[List[T]], List[U]], 
    batch_size: int = 100
) -> Iterator[U]:
    """Process items in batches for memory efficiency."""
    batch = []
    
    for item in items:
        batch.append(item)
        
        if len(batch) >= batch_size:
            yield from processor(batch)
            batch = []
    
    # Process remaining items
    if batch:
        yield from processor(batch)

# ✅ Good: Resource management with context managers
@contextmanager
def database_transaction(connection: Database) -> Iterator[Database]:
    """Context manager for database transactions."""
    transaction = connection.begin()
    try:
        yield connection
        transaction.commit()
    except Exception:
        transaction.rollback()
        raise
    finally:
        transaction.close()

# ✅ Good: Weak references to avoid memory leaks
class EventManager:
    def __init__(self) -> None:
        self._observers: weakref.WeakSet = weakref.WeakSet()
    
    def register_observer(self, observer: Any) -> None:
        """Register observer using weak reference."""
        self._observers.add(observer)
    
    def notify_observers(self, event: str, data: Any) -> None:
        """Notify all observers safely."""
        # Create a copy to avoid iteration issues
        observers = list(self._observers)
        for observer in observers:
            if hasattr(observer, 'handle_event'):
                try:
                    observer.handle_event(event, data)
                except Exception as e:
                    logger.warning(f"Observer error: {e}")
```

## 🧪 Testing Guidelines

### Comprehensive Testing with pytest

```python
# test_user_service.py
import pytest
from unittest.mock import AsyncMock, MagicMock, patch
from datetime import datetime, timezone
import asyncio

from src.services.user_service import UserService
from src.models.user import User
from src.exceptions import UserNotFoundError, ValidationError

class TestUserService:
    @pytest.fixture
    def mock_database(self):
        return AsyncMock()
    
    @pytest.fixture
    def mock_cache(self):
        return AsyncMock()
    
    @pytest.fixture
    def user_service(self, mock_database, mock_cache):
        return UserService(mock_database, mock_cache)
    
    @pytest.fixture
    def sample_user(self):
        return User(
            id="123",
            name="John Doe",
            email="john@example.com",
            is_active=True,
            created_at=datetime.now(timezone.utc)
        )
    
    @pytest.mark.asyncio
    async def test_get_user_from_cache(self, user_service, mock_cache, sample_user):
        """Test getting user from cache when available."""
        # Arrange
        user_id = "123"
        mock_cache.get.return_value = sample_user.__dict__
        
        # Act
        result = await user_service.get_user(user_id)
        
        # Assert
        assert result == sample_user.__dict__
        mock_cache.get.assert_called_once_with(f"user:{user_id}")
        user_service._database.find_user_by_id.assert_not_called()
    
    @pytest.mark.asyncio
    async def test_get_user_from_database_when_not_cached(
        self, user_service, mock_database, mock_cache, sample_user
    ):
        """Test fetching user from database when not in cache."""
        # Arrange
        user_id = "123"
        mock_cache.get.return_value = None
        mock_database.find_user_by_id.return_value = sample_user
        
        # Act
        result = await user_service.get_user(user_id)
        
        # Assert
        assert result == sample_user
        mock_database.find_user_by_id.assert_called_once_with(user_id)
        mock_cache.set.assert_called_once()
    
    @pytest.mark.asyncio
    async def test_get_user_raises_not_found_error(
        self, user_service, mock_database, mock_cache
    ):
        """Test that UserNotFoundError is raised when user doesn't exist."""
        # Arrange
        user_id = "nonexistent"
        mock_cache.get.return_value = None
        mock_database.find_user_by_id.return_value = None
        
        # Act & Assert
        with pytest.raises(UserNotFoundError, match="User nonexistent not found"):
            await user_service.get_user(user_id)
    
    @pytest.mark.parametrize("email,should_raise", [
        ("valid@example.com", False),
        ("invalid-email", True),
        ("", True),
        ("@example.com", True),
        ("user@", True),
    ])
    def test_user_validation(self, email, should_raise):
        """Test user validation with various email formats."""
        user = User(id="123", name="Test User", email=email)
        
        if should_raise:
            with pytest.raises(ValidationError):
                user.validate()
        else:
            # Should not raise
            user.validate()

# test_integration.py - Integration testing
@pytest.mark.integration
class TestUserAPIIntegration:
    @pytest.fixture(scope="class")
    async def app(self):
        """Create test application instance."""
        from src.main import create_app
        app = create_app(testing=True)
        yield app
    
    @pytest.fixture(scope="class")
    async def client(self, app):
        """Create test client."""
        async with AsyncClient(app=app, base_url="http://test") as client:
            yield client
    
    @pytest.fixture(autouse=True)
    async def setup_database(self):
        """Setup and teardown test database."""
        await setup_test_database()
        yield
        await cleanup_test_database()
    
    @pytest.mark.asyncio
    async def test_create_user_endpoint(self, client):
        """Test user creation endpoint."""
        user_data = {
            "name": "John Doe",
            "email": "john@example.com"
        }
        
        response = await client.post("/api/users", json=user_data)
        
        assert response.status_code == 201
        assert response.json()["name"] == user_data["name"]
        assert response.json()["email"] == user_data["email"]
        assert "id" in response.json()
    
    @pytest.mark.asyncio
    async def test_get_user_endpoint_returns_404_for_nonexistent(self, client):
        """Test that getting nonexistent user returns 404."""
        response = await client.get("/api/users/nonexistent-id")
        
        assert response.status_code == 404
        assert "not found" in response.json()["detail"].lower()

# conftest.py - Shared test configuration
@pytest.fixture(scope="session")
def event_loop():
    """Create event loop for async tests."""
    loop = asyncio.new_event_loop()
    yield loop
    loop.close()

@pytest.fixture
def anyio_backend():
    """Use asyncio backend for anyio."""
    return "asyncio"
```

## 📦 Package Management and Project Structure

### Modern Dependency Management

```python
# pyproject.toml
[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[project]
name = "my-python-project"
dynamic = ["version"]
description = "A modern Python project"
readme = "README.md"
requires-python = ">=3.9"
license = "MIT"
authors = [
    { name = "Your Name", email = "your.email@example.com" },
]
classifiers = [
    "Development Status :: 4 - Beta",
    "Programming Language :: Python :: 3",
    "Programming Language :: Python :: 3.9",
    "Programming Language :: Python :: 3.10",
    "Programming Language :: Python :: 3.11",
    "Programming Language :: Python :: 3.12",
]
dependencies = [
    "fastapi>=0.104.0",
    "pydantic>=2.0.0",
    "httpx>=0.25.0",
    "structlog>=23.0.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=7.0.0",
    "pytest-asyncio>=0.21.0",
    "pytest-cov>=4.0.0",
    "black>=23.0.0",
    "isort>=5.12.0",
    "mypy>=1.5.0",
    "ruff>=0.1.0",
]
docs = [
    "mkdocs>=1.5.0",
    "mkdocs-material>=9.0.0",
]

[project.scripts]
my-cli = "my_project.cli:main"

[tool.hatch.version]
path = "src/my_project/__about__.py"

[tool.black]
line-length = 88
target-version = ['py39']
include = '\.pyi?$'

[tool.isort]
profile = "black"
multi_line_output = 3

[tool.mypy]
python_version = "3.9"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true
disallow_incomplete_defs = true
check_untyped_defs = true
no_implicit_optional = true
warn_redundant_casts = true
warn_unused_ignores = true
warn_no_return = true
warn_unreachable = true
strict_equality = true

[tool.pytest.ini_options]
minversion = "7.0"
addopts = "-ra -q --strict-markers --strict-config"
testpaths = ["tests"]
markers = [
    "integration: marks tests as integration tests",
    "unit: marks tests as unit tests",
    "slow: marks tests as slow",
]

[tool.coverage.run]
source = ["src"]
omit = ["*/tests/*"]

[tool.coverage.report]
exclude_lines = [
    "pragma: no cover",
    "def __repr__",
    "raise AssertionError",
    "raise NotImplementedError",
]
```

## 🛠️ Development Tools and Configuration

### Code Quality Tools

```python
# .pre-commit-config.yaml (YAML format but included for completeness)
"""
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
  
  - repo: https://github.com/psf/black
    rev: 23.9.1
    hooks:
      - id: black
  
  - repo: https://github.com/pycqa/isort
    rev: 5.12.0
    hooks:
      - id: isort
  
  - repo: https://github.com/charliermarsh/ruff-pre-commit
    rev: v0.1.0
    hooks:
      - id: ruff
        args: [--fix, --exit-non-zero-on-fix]
  
  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.5.1
    hooks:
      - id: mypy
        additional_dependencies: [types-requests]
"""

# ruff.toml
[tool.ruff]
target-version = "py39"
line-length = 88
select = [
    "E",   # pycodestyle errors
    "W",   # pycodestyle warnings
    "F",   # pyflakes
    "I",   # isort
    "B",   # flake8-bugbear
    "C4",  # flake8-comprehensions
    "UP",  # pyupgrade
]
ignore = [
    "E501",  # line too long, handled by black
    "B008",  # do not perform function calls in argument defaults
]

[tool.ruff.per-file-ignores]
"__init__.py" = ["F401"]  # Ignore unused imports in __init__.py
"tests/**/*" = ["B011"]   # Allow assert statements in tests
```

## 🚫 Common Pitfalls to Avoid

### Anti-Patterns and Best Practices

```python
# ❌ Bad: Mutable default arguments
def process_items(items, processed=[]):  # DON'T DO THIS
    processed.append(len(items))
    return processed

# ✅ Good: Use None and create new instance
def process_items(items: List[Any], processed: Optional[List[int]] = None) -> List[int]:
    if processed is None:
        processed = []
    processed.append(len(items))
    return processed

# ❌ Bad: Catching all exceptions
try:
    risky_operation()
except:  # DON'T DO THIS
    pass

# ✅ Good: Catch specific exceptions
try:
    risky_operation()
except (ValueError, TypeError) as e:
    logger.error(f"Operation failed: {e}")
    raise

# ❌ Bad: Using string concatenation in loops
result = ""
for item in items:
    result += str(item)  # DON'T DO THIS

# ✅ Good: Use join for string concatenation
result = "".join(str(item) for item in items)

# ❌ Bad: Modifying list while iterating
for item in items:
    if should_remove(item):
        items.remove(item)  # DON'T DO THIS

# ✅ Good: Create new list or iterate backwards
items = [item for item in items if not should_remove(item)]
# OR
for i in range(len(items) - 1, -1, -1):
    if should_remove(items[i]):
        del items[i]

# ❌ Bad: Using global variables
config = {}  # DON'T DO THIS

def get_setting(key):
    return config.get(key)

# ✅ Good: Use dependency injection or configuration class
@dataclass
class Config:
    database_url: str
    api_key: str
    debug: bool = False

def get_setting(config: Config, key: str) -> Any:
    return getattr(config, key, None)
```

## 📚 Essential Libraries and Tools

### Recommended Python Ecosystem

```python
# Core Libraries (Python 3.9+)
from __future__ import annotations  # Enable postponed evaluation
import asyncio                      # Async programming
import logging                      # Structured logging
import pathlib                      # Modern path handling
import dataclasses                  # Data structures
import typing                       # Type hints
import contextlib                   # Context managers
import functools                    # Function tools
import itertools                    # Iterator utilities
import collections                  # Specialized containers

# Essential Third-Party Libraries
import httpx                        # Modern HTTP client
import pydantic                     # Data validation
import structlog                    # Structured logging
import click                        # CLI applications
import rich                         # Rich text and formatting
import pytest                       # Testing framework
import sqlalchemy                   # Database ORM
import fastapi                      # Web API framework
import redis                        # Caching and message broker

# Type Checking and Development
import mypy                         # Static type checking
import black                        # Code formatting
import isort                        # Import sorting
import ruff                         # Fast linting
import pre_commit                   # Git hooks
```

## 🎯 Performance Guidelines

### Memory and Execution Optimization

- **Avoid string concatenation in loops**: Use `''.join()` for combining multiple strings
- **Use generators for large datasets**: Memory-efficient iteration over large collections
- **Cache expensive computations**: Use `@lru_cache` or custom caching strategies
- **Prefer list comprehensions**: More efficient than equivalent for loops for simple operations
- **Use `__slots__`**: For classes with many instances to reduce memory usage
- **Profile before optimizing**: Use `cProfile`, `line_profiler`, or `memory_profiler`
- **Async for I/O operations**: Use async/await for network and file I/O
- **Connection pooling**: Reuse database and HTTP connections

## 📊 Testing and Quality Assurance

### Testing Strategy

1. **Unit Tests**: Test individual functions and methods in isolation
2. **Integration Tests**: Test component interactions and external dependencies
3. **Property-Based Testing**: Use Hypothesis for generating test cases
4. **Performance Tests**: Benchmark critical code paths
5. **Coverage**: Aim for 80%+ test coverage on core business logic
6. **Mutation Testing**: Use tools like `mutmut` to test your tests

### Code Quality Metrics

- **Cyclomatic Complexity**: Keep functions simple (complexity < 10)
- **Line Length**: Maximum 88 characters (Black standard)
- **Function Length**: Keep functions focused and under 20-30 lines
- **Module Length**: Split large modules into smaller, focused ones
- **Documentation**: Document all public APIs with comprehensive docstrings

## 📚 Resources and References

- [Python Enhancement Proposals (PEPs)](https://peps.python.org/)
- [Python Developer's Guide](https://devguide.python.org/)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Pydantic Documentation](https://docs.pydantic.dev/)
- [pytest Documentation](https://docs.pytest.org/)
- [mypy Documentation](https://mypy.readthedocs.io/)
- [Structlog Documentation](https://structlog.org/)
- [Python Patterns](https://python-patterns.guide/)
- [Effective Python by Brett Slatkin](https://effectivepython.com/)
- [Architecture Patterns with Python](https://www.cosmicpython.com/)

## AI Assistant Guidelines
When helping with Python:

1. **Always use modern Python features and type hints (3.9+)**
2. **Prioritize code readability and maintainability over performance optimizations**
3. **Include proper error handling with specific exception types**
4. **Suggest appropriate design patterns for the problem domain**
5. **Include comprehensive testing examples with pytest**
6. **Recommend async/await for I/O-bound operations**
7. **Provide configuration and environment management guidance**
8. **Include logging and monitoring best practices**

### Code Generation Rules
- Generate code with comprehensive type hints using modern syntax
- Include proper error handling with logging and structured exceptions
- Use dataclasses or Pydantic models for data structures
- Implement proper resource management with context managers
- Include docstrings for all public functions and classes
- Follow PEP 8 and use Black formatting standards
- Provide both synchronous and asynchronous examples where applicable
- Include unit test examples for generated functions and classes
- Use modern Python idioms (f-strings, pathlib, dataclasses, etc.)
- Consider security implications (input validation, SQL injection prevention)

### Performance Enforcement
- ✅ Promote list comprehensions over for loops for simple operations
- ✅ Suggest generators for memory-efficient iteration
- ✅ Recommend `@lru_cache` for expensive computations
- 🚫 Block string concatenation in loops without suggesting `join()`
- 🚫 Block bare `except:` clauses without specific exception handling
- ✅ Promote async/await for I/O operations
- ✅ Suggest connection pooling for database and HTTP operations

### Security Enforcement
- 🔒 Enforce parameterized queries for database operations
- 🔒 Block direct string formatting in SQL queries
- 🔒 Require input validation for user data
- 🔒 Promote secure random generation with `secrets` module
- 🔒 Suggest environment variables for sensitive configuration