# HW 3
# Graphics Skills "take 2" - this time with ggplot2.
# Due Thursday February 19th by midnight 
# This .R file should contain your code

# We use the same data as in HW2 and we recreate the same four plots
# but this time using the ggplot2 package.

# Any variables that you are asked to create are the same as in HW2 so you
# can copy your code over, the plotting functions are different.

# First of all you need to install the ggplot2 package.
# You only need to do that once, so the install command is commented out 
# here to make sure you don't run it multiple times but make sure to install it once:
install.packages("ggplot2")
library("ggplot2")
# And one more package:
install.packages("plyr")
library("plyr")

# Before getting started you should aquaint yourself with the ggplot2 package.
# Visit these websites and look at the plots (nice, eh?)
# http://www.r-bloggers.com/quick-introduction-to-ggplot2/
# http://www.cookbook-r.com/Graphs/
# http://zevross.com/blog/2014/08/04/beautiful-plotting-in-r-a-ggplot2-cheatsheet-3/

# Now open the manual pages and keep them open while you work:
# http://docs.ggplot2.org/current/

# STOP: Did you look at the examples in the links above?  Notice
# that the syntax of ggplot2 is different from what we've seen.
# The ggplot() or qplot() command is used to set up the
# plotting environment and then you call specific functions
# by literally adding them to the function call with a "+" and a new call.

# So if you are doing a boxplot you would write somethings like:
# ggplot(data) + geom_boxplot()
# see here : http://docs.ggplot2.org/current/geom_boxplot.html

# Look at a couple of more examples before going on.

##############################
## PART I
## (PART II is at the bottom, short and simple) 
##############################
# Remember, the three datasets are:
# a. SO2012Ctry which is a data frame with information about 
# each country that had an athlete participate in the olympics

# b. London2012ALL_ATHLETES.csv - a csv file which contains data
# on individual atheletes who participated in the 2012 Olympics

# c. wr1500m - a data frame containing information about the 
# world record in the 1500 meter men's race

##############################
# PLOT 1. World Record in Men's 1500 meter run
# When watching the summer Olympics, we might be curious
# about how much faster today's runners are compared to
# runners 50 or 100 years ago. 

# load the data
load("WR1500MeterMen.rda")

# The name of the object loaded is wr1500m
# The time (in the column "times") in these data are recorded in seconds, 
# and they are seconds over 3 minutes. 
# So a time of 70 is really 4 minutes and 10 seconds.

# Q1a. How many world records does this data frame contain?
#
n.wr = length(wr1500m$year)

# Q1b. Use R commands to find out who currently holds the world
# record in the men's 1500 meter.
 
wr.name = droplevels(wr1500m[wr1500m$times == min(wr1500m$times), c("athlete")])

# Let's look at the relationship between date and time.
# Q1c. What type of variable (numeric (continuous or discrete), nominal ordinal)
# are year and times? (no need to use R code to answer this question)

### year : discrete
### times : continuous

# When we are examining a variable to see how it changes in time,
# we typically make a line plot, with time on the x-axes and 
# the (x,y) values connected with line segments.

# Q2a. Begin by making a step plot of year by times for these data.
# Don't bother to make the plot pretty yet; we will get to that later.
# But do add 180 to the times so that they are accurate measurements in seconds,
# store that in a new variable and add to the data frame.
# Hint: which geom_* function creates a step plot?

times_sec = wr1500m$times + 180
wr1500m$times_sec = times_sec

# Your ggplot / qplot command:

ggplot(data=wr1500m, aes(x=wr1500m$year, y=wr1500m$times)) + geom_step(stat="identity")

# Q2b. Redo the plot using a date that incorporates the month as 
# well as the year. For example, in Sep 1904 the world record 
# was broken by James Lightbody. Use a date of 1904.75 for this
# date. If any month is NA, use 0.5 for the fraction.
# Create a new variable, new_year, with the date in this format but
# first find and set all missing months to 0.5
# Add new_year to the dataframe.

wr1500m$month[is.na(wr1500m$month)] = 6
new_year = wr1500m$year + wr1500m$month/12
wr1500m$new_year = new_year

# Your qplot command:

qplot(x=wr1500m$new_year, y=wr1500m$times_sec, geom = "step")

# Q3. The current world record was set in 1998. If we want to
# show that this record still stands in 2015, we could add a 
# horizontal line segment to the plot from 1998 to 2015 at the 
# 1998 record time.  
# Hint: which geom_* function adds a line segment?
# Hint: look at xlim() and theme().

wr_1998 = wr1500m[wr1500m$year==1998, c("times_sec")]

# Your ggplot command:
qplot(x=wr1500m$new_year, y=wr1500m$times_sec, geom = "step", xlim=c(1892, 2015)) + geom_segment(aes(x=1998.583, xend=2015, y=wr_1998, yend=wr_1998))

