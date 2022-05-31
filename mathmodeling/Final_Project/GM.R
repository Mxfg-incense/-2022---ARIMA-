gm11 <- function(x, k) {
n <- length(x)
x1 <- numeric(n)
for (i in 1:n) {  ##一次累加
x1[i] <- sum(x[1:i])
}
b <- numeric(n)
m <- n - 1
for (j in 1:m) {
b[j + 1] <- (0.5 * x1[j + 1] + 0.5 * x1[j]) ## 紧邻均值生成
}
yn <- t(t(x[2:n])) ## 构造Yn矩阵
B <- matrix(1, nrow = n - 1, ncol = 2)
B[, 1] <- t(t(-b[2:n])) ## 构造B矩阵
print(B)
A <- solve(t(B) %*% B) %*% t(B) %*% yn## 使用最小二乘法求得灰参数a,u
a <- A[1]
u <- A[2]
x2 <- numeric(k)
x2[1] <- x[1]
for (i in 1 : k - 1) {
x2[1 + i] <- (x[1] - u / a) * exp(-a * i) + u / a
}
x2 <- c(0, x2)
y <- diff(x2)
## 累减生成，获得预测数据数列
print(y)
print(a)
}
acc <- function(x1, x2) {
  n <- length(x1)
  sum1 <- 0
  for (k in 2:n - 1) {
    sum1 <- sum1 + (x1[k] - x1[1])
  }
  s1 <- sum1 + 0.5 * (x1[n] - x1[1])
  sum2 <- 0
  for (k in 2:n - 1) {
    sum2 <- sum2 + (x2[k] - x2[1])
  }
  s2 <- sum2 + 0.5 * (x2[n] - x2[1])
  abs1 <- abs(s1)
  abs2 <- abs(s2)
  abs12 <- abs(s1 - s2)
  ee <- (1 + abs1 + abs2) / (1 + abs1 + abs2 + abs12)
  print(ee)
}
x <- c(408.40, 479.00, 574.60, 758.00, 1055.30)
gm11(x, 7)
x1 <- x
x2 <- gm11(x, length(x))
acc(x2, x1)
