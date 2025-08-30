---
applyTo: 'gtk, gtk3, gtk4, libgtk, gi-gtk'
agentMode: 'framework-specific'
instructionType: 'guide'
guidelines: 'Focus on GTK 4.0+ for modern native Linux desktop applications'
---

# GTK Framework Instructions for AI Agents

## When to Use GTK

Use GTK when you need:

- Native Linux desktop applications with system integration
- Applications that feel truly native on GNOME/Linux environments
- High-performance UI with low memory footprint
- Accessibility support built into the framework
- Integration with Linux desktop standards (D-Bus, GSettings, etc.)
- Applications requiring complex custom widgets and drawing
- Multi-language desktop applications with gettext support
- Applications following GNOME Human Interface Guidelines

## When to Avoid GTK

Consider alternatives when:

- Targeting primarily Windows or macOS platforms
- Building simple applications that don't need native integration
- Team lacks C/Python/Rust experience
- Need web-based UI technologies and rapid prototyping
- Require extensive cross-platform consistency in appearance
- Building primarily data visualization or chart-heavy applications
- Working with teams preferring declarative UI frameworks

## Framework Overview

- **Framework**: GTK 4.0+ (GIMP Toolkit)
- **Type**: Native cross-platform desktop UI toolkit
- **Languages**: C (primary), Python (via PyGObject), Rust (via gtk-rs), JavaScript (via GJS)
- **Platform**: Linux (primary), Windows, macOS (experimental)
- **Use Cases**: Native desktop applications, system tools, GNOME applications, Linux utilities

## Installation & Setup

### ✅ Recommended: GTK 4 with Python (PyGObject)

```bash
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
```

### ✅ Alternative: GTK with Rust (gtk-rs)

```bash
# Install Rust (if not already installed)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env

# Install GTK 4 development packages
sudo apt install libgtk-4-dev  # Ubuntu/Debian
sudo dnf install gtk4-devel    # Fedora
sudo pacman -S gtk4            # Arch

# Create new Rust project
cargo new gtk_app
cd gtk_app

# Add GTK dependency to Cargo.toml
echo 'gtk = { version = "0.7", package = "gtk4" }' >> Cargo.toml
echo 'glib = "0.18"' >> Cargo.toml
echo 'gio = "0.18"' >> Cargo.toml
```

### ✅ GTK with C (Traditional)

```bash
# Install development tools
sudo apt install build-essential pkg-config libgtk-4-dev

# Create simple project structure
mkdir gtk_c_app && cd gtk_c_app
```

### AI Agent Decision Tree

- **For rapid prototyping**: Use Python with PyGObject for quick development
- **For performance-critical apps**: Use C or Rust for maximum performance
- **For modern applications**: Use GTK 4 for latest features and best practices
- **For GNOME integration**: Follow GNOME HIG and use libadwaita
- **For simple tools**: GTK 3 might be sufficient for basic applications

## Project Structure

### ✅ Python GTK Project Structure

```
gtk_python_app/
├── main.py                  # Application entry point
├── src/
│   ├── __init__.py
│   ├── application.py       # Main application class
│   ├── window.py           # Main window implementation
│   ├── widgets/            # Custom widgets
│   │   ├── __init__.py
│   │   ├── custom_button.py
│   │   └── file_chooser.py
│   ├── models/             # Data models
│   │   ├── __init__.py
│   │   └── document.py
│   ├── controllers/        # Business logic
│   │   ├── __init__.py
│   │   └── file_manager.py
│   └── utils/              # Utility functions
│       ├── __init__.py
│       └── helpers.py
├── data/                   # Application data
│   ├── ui/                 # UI definition files
│   │   ├── main_window.ui
│   │   └── preferences.ui
│   ├── icons/              # Application icons
│   └── schemas/            # GSettings schemas
├── po/                     # Translation files
├── tests/                  # Unit tests
├── requirements.txt        # Python dependencies
├── setup.py               # Installation script
├── meson.build            # Build configuration
└── README.md
```

### ✅ Rust GTK Project Structure

