library(igraph)

make.random.ccm<-function(nodes=10,con.frac=0.5) {
  node.names<-paste("Slide",c(1:nodes),sep=" ")
  c.mat<-matrix(runif(length(node.names)^2),length(node.names),length(node.names))
  c.mat<-c.mat<con.frac
  colnames(c.mat)<-node.names
  rownames(c.mat)<-node.names
  c.mat
}

ccm.fcns<-new.env()
ccm.fcns$Random<-make.random.ccm
ccm.fcns$Full<-function(n,ignore) get.adjacency(graph.full(n,T))
ccm.fcns$Lattice<-function(n,ignore) get.adjacency(graph.lattice(n,directed=T))
ccm.fcns$Tree<-function(n,ignore) get.adjacency(graph.tree(n,T))
ccm.fcns$Ring<-function(n,ignore) get.adjacency(graph.ring(n,T))
ccm.fcns$FullCitation<-function(n,ignore) get.adjacency(graph.full.citation(n,T))

layout.fcns<-new.env()
layout.fcns$Auto<-layout.auto
layout.fcns$Random<-layout.random
layout.fcns$SVD<-layout.svd
layout.fcns$Sphere<-layout.sphere
layout.fcns$Spring<-layout.spring
layout.fcns$Kamada<-layout.kamada.kawai
layout.fcns$Circle<-layout.circle
layout.fcns$LGL<-layout.lgl
layout.fcns$Grid<-layout.grid
layout.fcns$Grid3D<-layout.grid.3d
layout.fcns$DRL<-layout.drl
layout.fcns$MDS<-layout.mds
layout.fcns$Star<-layout.star

draw.graph<-function(g,layout.fcn) {
  plot(g,layout=layout.fcn)
}


make.graph<-function(c.mat) {
  node.names<-paste("Slide",c(1:nrow(c.mat)),sep=" ")
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
