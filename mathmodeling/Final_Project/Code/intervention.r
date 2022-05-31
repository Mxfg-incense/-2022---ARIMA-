library(readr)
library(forecast)
library(urca)
library(knitr)
library(AICcmodavg)
library(ggplot2)
library(tsfgrnn)
setwd("E:/Code/code/mathmodeling/Final_Project/DATA")
month_total <- read_csv("TRS_China_trainning.csv",
  locale = locale(encoding = "GBK")
)
t <- month_total[["社会消费品零售总额（亿元）"]]
trs <- ts(t, start = c(2012, 1), frequency = 12)


fit <- Arima(trs,
  order = c(1, 1, 1),
  seasonal = list(order = c(1, 1, 1), period = 12)
)
# 预测

# plot(fit$x,col="red",main="fitted model and original series")
# lines(fitted(fit),col="blue")
# plot(forecast(fit,h=12))
# 确定训练集和测试集
# print(autoplot(training))
# test <- subset(trs, start = length(trs) - 6)
# # test.fit <- Arima(training,
# #   order = c(1, 1, 1),
# #   seasonal = list(order = c(1, 1, 1), period = 12),
# #   method = "ML"
# )

# print(autoplot(forecast(test.fit, h = 6)) + autolayer(test) +
#   ylab("训练集") + xlab("时间") +
#   theme(text = element_text(family = "STHeiti")))

# print(autoplot(trs, series = "Training data") +
#   autolayer(fitted(fit, h = 12),
#     series = "12-step fitted values"
#   ) +
#   ylab("Training data") + xlab("Time") +
#   theme(text = element_text(family = "STHeiti")))
# print(accuracy(fit))
# 测算2020年的疫情损失

trs_2020 <- window(trs,
  start = c(2020, 1),
  end = c(2020, 12)
)
trs_2020_predict <- window(fitted(fit, h = 12),
  start = c(2020, 1),
  end = c(2020, 12)
)
print(trs_2020)
print(trs_2020_predict)

print(autoplot(trs_2020, series = "TRS_original") +
  autolayer(trs_2020_predict,
    series = "TRS_predicted"
  ) + geom_ribbon(
    aes(ymin = trs_2020, ymax = trs_2020_predict), fill = "red", alpha = 0.5
  ) +
  ylab("TRS") + xlab("Time") +
  theme(text = element_text(family = "STHeiti")))

print(autoplot(trs_2020_predict - trs_2020) +
  ylab("损失的消费品零售总额"))

# 分析干预模型参数估计AR模型

loss <- (trs_2020_predict - trs_2020)
x <- as.vector(loss)[1:11]
loss <- as.vector(loss)[2:12]
fit_loss <- lm(loss ~ 1 + x)

print(fit_loss)

print(fitted.values(fit_loss))
fitte <- ts(fitted.values(fit_loss),
  start = c(2020, 2), frequency = 12
)
print(autoplot(trs_2020_predict - trs_2020)+autolayer(fitte))


#残差检验
checkresiduals(fit_loss)

# 今年的数据

loss_2022 <- c(1:10)
loss_2022[1] = 3924.08
loss_2022[2] = 8587.446
for (i in c(3:10)) {
  loss_2022[i] = 0.8191 * loss_2022[i - 1] + 134.2268
}
#预测结果
trs_2022_loss <- ts(loss_2022, frequency = 12, start = c(2022, 3))
plot(trs_2022_loss)
print(trs_2022_loss)

#绘出2022年的图
month_total <- read_csv("TRS_China_trainning.csv",
  locale = locale(encoding = "GBK")
)

t <- month_total[["社会消费品零售总额（亿元）"]]
trs <- ts(t, start = c(2012, 1), frequency = 12)
fit <- Arima(trs,
  order = c(1, 1, 1),
  seasonal = list(order = c(1, 1, 1), period = 12),

)
fc <- forecast(fit, h = 10)
print(fc)
fc <- ts(c(
  38157.18, 38093.26, 41309.77, 42776.93, 41109.13,
  41751.93, 43536.51, 46978.47, 47642.45, 48357.27
), start = c(2022, 3), frequency = 12)

print(fc)
print(autoplot(fc) + autolayer(fc - trs_2022_loss)
  + geom_ribbon(aes(ymin = fc - trs_2022_loss, ymax = fc),
    fill = "red", alpha = 0.5
  ))
