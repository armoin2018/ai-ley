use Carp qw(croak carp);
use Try::Tiny;
use Log::Log4perl qw(get_logger);

my $logger = get_logger(__PACKAGE__);

sub process_user_data {
    my ($user_data_ref) = @_;
    
    croak 'User data must be a hash reference'
        unless ref $user_data_ref eq 'HASH';
    
    croak 'Email is required'
        unless $user_data_ref->{email};
    
    try {
        my $processed = validate_and_transform($user_data_ref);
        $logger->info("Successfully processed user: $user_data_ref->{email}");
        return $processed;
    }
    catch {
        $logger->error("Processing failed: $_");
        croak "User data processing failed: $_";
    };
}