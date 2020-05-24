#----------------------------------------------------------------------------------------------------
#
#     Plot1.R 
#
#-----------------------------------------------------------------------------------------------------

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
print ("Creating histogram...")
png('plot1.png',width=480,height=480)
hist(globalActivePower,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()
print ("Completed")

