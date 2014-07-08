## read file from working directory
tmp <- read.csv("household_power_consumption.txt", 
              header=TRUE, sep=";", 
              na.strings="?", 
              stringsAsFactors = FALSE, 
              comment.char = "",
              colClasses=c("character","character",rep("numeric",7)),
              nrows=2075259+1)

## subset only the first & second day of Feb,2007
data <- tmp[tmp$Date=="1/2/2007" | tmp$Date=="2/2/2007",]

## convert date to date format in new column
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %T")

## Plot 1
## draw histogram with color and labels
hist(data$Global_active_power,
     col="RED", 
     cex.axis=0.8,
     cex.lab=0.8,
     cex.main=0.9,
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")

## save the image of the plot
dev.copy(png, file = "plot1.png")  ## Copy my plot to a PNG file
dev.off()                          ## Don't forget to close the PNG device!
