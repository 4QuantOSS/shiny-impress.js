library(igraph)

layout.fcns<-new.env()
layout.fcns$Kamada<-layout.kamada.kawai
layout.fcns$Circle<-layout.circle
layout.fcns$LGL<-layout.lgl
layout.fcns$Grid<-layout.grid
layout.fcns$Grid3D<-layout.grid.3d
layout.fcns$DRL<-layout.drl
layout.fcns$Star<-layout.star

draw.graph<-function(g,layout.fcn) {
  plot(g,layout=layout.fcn)
}

make.random.graph<-function(nodes=10,con.frac=0.5) {
  node.names<-paste("Node",c(1:nodes),sep=" ")
  c.mat<-matrix(runif(length(node.names)^2)<con.frac,length(node.names),length(node.names))
  colnames(c.mat)<-node.names
  rownames(c.mat)<-node.names
  g<-graph.adjacency(c.mat,mode="directed")
  V(g)$degree <- degree(g)
  V(g)$label <- V(g)$name
  V(g)$color <- "lightblue"
  V(g)$size<-50
  E(g)$width<-2
  E(g)$curved<-T
  E(g)$arrow.mode<-1
  E(g)$color<-"black"
  g
}