# Q4. There are two times where the record stood for several
# years - in 1944 and 1998. Let's make it easier to see these
# dates and let's include the name of the athlete who set
# the record.  This additional reference information makes
# our plot richer.
# Add two *green* vertical lines. One at 1944 and the other at 1998.
# Add the runner's name in *blue* next to each vertical line.
# Remember, do not type in the athlete's name. Instead, use subsetting
# of wr1500m$athlete to access it.
# Hint: geom_vline(), annotate().


wr_1944 = wr1500m[wr1500m$year==1944, c("times_sec")]
wr_1998_name = as.character(wr.name)
wr_1944_name = as.character(wr1500m[wr1500m$times_sec==wr_1944, c("athlete")][1])

# Your ggplot command
qplot(x=wr1500m$new_year, y=wr1500m$times_sec, geom = "step", xlim=c(1892, 2015)) + 
  geom_segment(aes(x=1998.583, xend=2015, y=wr_1998, yend=wr_1998)) + 
  geom_vline(aes(xintercept=c(1944.583, 1998.583)), colour = "green") + 
  annotate("text", x=c((1944.583+10), (1998.583+10)), y=c(wr_1944+5, wr_1998+5), label=c(wr_1944_name, wr_1998_name), colour="blue", size=4)
  

# Q5. Now we are ready to add other contextual information.
# Remake the plot as before but now adding axis labels and a title.
# This is the FINAL version of the plot of world record times.
# Hint : labs()

# Your ggplot commands
ggplot(data=wr1500m, aes(x=wr1500m$new_year, y=wr1500m$times_sec), xlim=c(1892, 2015)) + 
  geom_step(stat="identity") + geom_segment(aes(x=1998.583, xend=2015, y=wr_1998, yend=wr_1998), size=0.2) + 
  geom_vline(xintercept=c(1944.583, 1998.583), colour = "green") + 
  annotate("text", x=c((1944.583+10), (1998.583+10)), y=c(wr_1944+5, wr_1998+5), label=c(wr_1944_name, wr_1998_name), colour="blue", size=4) +
  labs(x="Year", y="Time (sec)", title="Times of 1500 m World Record Holders") + 
  theme(plot.title = element_text(size=20, face="bold", vjust=2))

################################
# PLOT 2
# A lot of medal counting goes on during the Olympics.
# We might wonder about the relationship between number of medals
# a country has and the size of its population and its wealth.
# We collected data from various sources (ManyEyes, Guardian,
# ISO) to create this data frame with GDP, population, and other information
# about each country that participated in the Olympics.

# The data frame SO2012Ctry contains this information.
# It can be loaded into R with

load("SummerOlympics2012Ctry.rda")

#Q6 Take a look at the variables in this data frame.
# What kind of variable is GDP and population?

### GDP : continuous
### population : discrete

# What about Total?
### Total : discrete


# To examine the relationship between these three variables,
# we could consider making a scatter plot of GDP against population
# and use plotting symbols that are proportional in size to
# the number of medals. 

# To begin, make a plot of GDP against population. Your ggplot command:
ggplot(data=SO2012Ctry, aes(x=SO2012Ctry$pop, y=SO2012Ctry$GDP)) + geom_point()

#Q7. Let's examine GDP per person (create this new variable yourself)
# and population.
# Use a log scale for both axes and create circles whose area is
# proportional to the total number of medals.
# Do not log the variables directly.
# Hint: use the options log and size.

GDP_per_person = SO2012Ctry$GDP/SO2012Ctry$pop 
SO2012Ctry$GDP_per_person = GDP_per_person
symbols( your code here )

# Your ggplot command
ggplot(data=SO2012Ctry, aes(x=SO2012Ctry$pop, y=SO2012Ctry$GDP_per_person)) + 
  geom_point(shape=1, size=SO2012Ctry$Total/2) + scale_y_continuous(trans="log") +
  scale_x_continuous(trans="log")


# We skip Q8 this time the plot above is already fine.
# Q8. It appears that the countries with no medals are circles too....

# Q9. Make the plot information rich by adding axis labels, 
# title, and label 5 of the more interesting points
# with the country name.
# Hint: use annotate(), geom_text(), maybe other functions.
top5 = SO2012Ctry$Country[order(x=SO2012Ctry$Total, decreasing=TRUE)][1:5]
intersect(SO2012Ctry$Country, top5)
sapply(SO2012Ctry$Country, )

# Your ggplot command:
# Please zoom in on the plot to see the features more clearly. 
ggplot(data=SO2012Ctry, aes(x=SO2012Ctry$pop, y=SO2012Ctry$GDP_per_person)) + 
  geom_point(shape=1, size=SO2012Ctry$Total/2) + scale_y_continuous(trans="log") +
  scale_x_continuous(trans="log") +
  labs(x="Population (Logarithmic Scale)", y="GDP Per Person (Logarithmic Scale)", title="GDP Per Person VS Population of Countries in 2012 Olympics") + 
  theme(plot.title = element_text(size=20, face="bold", vjust=2)) +
  annotate("text", x=c(40000, SO2012Ctry[SO2012Ctry$Total>=44, c("pop")]), 
           y=c(400, SO2012Ctry[SO2012Ctry$Total>=44, c("GDP_per_person")]), 
           label=c("The size of the circles \ncorresponds to the total \nnumber of medals won \nby a specific country.", 
                   as.character(SO2012Ctry[SO2012Ctry$Total>=44, c("Country")])), size=4)

