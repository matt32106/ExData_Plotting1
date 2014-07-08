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


## Plot 3
## as i am using a non english system, i have to set the locale so that days of the week are
## displayed in english
## i think this is OS dependent so it may not work on your OS
Sys.setlocale(category = "LC_TIME", locale="English_US.1252")

## compute yrange so that values use the same y scale
yrange <- with(data, range(Sub_metering_1, Sub_metering_2, Sub_metering_3))
with(data, plot(DateTime,Sub_metering_1,
             type="l", 
             ylim=yrange,
             ylab="Energy sub metering", 
             cex.axis=0.7,
             cex.lab=0.7,
             mar=c(0,0,0,0),
             xlab=""))
with(data, lines(DateTime,Sub_metering_2,col="red"))
with(data, lines(DateTime,Sub_metering_3,col="blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd=1, 
       cex = 0.7,
       y.intersp = 1.2,
       text.width = 40000,
       col=c("black","red","blue") )
dev.copy(png, file = "plot3.png") ## Copy my plot to a PNG file
dev.off()                     ## Don't forget to close the PNG device!

