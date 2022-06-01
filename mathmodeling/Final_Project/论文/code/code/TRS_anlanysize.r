library(readr)
library(forecast)
library(tseries)
setwd("E:/Code/code/mathmodeling/Final_Project/DATA")

# 数据读取
month_total <- read_csv("TRS_China_trainning.csv",
  locale = locale(encoding = "GBK")
)
t <- month_total[["社会消费品零售总额（亿元）"]]
trs <- ts(t, start = c(2012, 1), frequency = 12)

# 绘出折线图
plot(trs,
  main = "TRS of China 2012-2022",
  col = "#fb6305",
  xlab = "Time",
  ylab = "TRS",
  lwd = 2
)

#stl季节性分解
fit <- stl(trs, s.window = "period")
plot(fit, main = "Decomposition", lwd = 2)

# 原数据平稳性检验
print(adf.test(t))

# 一阶差分与季节差分
diff_trs <- diff(trs)
ggtsdisplay(diff_trs, lag.max = 100)
diff_season <- diff(diff_trs, lag = 12)
ggtsdisplay(diff(diff_trs, lag = 12), lag.max = 100)
