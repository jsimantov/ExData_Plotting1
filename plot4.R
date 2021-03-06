#-----------------------------------------------------------------------------------------------------------
#
#     plot4.R 
#
#-----------------------------------------------------------------------------------------------------------

library(data.table)

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataFileName <- 'dataFile.zip'

if (!file.exists(dataFileName))
{
  print ("Downloading Source Data File...")
  download.file(fileURL,dataFileName,method='curl')
}
print ("Unzipping Source Data File...")
unzip(dataFileName)
print ("Creating Table...")
powerConsumption <- read.table("household_power_consumption.txt", sep=';',na.strings='?',header=TRUE)

print ("Subsetting and Converting Data...")
dataSubset <- powerConsumption[powerConsumption$Date %in% c("1/2/2007","2/2/2007"),]
globalActivePower <- as.numeric(dataSubset$Global_active_power)
globalReactivePower <- as.numeric(dataSubset$Global_reactive_power)
voltage <- as.numeric(dataSubset$Voltage)
subMetering1 <- as.numeric(dataSubset$Sub_metering_1)
subMetering2 <- as.numeric(dataSubset$Sub_metering_2)
subMetering3 <- as.numeric(dataSubset$Sub_metering_3)
dateTime <- strptime(paste(dataSubset$Date, dataSubset$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

print ("Creating plot...")
png('plot4.png',width=480,height=480)
par(mfrow=c(2,2))
plot(dateTime, globalActivePower, type="l", xlab="", ylab="Global Active Power")

plot(dateTime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(dateTime, subMetering1, type="l", xlab="", ylab="Energy Sub Metering")
lines(dateTime,subMetering2,type = "l", col="red")
lines(dateTime,subMetering3,type = "l", col="blue")

plot(dateTime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()
print ("Completed")

