png('cost.png', height=750, width=600, type='cairo')

data.by.type <- data.by.type[order(-SUMDMG),]
total.figure <- ggplot(data=data.by.type[5:1,],aes(EVTYPE, SUMDMG, fill=EVTYPE)) +
    geom_bar(stat="identity") +
    scale_x_discrete(limits=data.by.type[5:1,EVTYPE]) +
    scale_y_continuous(breaks=c(0,5e+10,1e+11,1.5e+11),labels=c(0,50,100,150)) +
    geom_text(aes(EVTYPE,rep_len(min(data.by.type$SUMDMG),5),
                  label=paste(EVTYPE, '-', '$', format(SUMDMG/1e+09, digits=3), 'B', sep=' ')),
              hjust=0, vjust=2) +
    geom_point(data=data[EVTYPE %in% data.by.type[5:1,EVTYPE]],
               aes(EVTYPE, (PROPDMG+CROPDMG), fill=EVTYPE), shape=23,
               alpha=0.75, position=position_jitter(height=.5, width=0)) +    
    labs(title='Highest Total Costs') +
    theme_bw() +
    theme(plot.title=element_text(vjust=1, face='bold', size='16'),
          axis.title=element_blank(),
          axis.text=element_blank(),
          axis.ticks=element_blank()) + 
    guides(fill=F) +
    coord_flip()
#means
data.by.type <- data.by.type[order(-AVGDMG),]
avg.figure <- ggplot(data=data.by.type[5:1,],aes(EVTYPE, AVGDMG, fill=EVTYPE)) +
    geom_bar(stat="identity") +
    scale_x_discrete(limits=data.by.type[5:1,EVTYPE]) +
    scale_y_continuous(breaks=c(0,5e+08,1e+09,1.5e+09),labels=c(0,0.5,1.0,1.5)) +
    geom_text(aes(EVTYPE,rep_len(min(data.by.type$AVGDMG),5),
                  label=paste(EVTYPE, '-', '$', format(AVGDMG/1e+09, digits=3), 'B', sep=' ')),
              hjust=0, vjust=2) +
    labs(title='Highest Average Costs') +
    theme_bw() +
    theme(plot.title=element_text(vjust=1, face='bold', size='16'),
          axis.title=element_blank(),
          axis.text=element_blank(),
          axis.ticks=element_blank()) + 
    guides(fill=F) +
    coord_flip()
library(gridExtra)
grid.arrange(total.figure,
             avg.figure,
             ncol=1,
             main=textGrob("Most Costly Weather Event Types - 1950 to 2011",
                           gp=gpar(fontsize=20, fontface="bold"), just='top')
)
dev.off()
