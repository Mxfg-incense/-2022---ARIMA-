library(lpSolve)
c <- c(3, 1, 4)
a <- matrix(c(6, 3, 5, 3, 4, 5),
  nrow = 2, ncol = 3, byrow = TRUE
)
d <- c("<=", "<=")
b <- c(45, 30)
sol <- lp(
  direction = "max", objective.in = c,
  const.mat = a, const.dir = d, const.rhs = b, compute.sens = 1
)
print(sol$solution)

print(sol$sens.coef.from)
print(sol$sens.coef.to)

print(sol$duals)
print(sol$duals.from)
print(sol$duals.to)
