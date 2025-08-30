---
applyTo: 'codeigniter, codeigniter4, ci4'
agentMode: 'framework-specific'
instructionType: 'guide'
guidelines: 'Focus on CodeIgniter 4.x with modern PHP 8.0+ features and MVC architecture'
---

# CodeIgniter Framework Instructions for AI Agents

## When to Use CodeIgniter

Use CodeIgniter when you need:

- Rapid web application development with minimal configuration
- Small to medium-sized projects with straightforward requirements
- Learning-friendly PHP framework with excellent documentation
- Lightweight framework with small footprint and fast performance
- Easy migration from legacy PHP applications
- Simple MVC architecture without complex abstractions
- Quick prototyping and MVP development
- Teams new to PHP frameworks seeking gentle learning curve
- Projects requiring minimal hosting requirements

## When to Avoid CodeIgniter

Consider alternatives when:

- Building large enterprise applications (consider Symfony or Laravel)
- Need advanced features like dependency injection or service containers
- Working with complex business logic requiring sophisticated architecture
- Building APIs requiring extensive validation and serialization (consider Laravel API)
- Need comprehensive testing tools and modern development practices
- Working with microservices architecture
- Require extensive third-party package ecosystem

## Framework Overview

- **Framework**: CodeIgniter 4.x
- **Type**: Lightweight PHP web application framework
- **Architecture**: Model-View-Controller (MVC) with simple structure
- **Language**: PHP 8.0+ with modern language features support
- **Use Cases**: Web applications, REST APIs, content management systems, small business websites

## Installation & Setup

### ✅ Recommended: Composer Installation

```bash
# Create new CodeIgniter project
composer create-project codeigniter4/appstarter my_project

# Navigate to project
cd my_project

# Set proper permissions (Linux/Mac)
chmod -R 755 writable/

# Start development server
php spark serve
# Or specify port
php spark serve --port=8080 --host=localhost
```

### Manual Installation

```bash
# Download and extract CodeIgniter
wget https://github.com/codeigniter4/CodeIgniter4/archive/v4.4.4.zip
unzip v4.4.4.zip
cd CodeIgniter4-4.4.4

# Copy app starter
cp -r app/ my_project/
cp -r public/ my_project/
cp -r writable/ my_project/

# Install dependencies
cd my_project
composer install
```

## Project Structure

```
my_project/
├── app/                    # Application code
│   ├── Config/            # Configuration files
│   │   ├── App.php       # Main app configuration
│   │   ├── Database.php  # Database configuration
│   │   └── Routes.php    # Route definitions
│   ├── Controllers/       # Controllers
│   │   ├── BaseController.php
│   │   └── Home.php      # Default controller
│   ├── Models/           # Models for database interaction
│   ├── Views/            # View templates
│   │   ├── welcome_message.php
│   │   └── errors/       # Error pages
│   ├── Helpers/          # Custom helper functions
│   ├── Libraries/        # Custom libraries
│   ├── Filters/          # Request/response filters
│   └── Language/         # Internationalization files
├── public/               # Web-accessible directory
│   ├── index.php        # Front controller
│   ├── .htaccess        # Apache rewrite rules
│   └── assets/          # CSS, JS, images
├── writable/            # Writable directories
│   ├── cache/          # Cache files
│   ├── logs/           # Log files
│   ├── session/        # Session files
│   └── uploads/        # File uploads
├── vendor/             # Composer dependencies
├── .env               # Environment configuration
├── composer.json      # Composer configuration
└── spark             # CLI tool
```

## Core Concepts

### Controllers

- **Purpose**: Handle HTTP requests and coordinate application flow
- **Usage**: Create controllers extending BaseController

