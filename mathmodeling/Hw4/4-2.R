x <- c(
    27, 21, 22, 24, 25, 23, 20, 20, 29, 24, 25, 28, 26, 38, 32, 33, 31, 34,
    37, 38, 33, 35, 30, 31, 37, 39, 46, 49, 40, 42, 43, 46, 43, 44, 46, 47,
    45, 49, 48, 40, 42, 55, 54, 57, 52, 53, 56, 52, 50, 59, 50, 52, 58, 57
)

y <- c(
    73, 66, 63, 75, 71, 70, 65, 70, 79, 72, 68, 67, 79, 91, 76, 69, 66, 73,
    78, 87, 76, 79, 73, 80, 68, 75, 89, 101, 70, 72, 80, 83, 75, 71, 80, 96,
    92, 80, 70, 90, 85, 76, 71, 99, 86, 79, 92, 85, 71, 90, 91, 100, 80, 109
)
plot(x, y)
relation <- lm(y ~ 1 + x)
print(summary(relation))

plot(relation, 1)
plot(relation, 2)
library(MASS)
plot(fitted(relation), resid(relation),
    cex = 1.2, pch = 21, col = "red", bg = "orange",
    xlab = "Fitted Value", ylab = "Residuals"
)

boxcox(relation, lambda = seq(-5, 0, by = 0.1))

lambda <- (-2)
ylam <- (y^lambda - 1) / lambda
lam <- lm(ylam ~ x)
print(summary(lam))
plot(fitted(lam), resid(lam),
    cex = 1.2, pch = 21, col = "red", bg = "orange",
    xlab = "Fitted Value", ylab = "Residuals"
)

library(MASS)
beta0 <- lam$coefficients[1]
beta1 <- lam$coefficients[2]
curve((1 + lambda * (beta0 + beta1 * x))^(1 / lambda),
    from = min(x), to = max(x), col = "blue", lwd = 2,
    xlab = "X", ylab = "Y"
)
points(x, y, pch = 1.2, cex = 1.2, col = "red", bg = "orange")
mtext("Box-Cox Transformations", outer = TRUE, cex = 1.5)