######################################
# PLOT 3.
# Plotting points on maps can help us see geographic relationships

#Q10. Install the maps library and load it into your R session.
# Make a map of the world where the countries are filled with a light grey color.
library("maps")
# Hint: look at map_data() and geom_polygon() in the ggplot2 manual.

# Your ggplot commands:
world = map_data(map="world")
ggplot(aes(long, lat, group=group), data=world) + geom_polygon(fill=8, colour="black")

# Q11. Now add circles to the map where
# the circles are proportional in area to the number of medals
# won by the country. 
# pull out the contries that won at least one medal (you will need at least
# the contries longitude, latitude and Total.)
# Consider using the colors "grey40" and "grey90" for the map and "gold" for the circles.
# Hint: look at the function [geom_point()] and the parameters [aes] and [size]

wonMedal = SO2012Ctry[SO2012Ctry$Total>=1, c("Country", "latitude", "longitude", "Total")]
longitude = wonMedal$longitude
latitude = wonMedal$latitude
total= wonMedal$Total

# Your ggplot commands here.
world = map_data(map="world")
ggplot() + geom_polygon(data=world, aes(x=long, y=lat, group=group), fill="grey40", colour="black") + geom_point(data=wonMedal, aes(x=longitude,y=latitude), colour="black", pch=21, fill="grey90", size=total/6)


## Not needed
#Q12. Remake the plot and fill ......


## That was the FINAL version of this plot

##############################################
# PLOT 4
# During the news coverage of the Olympics it was noted that this
# Olympics had by far the greatest number of women competing and
# that some countries had female athletes competing for the first time.

# The csv file called London2012ALL_ATHLETES.csv
# contains information about every athlete who competed in the Olympics.
# It can be loaded into R as a data frame with the following call:
load("London2012ALL_ATHLETES.rda")
# There is one observation for each athlete. 
# (Actually, about 20 athletes have two records if they
# competed in different sporting events. Let's not worry about that.)

# Skip over this question....
#Q13. We are interested in the relationship between Sport and Sex. 

#Q14. Make a barplot of Sport and Sex that emphasizes the 
# important differences. To do this, first make a table of 
# Sex by Sport.
# Hint: Find the geom_*() function that makes a barplot then
# find the option that allows you to put bars side-by-side (study the manual page)

# make barplot with ggplot
ggplot(athletes, aes(x=athletes$Sport, fill=athletes$Sex)) + geom_bar(position="dodge")

## Skip this question...
#Q15. Remake the barplot above...

## Skip this question...
# Q16. Notice that ....

# Q17. Finally to make the plot more informaation rich, try turning
# the x-axis labels on their side. To do this, find a parameter in theme()
# that allows you to set the angle.
# Lastly, add a title to the plot.

# Your ggplot commands
ggplot(athletes, aes(x=athletes$Sport, fill=athletes$Sex)) + geom_bar(position="dodge") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + labs(x="Sport", title="London 2012 Olympics: Gender and Sports")


# This was the final version of the 4th plot.

########### PART 2
########### Apply statements
## In this homework we will do a few simple excercises with apply.  
## You will be using apply statements in many of the upcoming assignments.

# Load the rainfall data, you will get two lists, [rain] and [day]
load("rainfallCO.rda")

# Create a variable 
# max.rain : a vector of length 5 with the maximum rainfall at each station
max.rain = sapply(rain, max)

# Create a variable 
# mean.rain : a vector of length 5 with the average rainfall at each station
mean.rain = sapply(rain, mean)

# Create a variable 
# sd.rain : a vector of length 5 with the standard deviation of the rainfall at each station
sd.rain = sapply(rain, sd)

# Create a variable 
# n1989.rain : a vector of length 5 with the number of measurements at each station in the year 1989 (use [day])
condition1 = sapply(day[[1]], function(x) x<1990 & x >=1989)
condition2 = sapply(day[[2]], function(x) x<1990 & x >=1989)
condition3 = sapply(day[[3]], function(x) x<1990 & x >=1989)
condition4 = sapply(day[[4]], function(x) x<1990 & x >=1989)
condition5 = sapply(day[[5]], function(x) x<1990 & x >=1989)
day1 = day[[1]][condition1]
day2 = day[[2]][condition2]
day3 = day[[3]][condition3]
day4 = day[[4]][condition4]
day5 = day[[5]][condition5]
day_1989 = list(day1, day2, day3, day4, day5)
n1989.rain = sapply(day_1989, length)





