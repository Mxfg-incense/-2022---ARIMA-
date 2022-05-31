library(readr)
library(forecast)
library(urca)
library(knitr)
library(AICcmodavg)
library(ggplot2)
setwd("E:/Code/code/mathmodeling/Final_Project/DATA")
month_total <- read_csv("TRS_China_trainning.csv",
  locale = locale(encoding = "GBK")
)

t <- month_total[["社会消费品零售总额（亿元）"]]
trs <- ts(t, start = c(2012, 1), frequency = 12)

# plot(trs)

# diff_trs <- diff(trs)
# # 一阶差分与季节差分
# ggtsdisplay(diff_trs, lag.max = 100)
# diff_season <- diff(diff_trs, lag = 12)
# ggtsdisplay(diff(diff_trs, lag = 12), lag.max = 100)

# AIC检验
# 方格搜索合适的 p ，q ,Q

# 命名
# model_names <- rep("(p,1,q)(1,1,1)[12]", 30)
# model_names[1] <- "(1,1,1)(1,1,1)[12]"
# for (p in 0:5) {
#   for (q in 0:5) {
#     models <- append(models,list(Arima(trs,
#       order = c(p, 1, q),
#       seasonal = list(order = c(1, 1, 1), period = 12)
#     )))
#     model_names[length(models)] <-
#       gsub("p", as.character(p), model_names[length(models)])
#     model_names[length(models)] <-
#       gsub("q", as.character(q), model_names[length(models)])

#   }
# }models

#print(models)
# 残差检验
fit <- Arima(trs,
  order = c(1, 1, 1),
  seasonal = list(order = c(1, 1, 1), period = 12),

)
# 独立性检验
checkresiduals(fit)
# 正态分布检验
qqnorm(fit$residuals)
qqline(fit$residuals)
# 预测

# plot(fit$x,col="red",main="fitted model and original series")
# lines(fitted(fit),col="blue")
# plot(forecast(fit,h=12))
# 确定训练集和测试集
training <- subset(trs, end = length(trs) - 7)
print(autoplot(training))
test <- subset(trs, start = length(trs) - 6)
test.fit <- Arima(training,
  order = c(1, 1, 1),
  seasonal = list(order = c(1, 1, 1), period = 12),
  method = "ML"
)

print(autoplot(forecast(test.fit, h = 6)) + autolayer(test) +
  ylab("训练集") + xlab("时间") +
  theme(text = element_text(family = "STHeiti")))

print(autoplot(trs, series = "Training data") +
  autolayer(fitted(fit, h = 12),
    series = "12-step fitted values"
  ) +
  ylab("Training data") + xlab("Time") +
  theme(text = element_text(family = "STHeiti")))
print(accuracy(fit))


# 预测
print(autoplot(forecast(fit, h = 10)))
print(forecast(fit,h = 6))