```
gtk_rust_app/
├── Cargo.toml             # Rust dependencies
├── Cargo.lock
├── src/
│   ├── main.rs            # Application entry point
│   ├── application.rs     # Application setup
│   ├── window.rs          # Main window
│   ├── widgets/           # Custom widgets
│   │   ├── mod.rs
│   │   ├── custom_button.rs
│   │   └── file_chooser.rs
│   ├── models/            # Data structures
│   │   ├── mod.rs
│   │   └── document.rs
│   ├── controllers/       # Business logic
│   │   ├── mod.rs
│   │   └── file_manager.rs
│   └── utils/             # Utilities
│       ├── mod.rs
│       └── helpers.rs
├── data/
│   ├── resources/         # GResource files
│   │   ├── ui/
│   │   └── icons/
│   └── schemas/
├── build.rs               # Build script
├── tests/                 # Integration tests
└── target/                # Build output
```

### ✅ C GTK Project Structure

```
gtk_c_app/
├── src/
│   ├── main.c             # Application entry point
│   ├── application.c      # Application implementation
│   ├── application.h      # Application header
│   ├── window.c           # Main window
│   ├── window.h
│   ├── widgets/           # Custom widgets
│   │   ├── custom-button.c
│   │   └── custom-button.h
│   └── utils/             # Utility functions
│       ├── helpers.c
│       └── helpers.h
├── data/
│   ├── ui/                # UI files
│   ├── icons/
│   └── schemas/
├── po/                    # Internationalization
├── tests/                 # Tests
├── Makefile               # Build configuration
├── meson.build            # Modern build system
└── configure.ac           # Autotools (legacy)
```

## Core Concepts

### Application Architecture

✅ **Best Practice**: Modern GTK 4 application with proper MVC separation

```python
# src/application.py - Main Application Class
import gi
gi.require_version('Gtk', '4.0')
gi.require_version('Adw', '1')

from gi.repository import Gtk, Adw, Gio, GLib
import sys
import os

from .window import MainWindow
from .preferences import PreferencesWindow

class MyApplication(Adw.Application):
    """Main application class implementing GTK Application pattern."""

    def __init__(self):
        super().__init__(
            application_id='org.example.MyApp',
            flags=Gio.ApplicationFlags.DEFAULT_FLAGS
        )

        self.create_action('quit', self.on_quit_action, ['<primary>q'])
        self.create_action('about', self.on_about_action)
        self.create_action('preferences', self.on_preferences_action, ['<primary>comma'])
        self.create_action('new_window', self.on_new_window_action, ['<primary>n'])

        self.windows = []
        self.settings = Gio.Settings.new('org.example.MyApp')

    def create_action(self, name, callback, shortcuts=None):
        """Create application action with optional keyboard shortcuts."""
        action = Gio.SimpleAction.new(name, None)
        action.connect('activate', callback)
        self.add_action(action)

        if shortcuts:
            self.set_accels_for_action(f'app.{name}', shortcuts)

    def do_activate(self):
        """Called when application is activated."""
        window = self.props.active_window
        if not window:
            window = MainWindow(application=self)
            self.windows.append(window)

        window.present()

    def do_startup(self):
        """Called once when application starts."""
        Adw.Application.do_startup(self)

        # Load custom CSS
        self.load_css()

        # Initialize application resources
        self.init_resources()

    def load_css(self):
        """Load custom CSS styling."""
        css_provider = Gtk.CssProvider()
        css_path = os.path.join(os.path.dirname(__file__), '..', 'data', 'style.css')

        if os.path.exists(css_path):
            css_provider.load_from_path(css_path)
            Gtk.StyleContext.add_provider_for_display(
                self.get_display(),
                css_provider,
                Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
            )

    def init_resources(self):
        """Initialize application resources."""
        resource_path = '/org/example/MyApp'
        resource = Gio.Resource.load(os.path.join(
            os.path.dirname(__file__), '..', 'data', 'resources.gresource'
        ))
        Gio.resources_register(resource)

    def on_quit_action(self, action, param):
        """Handle quit action."""
        self.quit()

    def on_about_action(self, action, param):
        """Show about dialog."""
        about_dialog = Adw.AboutWindow(
            transient_for=self.props.active_window,
            application_name='My GTK App',
            application_icon='org.example.MyApp',
            developer_name='Your Name',
            version='1.0.0',
            copyright='© 2025 Your Name',
            license_type=Gtk.License.GPL_3_0,
            website='https://example.org',
            issue_url='https://github.com/user/repo/issues',
            developers=['Your Name <your.email@example.com>']
        )
        about_dialog.present()

    def on_preferences_action(self, action, param):
        """Show preferences window."""
        prefs_window = PreferencesWindow(transient_for=self.props.active_window)
        prefs_window.present()

    def on_new_window_action(self, action, param):
        """Create new application window."""
        window = MainWindow(application=self)
        self.windows.append(window)
        window.present()

def main():
    """Application entry point."""
    app = MyApplication()
    return app.run(sys.argv)
```

