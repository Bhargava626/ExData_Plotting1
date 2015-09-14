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
png(file="plot2.png") ## Open the PNG File Device

with(hhsubset,     
     plot(Global_active_power,            ## Line plot for Global_active_power againest date time
          ylab="Global_active_power(kilowatts)",
          type="l",                       ## Type "l" indicates line plot     
          axes=FALSE,                     ## Axes are dropped, they will be built using axis function
          xlab=""                         ## x axis label is emty
         )
     )
axis(1,c(0,1441,2881),c("Thu","Fri","Sat")) ## add x axix labeles at specified ticks 
axis(2,2*0:6)                               ## add y axix with specified range

box() ## Draw BOX around the Plot

dev.off() ## shutdown the open device
