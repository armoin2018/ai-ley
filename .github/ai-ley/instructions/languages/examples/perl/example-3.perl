my $result = '';
for my $line (@lines) {
    $result .= $line; # prohibited in loops
}

# Also bad - array building for simple string concatenation
my @parts;
for my $line (@lines) {
    push @parts, $line; # prohibited for simple string building
}
my $result = join '', @parts;