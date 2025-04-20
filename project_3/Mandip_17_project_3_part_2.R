# Setup and libraries
library(ggplot2)
library(tidyverse)
library(igraph)

setwd("/Users/admin/Desktop/projects/r-starter/project_3")

# Reading the datasets
media_nodes <- read.csv("Dataset1-Media-Example-NODES.csv", header=T, as.is=T)
media_edges <- read.csv("Dataset1-Media-Example-EDGES.csv", header=T, as.is=T)

head(media_nodes)
head(media_edges)
nrow(media_nodes); length(unique(media_nodes$id))
nrow(media_edges); nrow(unique(media_edges[,c("from", "to")]))

# Remedying the 3 non unique links
media_edges <- aggregate(media_edges[,3], media_edges[,-3], sum)
media_edges <- media_edges[order(media_edges$from, media_edges$to),]
colnames(media_edges)[4] <- "weight"
rownames(media_edges) <- NULL

# Reading user-media data
media_user_nodes <- read.csv("Dataset2-Media-User-Example-NODES.csv", header=T, as.is=T)
media_user_adj_matrix <- read.csv("Dataset2-Media-User-Example-EDGES.csv", header=T, , as.is=T)
head(media_user_nodes)
head(media_user_adj_matrix)

# Convert to matrix
media_user_adj_matrix <- as.matrix(media_user_adj_matrix)
dim(media_user_adj_matrix)
dim(media_user_nodes)

# Create igraph object
media_network <- graph_from_data_frame(d=media_edges, vertices=media_nodes, directed=T) 

# Display edges and vertices
E(media_network)       # The edges of the media network
V(media_network)       # The vertices of the media network

# Initial plot
plot(media_network, edge.arrow.size=.4, vertex.label=NA)

# Remove loops
media_network <- simplify(media_network, remove.multiple = F, remove.loops = T) 

# Convert to graph using links matrix
bipartite_network <- graph_from_biadjacency_matrix(media_user_adj_matrix)
table(V(bipartite_network)$type)

# Plot Media Organizations
bipartite_proj <- bipartite.projection(bipartite_network)
plot(bipartite_proj$proj1, vertex.label.color="black", vertex.label.dist=1,
     vertex.size=7, vertex.label=media_user_nodes$media[!is.na(media_user_nodes$media.type)])

# Plot Media Consumers
plot(bipartite_proj$proj2, vertex.label.color="black", vertex.label.dist=1,
     vertex.size=7, vertex.label=media_user_nodes$media[is.na(media_user_nodes$media.type)])

# Different visualization options
plot(media_network, edge.arrow.size=.4, edge.curved=.1)

# Add media organization labels
set.seed(42)
plot(media_network, edge.arrow.size=.2, edge.curved=0,
     vertex.color="orange", vertex.frame.color="#555555",
     vertex.label=V(media_network)$media, vertex.label.color="black",
     vertex.label.cex=.7) 

# Customize node appearance based on media attributes
colrs <- c("gray50", "tomato", "gold")
V(media_network)$color <- colrs[V(media_network)$media.type]
V(media_network)$size <- V(media_network)$audience.size*0.7
V(media_network)$label.color <- "black"
V(media_network)$label <- NA
E(media_network)$width <- E(media_network)$weight/6
E(media_network)$arrow.size <- .2
E(media_network)$edge.color <- "gray80"
E(media_network)$width <- 1+E(media_network)$weight/12

# Plot with new styling
plot(media_network)

# Add legend
plot(media_network) 
legend("bottomleft", c("Newspaper", "Television", "Online News"), 
       pch=21, col="#777777", pt.bg=colrs, pt.cex=2, 
       cex=.8, bty="n", ncol=1)

# Plot with vertex shapes
plot(media_network, vertex.shape="none", vertex.label=V(media_network)$media, 
     vertex.label.font=2, vertex.label.color="gray40",
     vertex.label.cex=.7, edge.color="gray85")

# Create sample network for layout demonstrations
set.seed(123)
layout_network <- sample_pa(80)
V(layout_network)$size <- 8
V(layout_network)$frame.color <- "white"
V(layout_network)$color <- "orange"
V(layout_network)$label <- ""
E(layout_network)$arrow.mode <- 0

# Create normalized FR layout coordinates
l <- layout_with_fr(layout_network)
l <- norm_coords(l, ymin=-1, ymax=1, xmin=-1, xmax=1)