```php
// app/Controllers/UserController.php
<?php

namespace App\Controllers;

use App\Models\UserModel;
use CodeIgniter\RESTful\ResourceController;
use CodeIgniter\API\ResponseTrait;

class UserController extends ResourceController
{
    use ResponseTrait;

    protected $modelName = 'App\Models\UserModel';
    protected $format = 'json';

    public function index()
    {
        $users = $this->model->findAll();
        return $this->respond($users);
    }

    public function show($id = null)
    {
        $user = $this->model->find($id);
        
        if (!$user) {
            return $this->failNotFound('User not found');
        }
        
        return $this->respond($user);
    }

    public function create()
    {
        $data = $this->request->getJSON(true);
        
        if (!$this->validate($this->getValidationRules())) {
            return $this->failValidationErrors($this->validator->getErrors());
        }
        
        $userId = $this->model->insert($data);
        $user = $this->model->find($userId);
        
        return $this->respondCreated($user);
    }

    public function update($id = null)
    {
        $user = $this->model->find($id);
        
        if (!$user) {
            return $this->failNotFound('User not found');
        }
        
        $data = $this->request->getJSON(true);
        
        if (!$this->validate($this->getValidationRules())) {
            return $this->failValidationErrors($this->validator->getErrors());
        }
        
        $this->model->update($id, $data);
        $user = $this->model->find($id);
        
        return $this->respond($user);
    }

    private function getValidationRules()
    {
        return [
            'name' => 'required|min_length[3]|max_length[50]',
            'email' => 'required|valid_email|is_unique[users.email]',
            'password' => 'required|min_length[8]'
        ];
    }
}
```

### Models

- **Purpose**: Interact with database using active record pattern
- **Usage**: Create models extending Model class

```php
// app/Models/UserModel.php
<?php

namespace App\Models;

use CodeIgniter\Model;

class UserModel extends Model
{
    protected $table = 'users';
    protected $primaryKey = 'id';
    protected $useAutoIncrement = true;
    protected $returnType = 'array';
    protected $useSoftDeletes = true;

    protected $allowedFields = [
        'name', 'email', 'password', 'phone', 'address', 'status'
    ];

    protected $useTimestamps = true;
    protected $createdField = 'created_at';
    protected $updatedField = 'updated_at';
    protected $deletedField = 'deleted_at';

    protected $validationRules = [
        'name' => 'required|min_length[3]|max_length[50]',
        'email' => 'required|valid_email|is_unique[users.email,id,{id}]',
        'password' => 'required|min_length[8]'
    ];

    protected $validationMessages = [
        'email' => [
            'is_unique' => 'This email is already registered.'
        ]
    ];

    protected $skipValidation = false;
    protected $cleanValidationRules = true;

    // Custom methods
    public function findByEmail($email)
    {
        return $this->where('email', $email)->first();
    }

    public function getActiveUsers()
    {
        return $this->where('status', 'active')->findAll();
    }

    public function getUsersWithPosts()
    {
        return $this->select('users.*, COUNT(posts.id) as post_count')
                   ->join('posts', 'posts.user_id = users.id', 'left')
                   ->groupBy('users.id')
                   ->findAll();
    }

    // Callbacks
    protected function beforeInsert(array $data)
    {
        if (isset($data['data']['password'])) {
            $data['data']['password'] = password_hash($data['data']['password'], PASSWORD_DEFAULT);
        }
        return $data;
    }

    protected function beforeUpdate(array $data)
    {
        if (isset($data['data']['password'])) {
            $data['data']['password'] = password_hash($data['data']['password'], PASSWORD_DEFAULT);
        }
        return $data;
    }
}
```

### Views and Templating

- **Purpose**: Render HTML output with data from controllers
- **Usage**: Create PHP templates with built-in parser or third-party engines

