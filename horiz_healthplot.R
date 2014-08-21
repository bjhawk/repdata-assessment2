png('health.png', height=1000, width=1000, type='cairo')
#sums
data.by.type <- data.by.type[order(-SUMINJ),]
total.inj <- ggplot(data=data.by.type[5:1,],aes(EVTYPE, SUMINJ, fill=EVTYPE)) +
    geom_bar(stat="identity") +
    scale_x_discrete(limits=data.by.type[5:1,EVTYPE]) +
    #scale_y_continuous(breaks=c(0,5e+10,1e+11,1.5e+11),labels=c(0,50,100,150)) +
    geom_text(aes(EVTYPE,rep_len(0,5),label=paste(EVTYPE, SUMINJ, sep=' - ')),
              hjust=0, vjust=3) +
    #geom_point(data=data[EVTYPE %in% data.by.type[1:5,EVTYPE]],
     #          aes(EVTYPE, (INJURIES), fill=EVTYPE), shape=23,
      #         alpha=0.75, position=position_jitter(height=.5, width=0)) +    
    labs(title='Highest Total Injuries') +
    theme_bw() +
    theme(plot.title=element_text(vjust=1, face='bold', size='16'),
          axis.title=element_blank(),
          axis.text=element_blank(),
          axis.ticks=element_blank()) + 
    guides(fill=F) +
    coord_flip()
#means
data.by.type <- data.by.type[order(-AVGINJ),]
avg.inj <- ggplot(data=data.by.type[5:1,],aes(EVTYPE, AVGINJ, fill=EVTYPE)) +
    geom_bar(stat="identity") +
    scale_x_discrete(limits=data.by.type[5:1,EVTYPE]) +
    scale_y_continuous(breaks=c(0,5e+08,1e+09,1.5e+09),labels=c(0,0.5,1.0,1.5)) +
    geom_text(aes(EVTYPE,rep_len(0,5),label=paste(EVTYPE, AVGINJ, sep=' - ')),
              hjust=0, vjust=3) +
    labs(title='Highest Average Injuries') +
    theme_bw() +
    theme(plot.title=element_text(vjust=1, face='bold', size='16'),
          axis.title=element_blank(),
          axis.text=element_blank(),
          axis.ticks=element_blank()) + 
    guides(fill=F) +
    coord_flip()

#sums - fatalities
data.by.type <- data.by.type[order(-SUMFAT),]
total.fat <- ggplot(data=data.by.type[5:1,],aes(EVTYPE, SUMFAT, fill=EVTYPE)) +
    geom_bar(stat="identity") +
    scale_x_discrete(limits=data.by.type[5:1,EVTYPE]) +
    #scale_y_continuous(breaks=c(0,5e+10,1e+11,1.5e+11),labels=c(0,50,100,150)) +
    geom_text(aes(EVTYPE,rep_len(0,5),label=paste(EVTYPE, SUMFAT, sep=' - ')),
              hjust=0, vjust=3) +
    #geom_point(data=data[EVTYPE %in% data.by.type[1:5,EVTYPE]],
    #          aes(EVTYPE, (INJURIES), fill=EVTYPE), shape=23,
    #         alpha=0.75, position=position_jitter(height=.5, width=0)) +    
    labs(title='Highest Total Fatalities') +
    theme_bw() +
    theme(plot.title=element_text(vjust=1, face='bold', size='16'),
          axis.title=element_blank(),
          axis.text=element_blank(),
          axis.ticks=element_blank()) + 
    guides(fill=F) +
    coord_flip()
#means
data.by.type <- data.by.type[order(-AVGFAT),]
avg.fat <- ggplot(data=data.by.type[5:1,],aes(EVTYPE, AVGFAT, fill=EVTYPE)) +
    geom_bar(stat="identity") +
    scale_x_discrete(limits=data.by.type[5:1,EVTYPE]) +
    scale_y_continuous(breaks=c(0,5e+08,1e+09,1.5e+09),labels=c(0,0.5,1.0,1.5)) +
    geom_text(aes(EVTYPE,rep_len(0,5),label=paste(EVTYPE, AVGFAT, sep=' - ')),
              hjust=0, vjust=3) +
    labs(title='Highest Average Fatalities') +
    theme_bw() +
    theme(plot.title=element_text(vjust=1, face='bold', size='16'),
          axis.title=element_blank(),
          axis.text=element_blank(),
          axis.ticks=element_blank()) + 
    guides(fill=F) +
    coord_flip()
library(gridExtra)
grid.arrange(total.inj,
             avg.inj,
             total.fat,
             avg.fat,
             ncol=2,
             main=textGrob("Most Dangerous Weather Event Types - 1950 to 2011",
                           gp=gpar(fontsize=20, fontface="bold"), just='top')
)
dev.off()
