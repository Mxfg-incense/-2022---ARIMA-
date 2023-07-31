library(igraph,warn.conflicts = F)
library(igraph)
m <- matrix(
  c(
    1, 2, 3, 1, 3, 2, 1, 4, 4,
    2, 3, 2, 2, 6, 4,
    3, 5, 2, 3, 4, 3,
    4, 7, 5,
    5, 6, 1, 5, 7, 2,
    6, 7, 3
  ),
  ncol = 3, byrow = TRUE
)
g <- make_graph(t(m[, 1:2]), directed = FALSE)
graph_attr(g, "weight") <- m[, 3]
plot(g, edge.label = m[, 3], edge.width = 2)
mst <- mst(g, weights = m[, 3])
print(mst)
print(sum(mst$weight))

plot(mst, edge.label = mst$weight, edge.width = 2,algorithm="prim")