```php
// app/Views/users/index.php
<?= $this->extend('layouts/main') ?>

<?= $this->section('title') ?>User Management<?= $this->endSection() ?>

<?= $this->section('content') ?>
<div class="container">
    <h1>Users</h1>
    
    <div class="row mb-3">
        <div class="col">
            <a href="<?= route_to('users.create') ?>" class="btn btn-primary">Add New User</a>
        </div>
    </div>
    
    <?php if (session()->getFlashdata('success')): ?>
        <div class="alert alert-success">
            <?= session()->getFlashdata('success') ?>
        </div>
    <?php endif; ?>
    
    <div class="table-responsive">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Status</th>
                    <th>Created</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($users as $user): ?>
                <tr>
                    <td><?= $user['id'] ?></td>
                    <td><?= esc($user['name']) ?></td>
                    <td><?= esc($user['email']) ?></td>
                    <td>
                        <span class="badge bg-<?= $user['status'] === 'active' ? 'success' : 'secondary' ?>">
                            <?= ucfirst($user['status']) ?>
                        </span>
                    </td>
                    <td><?= date('M j, Y', strtotime($user['created_at'])) ?></td>
                    <td>
                        <a href="<?= route_to('users.show', $user['id']) ?>" class="btn btn-sm btn-info">View</a>
                        <a href="<?= route_to('users.edit', $user['id']) ?>" class="btn btn-sm btn-warning">Edit</a>
                        <form method="post" action="<?= route_to('users.delete', $user['id']) ?>" style="display:inline;">
                            <?= csrf_field() ?>
                            <input type="hidden" name="_method" value="DELETE">
                            <button type="submit" class="btn btn-sm btn-danger" 
                                    onclick="return confirm('Are you sure?')">Delete</button>
                        </form>
                    </td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
    
    <?= $pager->links() ?>
</div>
<?= $this->endSection() ?>

// app/Views/layouts/main.php
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= $this->renderSection('title') ?> - My App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <?= $this->renderSection('head') ?>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="<?= route_to('/') ?>">My App</a>
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="<?= route_to('users.index') ?>">Users</a>
                </li>
            </ul>
        </div>
    </nav>
    
    <main class="py-4">
        <?= $this->renderSection('content') ?>
    </main>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <?= $this->renderSection('scripts') ?>
</body>
</html>
```

## ✅ Best Practices

### Configuration Management

```php
// app/Config/App.php
<?php

namespace Config;

use CodeIgniter\Config\BaseConfig;

class App extends BaseConfig
{
    public string $baseURL = 'http://localhost:8080/';
    public string $indexPage = '';
    public string $uriProtocol = 'REQUEST_URI';
    public string $defaultLocale = 'en';
    public bool $negotiateLocale = false;
    public array $supportedLocales = ['en'];
    public string $appTimezone = 'America/Chicago';
    public string $charset = 'UTF-8';
    public bool $forceGlobalSecureRequests = false;

    // Session configuration
    public string $sessionDriver = 'CodeIgniter\Session\Handlers\FileHandler';
    public string $sessionCookieName = 'ci_session';
    public int $sessionExpiration = 7200;
    public string $sessionSavePath = WRITEPATH . 'session';
    public bool $sessionMatchIP = false;
    public int $sessionTimeToUpdate = 300;
    public bool $sessionRegenerateDestroy = false;

    // Cookie configuration
    public array $cookiePrefix = '';
    public string $cookieDomain = '';
    public string $cookiePath = '/';
    public bool $cookieSecure = false;
    public bool $cookieHTTPOnly = true;
    public string|null $cookieSameSite = 'Lax';

    // Security
    public bool $CSRFProtection = true;
    public string $CSRFTokenName = 'csrf_token_name';
    public string $CSRFCookieName = 'csrf_cookie_name';
    public int $CSRFExpire = 7200;
    public bool $CSRFRegenerate = true;
    public array $CSRFExcludeURIs = [];
}

// app/Config/Database.php
<?php

namespace Config;

use CodeIgniter\Database\Config;

class Database extends Config
{
    public string $filesPath = APPPATH . 'Database' . DIRECTORY_SEPARATOR;
    public string $defaultGroup = 'default';

    public array $default = [
        'DSN'      => '',
        'hostname' => 'localhost',
        'username' => 'root',
        'password' => '',
        'database' => 'ci4_app',
        'DBDriver' => 'MySQLi',
        'DBPrefix' => '',
        'pConnect' => false,
        'DBDebug'  => true,
        'charset'  => 'utf8',
        'DBCollat' => 'utf8_general_ci',
        'swapPre'  => '',
        'encrypt'  => false,
        'compress' => false,
        'strictOn' => false,
        'failover' => [],
        'port'     => 3306,
    ];

    public array $tests = [
        'DSN'      => '',
        'hostname' => 'localhost',
        'username' => 'root',
        'password' => '',
        'database' => 'ci4_test',
        'DBDriver' => 'MySQLi',
        'DBPrefix' => 'db_',
        'pConnect' => false,
        'DBDebug'  => true,
        'charset'  => 'utf8',
        'DBCollat' => 'utf8_general_ci',
        'swapPre'  => '',
        'encrypt'  => false,
        'compress' => false,
        'strictOn' => false,
        'failover' => [],
        'port'     => 3306,
    ];
}
```

