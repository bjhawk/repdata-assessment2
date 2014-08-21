png('cost.png', height=1000, width=800, type='cairo')

cost.by.type <- cost.by.type[order(-SUM),]
total.figure <- ggplot(data=cost.by.type[1:5,]) +
    geom_bar(aes(EVTYPE, SUM, fill=EVTYPE), stat="identity") +
    scale_x_discrete(limits=cost.by.type[1:5,EVTYPE]) +
    scale_y_continuous(labels=c("", "50", "100", "150")) +
    geom_text(aes(EVTYPE,rep_len(min(cost.by.type$SUM),5),label=EVTYPE),angle=90, hjust=0, vjust=2) +
    geom_point(data=data[EVTYPE %in% cost.by.type[1:5,EVTYPE]],
               aes(EVTYPE, (PROPDMG+CROPDMG), fill=EVTYPE), shape=23,
               alpha=0.75, position=position_jitter(height=.5, width=0)) +    
    labs(y = 'Estimated Damage (Billions USD)') +
    labs(title='Highest Total Cost') +
    theme_bw() +
    theme(plot.title=element_text(vjust=-8),
          legend.title=element_blank(),
          legend.position='top',
          axis.title.x=element_blank(),
          axis.text.x=element_blank(),
          axis.ticks.x=element_blank(),
          plot.margin=unit(c(0,0,0,0), 'points')) + 
    guides(fill=F)
#means
cost.by.type <- cost.by.type[order(-AVG),]
avg.figure <- ggplot(data=cost.by.type[1:5,]) +
    geom_bar(aes(EVTYPE, AVG, fill=EVTYPE), stat="identity") +
    scale_x_discrete(limits=cost.by.type[1:5,EVTYPE]) +
    scale_y_continuous(breaks=c(0,5e+08,1e+09,1.5e+09),labels=c(0,0.5,1.0,1.5)) +
    geom_text(aes(EVTYPE,rep_len(min(cost.by.type$AVG),5),label=EVTYPE),angle=90, hjust=0, vjust=2) +
    labs(y = 'Estimated Damage (Billions USD)') +
    labs(title='Highest Average Cost') +
    theme_bw() +
    theme(plot.title=element_text(vjust=-8),
          legend.title=element_blank(),
          legend.position='top',
          axis.title.x=element_blank(),
          axis.text.x=element_blank(),
          axis.ticks.x=element_blank(),
          plot.margin=unit(c(0,0,0,0), 'points')) + 
    guides(fill=F)
library(gridExtra)
grid.arrange(total.figure,
             avg.figure,
             ncol=1,
             main=textGrob("Most Costly Weather Event Types - 1950 to 2011",
                       gp=gpar(fontsize=20, fontface="bold"))
             )
dev.off()
