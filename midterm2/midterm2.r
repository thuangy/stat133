## Stat 133 Midterm 2
## Thursday April 2nd

<<<<<<< HEAD
present <- "yes"

=======
>>>>>>> f0dfdc58f3565c5098da3527e8c8b735ce98b31d
## General R commands

# [1 pt]
# Create [x], a numeric vector of length 1000 with 
# entries: 6, 12, 18, etc.

<<<<<<< HEAD
x <- seq(from=6, by=6, length.out=2000)
=======
#x <- <your code here>
>>>>>>> f0dfdc58f3565c5098da3527e8c8b735ce98b31d


# [1 pt]
# Create [y], a logical vector of length 2000 
# with y[i]=T if x[i] is divisible by 10, otherwise F

<<<<<<< HEAD
y <- x %% 10 == 0
=======
# y <- <your code here>
>>>>>>> f0dfdc58f3565c5098da3527e8c8b735ce98b31d

# [1 pt]
# Create [w], a random permutation of the numeric values of a deck of cards
# (i.e. just the numbers 1 through 13 each repeated 4 times)
set.seed(2718)
<<<<<<< HEAD
w <- sample(x=rep(seq(from=1, to=13, by=1), times=4), 52)
=======
#w <- <your code here>
>>>>>>> f0dfdc58f3565c5098da3527e8c8b735ce98b31d


# [1 pt]
# Create [m], a matrix of size 10x10 with entries that are 
# Exponential random variables (hint: rexp) with rate 3
# (arrange the values by column, as per default)
set.seed(344)
<<<<<<< HEAD
m <- matrix(data=rexp(100, rate=3), nrow=10, ncol=10)
=======

#m <- <your code here>
>>>>>>> f0dfdc58f3565c5098da3527e8c8b735ce98b31d


# [1 pt]
# Create [l], a list with 12 elements, each a vector of length 100.
# Each vector of length 100 of Poisson (hint:rpois) random variables with mean 5
set.seed(71)
<<<<<<< HEAD
list()
l <- list(rpois(100, lambda=5), rpois(100, lambda=5), rpois(100, lambda=5), rpois(100, lambda=5), rpois(100, lambda=5), rpois(100, lambda=5), rpois(100, lambda=5), rpois(100, lambda=5), rpois(100, lambda=5), rpois(100, lambda=5), rpois(100, lambda=5), rpois(100, lambda=5))
=======
#l <- <your code here>
>>>>>>> f0dfdc58f3565c5098da3527e8c8b735ce98b31d


# for the next two tasks you will use the data frame infants (size 1236x15)
# LEAVE AS IS:
load("KaiserBabies.rda") 

# [2 pt]
# Create a table [t] of the education level ($ed) of all married ($marital) first time ($parity=1) mothers:
<<<<<<< HEAD
t <- table(infants[(infants$marital == 'Married')&(infants$parity == 1), c("ed")])
=======
#t <- <your code here>
>>>>>>> f0dfdc58f3565c5098da3527e8c8b735ce98b31d


# [2 pt]
# Calculate [mw], the average birthweight ($bwt) of all babies whose were full term, i.e. gestation equal or more than 259 days.
<<<<<<< HEAD

mw <- mean(infants[infants$gestation >= 259, c("bwt")], na.rm=TRUE)
=======
#mw <- <your code here>
>>>>>>> f0dfdc58f3565c5098da3527e8c8b735ce98b31d


# For the next few tasks you will use the data frame family (size 14x5)
# LEAVE AS IS:
load("family.rda")

# [1 pt]
# Create [f1] a subset of family with only women over age 50
<<<<<<< HEAD

f1 <- family[(family$gender == 'f')&(family$age>50), ]
=======
#f <- <your code here>
>>>>>>> f0dfdc58f3565c5098da3527e8c8b735ce98b31d

  
# [1 pt]
# Create [f2] a subset of family with only men 6 foot tall or more
<<<<<<< HEAD

f2 <- family[(family$gender == 'm')&(family$height >= 72), ]
=======
#fm <- <your code here>
>>>>>>> f0dfdc58f3565c5098da3527e8c8b735ce98b31d

  
# [1 pt]
# Create [f3] a subset of family of people whose name starts with T
<<<<<<< HEAD
family[family$name[1] == 'T', ]
f3 <- family[family$name]
  
sapply(family$name, function(x) "T" %in% x)

