#################################################################################
#### BML Simulation Study

#### Put in this file the code to run the BML simulation study for a set of input parameters.
#### Save some of the output data into an R object and use save() to save it to disk for reference
#### when you write up your results.
#### The output can e.g. be how many steps the system took until it hit gridlock or
#### how many steps you observered before concluding that it is in a free flowing state.

bml.init = function(r, c, p){
  car_nums = sample(0:2, r*c, replace=TRUE, prob=c(1-p, p/2, p/2))
  m = matrix(car_nums, r, c)
  return(m)
}

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

newm = sapply(as.list(data.frame(m)), move_north)
sapply(as.list(data.frame(t(m))), move_east)

rotate <- function(x) t(apply(x, 2, rev))


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

bml.sim <- function(r, c, p, max.it=1000){
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



probabilities1 = seq(0.1, 0.9, by=0.1)
n1 = 100
result.matrix11 <- matrix(nrow=n1, ncol=length(probabilities1))
for (i in 1:length(probabilities1)){
  result.matrix11[,i] <- replicate(n1, bml.sim(50, 50, probabilities1[i], max.it= 1000)[[2]])
}
colnames(result.matrix11) = probabilities1


probabilities2 = seq(0.15, 0.35, by=0.01)
n2 = 100
result.matrix22 <- matrix(nrow=n2, ncol=length(probabilities2))
for (i in 1:length(probabilities2)){
  result.matrix22[,i] <- replicate(n2, bml.sim(50, 50, probabilities2[i], max.it=1000)[[2]])
}
colnames(result.matrix22) = probabilities2


sizes1 = seq(10, 100, by=10)
n3 = 100
result.matrix33 <- matrix(nrow=n3, ncol=length(sizes1))
for (i in 1:length(sizes1)){
  result.matrix33[,i] <- replicate(n3, bml.sim(sizes1[i], sizes1[i], 0.3, max.it=1000)[[2]])
}
colnames(result.matrix33) = sizes1


sizes2 = seq(50, 100, by=5)
n4 = 100
result.matrix44 <- matrix(nrow=n4, ncol=length(sizes2))
for (i in 1:length(sizes2)){
  result.matrix44[,i] <- replicate(n4, bml.sim(50, sizes2[i], 0.3, max.it=1000)[[2]])
}
colnames(result.matrix44) = sizes2


boxplot(result.matrix11, xlab="Density of Traffic (Probability)", ylab="Number of Iterations Before Gridlock (Max Iterations = 1000)", main="Number of Iterations Before Hitting Gridlock for Probabilities from 0.1 to 0.9")

boxplot(result.matrix22, xlab="Density of Traffic (Probability)", ylab="Number of Iterations Before Gridlock (Max Iterations = 1000)", main="Number of Iterations Before Hitting Gridlock for Probabilities from 0.15 to 0.35")

boxplot(result.matrix33, xlab="Dimension of Square Grid (Spaces per Row/Column)", ylab="Number of Iterations Before Gridlock (Max Iterations = 1000)", main="Number of Iterations Before Hitting Gridlock for Square Grids of Size 10x10 to 100x100")

boxplot(result.matrix44, xlab="Dimension of Columns of Grid (Spaces per Column)", ylab="Number of Iterations Before Gridlock (Max Iterations = 1000)", main = "Number of Iterations Before Hitting Gridlock for Rectangular Grids of size 50x50 to 50x100")
