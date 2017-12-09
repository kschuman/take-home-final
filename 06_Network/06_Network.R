setwd('~/take-home-final/06_Network')

# Libraries
library(igraph)
library(extrafont)
library(RColorBrewer)
library(colorspace)
library(grDevices)
library(networkD3)
library(plyr)
library(scales)
#library(dplyr)


pdf('06_Network.pdf', height=20, width=30)

# Read data
edges <- read.csv('SA_edges2.csv')[c('natlty1_txt', 'country_txt')]
nodes <- read.csv('SA_nodes2.csv')
edges <- count(edges, c('natlty1_txt','country_txt'))

count(edges, c('natltly1_txt', 'country_txt'))

names(edges) <- c('Origin', 'Target', 'Count')

nodes$ID <- c(0:(length(nodes$X0)-1))
rownames(nodes) <- nodes$ID
nodes <- data.frame(nodes$X0)

n1 <- edges[c('Target', 'Count')]
n1 <- aggregate(n1$Count, by=list(edges$Target), FUN=sum)
names(n1) <- c('Target', 'Count')
names(nodes) <- 'Target'
nodes <- merge(nodes, n1, by='Target', all.x = TRUE)
nodes[is.na(nodes)] <- 0
nodes
###### --------------------
# Set up network
g <- graph.data.frame(edges, nodes, directed=T)
#plot(g)

# Edge label is score differential
E(g)$label <- edges$Count
E(g)$label.cex <- .8



# Vertex colors based on conference
#col.a <- palette(rainbow_hcl(length(unique(nodes$ConfNum)), start = 10, end = 440))
#col.a <- palette(c(brewer.pal(n = 10, name = "Set3"), brewer.pal(n = 8, name = "Set1")))
#col.a <- palette(c('darkseagreen', 'indianred3', 'powderblue', 'royalblue2',
#                   'yellowgreen', 'tan1', 'cornflowerblue', ' plum3', 'rosybrown3',
#                   'darkolivegreen1', 'lightpink2', 'lightseagreen', 'lightsteelblue2',
#                   'salmon', 'pink2', 'tomato2', 'slateblue2', 'gold', 'mediumpurple1', 'cadetblue'))

#V(g)$color <- col.a[V(g)$Conference.Num]

# Vertex size by rank
#V(g)$size <- with(nodes, ifelse(College.Football.Playoff.Ranking < 25, 8, 3))



with(nodes, ifelse(Count == 0, 3, 10))
# Bigger labels for highly ranked schools
#V(g)$label.cex <- with(nodes, ifelse(College.Football.Playoff.Ranking < 25, 1, .5))
V(g)$size <- with(nodes, ifelse(Count == 0, 3, 10))
V(g)$size
# Rescale to 0 -> 1
E(g)$arrow.size <- .25

# Plot
plot(g, main='Where do South American Attackers Come From?')
#legend('bottomleft', unique(V(g)$Conference),
#       pch=21,col=col.a, pt.bg=col.a, pt.cex=1.5, cex=1, bty="n",
#       ncol=1, title = 'Conference')



wt <- cluster_walktrap(g, steps=5)
members <- membership(wt)

#plot(simple)
graph <- igraph_to_networkD3(g, group=members)

d3 <- forceNetwork(Links = graph$links, Nodes = graph$nodes, 
             Source = 'source',
             Target = 'target', 
             NodeID = 'name', 
             Group = 'group',
             zoom = TRUE, 
             linkDistance = 300, 
             fontSize = 20,
             opacity = .9,
             opacityNoHover = 0.5)  %>% 
  htmlwidgets::prependContent(htmltools::tags$h1('Where do South American Attackers Come From?')) %>% 
  networkD3::saveNetwork(file="06_Network.html",  selfcontained = TRUE)

# D3 Plot

graph
dev.off()



