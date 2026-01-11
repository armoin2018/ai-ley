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