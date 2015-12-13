
# plot2 -------------------------------------------------------------------
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

png(filename = "plot2.png", width = 480, height = 480, units = "px")

plot(
        dateTime,
        as.numeric(dataTwoDaysCleaned$Global_active_power),
        type = "l",
        xlab = "",
        ylab = "Global Active Power"
)

dev.off()
