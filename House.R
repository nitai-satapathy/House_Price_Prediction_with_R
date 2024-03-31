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
