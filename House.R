#Importing Libraries
library(dplyr)
library(ggplot2)
library(ggcorrplot)
library(caTools)

#Importing the data set
df<-read.csv('data.csv')
head(df)

#Data Preperation
str(df)

#Importing Libraries
library(dplyr)
library(ggplot2)
library(ggcorrplot)
library(caTools)

#Importing the data set
df<-read.csv('../input/housedata/data.csv')
head(df)

#Data Preperation
str(df)

require(dplyr)
df$date=NULL
df<-dplyr::mutate(df, date<-NULL, street = NULL, country = NULL, statezip = NULL, city = NULL, waterfront=NULL)


df$age_house <- as.integer(format(Sys.Date(), "%Y")) - df$yr_built #Finding the age of house
df$yr_built<-NULL
df$yr_renovated <- ifelse(df$yr_renovated > 0, 1, 0)
df$sqft_basement<- ifelse(df$sqft_basement > 0, 1, 0)

colMeans(is.na(df))


table(df$price==0) #No. of rows for which house price is 0
df<-df[df$price!=0,] #Removing rows for which house price is 0

#Plotting boxplot to check for outliers
par(mfrow=c(2, 3))
boxplot(df$price, main="Price")
boxplot(df$bedrooms, main="Bedrooms")
boxplot(df$bathrooms, main="Bathrooms")
boxplot(df$sqft_living, main="Sqft_Living")
boxplot(df$sqft_above, main="Sqft_Above")
boxplot(df$age_house, main="Age of house")

#Function to remove outliers
outlier_treat <- function(x){
  UC = quantile(x, p=0.99,na.rm=T)
  LC = quantile(x, p=0.01,na.rm=T)
  x=ifelse(x>UC,UC, x)
  x=ifelse(x<LC,LC, x)
  return(x)
}
df = data.frame(apply(df, 2, FUN=outlier_treat)) #Applying Outlier func. to the dataset

#Plotting boxplot to check if the outliers have been removed or not
par(mfrow=c(2, 3))
boxplot(df$price, main="Price")
boxplot(df$bedrooms, main="Bedrooms")
boxplot(df$bathrooms, main="Bathrooms")
boxplot(df$sqft_living, main="Sqft_Living")
boxplot(df$sqft_above, main="Sqft_Above")
boxplot(df$age_house, main="Age of house")

#Plotting Correlation Matrix
cor(df)

require(ggcorrplot)
corr <- round(cor(df), 1) 
ggcorrplot(corr, type = "lower",lab = TRUE, lab_size = 5, colors = c("red", "white", "cyan4"), 
           title="Correlogram of Housing Dataset", ggtheme=theme_bw)

#Plotting Histograms
par(mfrow=c(2, 3))
hist(df$price, breaks = 10, col = "coral2", main = "Histogram for price", xlab = "Price")
hist(df$bedrooms, breaks = 5, col = "gold1", main = "Histogram for no. of bedrooms", xlab = "Bedrooms")
hist(df$bathrooms, breaks = 10, col = "light green", main = "Histogram for no. of bathrooms", xlab = "Bathrooms")
hist(df$sqft_living, breaks = 10, col = "sky blue", main = "Histogram for area of living", xlab = "Sqft_living")
hist(df$floors, breaks = 5, col = "orange", main = "Histogram for no. Floors", xlab = "Floors")
hist(df$age_house, breaks = 10, col = "pink", main = "Histogram for Age of house", xlab = "Age")

#Box plot for the Comparison between the basement and price of the house
sqftbase<-ifelse(df$sqft_basement > 0, "Yes", "No")
ggplot(data=df,aes(y=price,x=sqftbase, fill=sqftbase))+geom_boxplot()

#Scatter plot to see the relation between area and price of the house
ggplot(data=df,aes(y=sqft_living,x=price))+geom_point()+geom_smooth(method="lm",se=F)

#Scatter plot to see the relation between no. of bedrooms and price of the house
ggplot(df,aes(x=sqft_living,y=price,col=factor(bedrooms))) +geom_point() +geom_smooth(method="lm",se=F)+ labs(col="Bedrooms")

# Splitting the dataset into the Training set and Test set
require(caTools)
sample.split(df$price, SplitRatio = 0.60)->split_index
training_set <- subset(df,split_index == TRUE)
test_set <- subset(df, split_index == FALSE)
print(paste("No. of rows for training:",nrow(training_set)))
print(paste("No. of rows for testing:",nrow(test_set)))

#Model Fitting
lm(price~.-yr_renovated -condition ,data=training_set)->mod1
predict(mod1,test_set)->result
summary(mod1)

cbind(actual=test_set$price,predicted=result)->compare_result 
as.data.frame(compare_result)->compare_result
compare_result$actual-compare_result$predicted->error #Finding the error between actual and predicted values
as.data.frame(error)->error
cbind(compare_result,error)->final
View(final)

