=head1 NAME

MyApp::UserManager - User management utilities

=head1 SYNOPSIS

    use MyApp::UserManager;
    
    my $manager = MyApp::UserManager->new();
    my $user = $manager->create_user({
        email    => 'user@example.com',
        name     => 'John Doe',
        password => 'secure_password',
    });

=head1 DESCRIPTION

This module provides user management functionality including
creation, validation, and authentication.

=head1 METHODS

=head2 create_user($user_data)

Creates a new user with the provided data.

    my $user = $manager->create_user({
        email    => 'user@example.com',
        name     => 'John Doe',
        password => 'secure_password',
    });

Returns a user object on success, dies on failure.

=cut

# Test example
use Test::More tests => 3;
use Test::Exception;

my $manager = MyApp::UserManager->new();

# Test successful user creation
my $user_data = {
    email    => 'test@example.com',
    name     => 'Test User',
    password => 'test_password',
};

lives_ok { $manager->create_user($user_data) } 'User creation succeeds';

# Test missing email
dies_ok { $manager->create_user({ name => 'Test' }) } 'Dies without email';

# Test return value
my $user = $manager->create_user($user_data);
isa_ok($user, 'MyApp::User', 'Returns user object');