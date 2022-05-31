# HW4

1.

(1)

```python
x <- c(5.1, 3.5, 7.1, 6.2, 8.8, 7.8, 4.5, 5.6, 8.0, 6.4)
y <- c(1907, 1287, 2700, 2373, 3260, 3000, 1947, 2273, 3113, 2493)
relation <- lm(y ~ 1 + x)
print(summary(relation))
```

输出结果

```python
Call:
lm(formula = y ~ x)

Residuals:
     Min       1Q   Median       3Q      Max 
-128.591  -70.978   -3.727   49.263  167.228 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)   140.95     125.11   1.127    0.293    
x             364.18      19.26  18.908 6.33e-08 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 96.42 on 8 degrees of freedom
Multiple R-squared:  0.9781,    Adjusted R-squared:  0.9754
F-statistic: 357.5 on 1 and 8 DF,  p-value: 6.33e-08
```



从计算结果看出，回归方程不通过系数的检验（$t​$的统计量的 $P​$ 值 > $0.05​$ )，方程的检验（ $F​$ 的统计量的 $P​$ 值 < $0.05​$ ）和相关性检验（$R^2 = 0.9651​$).因此，回归方程为
$$
\hat{Y} = 75.48+377.75X
$$

```python
print(confint(relation))
```



列出 $\beta$ 的 $95\%$ 的置信区间

```python
                2.5 %   97.5 %
(Intercept) -304.7836 455.7411
x            319.2101 436.2887
```

上述区间包括零，说明常数项系数不显著，一次项系数显著。

(2)

  ```python
a <- data.frame(x = 7)
result <- predict(relation, a, interval = "prediction")
print(result)
result <- predict(relation, a, interval = "confidence")
print(result)
  ```

输出结果

```python
       fit      lwr      upr
1 2719.725 2409.654 3029.795
       fit      lwr     upr
1 2719.725 2618.399 2821.05
```

所以预测值 $2719.725$ ,预测区间 $[ 2409.654 ,3029.795]$ ,置信区间 $[2618.399, 2821.05]$

2.

```python
x <- c(
    27, 21, 22, 24, 25, 23, 20, 20, 29, 24, 25, 28, 26, 38, 32, 33, 31, 34,
    37, 38, 33, 35, 30, 31, 37, 39, 46, 49, 40, 42, 43, 46, 43, 44, 46, 47,
    45, 49, 48, 40, 42, 55, 54, 57, 52, 53, 56, 52, 50, 59, 50, 52, 58, 57
)

y <- c(
    73, 66, 63, 75, 71, 70, 65, 70, 79, 72, 68, 67, 79, 91, 76, 69, 66, 73,
    78, 87, 76, 79, 73, 80, 68, 75, 89, 101, 70, 72, 80, 83, 75, 71, 80, 96,
    92, 80, 70, 90, 85, 76, 71, 99, 86, 79, 92, 85, 71, 90, 91, 100, 80, 109
)
plot(x, y)
relation <- lm(y ~ 1 + x)
print(summary(relation))

```

输出结果为

```python
lm(formula = y ~ 1 + x)

Residuals:
     Min       1Q   Median       3Q      Max 
-16.4786  -5.7877  -0.0784   5.6117  19.7813 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) 56.15693    3.99367  14.061  < 2e-16 ***
x            0.58003    0.09695   5.983 2.05e-07 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 8.146 on 52 degrees of freedom
Multiple R-squared:  0.4077,    Adjusted R-squared:  0.3963
F-statistic: 35.79 on 1 and 52 DF,  p-value: 2.05e-07
```

从计算结果看出，回归方程通过系数的检验（ $t$ 的统计量的 $P$ 值 < $0.05$ )，方程的检验（ $F$ 的统计量的 $P$ 值 < $0.05$ ）, 但是相关性系数较差（$R^2 =0.4077$).

绘出正态 $Q-Q$ 图

![](E:\photo\Camera Roll\4-2-2.png)

绘出残差图

![](E:\photo\Camera Roll\4-2.png)

从图形看出，残差通过正态性检验，但不满足方差齐性要求，有喇叭口。

通过boxcox确定 $\lambda$ 的值为 $-2$

```python
boxcox(relation, lambda = seq(-5, 0, by = 0.1))
```

![4-3](E:\photo\Camera Roll\4-3.png)

做变换后残差与预测散点图

```python
lambda <- -2
ylam <- (y^lambda - 1) / lambda
relation <- lm(ylam ~ x)
print(summary(relation))
plot(fitted(relation), resid(relation),
    cex = 1.2, pch = 21, col = "red", bg = "orange",
    xlab = "Fitted Value", ylab = "Residuals"
)
```

![4-4](E:\photo\Camera Roll\4-4.png)

明显喇叭口形状有很大改善

所以$Box-Cox$ 变换是成功的，变换后能满足方差齐次性要求