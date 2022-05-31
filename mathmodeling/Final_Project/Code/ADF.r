library(readr)
library(zoo)
library(forecast)
library(urca)
library(fUnitRoots)
setwd("E:/Code/code/mathmodeling/Final_Project/DATA")
month_total <- read_csv("TRS_China_trainning.csv",
  locale = locale(encoding = "GBK")
)

t <- month_total[["社会消费品零售总额（亿元）"]]
trs <- ts(t, start = c(2012, 1), frequency = 12)

fit <- stl(trs, s.window = "period")
print(ndiffs(trs))
print(adfTest(trs))
print(adfTest(diff(trs)))
plot(diff(trs))

print(Box.test(trs, lag = 6, type = "Ljung-Box"))


ggtsdisplay(diff(trs),lag.max = 100)
pacf(diff(trs),lag=100)