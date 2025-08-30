---
applyTo: "**/*.pl,**/*.pm,**/*.t"
---

# Perl Coding & Style Guide (with AI Linting Hints)

This guide defines coding standards and best practices for Perl development. These include AI linting hints to automatically enforce style rules and maintain clean, performant, and maintainable Perl code.

⸻

📂 Project Architecture

✅ Rule: Enforce modular architecture

- Organize code into modules with proper package declarations
- Use `lib/` directory for application modules
- Separate scripts, modules, and tests into distinct directories
- Follow standard Perl directory structure conventions

✅ Rule: Strict separation of concerns

- Perl → Business logic, data processing, and system integration
- Templates → Structural markup only (Template Toolkit, Mason)
- Configuration → External config files (YAML, JSON, INI)
- Documentation → POD (Plain Old Documentation) embedded in modules

✅ Rule: Module Organization

- Use meaningful package names following hierarchy (e.g., `MyApp::User::Manager`)
- Implement proper `use`/`require` statements with version requirements
- Export only necessary functions and variables
- Use namespaces effectively to avoid pollution

✅ Rule: CPAN Integration

- Use `cpanfile` or `Makefile.PL` for dependency management
- Prefer stable CPAN modules over custom implementations
- Document module dependencies clearly
- Use proper versioning for module releases

✅ Rule: Variable Functions & Subroutines

- Use symbolic references and dispatch tables instead of large if/elsif chains
- Implement consistent patterns for flexibility and reduced code changes

⸻

📜 Standard Libraries & Frameworks

✅ Rule: Prefer core modules when possible

- Use `strict` and `warnings` pragmas in all code
- Use `Carp` for error reporting instead of `die` and `warn`
- Use `File::Spec` for portable file path operations
- Use `Getopt::Long` for command-line argument processing

✅ Rule: Approved CPAN modules

- **Web Frameworks**: Mojolicious, Catalyst, Dancer2
- **Database**: DBI with DBD drivers, DBIx::Class ORM
- **Testing**: Test::More, Test::Exception, Test::Deep
- **HTTP**: LWP::UserAgent, HTTP::Tiny for web requests
- **JSON/XML**: JSON::XS, XML::LibXML for data processing
- **Templates**: Template Toolkit, Mason, Text::Template

✅ Rule: Development Tools

- Use `Perl::Critic` for code quality analysis
- Use `Perl::Tidy` for consistent code formatting
- Use `Devel::NYTProf` for performance profiling
- Use `prove` for running test suites

⸻

🖋 Perl Coding Standards

✅ Pragmas and Declarations

- Always use `strict` and `warnings` pragmas
- Use `use v5.10` or higher for modern Perl features
- Declare variables with appropriate scope (`my`, `our`, `local`)
- Use `state` variables for persistent function-scoped data

✅ Example:

```perl
#!/usr/bin/env perl
use strict;
use warnings;
use v5.20;
use feature qw(signatures);

package MyApp::UserManager;

our $VERSION = '1.0.0';
```

⸻

✅ Variable Declarations and Naming

- Use descriptive variable names that indicate content and scope
- Follow Perl conventions: `$scalar`, `@array`, `%hash`
- Use underscore_separated names for variables and subroutines
- Declare variables in the smallest applicable scope

✅ Example:

```perl
# Good variable naming
my $user_count = scalar @users;
my @valid_emails = grep { is_valid_email($_) } @email_list;
my %config_data = load_configuration();

# Subroutine with proper naming
sub calculate_total_price {
    my ($items_ref, $tax_rate) = @_;
    # implementation
}
```

⸻

✅ Loops & Memory (Perl)

- Cache expensive operations outside loops when possible
- 🚫 Avoid string concatenation inside loops:
  - Do not use `.=` for string building in loops
  - Do not use `push @array, $string` followed by `join` for simple concatenations

❌ Bad:

```perl
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
```

✅ Good:

```perl
my $result = join '', @lines;

# For more complex operations
my $result = join "\n", map { process_line($_) } @lines;
```

⸻

✅ Variable Functions (Perl)

- Use dispatch tables and symbolic references instead of large if/elsif chains
- Implement consistent message-passing patterns
- Enable dynamic subroutine calls for extensible architectures

✅ Example:

```perl
# Bad: Multiple if/elsif statements
sub process_action {
    my ($action, $data) = @_;
    
    if ($action eq 'validate') {
        return validate_data($data);
    } elsif ($action eq 'transform') {
        return transform_data($data);
    } elsif ($action eq 'save') {
        return save_data($data);
    } else {
        croak "Unknown action: $action";
    }
}

# Good: Dispatch table pattern
my %handlers = (
    validate  => \&validate_handler,
    transform => \&transform_handler,
    save      => \&save_handler,
);

sub process_message {
    my ($msg) = @_;
    my $action = $msg->{action};
    
    my $handler = $handlers{$action}
        or croak "Unknown handler: $action";
    
    return $handler->($msg);
}

sub validate_handler {
    my ($msg) = @_;
    $msg->{payload} = validate_data($msg->{payload});
    return $msg;
}
```

