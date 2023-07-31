setwd("E:/Code/code/mathmodeling/HW1")
x <- scan("height.txt")
r1 <- quantile(x, 3 / 4, names = FALSE) - quantile(x, 1 / 4, names = FALSE)
    frame <- data.frame(
        n = length(x), mean = mean(x), median = median(x),
        sd = sd(x), R = max(x) - min(x), R1 = r1
    )
print(frame)
