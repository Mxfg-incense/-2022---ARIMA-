x <- c(4, 6, 7, 9)
y <- c(1, 2, 3, 5, 8)
print(wilcox.test(x, y, al = "g"))