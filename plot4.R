# plot4 -------------------------------------------------------------------

listPkgs<-c("dplyr","data.table")

have.pkg<-listPkgs %in% installed.packages()
if(any(!have.pkg)){
        need<-listPkgs[!have.pkg] 
        install.packages(need)
}

require(data.table)
require(dplyr)

data<-fread("household_power_consumption.txt",header=TRUE,sep=";",stringsAsFactors = FALSE,na.strings = "?")

dataTwoDays<-filter(data,grepl("(^1/2/2007)|(^2/2/2007)",Date))

png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfcol=c(2,2))
par(mar = c(4,4,4,4))

#subplot 1

plot(
        dateTime,
        as.numeric(dataTwoDaysCleaned$Global_active_power),
        type = "l",
        xlab = "",
        ylab = "Global Active Power"
)

#subplot 2

with(dataTwoDaysCleaned,{
        plot(dateTime,Sub_metering_1, type = "l",xlab='',ylab='Energy sub metering')
        lines(dateTime,Sub_metering_2, type = "l",col = "red")
        lines(dateTime,Sub_metering_3, type = "l",col = "blue")
        legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               lty = 1, 
               lwd = 2, 
               bty = "n",
               col = c("black", "red", "blue"))
}
)

# subplot 3

with(dataTwoDaysCleaned, plot(dateTime,
                              dataTwoDaysCleaned$Voltage,
                              type = "l",
                              ylab = "Voltage")
)

# subplot 4

with(dataTwoDaysCleaned, plot(dateTime,
                              dataTwoDaysCleaned$Global_reactive_power,
                              type = "l",
                              ylab = "Global Reactive Power")
)


dev.off()