### Window Management with Libadwaita

✅ **Best Practice**: Modern adaptive UI with Libadwaita components

```python
# src/window.py - Main Window Implementation
import gi
gi.require_version('Gtk', '4.0')
gi.require_version('Adw', '1')

from gi.repository import Gtk, Adw, Gio, GLib
from .widgets.file_chooser import FileChooserWidget
from .controllers.file_manager import FileManager

@Gtk.Template(resource_path='/org/example/MyApp/ui/main_window.ui')
class MainWindow(Adw.ApplicationWindow):
    """Main application window with adaptive layout."""

    __gtype_name__ = 'MainWindow'

    # Template widgets (defined in UI file)
    header_bar = Gtk.Template.Child()
    main_box = Gtk.Template.Child()
    sidebar = Gtk.Template.Child()
    content_area = Gtk.Template.Child()
    status_bar = Gtk.Template.Child()

    def __init__(self, **kwargs):
        super().__init__(**kwargs)

        self.file_manager = FileManager()
        self.current_file = None

        self.setup_ui()
        self.connect_signals()
        self.load_window_state()

    def setup_ui(self):
        """Initialize user interface components."""
        # Setup header bar
        self.setup_header_bar()

        # Setup main content area
        self.setup_content_area()

        # Setup sidebar
        self.setup_sidebar()

        # Setup status bar
        self.setup_status_bar()

    def setup_header_bar(self):
        """Configure header bar with buttons and menu."""
        # Primary menu button
        menu_button = Gtk.MenuButton()
        menu_button.set_icon_name('open-menu-symbolic')
        menu_button.set_menu_model(self.create_primary_menu())
        self.header_bar.pack_end(menu_button)

        # Open file button
        open_button = Gtk.Button()
        open_button.set_icon_name('document-open-symbolic')
        open_button.set_tooltip_text('Open File')
        open_button.connect('clicked', self.on_open_file)
        self.header_bar.pack_start(open_button)

        # Save button
        save_button = Gtk.Button()
        save_button.set_icon_name('document-save-symbolic')
        save_button.set_tooltip_text('Save File')
        save_button.set_sensitive(False)
        save_button.connect('clicked', self.on_save_file)
        self.header_bar.pack_start(save_button)

        # Window title
        self.header_bar.set_title_widget(Adw.WindowTitle(
            title='My GTK App',
            subtitle='Ready'
        ))

    def setup_content_area(self):
        """Setup main content area with text editor."""
        # Create leaflet for adaptive layout
        leaflet = Adw.Leaflet()
        leaflet.set_can_navigate_back(True)
        leaflet.set_can_navigate_forward(True)

        # Text view with scrolling
        scrolled_window = Gtk.ScrolledWindow()
        scrolled_window.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
        scrolled_window.set_vexpand(True)

        self.text_view = Gtk.TextView()
        self.text_view.set_left_margin(12)
        self.text_view.set_right_margin(12)
        self.text_view.set_top_margin(12)
        self.text_view.set_bottom_margin(12)
        self.text_view.get_buffer().connect('changed', self.on_text_changed)

        scrolled_window.set_child(self.text_view)

        # Add to leaflet
        leaflet.append(self.sidebar)
        leaflet.append(scrolled_window)

        self.main_box.append(leaflet)

    def setup_sidebar(self):
        """Setup sidebar with file browser."""
        sidebar_page = Adw.ToolbarView()

        # Sidebar header
        sidebar_header = Adw.HeaderBar()
        sidebar_header.set_title_widget(Gtk.Label(label='Files'))
        sidebar_page.add_top_bar(sidebar_header)

        # File tree view
        self.file_tree = FileChooserWidget()
        self.file_tree.connect('file-selected', self.on_sidebar_file_selected)

        sidebar_page.set_content(self.file_tree)
        self.sidebar.set_child(sidebar_page)

    def setup_status_bar(self):
        """Setup status bar with file information."""
        status_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL)

        self.status_label = Gtk.Label()
        self.status_label.set_markup('<small>Ready</small>')
        self.status_label.set_halign(Gtk.Align.START)

        self.position_label = Gtk.Label()
        self.position_label.set_markup('<small>Line 1, Column 1</small>')
        self.position_label.set_halign(Gtk.Align.END)

        status_box.append(self.status_label)
        status_box.append(self.position_label)

        self.status_bar.append(status_box)

    def create_primary_menu(self):
        """Create primary menu model."""
        menu = Gio.Menu()

        file_section = Gio.Menu()
        file_section.append('New Window', 'app.new_window')
        file_section.append('Preferences', 'app.preferences')

        help_section = Gio.Menu()
        help_section.append('About', 'app.about')

        menu.append_section(None, file_section)
        menu.append_section(None, help_section)

        return menu

    def connect_signals(self):
        """Connect window signals."""
        self.connect('close-request', self.on_close_request)

        # Text view cursor position tracking
        buffer = self.text_view.get_buffer()
        buffer.connect('notify::cursor-position', self.update_cursor_position)

    def load_window_state(self):
        """Load saved window state."""
        settings = self.get_application().settings

        width = settings.get_int('window-width')
        height = settings.get_int('window-height')
        is_maximized = settings.get_boolean('window-maximized')

        if width > 0 and height > 0:
            self.set_default_size(width, height)

        if is_maximized:
            self.maximize()

    def save_window_state(self):
        """Save current window state."""
        settings = self.get_application().settings

        width, height = self.get_default_size()
        settings.set_int('window-width', width)
        settings.set_int('window-height', height)
        settings.set_boolean('window-maximized', self.is_maximized())

    def on_open_file(self, button):
        """Handle open file button click."""
        file_dialog = Gtk.FileDialog()
        file_dialog.set_title('Open File')

        file_dialog.open(self, None, self.on_file_dialog_response)

    def on_file_dialog_response(self, dialog, result):
        """Handle file dialog response."""
        try:
            file = dialog.open_finish(result)
            if file:
                self.load_file(file)
        except Exception as e:
            self.show_error_dialog(f'Failed to open file: {e}')

    def load_file(self, file):
        """Load file content into text view."""
        try:
            content = self.file_manager.read_file(file.get_path())
            buffer = self.text_view.get_buffer()
            buffer.set_text(content)

            self.current_file = file
            self.update_title()
            self.update_status(f'Loaded {file.get_basename()}')

        except Exception as e:
            self.show_error_dialog(f'Failed to load file: {e}')

    def on_save_file(self, button):
        """Handle save file button click."""
        if self.current_file:
            self.save_current_file()
        else:
            self.save_file_as()

    def save_current_file(self):
        """Save content to current file."""
        try:
            buffer = self.text_view.get_buffer()
            start, end = buffer.get_bounds()
            content = buffer.get_text(start, end, False)

            self.file_manager.write_file(self.current_file.get_path(), content)
            self.update_status(f'Saved {self.current_file.get_basename()}')

        except Exception as e:
            self.show_error_dialog(f'Failed to save file: {e}')

    def on_text_changed(self, buffer):
        """Handle text buffer changes."""
        self.update_status('Modified')

    def update_cursor_position(self, buffer, param):
        """Update cursor position display."""
        mark = buffer.get_insert()
        iter = buffer.get_iter_at_mark(mark)
        line = iter.get_line() + 1
        column = iter.get_line_offset() + 1

        self.position_label.set_markup(f'<small>Line {line}, Column {column}</small>')

    def update_title(self):
        """Update window title."""
        if self.current_file:
            title = self.current_file.get_basename()
            subtitle = self.current_file.get_parent().get_path()
        else:
            title = 'My GTK App'
            subtitle = 'Untitled'

        title_widget = self.header_bar.get_title_widget()
        title_widget.set_title(title)
        title_widget.set_subtitle(subtitle)

    def update_status(self, message):
        """Update status bar message."""
        self.status_label.set_markup(f'<small>{message}</small>')

    def show_error_dialog(self, message):
        """Show error dialog."""
        dialog = Adw.MessageDialog(
            transient_for=self,
            heading='Error',
            body=message
        )
        dialog.add_response('ok', 'OK')
        dialog.present()

    def on_close_request(self, window):
        """Handle window close request."""
        self.save_window_state()
        return False  # Allow close
```

