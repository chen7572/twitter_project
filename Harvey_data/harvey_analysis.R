# Analysis of data downloaded from 
# https://digital.library.unt.edu/ark:/67531/metadc993940/

## load libraries used in the analysis
library(ggplot2)
library(dplyr)
library(tidyr)

## Read in a .txt file that contains the number of tweets per day
dates_df <- read.table("HurricaneHarvey_dates.txt",
                 stringsAsFactors = FALSE)

# plotting the change over time and highlight the landfall date 
ggplot(dates_df,aes(x = V2, y = V1)) + 
  geom_col() + 
  geom_col(data = dates_df[8,],
           aes(x=V2, y = V1), fill = "RED") +
  theme(axis.text.x = element_text(angle = 90, 
                                   vjust=0.5)) +
  labs(x="Date",y = "Number of Hurricane Harvey tweets") +
  annotate("text", label = "landfall in TX",
           x = 8, y = 650000, size = 3, 
           angle = 90,color = "red",hjust = 0.1)

## Read in a .txt file that contains the Number of tweets per hashtag
hashtags <- read.table("HurricaneHarvey_hashtags.txt",
                       stringsAsFactors = FALSE)

# Find the top 30 hashtags and organize in descending order
popular_tags <- hashtags[order(hashtags$V1,decreasing = T)[1:30],]

# convert the column of hashtags into factor to 
# avoid plotting them in Alphabetical order
popular_tags$V2 <- factor(popular_tags$V2,levels=rev(unique(popular_tags$V2)))

# plotting the top 30 hashtags 
ggplot(popular_tags,aes(x=V2,y=V1)) + 
  geom_col(fill = "blue") +
  labs(x="Hashtags",y="Counts") +
  scale_y_continuous(labels = scales::comma) +
  coord_flip()

## read .txt file containing tweet IDs for tweets in dataset
# I don't think this file is of much use. 
ids <- scan("HurricaneHarvey_ids.txt",what="numeric")
str(ids)

## read .txt file contains images harvested from tweets
media <- read.table("HurricaneHarvey_media.txt",stringsAsFactors = F)
str(media)

# table the time each imaged occured and sort them in descending order
image_sort <- sort(table(media$V2),decreasing = T)
# convert into a data frame, so I can easily index the image urls
image_freq_df <- as.data.frame(image_sort,stringsAsFactors = F)
colnames(image_freq_df)[1] <- "url"

# Download top 10 images from the web
# and save to a pre-created folder called twitter_image
for(i in 1:10){
  download.file(image_freq_df$url[i],
                paste0('twitter_images/img',i,'.jpg'),mode="wb")
}

# Then I created a R markdown file to show the top 10 files and their counts
# the markdown file is called "Harvey_Twitter_Image.Rmd

## read .txt file that contains the number of tweets at a given timestamp
tweet_times <- read.table("HurricaneHarvey_times.txt",stringsAsFactors = F)
str(tweet_times)

# similar to the practice of ordering popular hastags, 
# I ordered the top 50 time stamps with most tweets 
#and organized them in descending order
top_times <- tweet_times[order(tweet_times$V1,decreasing = T)[1:50],]
head(top_times)
# I combined the date and time columns into 2 column
tt_stamp <- unite(top_times,"date_time",c("V2","V3"),sep=" ")
# convert the date_time column into factor to help plotting 
tt_stamp$date_time <- factor(tt_stamp$date_time,
                             levels=rev(unique(tt_stamp$date_time)))

# Plotting the top 50 time stamps of number of tweets 
ggplot(tt_stamp,aes(x=date_time,y=V1)) + 
  geom_col(fill = "red",color="black") +
  labs(x="Time Stamps",y="Counts") +
  coord_flip()

## Read in number of tweets per username
# this one has problem because the user name contains spaces 
tt_users <- read.table("HurricaneHarvey_users.txt",
                       sep="\t",stringsAsFactors = F)

