# Development
python main.py

# UI file compilation
pyside6-uic mainwindow.ui -o ui_mainwindow.py

# Resource file compilation
pyside6-rcc resources.qrc -o resources_rc.py

# Translation workflow
pyside6-lupdate src/ -ts translations/app_en.ts
pyside6-lrelease translations/app_en.ts

# Testing with pytest
pytest tests/

# Type checking
mypy src/

# Code formatting
black src/
isort src/

# Packaging with cx_Freeze
pip install cx_Freeze
python setup.py build

# Creating wheel distribution
python setup.py bdist_wheel