### Custom Widget Development

✅ **Best Practice**: Reusable custom widgets with proper GObject integration

```python
# src/widgets/file_chooser.py - Custom File Chooser Widget
import gi
gi.require_version('Gtk', '4.0')

from gi.repository import Gtk, Gio, GObject, GLib
import os

class FileChooserWidget(Gtk.Box):
    """Custom file chooser widget with tree view."""

    __gtype_name__ = 'FileChooserWidget'
    __gsignals__ = {
        'file-selected': (GObject.SignalFlags.RUN_FIRST, None, (str,))
    }

    def __init__(self):
        super().__init__(orientation=Gtk.Orientation.VERTICAL)

        self.current_path = GLib.get_home_dir()

        self.setup_ui()
        self.load_directory(self.current_path)

    def setup_ui(self):
        """Setup the file chooser interface."""
        # Path bar
        self.setup_path_bar()

        # File tree view
        self.setup_tree_view()

        # Action buttons
        self.setup_action_buttons()

    def setup_path_bar(self):
        """Setup path navigation bar."""
        path_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL)
        path_box.add_css_class('toolbar')

        # Up directory button
        up_button = Gtk.Button()
        up_button.set_icon_name('go-up-symbolic')
        up_button.set_tooltip_text('Up Directory')
        up_button.connect('clicked', self.on_up_directory)

        # Home button
        home_button = Gtk.Button()
        home_button.set_icon_name('go-home-symbolic')
        home_button.set_tooltip_text('Home Directory')
        home_button.connect('clicked', self.on_home_directory)

        # Path entry
        self.path_entry = Gtk.Entry()
        self.path_entry.set_hexpand(True)
        self.path_entry.connect('activate', self.on_path_entry_activate)

        path_box.append(up_button)
        path_box.append(home_button)
        path_box.append(self.path_entry)

        self.append(path_box)

    def setup_tree_view(self):
        """Setup file tree view."""
        # Create list store
        self.file_store = Gtk.ListStore(str, str, str)  # name, path, type

        # Create tree view
        self.tree_view = Gtk.TreeView(model=self.file_store)
        self.tree_view.set_headers_visible(True)
        self.tree_view.connect('row-activated', self.on_row_activated)

        # Name column
        name_column = Gtk.TreeViewColumn('Name')
        name_renderer = Gtk.CellRendererText()
        name_column.pack_start(name_renderer, True)
        name_column.add_attribute(name_renderer, 'text', 0)
        self.tree_view.append_column(name_column)

        # Type column
        type_column = Gtk.TreeViewColumn('Type')
        type_renderer = Gtk.CellRendererText()
        type_column.pack_start(type_renderer, True)
        type_column.add_attribute(type_renderer, 'text', 2)
        self.tree_view.append_column(type_column)

        # Scrolled window
        scrolled = Gtk.ScrolledWindow()
        scrolled.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
        scrolled.set_vexpand(True)
        scrolled.set_child(self.tree_view)

        self.append(scrolled)

    def setup_action_buttons(self):
        """Setup action buttons."""
        button_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL)
        button_box.set_homogeneous(True)
        button_box.add_css_class('toolbar')

        # Refresh button
        refresh_button = Gtk.Button(label='Refresh')
        refresh_button.connect('clicked', self.on_refresh)

        # New folder button
        new_folder_button = Gtk.Button(label='New Folder')
        new_folder_button.connect('clicked', self.on_new_folder)

        button_box.append(refresh_button)
        button_box.append(new_folder_button)

        self.append(button_box)

    def load_directory(self, path):
        """Load directory contents into tree view."""
        self.file_store.clear()
        self.current_path = path
        self.path_entry.set_text(path)

        try:
            entries = []

            # Add directories first
            for entry in os.listdir(path):
                entry_path = os.path.join(path, entry)

                if os.path.isdir(entry_path):
                    entries.append((entry, entry_path, 'Directory'))

            # Add files
            for entry in os.listdir(path):
                entry_path = os.path.join(path, entry)

                if os.path.isfile(entry_path):
                    file_type = self.get_file_type(entry_path)
                    entries.append((entry, entry_path, file_type))

            # Sort entries
            entries.sort(key=lambda x: (x[2] != 'Directory', x[0].lower()))

            # Add to store
            for name, path, file_type in entries:
                self.file_store.append([name, path, file_type])

        except PermissionError:
            self.show_error('Permission denied')
        except Exception as e:
            self.show_error(f'Error loading directory: {e}')

    def get_file_type(self, file_path):
        """Get file type based on extension."""
        _, ext = os.path.splitext(file_path)

        file_types = {
            '.txt': 'Text File',
            '.py': 'Python File',
            '.c': 'C Source File',
            '.h': 'C Header File',
            '.cpp': 'C++ Source File',
            '.rs': 'Rust Source File',
            '.js': 'JavaScript File',
            '.html': 'HTML File',
            '.css': 'CSS File',
            '.json': 'JSON File',
            '.xml': 'XML File',
            '.md': 'Markdown File',
            '.png': 'PNG Image',
            '.jpg': 'JPEG Image',
            '.gif': 'GIF Image',
            '.pdf': 'PDF Document',
        }

        return file_types.get(ext.lower(), 'File')

    def on_row_activated(self, tree_view, path, column):
        """Handle tree view row activation."""
        model = tree_view.get_model()
        iter = model.get_iter(path)

        name = model.get_value(iter, 0)
        file_path = model.get_value(iter, 1)
        file_type = model.get_value(iter, 2)

        if file_type == 'Directory':
            self.load_directory(file_path)
        else:
            self.emit('file-selected', file_path)

    def on_up_directory(self, button):
        """Navigate to parent directory."""
        parent = os.path.dirname(self.current_path)
        if parent != self.current_path:  # Not at root
            self.load_directory(parent)

    def on_home_directory(self, button):
        """Navigate to home directory."""
        self.load_directory(GLib.get_home_dir())

    def on_path_entry_activate(self, entry):
        """Handle path entry activation."""
        path = entry.get_text()
        if os.path.isdir(path):
            self.load_directory(path)
        else:
            entry.set_text(self.current_path)

    def on_refresh(self, button):
        """Refresh current directory."""
        self.load_directory(self.current_path)

    def on_new_folder(self, button):
        """Create new folder dialog."""
        dialog = Gtk.Dialog(
            title='New Folder',
            transient_for=self.get_root(),
            modal=True
        )
        dialog.add_buttons(
            'Cancel', Gtk.ResponseType.CANCEL,
            'Create', Gtk.ResponseType.OK
        )

        content_area = dialog.get_content_area()

        label = Gtk.Label(label='Folder name:')
        entry = Gtk.Entry()
        entry.set_text('New Folder')

        content_area.append(label)
        content_area.append(entry)

        dialog.connect('response', self.on_new_folder_response, entry)
        dialog.present()

    def on_new_folder_response(self, dialog, response_id, entry):
        """Handle new folder dialog response."""
        if response_id == Gtk.ResponseType.OK:
            folder_name = entry.get_text().strip()
            if folder_name:
                folder_path = os.path.join(self.current_path, folder_name)
                try:
                    os.makedirs(folder_path, exist_ok=True)
                    self.load_directory(self.current_path)
                except Exception as e:
                    self.show_error(f'Failed to create folder: {e}')

        dialog.destroy()

    def show_error(self, message):
        """Show error message."""
        print(f'Error: {message}')  # In real app, show proper dialog
```

