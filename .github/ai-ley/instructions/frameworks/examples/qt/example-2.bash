# Install Python and PySide6
python -m pip install --upgrade pip
pip install PySide6 PySide6-tools

# Verify installation
python -c "import PySide6; print(f'PySide6 {PySide6.__version__} ready!')"

# Create project structure
mkdir qt_python_app && cd qt_python_app
mkdir src ui resources

# Test with simple application
cat > src/main.py << 'EOF'
import sys
from PySide6.QtWidgets import QApplication, QMainWindow, QLabel

class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Qt Python App")
        self.setCentralWidget(QLabel("Hello, Qt!"))

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec())
EOF

python src/main.py