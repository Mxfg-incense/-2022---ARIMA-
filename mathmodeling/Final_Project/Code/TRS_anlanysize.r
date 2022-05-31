library(readr)
setwd("E:/Code/code/mathmodeling/Final_Project/DATA")
month_total <- read_csv("TRS_China_trainning.csv",
  locale = locale(encoding = "GBK")
)
test <- read_csv("TRS_China.csv",
  locale = locale(encoding = "GBK")
)
plot(ts(test[["社会消费品零售总额（亿元）"]], start = c(2012, 1), frequency = 12))
t <- month_total[["社会消费品零售总额（亿元）"]]
trs <- ts(t, start = c(2012, 1), frequency = 12)
plot(trs,
  main = "TRS of China 2012-2022",
  col = "#fb6305",
  xlab = "Time",
  ylab = "TRS",
  lwd = 2
)

library(forecast)
library(tseries)
fit <- stl(trs, s.window = "period")
plot(fit, main = "Decomposition", lwd = 2)

print(adf.test(t))

print(adf.test(diff(trs)))

fit <- auto.arima(diff(trs))
print(fit)
accuracy(fit)
forecast(fit, 100)
plot(forecast(fit, 100), xlab = "Month", ylab = "Annual Flow")