person <- data.frame(
    X = c(
        62, 60, 60, 25, 24, 23, 20, 13, 12, 6,
        62, 62, 24, 24, 22, 20, 19, 10, 8, 8,
        37, 31, 15, 15, 14, 14, 14, 5, 3, 2
    ),
    A = factor(rep(1:3, c(10, 10, 10)))
)

print(bartlett.test(X ~ A, data = person))
