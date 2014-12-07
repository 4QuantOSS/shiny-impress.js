library(igraph)

layout.fcns<-new.env()
layout.fcns$Kamada<-layout.kamada.kawai
layout.fcns$Circle<-layout.circle

draw.graph<-function(g,layout.fcn) {
  plot(g,layout=layout.fcn)
}

make.random.graph<-function(nodes=10) {
  node.names<-c("Cells","Animals","Type","Anisotropy","Volume","Animal","id","Weight")
  c.mat<-matrix(0,length(node.names),length(node.names))
  colnames(c.mat)<-node.names
  rownames(c.mat)<-node.names
  c.mat["Cells","Animal"]<-1
  c.mat["Cells","Type"]<-1
  c.mat["Cells","Anisotropy"]<-1
  c.mat["Cells","Volume"]<-1
  c.mat["Animals","id"]<-1
  c.mat["Animals","Weight"]<-1
  c.mat["Animal","id"]<-1
  g<-graph.adjacency(c.mat,mode="directed")
  V(g)$degree <- degree(g)
  V(g)$label <- V(g)$name
  V(g)$color <- "lightblue"
  V(g)["Cells"]$color<-"red"
  V(g)["Animals"]$color<-"red"
  V(g)["Cells"]$frame.width<-4 
  V(g)["Animals"]$frame.width<-4
  V(g)$size<-50
  E(g)$width<-2
  E(g)$curved<-F
  E(g)$arrow.mode<-1
  E(g)[7]$width<-5
  E(g)[7]$curved<-T
  E(g)[7]$arrow.mode<-3
  E(g)$color<-"black"
  g
}