'T' %in% family$name[1]
family$name

# [1 pt]
# Create [f4] a subset of family with just the youngest individual (so just one row)
f4 <- family[family$age == min(family$age), ]
=======
#f3 <- <your code here>
  


# [1 pt]
# Create [f4] a subset of family with just the youngest individual (so just one row)
#f4 <- <your code here>
>>>>>>> f0dfdc58f3565c5098da3527e8c8b735ce98b31d




## Plotting

# We will now use the dataset "iris" which is icluded in the R package.
# To look at the dataframe you can just type "iris" at the prompt
# It is a data frame of size 150x5 with measurements of 4 attributes
# for 150 flowers, 50 each of 3 different species of irises.

# [2 pts]
# Make a box plot of Sepal Length by Species (so 3 boxplots in one plot)
<<<<<<< HEAD
table(iris[ ,c("Species")])
iris[ , c("Sepal.Length", "Species")]
data.frame(iris[iris$Species == 'setosa', c("Sepal.Length")], iris[iris$Species == 'Versicolor', c("Sepal.Length")], iris[iris$Species == 'virginica', c("Sepal.Length")])
boxplot(iris[ , c("Sepal.Length", "Species")])
=======


>>>>>>> f0dfdc58f3565c5098da3527e8c8b735ce98b31d

# [3 pts]
# Make a scatterplot of petal width (y-axis) versus petal length (x-axis)
# The axes labels should be "Petal Length" and "Petal Width",
# Color the plotting symbol by Species (any 3 colors)
<<<<<<< HEAD
species.colors = c()
species.colors[iris$Species == "setosa"] = "red"
species.colors[iris$Species == "versicolor"] = "blue"
species.colors[iris$Species == "virginica"] = "green"

plot(x=iris$Petal.Length, y=iris$Petal.Width, xlab="Petal Length", ylab="Petal Width", col=species.colors)
=======

>>>>>>> f0dfdc58f3565c5098da3527e8c8b735ce98b31d


# [3 pt]
# Make a scatterplot of ( sepal length / petal length) as a function of index (order)
# Color the plotting symbol by Species (any 3 colors)

<<<<<<< HEAD
plot(x=seq(from=1, to=150, by=1), y=iris$Sepal.Length/iris$Petal.Length, col=species.colors, xlab="Index", ylab="Sepal Length/Petal Length")
=======
>>>>>>> f0dfdc58f3565c5098da3527e8c8b735ce98b31d

##  apply statements

# For the next few tasks you will use the list Cache500 
# (list of length 500, each element is a numeric vector of various lengths)
# LEAVE AS IS:
load("Cache500.rda")

# [3 pts]
# Create [first.cache], a vector where each entry is the _first_ element of the
# corresponding vector in the list Cache500

<<<<<<< HEAD
first.cache <- sapply(Cache500, function(x) x[1])
=======
#first.cache <- <your code here>
>>>>>>> f0dfdc58f3565c5098da3527e8c8b735ce98b31d


# [3 pts]
# Create [mean.cache], a vector of length 500 where each entry is the mean 
# of the corresponding element of the list Cache500

<<<<<<< HEAD
mean.cache <- sapply(Cache500, mean)
=======
#mean.cache <- <your code here>
>>>>>>> f0dfdc58f3565c5098da3527e8c8b735ce98b31d


# [2 pts]
# Create [sd.cache], a vector of length 500 where each entry is the sd
# of the corresponding element of the list Cache500

<<<<<<< HEAD
sd.cache <- sapply(Cache500, sd)
=======
#sd.cache <- <your code here>
>>>>>>> f0dfdc58f3565c5098da3527e8c8b735ce98b31d
  


# [4 pts]
# Create [mean.long.cache], a vector where 
# mean.long.cache[i] is:
# the mean of Cache500[[i]] IF it has 50 or more entries.
# NA IF Cache500[[i]] has less than 50 entries.

<<<<<<< HEAD
temp.vector = c()
for(i in 1:length(Cache500)){
  if(length(Cache500[[i]]) < 50){
    temp.vector = c(temp.vector, NA)
  }else{
    temp.vector = c(temp.vector, mean.cache[i])
  }  
}

mean.long.cache <- temp.vector
=======
#mean.long.cache <- <your code here>
>>>>>>> f0dfdc58f3565c5098da3527e8c8b735ce98b31d



