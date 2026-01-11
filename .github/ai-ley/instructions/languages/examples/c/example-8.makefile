# Recommended compiler flags for development
CFLAGS = -std=c17 -Wall -Wextra -Wpedantic -Werror \
         -Wformat=2 -Wconversion -Wunused -Wshadow \
         -Wstrict-prototypes -Wmissing-prototypes \
         -g -O2 -fstack-protector-strong