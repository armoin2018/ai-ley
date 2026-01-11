#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 6;
use Test::Exception;
use Test::Deep;

use_ok('MyApp::UserManager');

my $manager = MyApp::UserManager->new();
isa_ok($manager, 'MyApp::UserManager');

# Test valid user creation
my $valid_user_data = {
    email    => 'test@example.com',
    name     => 'Test User',
    password => 'secure_password123',
};

my $user;
lives_ok { 
    $user = $manager->create_user($valid_user_data) 
} 'Valid user creation succeeds';

isa_ok($user, 'MyApp::User');

# Test user data structure
cmp_deeply(
    $user->to_hash(),
    superhashof({
        email => 'test@example.com',
        name  => 'Test User',
        id    => re(qr/^\d+$/),
    }),
    'User data structure is correct'
);

# Test error conditions
throws_ok {
    $manager->create_user({ name => 'No Email' })
} qr/Email is required/, 'Dies when email is missing';