#this function will return the rows of the matrix 
#that make up the pareto frontier
findParetoBoundary = function(m){
  rows = nrow(m)
  cols = ncol(m)
  pareto_frontier = c()
  for(point in 1:rows){
    domination = apply(m[-point,], 1, function(d) 
                  paretoDomination(m[point,], d))
    if(sum(domination) == 0){ #no point dominates this point
      pareto_frontier = c(pareto_frontier, point)
    }
  }
  o = order(m[pareto_frontier,1])
  return(pareto_frontier[o])
}