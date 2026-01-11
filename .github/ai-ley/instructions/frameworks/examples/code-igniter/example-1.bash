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