## Best Practices

### ✅ Do's

- Use Libadwaita for modern, adaptive GNOME-style applications
- Implement proper MVC architecture with clear separation of concerns
- Use GObject signals for event handling and component communication
- Follow GNOME Human Interface Guidelines for consistent user experience
- Implement proper keyboard shortcuts and accessibility features
- Use GSettings for application preferences and state persistence
- Handle errors gracefully with user-friendly error messages
- Implement proper internationalization with gettext

### ❌ Don'ts

- Don't mix UI logic with business logic in the same classes
- Don't ignore memory management in C applications
- Don't hardcode UI layouts - use UI definition files where possible
- Don't forget to handle edge cases and error conditions
- Don't ignore accessibility requirements (screen readers, keyboard navigation)
- Don't skip proper signal disconnection when destroying widgets
- Don't use deprecated GTK 3 patterns in GTK 4 applications
- Don't ignore cross-platform considerations if targeting multiple OSes

### Performance and Memory Management

```c
// Example of proper memory management in C GTK
#include <gtk/gtk.h>

typedef struct {
    GtkWidget *window;
    GtkWidget *text_view;
    GtkTextBuffer *buffer;
    char *current_file;
} AppData;

static void
cleanup_app_data(AppData *data)
{
    // Free allocated memory
    if (data->current_file) {
        g_free(data->current_file);
        data->current_file = NULL;
    }

    // Disconnect signals if needed
    // GTK automatically handles widget cleanup
}

static void
on_window_destroy(GtkWidget *widget, AppData *data)
{
    cleanup_app_data(data);
    gtk_main_quit();
}

static void
load_file(const char *filename, AppData *data)
{
    GError *error = NULL;
    char *content = NULL;
    gsize length;

    // Read file with proper error handling
    if (g_file_get_contents(filename, &content, &length, &error)) {
        gtk_text_buffer_set_text(data->buffer, content, length);

        // Update current file
        g_free(data->current_file);
        data->current_file = g_strdup(filename);

        // Update window title
        char *basename = g_path_get_basename(filename);
        gtk_window_set_title(GTK_WINDOW(data->window), basename);
        g_free(basename);
    } else {
        // Show error dialog
        GtkWidget *dialog = gtk_message_dialog_new(
            GTK_WINDOW(data->window),
            GTK_DIALOG_MODAL,
            GTK_MESSAGE_ERROR,
            GTK_BUTTONS_OK,
            "Failed to load file: %s",
            error->message
        );
        gtk_dialog_run(GTK_DIALOG(dialog));
        gtk_widget_destroy(dialog);
        g_error_free(error);
    }

    // Free content (always free even if NULL)
    g_free(content);
}
```

