# Ubuntu/Debian
sudo apt install python3-gi python3-gi-cairo gir1.2-gtk-4.0
sudo apt install libgtk-4-dev build-essential

# Fedora/RHEL
sudo dnf install python3-gobject gtk4-devel python3-cairo-devel
sudo dnf install gcc pkg-config

# Arch Linux
sudo pacman -S python-gobject gtk4 python-cairo

# Create virtual environment
python3 -m venv gtk_env
source gtk_env/bin/activate
pip install PyGObject pycairo

# Test installation
python3 -c "import gi; gi.require_version('Gtk', '4.0'); from gi.repository import Gtk; print('GTK 4 ready!')"