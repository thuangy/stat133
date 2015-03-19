# Homework 6
# Stat 133, Lec 2, Spring 2015
# Due : Friday March 20th by 5 pm

# Review the slides on simulations for this assignment.

# Consider the following model on use of a new drug:
# We have a population of doctors, population size : <n.doctors>
# Every doctor has either adopted the use of a new drug, or not (0/1 status)
# Now write a function that runs a simulation for a period of :
# <n.days> where
# - every day exactly two _random_ doctors meet
# - if one has adopted but the other one has not then the
#   holdout adopts the use of the drug with probability p
# Return a matrix that shows for each day which doctors have adopted
# the use of the drug.

# Input varibles are
# <n.days> : the number of days the simulation should be run for
# <n.doctors> : total number of doctors 
# <initial.doctors> : a 0/1 vector of length <n.doctors>, 1 for adopters
# <p> : the probability that the non-adopter adopts the drug.

# Ouput variable
# <has_adopted> : matrix with <n.doctors> rows and <n.days> columns
#                 i.e. one row for each doctor
#                 the entries are 0 for days where the doctor is a
#                 non-adopter, else 1 (so once a row turns to 1 it stays as 1).

sim.doctors <- function(initial.doctors, n.doctors, n.days, p){
  total.doctors.days = initial.doctors
  for(i in 2:n.days){
    two.doctors.indices = sample(seq(from=1, to=length(initial.doctors)), 2, replace=TRUE)
    two.doctors = c(initial.doctors[two.doctors.indices[1]], initial.doctors[two.doctors.indices[2]])
    if((1 %in% two.doctors) & (0 %in% two.doctors)){
      boolean = sample(c('True', 'False'), 1, prob=c(p, 1-p))
      if(two.doctors[1] == 0){
        if(boolean == 'True'){
          initial.doctors[two.doctors.indices[1]] = 1
        }
      }else{
        if(boolean == 'True'){
          initial.doctors[two.doctors.indices[2]] = 1
        }
      }
    }
    total.doctors.days = c(total.doctors.days, initial.doctors)
  }
  has_adopted = matrix(total.doctors.days, nrow=n.doctors)
  return(has_adopted)
} 


  # Set up the output variable, define it as a matrix then use initial.doctors
  # to set the first column (day)

  # Run a simulation for <n.days> (use a for loop).  In the loop:
  # 1) pick two random doctors
  # 2) check if one has adopted the other hasn't
  # 3) convert the non-adopter with probability p

  # return the output



# When you test your function you have to generate <initial.doctors> and
# pick values for the other input parameters.

set.seed(42)
initial.doctors = sample(0:1, 1000, replace=TRUE, prob=c(0.9, 0.1))
probabilities = seq(0.1, 0.9, by=0.2)

num_doctors_adopted = c()
for(i in 1:length(probabilities)){
  mat = sim.doctors(initial.doctors, 1000, 10000, probabilities[i])
  num_doctors_adopted = c(num_doctors_adopted, colSums(mat))
}
prob.1 = num_doctors_adopted[1:10000]
prob.3 = num_doctors_adopted[10001:20000]
prob.5 = num_doctors_adopted[20001:30000]
prob.7 = num_doctors_adopted[30001:40000]
prob.9 = num_doctors_adopted[40001:50000]


# Geerate a value for <initial.doctors> that has 10% 1s and 90% 0s.
# Run your function for at least 5 different values of <p> and plot
# on x-axis: days,
# on y-axis : the number of doctors that have already adopted the drug, on that day
# Put all 5 lines in one figure (e.g. use first plot() then lines() for the subsequent lines)
plot(x = prob.1, type="l", ylim = c(0, 1000), xlab = "Days", ylab="Number of Doctors That Have Adopted the Drug", main="Adoption of a New Drug by Doctors over Time", col="red")
lines(x=seq(1, 10000, by=1), y = prob.3, col="orange")
lines(x=seq(1, 10000, by=1), y = prob.5, col="green")
lines(x=seq(1, 10000, by=1), y = prob.7, col="blue")
lines(x=seq(1, 10000, by=1), y = prob.9, col="purple")
legend(x=-300, y=1000, legend=c("10%", "30%", "50%", "70%", "90%"), lty=c(1,1, 1, 1, 1), col=c("red","orange", "green", "blue", "purple"), cex=0.65)

