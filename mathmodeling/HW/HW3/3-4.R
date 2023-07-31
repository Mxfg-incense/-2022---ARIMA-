x <- 0:4
y <- c(7, 10, 12, 8, 5)
#y <- c(6, 16, 17, 26, 11, 9, 9, 6)
f <- ppois(x, mean(rep(x, y)))
m <- length(y)
print(f)
p <- f[1]
p[m] <- 1 - f[m - 1]
for (i in 2:(m - 1)) p[i] <- f[i] - f[i - 1]
print(p)
print(chisq.test(y, p = p))
