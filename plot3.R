# plot3 -------------------------------------------------------------------

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
dataTwoDaysCleaned<-mutate(dataTwoDays, Date=dataDate<-as.Date(dataTwoDays$Date,"%d/%m/%Y"))
dateTime <- strptime(paste(dataTwoDaysCleaned$Date, dataTwoDaysCleaned$Time, sep=" "), "%Y-%m-%d %H:%M:%S")

png(filename = "plot3.png", width = 480, height = 480, units = "px")
with(dataTwoDaysCleaned,{
        plot(dateTime,Sub_metering_1, type = "l",xlab='',ylab='Energy sub metering')
        lines(dateTime,Sub_metering_2, type = "l",col = "red")
        lines(dateTime,Sub_metering_3, type = "l",col = "blue")
        legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               lty = 1, 
               lwd = 2, 
               bty = "o",
               col = c("black", "red", "blue"))
}
)
dev.off()