setwd('~/take-home-final/10_graphic')
library(plotly)
library(dplyr)

SA <- read.csv('south_amer.csv', header=T)
edges <- read.csv('sankey_nodes.csv', header=T)
nodes <- read.csv('sankey_true_nodes.csv', header=T)
nodes = data.frame("name" = 
                     nodes$name)# Node 3

links = edges[c('source_id', 'target_id')]

links <- data.frame(xtabs(~ source_id + target_id, links))
names(links) = c("source", "target", "value")

links$source <- as.numeric(links$source)
links$target <- as.numeric(links$target)
links$value <- as.numeric(links$value)

sankeyNetwork(Links = links, Nodes = nodes,
              Source = "source", Target = "target",
              Value = "value", NodeID = "name", sinksRight = TRUE,
              fontSize = 13)  %>% 
  htmlwidgets::prependContent(htmltools::tags$h1('Attacker Source to Attack Target')) %>% 
  networkD3::saveNetwork(file="attacks.html",  selfcontained = TRUE)