### Routing Configuration

```php
// app/Config/Routes.php
<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */

// Default route
$routes->get('/', 'Home::index');

// User management routes
$routes->group('users', ['namespace' => 'App\Controllers'], function($routes) {
    $routes->get('/', 'UserController::index', ['as' => 'users.index']);
    $routes->get('create', 'UserController::new', ['as' => 'users.create']);
    $routes->post('/', 'UserController::create');
    $routes->get('(:num)', 'UserController::show/$1', ['as' => 'users.show']);
    $routes->get('(:num)/edit', 'UserController::edit/$1', ['as' => 'users.edit']);
    $routes->put('(:num)', 'UserController::update/$1');
    $routes->delete('(:num)', 'UserController::delete/$1', ['as' => 'users.delete']);
});

// API routes
$routes->group('api', ['namespace' => 'App\Controllers\API'], function($routes) {
    $routes->resource('users', ['controller' => 'UserController']);
    $routes->resource('posts', ['controller' => 'PostController']);
    
    // Custom API routes
    $routes->post('auth/login', 'AuthController::login');
    $routes->post('auth/logout', 'AuthController::logout');
    $routes->get('users/(:num)/posts', 'UserController::posts/$1');
});

// Admin routes with filter
$routes->group('admin', ['filter' => 'auth'], function($routes) {
    $routes->get('dashboard', 'Admin\DashboardController::index');
    $routes->resource('users', ['controller' => 'Admin\UserController']);
});
```

### Request Handling and Validation

```php
// app/Controllers/PostController.php
<?php

namespace App\Controllers;

use App\Models\PostModel;
use CodeIgniter\RESTful\ResourceController;

class PostController extends ResourceController
{
    protected $modelName = 'App\Models\PostModel';
    protected $format = 'json';

    public function create()
    {
        $rules = [
            'title' => 'required|min_length[3]|max_length[255]',
            'content' => 'required|min_length[10]',
            'category_id' => 'required|is_natural_no_zero',
            'featured_image' => 'uploaded[featured_image]|is_image[featured_image]|max_size[featured_image,2048]'
        ];

        if (!$this->validate($rules)) {
            return $this->failValidationErrors($this->validator->getErrors());
        }

        // Handle file upload
        $file = $this->request->getFile('featured_image');
        $imagePath = null;
        
        if ($file->isValid() && !$file->hasMoved()) {
            $imagePath = $file->store('uploads/posts');
        }

        $data = [
            'title' => $this->request->getPost('title'),
            'content' => $this->request->getPost('content'),
            'category_id' => $this->request->getPost('category_id'),
            'featured_image' => $imagePath,
            'user_id' => session()->get('user_id'),
            'status' => 'published'
        ];

        $postId = $this->model->insert($data);
        $post = $this->model->find($postId);

        return $this->respondCreated($post);
    }

    public function update($id = null)
    {
        $post = $this->model->find($id);
        
        if (!$post) {
            return $this->failNotFound('Post not found');
        }

        // Check ownership
        if ($post['user_id'] !== session()->get('user_id')) {
            return $this->failForbidden('You can only edit your own posts');
        }

        $rules = [
            'title' => 'required|min_length[3]|max_length[255]',
            'content' => 'required|min_length[10]',
            'category_id' => 'required|is_natural_no_zero'
        ];

        if (!$this->validate($rules)) {
            return $this->failValidationErrors($this->validator->getErrors());
        }

        $data = [
            'title' => $this->request->getPost('title'),
            'content' => $this->request->getPost('content'),
            'category_id' => $this->request->getPost('category_id')
        ];

        // Handle file upload if new image provided
        $file = $this->request->getFile('featured_image');
        if ($file && $file->isValid() && !$file->hasMoved()) {
            // Delete old image
            if ($post['featured_image'] && file_exists(WRITEPATH . 'uploads/' . $post['featured_image'])) {
                unlink(WRITEPATH . 'uploads/' . $post['featured_image']);
            }
            
            $data['featured_image'] = $file->store('uploads/posts');
        }

        $this->model->update($id, $data);
        $post = $this->model->find($id);

        return $this->respond($post);
    }
}
```

## Common Patterns

