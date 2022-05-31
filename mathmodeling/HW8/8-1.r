library(igraph,warn.conflicts = F)
library(igraph)
m <- matrix(c(
  1, 2, 2, 1, 3, 8, 1, 4, 1,
  2, 3, 6, 2, 5, 1,
  3, 4, 7,
  4, 7, 9,
  5, 3, 5, 5, 9, 1,
  6, 5, 3, 6, 3, 1, 6, 7, 4,
  7, 3, 2, 7, 9, 3, 7, 10, 1,
  8, 5, 2, 8, 11, 9,
  9, 8, 7, 9, 6, 6,
  10, 9, 1,
  10, 11, 4,
  11, 9, 2
), ncol = 3, byrow = TRUE)
g <- make_graph(t(m[, 1:2]), directed = TRUE)
graph_attr(g, "weight") <- m[, 3]
plot(g, edge.label = m[, 3])
print(
  shortest.paths(g, 1,weights = graph_attr(g, "weight"),algorithm="johnson")
)
gs <- get.shortest.paths(g, from = V(g)[1], weights = graph_attr(g, "weight"))
print(gs)