# Plot at different scales
par(mfrow=c(2,2), mar=c(0,0,0,0))
plot(layout_network, rescale=F, layout=l*0.4)
plot(layout_network, rescale=F, layout=l*0.6) 
plot(layout_network, rescale=F, layout=l*0.8)
plot(layout_network, rescale=F, layout=l*1.0)

# Try different layouts
plot(layout_network, layout=layout_randomly)
plot(layout_network, layout=layout_in_circle)
l <- cbind(1:vcount(layout_network), c(1, vcount(layout_network):2))
plot(layout_network, layout=l)
l <- layout_randomly(layout_network)
plot(layout_network, layout=l)
l <- layout_on_sphere(layout_network)
plot(layout_network, layout=l)

# Fruchterman-Reingold Algorithm
l <- layout_with_fr(layout_network)
plot(layout_network, layout=l)

# Compare Different FR Layout Runs
par(mfrow=c(2,2), mar=c(0,0,0,0))
plot(layout_network, layout=layout_with_fr)
plot(layout_network, layout=layout_with_fr)
plot(layout_network, layout=l)
plot(layout_network, layout=l)

# Compare Different Layout Scales
l <- layout_with_fr(layout_network)
l <- norm_coords(l, ymin=-1, ymax=1, xmin=-1, xmax=1)
par(mfrow=c(2,2), mar=c(0,0,0,0))
plot(layout_network, rescale=F, layout=l*0.4)
plot(layout_network, rescale=F, layout=l*0.6)
plot(layout_network, rescale=F, layout=l*0.8)
plot(layout_network, rescale=F, layout=l*1.0)

# Kamada Kawai Algorithm
l <- layout_with_kk(layout_network)
plot(layout_network, layout=l)

# LGL algorithm
plot(layout_network, layout=layout_with_lgl)

# Heatmap
netm <- get.adjacency(media_network, attr="weight", sparse=F)
colnames(netm) <- V(media_network)$media
rownames(netm) <- V(media_network)$media
palf <- colorRampPalette(c("gold", "dark orange")) 
heatmap(netm[,17:1], Rowv = NA, Colv = NA, col = palf(100), 
        scale="none", margins=c(10,10))

# Two mode network visualization
V(bipartite_network)
V(bipartite_network)$color <- c("steel blue", "orange")[V(bipartite_network)$type+1]
V(bipartite_network)$shape <- c("square", "circle")[V(bipartite_network)$type+1]
V(bipartite_network)$label <- ""
V(bipartite_network)$label[V(bipartite_network)$type==F] <- media_user_nodes$media[V(bipartite_network)$type==F] 
V(bipartite_network)$label.cex=.4
V(bipartite_network)$label.font=2
plot(bipartite_network, vertex.label.color="white", vertex.size=(2-V(bipartite_network)$type)*8)

plot(bipartite_network, vertex.label=NA, vertex.size=7, layout=layout_as_bipartite)

plot(bipartite_network, vertex.shape="none", vertex.label=media_user_nodes$media,
     vertex.label.color=V(bipartite_network)$color, vertex.label.font=2.5, 
     vertex.label.cex=.6, edge.color="gray70", edge.width=2)

# Network and Node Descriptives
edge_density(media_network, loops=F)
ecount(media_network)/(vcount(media_network)*(vcount(media_network)-1))

# Reciprocity
reciprocity(media_network)
dyad_census(media_network)
2*dyad_census(media_network)$mut/ecount(media_network)

# Transitivity
transitivity(media_network, type="global")
transitivity(as_undirected(media_network, mode="collapse"))
transitivity(media_network, type="local")
triad_census(media_network)

# Diameter analysis
diameter(media_network, directed=F, weights=NA)
diameter(media_network, directed=F)
diam <- get_diameter(media_network, directed=T)
diam
class(diam)
as.vector(diam)

# Visualize diameter
vcol <- rep("gray40", vcount(media_network))
vcol[diam] <- "gold"
ecol <- rep("gray80", ecount(media_network))
ecol[E(media_network, path=diam)] <- "orange"
plot(media_network, vertex.color=vcol, edge.color=ecol, edge.arrow.mode=0)

# Node Degrees
deg <- degree(media_network, mode="all")
plot(media_network, vertex.size=deg*3)
hist(deg, breaks=1:vcount(media_network)-1, main="Histogram of node degree")

