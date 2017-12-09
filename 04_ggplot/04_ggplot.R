setwd('~/take-home-final/04_ggplot')

# Libraries
library(ggplot)
library(plotly)

# Read data
SA <- read.csv('south_amer.csv', header=T)
SA <- SA[which(SA$nperps > -1), ]
SA <- SA[which(SA$nkill > 1),]
SA <- SA[which(SA$nperps < 200),]


SA$weaptype1_txt <- as.character(SA$weaptype1_txt)
SA[which(SA$weaptype1_txt == 'Vehicle (not to include vehicle-borne explosives, i.e., car or truck bombs)'),
       "weaptype1_txt"] <- 'Vehicle'
SA$weaptype1_txt <- as.factor(SA$weaptype1_txt)


theme_set(theme_bw())

g <- ggplot(SA, aes(x=nperps, y=nkill, col=weaptype1_txt)) + geom_count() +
  labs(title='Does the Number of Perpetrators Influence the Number of People Killed?', 
       subtitle='For incidents with at least one person killed',
       x='Number or Perpetrators',
       y='Number of People Killed') + scale_size_continuous(guide=FALSE) +
  scale_color_discrete(name='Weapon Type') + geom_smooth(se=FALSE)
  #geom_smooth(group=weaptype1_txt, se=FALSE)

g <- ggplotly(g, originalData = F, tooltip=c('nperps', 'nkill'))
saveWidget(g, '04_ggplot.html', selfcontained = TRUE)


