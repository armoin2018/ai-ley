# Install UI designer tools
sudo apt install cambalache  # GTK 4 (recommended)
sudo apt install glade       # GTK 3 (legacy)

# Create UI files
cambalache my_window.ui

# Load UI in application
builder = Gtk.Builder()
builder.add_from_resource('/org/example/MyApp/ui/main_window.ui')
window = builder.get_object('main_window')