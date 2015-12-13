# plot1 -------------------------------------------------------------------

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


png(filename = "plot1.png", width = 480, height = 480, units = "px")

hist(dataTwoDays$Global_active_power,
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency", 
     col='red'
)

dev.off()
