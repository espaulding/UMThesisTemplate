paretoDomination = function(point, dominator){
  numdims = length(point)
  if(numdims != length(dominator)){
    print("points of varying lengths can't exist in the same vectorspace")
    return(NULL)
  }
  greater = FALSE
  peer    = TRUE
  for(d in 1:numdims){
    if(dominator[d] > point[d]){ greater = TRUE; }
    if(dominator[d] < point[d]){ peer = FALSE; }
  }
  return(greater && peer)
}