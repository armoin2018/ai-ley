# Setup development environment
python3 -m venv venv
source venv/bin/activate
pip install PyGObject pycairo

# Development with hot reload
python3 main.py

# Testing
python3 -m pytest tests/

# Linting and formatting
python3 -m flake8 src/
python3 -m black src/

# Building with Meson
meson setup build
meson compile -C build

# Installing
meson install -C build

# Creating distribution packages
python3 setup.py sdist bdist_wheel

# Flatpak packaging
flatpak-builder build-dir org.example.MyApp.json