## Development Workflow

### ✅ Python Development Workflow

```bash
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
```

### ✅ Rust Development Workflow

```bash
# Development
cargo run

# Testing
cargo test

# Linting
cargo clippy

# Formatting
cargo fmt

# Building for release
cargo build --release

# Cross-compilation
rustup target add x86_64-pc-windows-gnu
cargo build --target x86_64-pc-windows-gnu

# Creating AppImage (Linux)
cargo install cargo-appimage
cargo appimage
```

### ✅ C Development Workflow

```bash
# Build with Meson (modern)
meson setup build
meson compile -C build
meson test -C build

# Build with Make (traditional)
make
make test
make install

# Debug with GDB
gdb ./my_gtk_app

# Memory leak detection
valgrind --leak-check=full ./my_gtk_app

# Static analysis
cppcheck src/
scan-build make
```

### UI Development with Cambalache/Glade

```bash
# Install UI designer tools
sudo apt install cambalache  # GTK 4 (recommended)
sudo apt install glade       # GTK 3 (legacy)

# Create UI files
cambalache my_window.ui

# Load UI in application
builder = Gtk.Builder()
builder.add_from_resource('/org/example/MyApp/ui/main_window.ui')
window = builder.get_object('main_window')
```

## AI Agent Decision Matrix

