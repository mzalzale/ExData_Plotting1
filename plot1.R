# Clear all variables
rm(list=ls())

# Check if household_power_consumption.txt exists in current working directory and download it if necessary
if(!file.exists("household_power_consumption.txt")) {
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url,"data.zip", mode = "wb")
    unzip("data.zip", exdir=".")
}

## Install and/or load required libraries 
if (!"lubridate" %in% installed.packages()){install.packages("lubridate")}
library("lubridate")

# Read the text file as a table
data <- read.table("household_power_consumption.txt", header=TRUE,sep=";",na.strings=c("NA","?"),stringsAsFactors=F)
# Select dates of interest, that is 2007-02-01 and 2007-02-01
data$Date <- as.Date(data$Date,"%d/%m/%Y")
data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")


# Plot 1
png("plot1.png", width=480, height=480)
hist(data$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")
dev.off()



