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