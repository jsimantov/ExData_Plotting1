#------------------------------------------------------------------------------------------------------------------------------
#
#     Plot2.R 
#
#------------------------------------------------------------------------------------------------------------------------------

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
print ("Subsetting...")
dataSubset <- powerConsumption[powerConsumption$Date %in% c("1/2/2007","2/2/2007"),]
globalActivePower <- as.numeric(dataSubset$Global_active_power)
dateTime <- strptime(paste(dataSubset$Date, dataSubset$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
print ("Creating plot...")
png('plot2.png',width=480,height=480)
plot(dateTime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
print ("Completed")

