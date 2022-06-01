library(readr)
library(forecast)
library(urca)
library(knitr)
library(AICcmodavg)
library(ggplot2)

#数据读取
setwd("E:/Code/code/mathmodeling/Final_Project/DATA")
month_total <- read_csv("TRS_China_trainning.csv",
  locale = locale(encoding = "GBK")
)
t <- month_total[["社会消费品零售总额（亿元）"]]
trs <- ts(t, start = c(2012, 1), frequency = 12)

#方格搜索合适的 p ，q ,Q
models <- list(Arima(trs,
  order = c(1, 1, 1),
  seasonal = list(order = c(1, 1, 1), period = 12)
))
model_names <- rep("(p,1,q)(1,1,1)[12]", 30)
model_names[1] <- "(1,1,1)(1,1,1)[12]"
for (p in 0:5) {
  for (q in 0:5) {
    models <- append(models,list(Arima(trs,
      order = c(p, 1, q),
      seasonal = list(order = c(1, 1, 1), period = 12)
    )))
    model_names[length(models)] <-
      gsub("p", as.character(p), model_names[length(models)])
    model_names[length(models)] <-
      gsub("q", as.character(q), model_names[length(models)])
  }
}
print(models)

# 选取出最优的模型为ARIMA(2,1,1)(1,1,1)[12]
fit <- Arima(trs,
  order = c(2, 1, 1),
  seasonal = list(order = c(1, 1, 1), period = 12)
)

# 残差检验
checkresiduals(fit)
qqnorm(fit$residuals)
qqline(fit$residuals)

# 预测
print(autoplot(trs, series = "Training data") +
  autolayer(fitted(fit, h = 12),
    series = "12-step fitted values"
  ) +
  ylab("Training data") + xlab("Time") +
  theme(text = element_text(family = "STHeiti")))
print(autoplot(forecast(fit, h = 10)))
print(forecast(fit,h = 10))