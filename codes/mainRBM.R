data1 <- read.csv("irony_DTM_36631_no_label.csv", quote = "")
data_copy <- data1

row <- nrow(data1)
col <- ncol(data1)

max <- numeric(col)
min <- numeric(col)

for(i in 1:col)
{
  max[i] <- max(data1[,i])
  min[i] <- min(data1[,i])
}

for(i in 1:col)
{
  data_copy[,i] <- (data1[,i] - min[i])/(max[i]-min[i])
}

rbmdata <- t(data_copy)

source('mycode_binary.R')
source('RBM_feature_extractor.R')

model <- rbm(50 , rbmdata , 0.09 , 3800 , 44 , 0.9)

new_reduced_data = matrix(50,dim(rbmdata)[2])
new_reduced_data <- new_features(model,rbmdata)

finaldata <- t(new_reduced_data)

write.csv(finaldata,"data.csv",row.names = FALSE , col.names = FALSE)