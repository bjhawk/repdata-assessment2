file.url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
# if file doesn't exist
#download.file(file.url, 'stormdata.csv.bz2')

#if linux
#system("bunzip2 stormdata.csv.bz2")

#if windows
#library(R.utils)
#bunzip2("stormdata.csv.bz2")

# I hate doing this but there is something preventing fread() from working -
# it's a tracked issue - see https://github.com/Rdatatable/data.table)
# and data.frame is unreasonably slow in my computations.
library(data.table)
data <- data.table(read.csv('stormdata.csv'))

#the following takes FOREVER... how could i optimize this?
data[,r:=1:.N]

data[,PROPDMG:={
    if (PROPDMGEXP == 'b' | PROPDMGEXP =='B') {
        PROPDMG*1000000000
    } else if (PROPDMGEXP == 'm' | PROPDMGEXP =='M') {
        PROPDMG*1000000
    } else if (PROPDMGEXP == 'k' | PROPDMGEXP =='K') {
        PROPDMG*1000
    } else if (PROPDMGEXP == 'h' | PROPDMGEXP == 'H') {
        PROPDMG*100
    } else if (is.na(PROPDMG)) {
        0
    } else {
        PROPDMG
    }
},by=r]

data[,CROPDMG:={
    if (CROPDMGEXP == 'b' | CROPDMGEXP =='B') {
        CROPDMG*1000000000
    } else if (PROPDMGEXP == 'm' | CROPDMGEXP =='M') {
        CROPDMG*1000000
    } else if (PROPDMGEXP == 'k' | CROPDMGEXP =='K') {
        CROPDMG*1000
    } else if (PROPDMGEXP == 'h' | PROPDMGEXP == 'H') {
        PROPDMG*100
    } else if (is.na(CROPDMG)) {
        0
    } else {
        CROPDMG
    }
},by=r]
#cost
# sum and avg data in one DT
data.by.type <- data[,
                     list(
                         sum(PROPDMG+CROPDMG),
                         round(mean(PROPDMG+CROPDMG),digits=0),
                         sum(INJURIES),
                         round(mean(INJURIES), digits=1),
                         sum(FATALITIES),
                         round(mean(FATALITIES), digits=1),
                         .N),
                     by=EVTYPE]
setnames(data.by.type, c('EVTYPE','SUMDMG','AVGDMG','SUMINJ', 'AVGINJ', 'SUMFAT', 'AVGFAT', 'COUNT'))

library(gridExtra)
#injuries etc
#do side by sides, as above, total - avg injuries, total-avg fatalities
p1 <- qplot(EVTYPE, V1, data=injury[1:5,], stat="identity", geom="bar") +
    aes(fill=EVTYPE) + guides(fill=F) +
    scale_x_discrete(limits=injury[1:5,EVTYPE]) +
    labs(x = 'Event Type') +
    labs(y = 'Total Injuries') +
    labs(title='Injuries') +
    #scale_y_continuous(labels=c("", "50", "100", "150")) +
    theme_bw() + theme(plot.title=element_text(vjust=-5, size=20))


p2 <- qplot(EVTYPE, V1, data=fatalities[1:5,], stat="identity", geom="bar") +
    aes(fill=EVTYPE) + guides(fill=F) +
    scale_x_discrete(limits=fatalities[1:5,EVTYPE]) +
    labs(x = 'Event Type') +
    labs(y = 'Total Fatalities') +
    labs(title='Fatalities') +
    #scale_y_continuous(labels=c("", "50", "100", "150")) +
    theme_bw() + theme(plot.title=element_text(vjust=-5, size=20))

library(gridExtra)
grid.arrange(p1, p2, ncol=1, main='Most Injurious Weather Events - 1950 to 2011')
