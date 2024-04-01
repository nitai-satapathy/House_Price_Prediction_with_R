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
