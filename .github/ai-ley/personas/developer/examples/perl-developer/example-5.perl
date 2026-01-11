package MyClass;
use Moose;
use namespace::autoclean;

has 'attribute' => (
    is       => 'rw',
    isa      => 'Str',
    required => 1,
);

sub method_name {
    my ($self, $param) = @_;
    # Implementation
}

__PACKAGE__->meta->make_immutable;
1;