# Good variable naming
my $user_count = scalar @users;
my @valid_emails = grep { is_valid_email($_) } @email_list;
my %config_data = load_configuration();

# Subroutine with proper naming
sub calculate_total_price {
    my ($items_ref, $tax_rate) = @_;
    # implementation
}