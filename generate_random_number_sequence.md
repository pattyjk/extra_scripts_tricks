## Generate random number string in R

```
#2500 is the number of numbers needed
# 1 and 6 are the range of numbers to generate in between
x1 <- round(runif(2500, 1, 6),0)
x1
write.table(x1, 'data.txt', row.names=F, quote=F)
```