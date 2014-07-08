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

## Plot 2
## as i am using a non english system, i have to set the locale so that days of the week are
## displayed in english
## i think this is OS dependent so it may not work on your OS
Sys.setlocale(category = "LC_TIME", locale="English_US.1252")

with(data, plot(DateTime,Global_active_power,
                type="l", 
                cex.axis=0.8,
                cex.lab=0.8,
                ylab="Global Active Power (kilowatts)", 
                xlab=""))
dev.copy(png, file = "plot2.png") ## Copy my plot to a PNG file
dev.off()                     ## Don't forget to close the PNG device!
