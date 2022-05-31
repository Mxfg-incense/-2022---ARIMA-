library(readr)
setwd("E:/Code/code/mathmodeling/learn_R")
month_total <- c(
  1201.38, 988.4, 1086.25, 1065.78, 1092.88, 1226.75,
  1043.7, 1081.17, 1126.98, 1057.92, 1243.2, 1282.33, 1134.5,
  914.63, 1011.22, 1148.09, 1290.72, 1447.6, 1297.19, 1415.06, 1445.05,
  1421.76, 1709.62, 1697.54, 764.46, 615.43, 1518.17, 
  1385.51, 1492.77, 1613.49,1377.27, 1379.31,
  1474.16, 1468.21, 1726.56, 1605.29, 1500,1378.21, 1231.44
)
print(month_total)
print(attributes(month_total))
revenue <- ts(month_total, start = c(2019, 1), frequency = 12)
plot(revenue,
  main = "Total",
  col = "red",
)
library(forecast)
opar <- par(no.readonly = TRUE)
par(mfrow = c(2, 1))
ylim <- c(min(revenue), max(revenue))
plot(revenue,main="Raw time series")
plot(ma(revenue,2),main="Simple Moving Averages (k=2)")

fit <- stl(revenue, s.window = "period")
plot(fit)
fit$time.series[1:12]