| Scenario                     | Recommended Approach                 | Avoid                              |
| ---------------------------- | ------------------------------------ | ---------------------------------- |
| GNOME desktop integration    | GTK 4 + Libadwaita + Python          | Cross-platform frameworks          |
| Performance-critical app     | GTK + Rust or C                      | GTK + Python for heavy computation |
| Rapid prototyping            | GTK + Python + Glade                 | Writing UI code manually           |
| System administration tool   | GTK + Python + PolicyKit             | Web-based interfaces               |
| Native Linux application     | GTK 4 with adaptive layout           | GTK 3 or non-native toolkits       |
| Multi-platform desktop app   | Qt or Electron                       | GTK (Linux-focused)                |
| Educational/learning project | GTK + Python with clear examples     | Complex C implementations          |
| Enterprise application       | GTK + C/Rust + comprehensive testing | Rapid prototyping approaches       |

## Testing

### ✅ Python Testing with pytest

```python
# tests/test_file_manager.py
import pytest
import tempfile
import os
from src.controllers.file_manager import FileManager

class TestFileManager:
    def setup_method(self):
        self.file_manager = FileManager()
        self.temp_dir = tempfile.mkdtemp()

    def teardown_method(self):
        import shutil
        shutil.rmtree(self.temp_dir, ignore_errors=True)

    def test_read_file(self):
        # Create test file
        test_file = os.path.join(self.temp_dir, 'test.txt')
        test_content = 'Hello, GTK!'

        with open(test_file, 'w') as f:
            f.write(test_content)

        # Test reading
        content = self.file_manager.read_file(test_file)
        assert content == test_content

    def test_write_file(self):
        test_file = os.path.join(self.temp_dir, 'output.txt')
        test_content = 'Test content'

        self.file_manager.write_file(test_file, test_content)

        with open(test_file, 'r') as f:
            content = f.read()

        assert content == test_content

    def test_read_nonexistent_file(self):
        with pytest.raises(FileNotFoundError):
            self.file_manager.read_file('/nonexistent/file.txt')

# Run tests
# pytest tests/ -v
```

