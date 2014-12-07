## We check if the data set is already downloaded in the working directory 
## and only if is not downloaded yet we will download it and unzip it.
read_data <- function() {
  file_name <- "./data.zip"
  source_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  if(!file.exists(file_name)) {
    download.file(source_url, destfile="data.zip")
  }
}
read_data()
unzip("data.zip")

## The data set is loaded into a dataframe, and we are subsetting only 
##the data for 1/2/2007 and 2/2/2007
df_filename <- "household_power_consumption.txt"
df <- read.table(df_filename, header = TRUE, sep = ";", na = "?")
dim(df) 
newdf <- df[df$Date == "1/2/2007" | df$Date == "2/2/2007", ]
x <- paste(newdf$Date, newdf$Time)
newdf$DateTime <- strptime(x, "%d/%m/%Y %H:%M:%S")
rownames(newdf) <- 1:nrow(newdf)
dim(newdf) 

## Plotting the first graphic
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "transparent")
par(mfrow = c(2, 2))
plot(newdf$DateTime, newdf$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power")
plot(newdf$DateTime, newdf$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage")
plot(newdf$DateTime, newdf$Sub_metering_1, type = "l",
     col = "black", xlab = "", ylab = "Energy sub metering")
lines(newdf$DateTime, newdf$Sub_metering_2, col = "red")
lines(newdf$DateTime, newdf$Sub_metering_3, col = "blue")
legend("topright", bty = "n", col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)
plot(newdf$DateTime, newdf$Global_reactive_power, type = "l",
     col = "black", xlab = "datetime", ylab = colnames(newdf)[4])
dev.off()