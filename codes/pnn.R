# Tranining should contain the category (class) variable as the first column (category.column parameter)
# Test set should not contain any category (class) variable
# Category (class) variable is coded as a binary "0/1" variable, with "1" indicating the positive case

# setwd("e:/r prog/pnn")
data <- read.csv("fold1.csv")

training_set <- as.data.frame(cbind(data[81:800, 47],data[81:800,1:45]))
training_set
colnames(training_set)
nrow(training_set)
summary(training_set)
test_set <- data[1:80, 1:45]
install.packages("pnn")
library(pnn)
nnet <- pnn::smooth(learn(training_set,category.column=1),sigma=0.75)

nnet <- pnn::smooth(learn(training_set,category.column=1))

# The prediction part - this may run slow, depending on the size of the problem
# system.time(pred_test_set <- apply(test_set,1,function(x){
#     p <- guess(nnet, as.matrix(x))
#     p <- if(length(p)==2) p$probabilities[2] else NA
# }))
pred_test_set <- apply(test_set,1,function(x){ # 1 > refers row, 2 will refer column
    p <- guess(nnet, as.matrix(x))
    p <- if(length(p)==2) p$probabilities[2] else NA # p$probabilities[2] => gives probability of class "1"
})


pred_class <- (pred_test_set >= 0.5)*1

# Parallel version of the prediction part with doParallel library - runs faster than non-parallel version

library(doParallel)
registerDoParallel(cores = 4)
system.time(pred_test_set <- foreach(i=1:nrow(test_set),.combine=c) %dopar% {
    x <- test_set[i,]
    p <- guess(nnet, as.matrix(x))
    p <- if(length(p)==2) p$probabilities[2] else NA
})