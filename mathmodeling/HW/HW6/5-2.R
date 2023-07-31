library(lpSolve)
c <- c(0.2, 0.7, 0.4, 0.3, 0.8)
a <- matrix(c(3, 2, 1, 6, 18, 1, 0.5, 0.2, 2, 0.5, 0.5, 1.0, 0.2, 2, 0.8),
  nrow = 3, ncol = 5, byrow = TRUE
)
d <- c(">=", ">=", ">=")
b <- c(700, 30, 100)
sol <- lp(
   objective.in = c,
  const.mat = a, const.dir = d, const.rhs = b
)
print(sol)
print(sol$solution)
