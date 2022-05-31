library(lpSolve)
c <- c(7, 3, 6)
a <- matrix(c(4, 4, 5, 4, 2, 3), nrow = 2, ncol = 3, byrow = TRUE)
d <- c("<=", "<=")
b <- c(600, 1400)
sol <- lp(
  direction = "max", objective.in = c,
  const.mat = a, const.dir = d, const.rhs = b
)
print(sol)
print(sol$solution)
