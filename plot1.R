#If necessary, set your working directory where you want the files saved, unzipped
#and written to. 
if(file.exists("household_power_consumption.txt") == FALSE) {
    #Download data from source.
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","files.zip")
    }
#Unzip data into current working directory.
data <- unzip("files.zip")
#Read in subset of data
data2 <- read.table(data, header = FALSE, sep = ";", skip = 66637, 
                    nrows = 2879, col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#Change margin height to show full height
par(mar = c(5.1, 4.1,5.1,2.1))
#Set Graphical Device to png, create histogram and export
png(filename = "plot1.png", width = 480, height = 480, units = "px", type = "windows")
hist(data2$Global_active_power, main = "Global Active Power", col = "Red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", ylim = c(0,1200), cex.axis = 0.9, cex.lab = 0.9)
dev.off()