### Authentication and Authorization

```php
// app/Controllers/AuthController.php
<?php

namespace App\Controllers;

use App\Models\UserModel;

class AuthController extends BaseController
{
    public function login()
    {
        if ($this->request->getMethod() === 'POST') {
            $rules = [
                'email' => 'required|valid_email',
                'password' => 'required|min_length[8]'
            ];

            if (!$this->validate($rules)) {
                return redirect()->back()->withInput()->with('errors', $this->validator->getErrors());
            }

            $userModel = new UserModel();
            $user = $userModel->findByEmail($this->request->getPost('email'));

            if ($user && password_verify($this->request->getPost('password'), $user['password'])) {
                $sessionData = [
                    'user_id' => $user['id'],
                    'user_name' => $user['name'],
                    'user_email' => $user['email'],
                    'is_logged_in' => true
                ];
                
                session()->set($sessionData);
                return redirect()->to('/dashboard')->with('success', 'Welcome back!');
            } else {
                return redirect()->back()->with('error', 'Invalid credentials');
            }
        }

        return view('auth/login');
    }

    public function logout()
    {
        session()->destroy();
        return redirect()->to('/')->with('success', 'You have been logged out');
    }
}

// app/Filters/AuthFilter.php
<?php

namespace App\Filters;

use CodeIgniter\Filters\FilterInterface;
use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;

class AuthFilter implements FilterInterface
{
    public function before(RequestInterface $request, $arguments = null)
    {
        if (!session()->get('is_logged_in')) {
            return redirect()->to('/login')->with('error', 'Please log in to access this page');
        }
    }

    public function after(RequestInterface $request, ResponseInterface $response, $arguments = null)
    {
        // Do nothing
    }
}
```

### Database Migration and Seeding

```php
// app/Database/Migrations/2024-01-01-000001_CreateUsersTable.php
<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class CreateUsersTable extends Migration
{
    public function up()
    {
        $this->forge->addField([
            'id' => [
                'type' => 'INT',
                'constraint' => 5,
                'unsigned' => true,
                'auto_increment' => true,
            ],
            'name' => [
                'type' => 'VARCHAR',
                'constraint' => '100',
            ],
            'email' => [
                'type' => 'VARCHAR',
                'constraint' => '100',
                'unique' => true,
            ],
            'password' => [
                'type' => 'VARCHAR',
                'constraint' => '255',
            ],
            'status' => [
                'type' => 'ENUM',
                'constraint' => ['active', 'inactive'],
                'default' => 'active',
            ],
            'created_at' => [
                'type' => 'DATETIME',
                'null' => true,
            ],
            'updated_at' => [
                'type' => 'DATETIME',
                'null' => true,
            ],
            'deleted_at' => [
                'type' => 'DATETIME',
                'null' => true,
            ],
        ]);
        
        $this->forge->addPrimaryKey('id');
        $this->forge->createTable('users');
    }

    public function down()
    {
        $this->forge->dropTable('users');
    }
}

// app/Database/Seeds/UserSeeder.php
<?php

namespace App\Database\Seeds;

use CodeIgniter\Database\Seeder;

class UserSeeder extends Seeder
{
    public function run()
    {
        $data = [
            [
                'name' => 'Admin User',
                'email' => 'admin@example.com',
                'password' => password_hash('admin123', PASSWORD_DEFAULT),
                'status' => 'active',
                'created_at' => date('Y-m-d H:i:s'),
            ],
            [
                'name' => 'Test User',
                'email' => 'test@example.com',
                'password' => password_hash('test123', PASSWORD_DEFAULT),
                'status' => 'active',
                'created_at' => date('Y-m-d H:i:s'),
            ],
        ];

        $this->db->table('users')->insertBatch($data);
    }
}
```

## Integration Points

### Third-Party Library Integration

- **Purpose**: Integrate external libraries and packages
- **Setup**: Use Composer for dependency management
- **Usage**: 
  ```bash
  composer require monolog/monolog
  composer require guzzlehttp/guzzle
  ```

### RESTful API Development

- **Purpose**: Build APIs with proper HTTP methods and status codes
- **Setup**: Use ResourceController and ResponseTrait
- **Usage**: 
  ```php
  class APIController extends ResourceController
  {
      use ResponseTrait;
  }
  ```