### ✅ Rust Testing

```rust
// src/controllers/file_manager.rs
#[cfg(test)]
mod tests {
    use super::*;
    use std::fs;
    use tempfile::tempdir;

    #[test]
    fn test_read_file() {
        let dir = tempdir().unwrap();
        let file_path = dir.path().join("test.txt");
        let content = "Hello, GTK!";

        fs::write(&file_path, content).unwrap();

        let result = read_file(file_path.to_str().unwrap()).unwrap();
        assert_eq!(result, content);
    }

    #[test]
    fn test_write_file() {
        let dir = tempdir().unwrap();
        let file_path = dir.path().join("output.txt");
        let content = "Test content";

        write_file(file_path.to_str().unwrap(), content).unwrap();

        let written_content = fs::read_to_string(&file_path).unwrap();
        assert_eq!(written_content, content);
    }

    #[test]
    fn test_read_nonexistent_file() {
        let result = read_file("/nonexistent/file.txt");
        assert!(result.is_err());
    }
}
```

## Security Considerations

- Use Flatpak or Snap for sandboxed application distribution
- Implement proper input validation for all user data
- Use GLib's secure string functions to prevent buffer overflows
- Handle file permissions and access controls appropriately
- Validate file paths to prevent directory traversal attacks
- Use secure communication protocols for network operations
- Implement proper session management for multi-user applications
- Follow principle of least privilege for system access
- Use AppArmor or SELinux policies for additional security
- Regularly update GTK and dependencies for security patches

## AI Agent Quick Reference

- **Project Setup**: Use modern GTK 4 with Libadwaita for best user experience
- **Language Choice**: Python for rapid development, Rust for performance, C for system integration
- **Architecture**: Implement clean MVC with GObject signals for communication
- **UI Design**: Use Cambalache for GTK 4 UI files and follow GNOME HIG
- **Testing**: Comprehensive unit tests for business logic, integration tests for UI
- **Distribution**: Package as Flatpak for modern Linux distribution
- **Performance**: Profile with sysprof, optimize memory usage, use efficient algorithms
- **Cross-platform**: Consider Qt if Windows/macOS support is critical requirement

## Installation & Setup

```bash
# Installation commands
[package manager install command]

# Project initialization
[framework CLI or setup commands]
```

## Project Structure

```
project-root/
├── [typical folder structure]
├── [configuration files]
├── [source directories]
└── [other important directories]
```

## Core Concepts

### [Concept 1]

- **Purpose**: [What this concept does]
- **Usage**: [How to implement/use it]
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