# Degree Distribution
deg.dist <- degree_distribution(media_network, cumulative=T, mode="all")
plot(x=0:max(deg), y=1-deg.dist, pch=19, cex=1.2, col="orange", 
     xlab="Degree", ylab="Cumulative Frequency")

# Centrality and Centralization
degree(media_network, mode="in")
centr_degree(media_network, mode="in", normalized=T)
closeness(media_network, mode="all", weights=NA)
centr_clo(media_network, mode="all", normalized=T)
betweenness(media_network, directed=T, weights=NA)
edge_betweenness(media_network, directed=T, weights=NA)
centr_betw(media_network, directed=T, normalized=T)

# Hubs and Authorities
hs <- hub_score(media_network, weights=NA)$vector
as <- authority_score(media_network, weights=NA)$vector
par(mfrow=c(1,2))
plot(media_network, vertex.size=hs*50, main="Hubs")
plot(media_network, vertex.size=as*30, main="Authorities")

# Distance Analysis
mean_distance(media_network, directed=F)
mean_distance(media_network, directed=T)

# Distance from NYT
dist.from.NYT <- distances(media_network, v=V(media_network)[media=="NY Times"], to=V(media_network), weights=NA)
oranges <- colorRampPalette(c("dark red", "gold"))
col <- oranges(max(dist.from.NYT)+1)
col <- col[dist.from.NYT+1]
plot(media_network, vertex.color=col, vertex.label=dist.from.NYT, edge.arrow.size=.6, 
     vertex.label.color="white")

# Shortest path analysis
news.path <- shortest_paths(media_network, 
                          from = V(media_network)[media=="MSNBC"], 
                          to = V(media_network)[media=="New York Post"],
                          output = "both")
ecol <- rep("gray80", ecount(media_network))
ecol[unlist(news.path$epath)] <- "orange"
ew <- rep(2, ecount(media_network))
ew[unlist(news.path$epath)] <- 4
vcol <- rep("gray40", vcount(media_network))
vcol[unlist(news.path$vpath)] <- "gold"
plot(media_network, vertex.color=vcol, edge.color=ecol, 
     edge.width=ew, edge.arrow.mode=0)

# Edge analysis for WSJ
inc.edges <- incident(media_network, V(media_network)[media=="Wall Street Journal"], mode="all")
ecol <- rep("gray80", ecount(media_network))
ecol[inc.edges] <- "orange"
vcol <- rep("grey40", vcount(media_network))
vcol[V(media_network)$media=="Wall Street Journal"] <- "gold"
plot(media_network, vertex.color=vcol, edge.color=ecol)

# Neighbor analysis for WSJ
neigh.nodes <- neighbors(media_network, V(media_network)[media=="Wall Street Journal"], mode="out")
vcol[neigh.nodes] <- "#ff9d00"
plot(media_network, vertex.color=vcol)

# Edge selection between newspaper and online sources
E(media_network)[V(media_network)[type.label=="Newspaper"] %->% V(media_network)[type.label=="Online"]]

# Convert to undirected graph for subgroup analysis
net.sym <- as.undirected(media_network, mode= "collapse",
                        edge.attr.comb=list(weight="sum", "ignore"))

# Clique analysis
vcol <- rep("grey80", vcount(net.sym))
vcol[unlist(largest_cliques(net.sym))] <- "gold"
plot(as.undirected(net.sym), vertex.label=V(net.sym)$name, vertex.color=vcol)

# Community Detection
ceb <- cluster_edge_betweenness(media_network)
plot_dendrogram(ceb, mode="hclust")
plot(ceb, media_network)
length(ceb)
membership(ceb)
modularity(ceb)

# Label propagation community detection
clp <- cluster_label_prop(media_network)
plot(clp, media_network)

# K-core decomposition
kc <- coreness(media_network, mode="all")
plot(media_network, vertex.size=kc*6, vertex.label=kc, vertex.color=colrs[kc])

# Fast greedy community detection
cfg <- cluster_fast_greedy(as.undirected(media_network))
plot(cfg, as.undirected(media_network))

# Assortativity analysis
assortativity_nominal(media_network, V(media_network)$media.type, directed=F)
assortativity(media_network, V(media_network)$audience.size, directed=F)
assortativity_degree(media_network, directed=F)
