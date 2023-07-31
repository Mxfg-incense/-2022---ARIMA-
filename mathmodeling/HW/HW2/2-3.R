library(MASS)
train <- matrix(
    c(
        1.24, 1.36, 1.38, 1.38, 1.38, 1.40, 1.48, 1.54, 1.56,
        1.14, 1.18, 1.20, 1.26, 1.28, 1.30,
        1.27, 1.74, 1.64, 1.82, 1.90, 1.70, 1.82, 1.82, 2.08,
        1.78, 1.96, 1.86, 2.00, 2.00, 1.96
    ),
    ncol = 2
)
sp <- factor(rep(1:2, c(9, 6)), labels = c("Af", "Apf"))
tst <- c(1.00, 190)
lda_sol <- lda(train, sp)
print(predict(lda_sol, tst)$class)
print(table(sp, predict(lda_sol)$class))
qda_sol <- qda(train, sp)
print(predict(qda_sol, tst)$class)
print(table(sp, predict(qda_sol)$class))
