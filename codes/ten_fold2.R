# Splitting of data in 10 folds
# Where, dataset should contain binary class data
# and data belongs to same class should be kept together.
#stratified sampling
k_fold <- function(data, nneg, npos, k = 10)
{
    
    for(i in 1:k)
    {
        #     print(nneg/k*(i-1)+1)
        #     print(nneg/k*i)
        #fold[[i]]
        
        negtest <- (nneg/k*(i-1)+1) : (nneg/k*i)
        postest <- (nneg + npos/k*(i-1)+1):(nneg + npos/k*i)

        testind <- c(negtest, postest)
        data$Validation <- rep(0, (nneg + npos))
        data$Validation[testind] <- 1        
        
#         write.csv(data[testind,], paste("e:/ten_fold/test", i, ".csv"),  row.names=FALSE, quote = FALSE)
        write.csv(data, paste("train", i, ".csv"), row.names=FALSE, quote = FALSE)
    }  
}

setwd()
data1 <- read.csv("data1.csv")
colnames(data1)
nneg = 1272
npos = 400
data2 <- data1
data2$PosClass <- rep(0, nneg + npos) 
data2$PosClass[(nneg+1):(nneg + npos)] <- 1 #rep(1, npos)
data2$PosClass
data2$NegClass <- rep(1, nneg + npos) 
data2$NegClass[(nneg+1):(nneg + npos)] <- 0 #rep(1, npos)
data2$NegClass
fold <- k_fold(data2, nneg=nneg, npos=npos, k = 10)



# nneg = 100
# npos = 100
# data <- data.frame(1:200,rep(0,200))
# colnames(data) <- c("Val","Class")
# # data$Class[41:50] <-1
# data$Class
# data$Class[101:200] <- 1
# View(data)
# nrow(data)
# ncol(data)

fold <- k_fold(data, nneg=nneg, npos=npos, k = 10)
# data


data1 <- data[data$Class==1,]
data2 <- data[data$Class==0,]
nneg = nrow(data2)
npos = nrow(data1)

data <- rbind(data2, data1)

fold <- k_fold(data, nneg=nneg, npos=npos, k = 10)


?seq_len
?duplicated
df1[!duplicated(rbind(df2, df1))[-seq_len(nrow(df2))], ]
