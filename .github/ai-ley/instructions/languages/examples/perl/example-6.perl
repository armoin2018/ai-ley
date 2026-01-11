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