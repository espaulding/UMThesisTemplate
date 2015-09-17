sub cleanTaxa{
  my $args = shift;
  #adjust the level because arrays are zero based
  my $level = $args->{'level'} - 1; 
  my $data = deleteLineageSymbols({hash => $args->{'hash'}});
  my %cleanedData = ();
  my @phyloLevels = ("kingdom","phylum","class","order","family","genus","species");
  my $othercount = 0;
  foreach my $taxon (keys(%$data)){
    my @phylo = split(";",$taxon);
    
    #if there aren't enough elements inject some blank others
    while(@phylo < ($level + 1)){ push(@phylo, "Other"); }
    my $cleanTaxon = $phylo[$level];
    if($cleanTaxon eq "Other"){
      $othercount++;
      for(my $i = $level; $i >= 0; $i--){
        if($phylo[$i] ne "Other"){
          $cleanTaxon = $phyloLevels[$i] . "_" . $phylo[$i] . "_" . $cleanTaxon . "_" . $othercount;
          $i = -1; #stop the loop here because 
                   #found the most specific known phylogeny 
        }
      }
    }
    $cleanedData{$cleanTaxon} = $data->{$taxon};
  }
  print "there were ".keys(%$data)." taxa\n";
  print "of which $othercount were others\n";
  return \%cleanedData;
}