#################################################################################
#### Functions for BML Simulation Study


#### Initialization function.
## Input : size of grid [r and c] and density [p]
## Output : A matrix [m] with entries 0 (no cars) 1 (red cars) or 2 (blue cars)
## that stores the state of the system (i.e. location of red and blue cars)

bml.init = function(r, c, p){
  car_nums = sample(0:2, r*c, replace=TRUE, prob=c(1-p, p/2, p/2))
  m = matrix(car_nums, r, c)
   return(m)
}

#### Function to move the system one step (east and north)
## Input : a matrix [m] of the same type as the output from bml.init()
## Output : TWO variables, the updated [m] and a logical variable
## [grid.new] which should be TRUE if the system changed, FALSE otherwise.

## NOTE : the function should move the red cars once and the blue cars once,
## you can write extra functions that do just a step north or just a step east.


move_north = function(v){
  i = 1
  while(i <= length(v)){
    if(v[i] == 2){
      if(i == 1){
        if(v[length(v)] == 0){
          v[length(v)] = v[i]
          v[i] = 0
        }
      }else{
        if(v[i-1] == 0){
          v[i-1] = v[i]
          v[i] = 0
        }
      }
      i = i + 2
    }
    i = i + 1
  }
  return(v)
}

move_east = function(v){
  i = 1
  while(i <= length(v)){
    if(v[i] == 1){
      if(i == length(v)){
        if(v[1] == 0){
          v[1] = v[i]
          v[i] = 0
        }
      }else{
        if(v[i+1] == 0){
          v[i+1] = v[i]
          v[i] = 0
        }
      }
      i = i + 2
    }
    i = i + 1
  }
  return(v)
}


bml.step <- function(m){
  eastm = t(sapply(as.list(data.frame(t(m))), move_east))
  newm = sapply(as.list(data.frame(eastm)), move_north)
  if(all(newm == m)){
    grid.new = FALSE
  }else{
    grid.new = TRUE
  }
  
  return(list(newm, grid.new))
}


#### Function to do a simulation for a given set of input parameters
## Input : size of grid [r and c] and density [p]
## Output : *up to you* (e.g. number of steps taken, did you hit gridlock, ...)

bml.sim <- function(r, c, p, max.it=5000){
  mat = list(bml.init(r, c, p), TRUE)
  i = 1
  gridlock = FALSE
  while(i < max.it){
    mat = bml.step(mat[[1]])
    
    if(mat[[2]] == FALSE){
      gridlock = TRUE
      break}
    i = i + 1
  }
  return(list(mat[[1]], i, gridlock))
}

