taxa_filter = function(taxon, threshold, names=FALSE){
  filter = taxon > threshold
  if(sum(filter) == length(filter)){
    if(names){
      return(1)
    } else {
      stats = list(median=median(taxon),
                   min=min(taxon),max=max(taxon))
      return(stats); 
    }
  } 
  else { return(NULL); }
}