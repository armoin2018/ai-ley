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