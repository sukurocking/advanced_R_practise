# This project is where I would be practising R/RStudio examples from the book named "Advanced R" by Hadley Wickham----


# To know the type of an object, we use `typeof()` function.
typeof(a <- c("a","b"))
typeof(1)

# Here the double datatype is coerced into a character datatype
# Coercion happens to suit the most "flexible" datatype
# Increasing order of flexibility: logical, integer, double, character
# 
# `is.numeric` is a general test for numberliness
# `is.integer` and `is.double` are more specific tests
# See the following examples
is.numeric(1)
is.numeric(1L)
is.double(1)
is.integer(1L)
is.integer(1)
# `NA` is automatically coerced to the datatype with which it is associated.
# It can also be explicitly mentioned by `NA_integer_` or `NA_character`
a <- c(NA,1)
typeof(a[1])
# Some other interesting examples of coercion
1 == "1"
"one"< 2 
# Apparently "one" is greater than 2.
# `FALSE` when coerced to numeric is 0
# `TRUE` when coerced to numeric is 1
# This is especially useful when mathematical functions have to be used on logical datatypes
sum(c(1,FALSE,TRUE))

# List is a special datatype that can contain different datatypes. It is recursive (unlike an atomic vector). See the following examples
my_list <- list(1,2,3)
my_list1 <- list(1,list(2,3))
str(my_list)
str(my_list1)
# To convert a list into an atomic vector, we use unlist() (and not as.vector)
unlist(my_list)
as.vector(my_list1) #Doesn't work, because a list is a vector as well

## Attributes----

# attr() function is used for setting attributes of an object
attr(a,"my_attribute") <- "This is a vector"
attr(a, "my_attribute") #Individually accessing an attribute
attributes(a) #This is for accessing all the attributes of an object at once
str(a) # A more comprehensive function for accessing the structure and the attributes of an object
structure(a, "another_attribute" = "This is another attribute") # Creating another object with another attribute
structure(v <- 1:6, dim = 2:3) # Returns a matrix, since matrix is nothing but a vector with a dimension attribute

v1 <- structure(1:6, dim = 2:3) # storing the changed 'structure' within a data
# When modifying the data, most of the attributes are lost
str(a[1])
str(sum(a))

#The only attributes not lost are:
# Names, dimensions and class

attr(v, "another-attribute") <- "I am awesome!"
str(v)
structure(v, second_attribute = "another arbitrary attribute")
attributes(v)

# Names, dimensions and class are 3 special kinds of attributes that have special functions for setting them: names(), dim() and class()
# Although they are set by attr(variable, "names"), they should be avoided

### Names----
attr(my_list, "names") <- c("one", "more", "name")
str(my_list)
names(my_list) <- NULL #Resetting the names of my_list

# Other ways of gives names attribute
x <- c(one = 1, two = 2, three = 3)
str(x)

# One special use of attributes is defining factors
# Defining a factor gives a vector 2 attributes - "levels" and "class"
my_factor <- factor(c("a", "b", "c", "c", "e"))
str(my_factor)
table(my_factor)
attributes(my_factor)
class(my_factor)
levels(my_factor)
typeof(my_factor) #This shows that my_factor is an integer object

structure(1:5, hello = "my_attribute")
# rev() provides a reversed version of the argument into it
f1 <- factor(letters)
levels(f1) <- rev(levels(f1))
str(f1)
f1 #The factor is reversed along with the levels
f2 <- rev(factor(letters))
f2 #The factor is reversed but not the levels
f3 <- factor(letters, levels = rev(letters))
f3 # Just the levels are the reverse of letters from "z" to "a"

str(UCBAdmissions)
## Arrays are rare
is.array(UCBAdmissions)

b <- array(1:12, dim = c(2, 3, 2))
b
c <- array(1:16, c(2, 2, 2, 2))
is.array(c)
c

# Matrices are a special kind of arrays
# Different ways of creating a matrix
my_matrix <- matrix(1:6, ncol = 2, nrow = 3)
my_matrix1 <- structure(1:6, dim = c(3, 2))
all.equal(my_matrix, my_matrix1)
dim(b)
dim(my_matrix)
is.array(my_matrix)
str(array(1:3, 3)) #1d array

#names() and length() are high-dimensional attributes having high-dimensional generalizations. names() generalize to colnames and rownames for matrices
# 1. names() generalizes to rownames() and colnames() for matrices.. For arrays, it generalizes to dimnames()
# 2. length() generalizes to nrow() and ncol() for matrices.. For arrays, it generalizes to dim()
my_matrix
colnames(my_matrix) <- c("first", "second")
rownames(my_matrix) <- c("one", "two", "three")
names(my_matrix)
# c() generalizes to cbind() and rbind() for matrices and abind() for arrays
# t() transposes a matrix.. Its equivalent function for arrays is aperm()

dim(1:5)
array(1:5, c(1, 1, 5))
array(1:5, c(1, 1, 5))[, , 2]


# Data frames ----

data("mtcars")
head(mtcars)
x <- mtcars
x$newcol = matrix(1:128, nrow = 32, ncol = 4) ## Adding a matrix as a column of a dataframe
head(x) 

df <- data.frame(x = 1:3, y = c("a","b","c"))
df
str(df)
# Data frame automatically reads characters as factors
df <- data.frame(x = 1:3, y = c("a","b","c"), stringsAsFactors = FALSE)
typeof(df) # R stores a dataframe as a list
class(df)
is.data.frame(df)
colnames(df)
rownames(df)