✅ Variable Classes (Perl)

- Implement consistent object interface using blessed references
- Use Moose or Moo for modern object-oriented programming
- Enable dynamic class instantiation and polymorphism

✅ Example:

```perl
package BaseProcessor;
use Moose;

has 'data' => (
    is      => 'rw',
    isa     => 'HashRef',
    default => sub { {} },
);

sub BUILD {
    my ($self, $args) = @_;
    # Initialization logic
}

sub DEMOLISH {
    my ($self) = @_;
    # Cleanup logic
}

sub get {
    my ($self, $key) = @_;
    return $self->data->{$key};
}

sub set {
    my ($self, $key, $value) = @_;
    $self->data->{$key} = $value;
    return $self;
}

sub main {
    my ($self, $msg) = @_;
    $msg->{payload} = $self->process($msg->{payload});
    return $msg;
}

sub process {
    my ($self, $payload) = @_;
    # Override in subclasses
    return $payload;
}

# Usage with variable classes
my $class_name = ucfirst($msg->{processor}) . 'Processor';
eval "require $class_name";
croak $@ if $@;

my $processor = $class_name->new($config);
my $result = $processor->main($msg);
```

⸻

✅ Error Handling and Exceptions

- Use `Carp` module for proper error reporting
- Implement exception handling with `Try::Tiny` or `Feature::Try`
- Validate input parameters and return meaningful error messages
- Use proper logging with `Log::Log4perl` or similar

✅ Example:

```perl
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
```

⸻

✅ Documentation and Testing

- Write POD documentation for all modules and complex subroutines
- Use Test::More for comprehensive unit testing
- Test both success and failure scenarios
- Include usage examples in documentation

✅ Example:

```perl
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
```

⸻

🧠 Performance & Best Practices

- Use references to avoid copying large data structures
- Implement lazy evaluation where appropriate
- Use compiled regular expressions for repeated pattern matching
- Profile code with Devel::NYTProf to identify bottlenecks

✅ Example:

```perl
# Efficient data processing
sub process_large_dataset {
    my ($data_ref) = @_;
    
    # Compiled regex for efficiency
    state $email_regex = qr/^[^@]+@[^@]+\.[^@]+$/;
    
    # Process in chunks to manage memory
    my @results;
    my $chunk_size = 1000;
    
    for my $i (0 .. $#{$data_ref}) {
        my $item = $data_ref->[$i];
        
        # Skip invalid emails efficiently
        next unless $item->{email} =~ $email_regex;
        
        push @results, process_item($item);
        
        # Process in chunks
        if (@results >= $chunk_size) {
            save_chunk(\@results);
            @results = ();  # Clear processed items
        }
    }
    
    # Process remaining items
    save_chunk(\@results) if @results;
}
```

⸻

🧪 Testing Standards

✅ Comprehensive Testing with Test::More

- Write unit tests for all public subroutines and methods
- Use descriptive test names that explain expected behavior
- Test edge cases, error conditions, and boundary values
- Use Test::Exception for exception testing

✅ Example:

```perl
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
```

⸻

⚡ Performance Rules

✅ Perl-Specific Optimization

- 🚫 Avoid string concatenation in loops using `.=`
- 🚫 Avoid unnecessary array building for simple string operations
- ✅ Use `join` and `map` for string operations
- ✅ Cache compiled regular expressions with `state`
- ✅ Use references to avoid copying large data structures
- ✅ Profile with Devel::NYTProf before optimizing

⸻

✍️ Commit Message Conventions

- Prefix commits with: `feat:`, `fix:`, `docs:`, `style:`, `refactor:`, `perf:`, `test:`
- Example: `feat: add user authentication with session management`

⸻

🚦 AI Enforcement Summary

✅ Enforce strict and warnings pragmas in all code
✅ Block string concatenation in loops (`.=`)
✅ Block array building for simple string concatenation
✅ Require proper variable scoping with my/our/local
✅ Enforce Carp usage over die/warn for error reporting
✅ Prefer dispatch tables over long if/elsif chains
✅ Enforce consistent object interfaces (BUILD, DEMOLISH, accessors)
✅ Require POD documentation for all public subroutines
✅ Enforce comprehensive testing with Test::More
✅ Use Perl::Critic for automated code quality checks
✅ Auto-fix Perl::Tidy formatting violations where possible
