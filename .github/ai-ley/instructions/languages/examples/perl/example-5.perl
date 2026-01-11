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