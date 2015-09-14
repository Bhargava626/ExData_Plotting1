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

png(file="plot1.png") ## Open the PNG File Device 

## call hist function to plot "Global_active_power" 
with(hhsubset,
     hist(Global_active_power,
          xlab="Global_active_power(kilowatts)", ## x axis Label 
          main="Global Active Power",            ## Plot heading 
          col="red"                              ## Hist plot color 
          )
    )

dev.off()  ## shutdown the open device
