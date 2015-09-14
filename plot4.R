## Read File from the current working directory 
hpowcols <- read.table("household_power_consumption.txt",
                       header=T,
                       sep=';',
                       as.is=TRUE,
                       nrows=5,
                       na.string="?")
## Get the Col classes to save the read time 
gocls <- sapply(names(hpowcols),
                function(y) 
                { 
                  class(hpowcols[[y]])
                }
)

hhpowcons <- read.table("household_power_consumption.txt",
                        header=T,sep=';',
                        as.is=TRUE,
                        na.string="?",
                        colClasses=gocls
)
## Filter the data for dates "2007-02-01" & "2007-02-02"
hhsubset <- subset(hhpowcons,
                   as.Date(Date,format='%d/%m/%Y') %in% as.Date(c("2007-02-01","2007-02-02"))
)
## Format the Date column from data frame hhsubset and add new column aDay with Day 
hhsubset <- data.frame(hhsubset,
                       aDay=format(as.Date(hhsubset$Date,'%d/%m/%Y'),"%a")
)
png(file="plot4.png") ## Open the PNG File Device

## set global param mfcol to add 4 plots to the device 
par(mfcol=c(2,2))

with(hhsubset,                        ## Line plot for Global_active_power againest date time
     plot(Global_active_power,
          ylab="Global_active_power(kilowatts)",
          type="l",
          axes=FALSE,
          xlab=""
     )
)
axis(1,c(0,1441,2881),c("Thu","Fri","Sat")) ## add x axix labeles at specified ticks
axis(2,2*0:6)                               ## add y axix with specified range

box() ## Draw BOX around the Plot

with(hhsubset,
     plot(Sub_metering_1,               ## Line plot for Sub_metering_1 againest date time
          ylab="Energy sub metering",
          type="l",
          axes=FALSE,
          xlab=""
     )
)  
with(hhsubset,                         ## add Sub_metering_2 line for existing plot
     lines(Sub_metering_2,
           type="l",
           col="red"
     )
)
with(hhsubset,                        ## add Sub_metering_3 line for existing plot
     lines(Sub_metering_3,
           type="l",
           col="blue"
     )
) 
axis(1,c(0,1441,2881),c("Thu","Fri","Sat")) ## add x axix labeles at specified ticks
axis(2,seq(0,30,10))                        ## add y axix with specified range
legend("topright",                          ## Add Legend to the plot at topright corner
       lwd=1,
       col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
)

box() ## Draw BOX around the Plot

with(hhsubset,               ## Line plot for Voltage againest date time
     plot(Voltage,
          ylab="Voltage",
          type="l",
          axes=FALSE,
          xlab="datetime"
     )
)
axis(1,c(0,1441,2881),c("Thu","Fri","Sat")) ## add x axix labeles at specified ticks
axis(2,c(234,238,242,246))                    ## add y axix with specified range

box() ## Draw BOX around the Plot

with(hhsubset,                    ## Line plot for Global_reactive_power againest date time
     plot(Global_reactive_power,
          ylab="Global_reactive_power",
          type="l",
          axes=FALSE,
          xlab="datetime"
     )
)
axis(1,c(0,1441,2881),c("Thu","Fri","Sat")) ## add x axix labeles at specified ticks
axis(2,seq(0.0,0.5,0.1))                     ## add y axix with specified range
     
box()  ## Draw BOX around the Plot

dev.off() ## shutdown the open device
