library(ggplot2, help, pos = 2, lib.loc = NULL)
library(forecast)
set.seed(0)
x<-w<-rnorm(1000)       # 生成符合正态分布N(0,1)的数据
 for(t in 2:1000) x[t]<-x[t-1]+w[t]
 tsx<-ts(x)              # 生成ts时间序列的数据集

# 查看数据集
 head(tsx,15)


 plot(tsx)            # 生成可视化图形 
 a <- ar(tsx)
 # 进行自回归建模
 print(ggplot2:: autoplot(forecast(a,h=50)))