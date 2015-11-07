#If necessary, set your working directory where you want the files saved, unzipped
#and written to. 
if(file.exists("household_power_consumption.txt") == FALSE) {
    #Download data from source.
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","files.zip")
}
#Unzip data into current working directory
data <- unzip("files.zip")
#Loads the dplyr and tidyr package
library(tidyr)
library(dplyr)
#Read in subset of data
data2 <- read.table(data, header = FALSE, sep = ";", skip = 66637, 
                    nrows = 2879, col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#Separate Date Variable into Month, Day and Year
data5 <- separate(data2, "Date",c("Day", "Month", "Year"), sep = "/")
#Combine Month, Day, Year columns and format as Date
data5 <- mutate(data5, "Date" = as.Date(paste0(data5$Month,"-",data5$Day,"-",data5$Year),"%m-%d-%Y"))
#Create timestamp, format time stamp and create data frame with date stamp
data5 <- mutate(data5, "timestamp" = paste(data5$Date,data5$Time))
data6 <- data.frame(strptime(data5$timestamp, format = "%Y-%m-%d %H:%M:%S"))
names(data6) <- "DateStamp"
data5 <- cbind(data5, data6)
#Change margin height to show full height
par(mar = c(5.1, 4.1,4.1,2.1))
#Set Graphical Device to png, create histogram and export
png(filename = "plot3.png", width = 480, height = 480, units = "px", type = "windows")
plot(data5$DateStamp,data5$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
lines(data5$DateStamp,data5$Sub_metering_2, type = "l", col = "Red")
lines(data5$DateStamp,data5$Sub_metering_3, type = "l", col = "Blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), text.col = "Black",lty = 1, col = c("Black","Red","Blue"))
dev.off()