## Version Compatibility

- **PHP**: 8.0+ (8.1+ recommended for better performance)
- **MySQL**: 5.7+ or MariaDB 10.3+
- **PostgreSQL**: 10.0+
- **SQLite**: 3.7.17+
- **Apache**: 2.4+ with mod_rewrite
- **Nginx**: 1.7+

## Troubleshooting

### Debug Mode

```bash
# Enable debug mode in .env
CI_ENVIRONMENT = development

# Check application logs
tail -f writable/logs/log-*.log

# Debug database queries
# Set DBDebug = true in Database config

# Use Spark commands
php spark list
php spark migrate:status
php spark cache:clear
```

### Log Analysis

- **Application logs**: `writable/logs/log-YYYY-MM-DD.log`
- **Error logs**: Check web server error logs
- **Database logs**: Enable query logging in Database config

### Common Error Messages

- **Error**: `The action you requested is not allowed`
  **Cause**: CSRF protection triggered or missing CSRF token
  **Solution**: Include `<?= csrf_field() ?>` in forms or disable CSRF for specific routes

- **Error**: `Class 'App\Models\MyModel' not found`
  **Cause**: Incorrect namespace or file not found
  **Solution**: Check namespace declaration and file location match PSR-4 standards

- **Error**: `Unable to connect to your database server`
  **Cause**: Database configuration incorrect or server unavailable
  **Solution**: Verify database credentials and server status in `app/Config/Database.php`
- **Example**: [Code example]

### [Concept 2]
- **Purpose**: [What this concept does]
- **Usage**: [How to implement/use it]
- **Example**: [Code example]

## Development Workflow
1. **Setup**: [Initial project setup steps]
2. **Development**: [Development server, hot reload, etc.]
3. **Testing**: [Testing framework and commands]
4. **Building**: [Build process and commands]
5. **Deployment**: [Deployment strategies]

## Best Practices
- [Best practice 1 with explanation]
- [Best practice 2 with explanation]
- [Best practice 3 with explanation]

## Common Patterns
### [Pattern Name]
```[language]
// Example implementation
[code example]
```

### [Pattern Name]
```[language]
// Example implementation
[code example]
```

## Configuration
### [Config File 1]
```[format]
# Configuration options
[example configuration]
```

### [Config File 2]
```[format]
# Configuration options
[example configuration]
```

## Essential Commands
```bash
# Development
[dev server command]

# Testing
[test command]

# Building
[build command]

# Linting
[lint command]

# Package management
[install dependencies]
[add new package]
[update packages]
```

## Common Issues & Solutions
### [Issue 1]
**Problem**: [Description of the problem]
**Solution**: [How to solve it]

### [Issue 2]
**Problem**: [Description of the problem]
**Solution**: [How to solve it]

## Performance Optimization
- [Optimization technique 1]
- [Optimization technique 2]
- [Optimization technique 3]

## Security Considerations
- [Security best practice 1]
- [Security best practice 2]
- [Security best practice 3]

## Useful Resources
- **Official Documentation**: [URL]
- **Community Resources**: [URLs]
- **Learning Materials**: [URLs]
- **Tools & Extensions**: [List of helpful tools]

## Framework-Specific Guidelines
### Code Style
- [Coding conventions specific to this framework]
- [Naming conventions]
- [File organization patterns]

### Architecture Patterns
- [Recommended architectural patterns]
- [State management approaches]
- [Component/module organization]

## Integration Points
### [External Service/Tool 1]
- **Purpose**: [What it integrates with]
- **Setup**: [How to configure]
- **Usage**: [Implementation examples]

### [External Service/Tool 2]
- **Purpose**: [What it integrates with]
- **Setup**: [How to configure]
- **Usage**: [Implementation examples]

## Version Compatibility
- **Node.js**: [Supported versions]
- **Dependencies**: [Key dependency versions]
- **Browser Support**: [If applicable]
- **OS Support**: [If applicable]

## Troubleshooting
### Debug Mode
```bash
[debug commands]
```

### Log Analysis
- [Where to find logs]
- [How to interpret common error messages]

### Common Error Messages
- **Error**: `[error message]`
  **Cause**: [Why this happens]
  **Solution**: [How to fix]
