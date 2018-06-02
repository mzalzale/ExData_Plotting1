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


# Plot 4
data$DateTime <- strptime(paste(data$Date,data$Time), "%Y-%m-%d %H:%M:%S")
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
# Top left
data$DayofWeek <- wday(data$Date,label=TRUE)
data$DateTime <- strptime(paste(data$Date,data$Time), "%Y-%m-%d %H:%M:%S")
plot(data$DateTime,data$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power")
# Top right
plot(data$DateTime,data$Voltage, 
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")
# Bottom left
plot(data$DateTime,data$Sub_metering_1, 
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     col = "black")
lines(data$DateTime,data$Sub_metering_2, 
      type = "l",
      col = "red")
lines(data$DateTime,data$Sub_metering_3, 
      type = "l",
      col = "blue")
legend("topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),
       lty = 1,
       bty = "n", # To remove box around legend
       cex = 0.9) # Resize to make it smaller
# Bottom right
plot(data$DateTime,data$Global_reactive_power, 
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")
dev.off()

