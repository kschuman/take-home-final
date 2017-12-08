library(igraph)
library(networkD3)

setwd('~/take-home-final/01_Network')

# Read data
edges <- read.csv('SA_edges.csv')[c('gname', 'country_txt')]
edges <- count(edges, c('gname','country_txt'))
nodes <- read.csv('SA_nodes.csv')[c('X0')]

# Network
simpleNetwork(edges, Source = 'gname', Target = 'country_txt', opacity=.8 )


# Sankey network
names(nodes) <- 'name'
names(edges) <- c('source', 'target', 'value')


Data <- list()
Data$links <- data.frame(edges)
Data$nodes <- nodes

sankeyNetwork(Links = Data$edges, Nodes = Data$nodes)

Data
URL <- paste0("https://cdn.rawgit.com/christophergandrud/networkD3/",
              "master/JSONdata/energy.json")
Energy <- jsonlite::fromJSON(URL)
class(Energy)
# Plot
sankeyNetwork(Links = edges, Nodes = nodes, Source = "source",
              Target = "target", Value = "value", NodeID = "name",
               fontSize = 12, nodeWidth = 30)

edges

Data
head(Energy)
plot(g)
g$links
