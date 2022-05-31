setwd("E:/Code/code/mathmodeling/HW1")
x <- scan("height.txt")
print(x)
qqnorm(x,col="#797905");qqline(x,col="red")