# Creating dataframes
cbind(df, data.frame(z = 7:9)) # Its okay if the rownames dont match
rbind(df, data.frame(x = 10, y = "z"))
try(rbind(df, data.frame(10,"z")), silent = TRUE) #Error.. the colnames need to match.. # The error msg is suppressed using try()

# It is a mistake to create a data frame using cbind..Instead just use the data.frame()
baddf <- data.frame(cbind(c(1,2),c("a",'b')))
str(baddf) # cbind tries to create a dataframe with the columns of same datatype
gooddf <- data.frame(column1 = c(1,2),column2 = c("a","b"), stringsAsFactors = FALSE)
str(gooddf)


# Special columns

# It is possible for a dataframe to columns of different datatypes like list, matrix, array, etc

df1 <- data.frame(x = 1:3, y = c("a","b","c"))
df1$z <- list(1:2, 1:3, 1:4) # Creating a list-column
df1
str(df1)
df1$z[[1]]
df1[2,"z"]


# Vocabulary Chapter----
# As said by Hadley, it is necessary for a R programmer to have functions across functionalities in his repertoire

# The basic functions are '?' and `help()` .. Through these two, we can acquire inbuilt help on a function

# Math functions
sin(pi/2) # Sine of 90 degree
cos(pi/3) #Cosine of 60 degree
tan(pi/4) # Tan of 45 degrees

ceiling(1.2) # Ceiling provides the integer just above or equal to a decimal number
floor(1.2) # Floor provides the integer below or equal to a decimal number

# Functions relating to vectors
x <- rev(rep(x = 6:10, times = 1:5))
# Run length encoding.. Returns the no. of "runs" of numbers/characters in a vector
rle(x)
# inverse.rle is the opposite of the above function
inverse.rle(rle(x))

# Functions relating to missing values 
library(tidyverse)
c(1,3,5,4,2,NA) %>% is.na() # Checks and returns TRUE for missing values
complete.cases(c(1,2,4,NA,5)) # Checks and returns FALSE for missing values
stopifnot(1==1, TRUE == 1, FALSE == 0, 2%%2 == 0) # Returns error if any of the logical arguments passed to it is FALSE

# missing() is used when arguments to a function is missing
# invisible() returns an invisible argument, which is not printed to the console
f1 <- function(x) x
f2 <- function(x) invisible(x)
f1(1)
f2(1) # Doesnt print

x <- cumsum(cumsum(1:10))
x
diff(x,lag = 1) # Finds lagged differences in a vector
diff(x, lag = 2)
diff(x, differences = 2)

# %in% and match
match(x = 4:7, table = 1:10)
match(1:10, c(1,3,4,9))
# Returns the numbers and missing values relating to match of 1st argument with the table
# %in% is more intuitive
1:10 %in% c(1,3,4,9)
# Logical vector that returns the results of matching 1st with 2nd argument

# Creates a sequence of numbers equal to the length of the vector passed as argument
seq_along(10:15)
rep_along(x = 11:15, 4)
rep_len(x = list(a = 1:5, b = 1:6),length.out = 4)
rep_len(x = 2:5, length.out = 6)
# Repeats a vector 
rep(x = 1:5, length.out = 9)

# Set operations - intersect, union, setdiff and setequal
intersect(1:5, 4:7)
union(1:4, 6:7)
setdiff(1:5, 4:7) # 1st set - intersection
setdiff(4:7, 1:5)
setequal(1:5, 3:7) # Checking if 2 sets are equal
setequal(4:5, 5:4)

# Matrix diagonals
diag(3)
y <- matrix(1:16, nrow = 4, ncol = 4)
y
diag(y) # Returns the diagonals of matrix y
diag(y) <- 4 # Sets the diagonals of matrix
diag(y)

# Transpose
y
t(y)

# Sweep function
A <- array(1:24, dim = 4:2)
A
str(A)
sweep(x = A, MARGIN = 1, STATS = 5) # Subtracts 5 across the entire array
A %>% sweep(MARGIN = 1, STATS = apply(A,1,min))
# Applies the min of the row vectors and substracts the vectors

choose(5,2) # Performs combination in maths
combn(1:6,m = 4) # Generates all possible combinations of 1:6, taking 4 at a time

# strsplit for splitting character strings
strsplit("Hello Suku",split = "")

x <- data.frame(a = c("Group_1", "Group_2"), b = 1:8)
x
split(x,f = x$a) 
# Splits the data frame according to Groups

#Using switch function
centre <- function(x, type) {
  switch(type,
         mean = mean(x),
         median = median(x),
         trimmed = mean(x, trim = .1))
}
x <- rcauchy(10)
centre(x, "mean")
centre(x, "median")
centre(x, "trimmed")

# rlnorm is for generating random numbers in the log normal distribution
set.seed(10);a <- rnorm(10)
set.seed(10);b <- rlnorm(10)
# Observe these values
log(b); a
all.equal(log(b),a)
# The numbers generated in log normal distribution are the antilog of normal distribution

# %*% is for matrix multiplication
# %o% is for outer matrix multiplication
1:9 %o% 1:9

# nlevels returns the number of levels of a factor
x <- factor(c("Male", "Female", "Male", "Male"))
x
nlevels(x)

gl(3,7) # Generates a factor with 3 levels and 7 replications
gl(3,7) %>% nlevels()
