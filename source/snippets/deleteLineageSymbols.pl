sub deleteLineageSymbols{
  my $args = shift;
  my $data = $args->{'hash'};
  my %cleanedData = ();
  foreach my $taxon (keys(%$data)){
    my $newtaxon = $taxon;
    #zap any occurrence like k__ or g__ in a taxa name
    $newtaxon =~ s/[kpcofgs]__//gi; 
    #zap any square brackets in a taxa name
    $newtaxon =~ s/\[|\]//gi;       
    #clean up any semicolons at the end of a taxa name
    while((substr $newtaxon, -1) eq ";"){ $newtaxon = substr($newtaxon,0,length($newtaxon)-1); }    
    #move the data over to the new hash with the updated taxa name
    $cleanedData{$newtaxon} = $data->{$taxon};
  }
  return %cleanedData;
}