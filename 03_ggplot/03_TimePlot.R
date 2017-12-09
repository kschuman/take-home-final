setwd('~/take-home-final/03_TimePlot')

# Libraries
library(ggplot)
library(plotly)
library(tidyr)
library(plyr)
library(reshape)

theme_set(theme_bw())

# Read data
SA <- read.csv('south_amer.csv', header=T)
freqs <- count(SA, c('country_txt','iyear'))

gplot <- ggplot(freqs, aes(x = iyear, y=freq, group=country_txt, color=country_txt)) + 
  geom_line() + labs(x = 'Year', y = '# Incidents', title='Incidents by Year and Country') +
  scale_color_discrete(name = 'Country')

gplot <- ggplotly(gplot, originalData = F, tooltip = c('iyear', 'freq', 'country_txt'))
saveWidget(gplot, '03_ggplot1.html', selfcontained = TRUE)


freqs2 <- count(SA, c('weaptype1_txt','iyear'))

gplot2 <- ggplot(freqs2, aes(x = iyear, y=freq, group=weaptype1_txt, color=weaptype1_txt)) + 
  geom_line() + labs(x = 'Year', y = '# Incidents', title='Incidents by Year and Weapon Type') +
  scale_color_discrete(name = 'Weapon Type')
#gplot2

gplot2 <- ggplotly(gplot2, originalData = F, tooltip = c('iyear', 'freq', 'weaptype1_txt'))
saveWidget(gplot2, '03_ggplot2.html', selfcontained = TRUE)




