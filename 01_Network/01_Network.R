library(igraph)
library(networkD3)

setwd('~/take-home-final/01_Network')

# Read data
edges <- read.csv('SA_edges.csv')[c('gname', 'country_txt')]
edges <- count(edges, c('gname','country_txt'))
nodes <- read.csv('SA_nodes.csv')[c('X0')]

# Network
simpleNetwork(edges, Source = 'gname', Target = 'country_txt', opacity=.8 ) %>% 
  htmlwidgets::prependContent(htmltools::tags$h1('Which Terrorist Groups Attach South American Countries?')) %>% 
  networkD3::saveNetwork(file="KS_D3Network.html",  selfcontained = TRUE)




