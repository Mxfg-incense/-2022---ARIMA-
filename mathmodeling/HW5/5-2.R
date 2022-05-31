solvent <- data.frame(
  x = c(
    148, 76, 393, 520, 236, 134, 55, 166, 415, 153, 513,
    264, 433, 94, 535, 327, 214, 135, 280,
    304, 335, 643, 216, 536, 128, 723, 258, 380, 594, 465
  ),
  A = factor(rep(1:3, c(10, 10, 10)))
)
attach(solvent)
lamp_aov <- aov(x ~ A, data = solvent)
print(summary(lamp_aov))
print(pairwise.t.test(x, A))
plot(x~A)