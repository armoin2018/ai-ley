my $result = join '', @lines;

# For more complex operations
my $result = join "\n", map { process_line($_) } @lines;