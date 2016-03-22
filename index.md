---
title       : GDP per Capita by Countries
subtitle    : Course Project
author      : Thong B. Tran
job         : Developing Data Products
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Features 
Each year, the World Bank collects data from various sources and publish them on its website. This app
is an attempt to show the GDP per Capita of a few typical countries. In general, we have 

1. An interactive chart 
2. A summary of the GDP per Capita of the data
3. A data table to inspect each record.

---  

## Summary 
We can use `WDI`, an R package, in this project to get WDI data. Then we summarize it using the `summary` function in R 
 

```r
library(WDI)
dat <- WDI(indicator='NY.GDP.PCAP.CD', 
           country=c('US','GB','JP','FR','DE','TH','VN','ID'), 
           start=1980, end=2014)
summary(dat)
```

```
##     iso2c             country          NY.GDP.PCAP.CD          year     
##  Length:280         Length:280         Min.   :   97.16   Min.   :1980  
##  Class :character   Class :character   1st Qu.: 1878.80   1st Qu.:1988  
##  Mode  :character   Mode  :character   Median :17134.29   Median :1997  
##                                        Mean   :18642.74   Mean   :1997  
##                                        3rd Qu.:32832.81   3rd Qu.:2006  
##                                        Max.   :54629.50   Max.   :2014  
##                                        NA's   :5
```

---

## Chart
We can also visualize it by using `ggplot2` and `plotly`. The combination of these two library give you an interactive and beautiful chart.


```r
library(plotly)
library(ggplot2)
ggplot(data = dat, aes(year, NY.GDP.PCAP.CD, col = country)) + 
                                    geom_line() +     
                                    xlab('Year') + ylab('GDP per capita') + 
                                    labs(title = 'GDP Per Capita (current US$)')
```

![plot of chunk unnamed-chunk-2](assets/fig/unnamed-chunk-2-1.png)

```r
ggplotly()
```

---

## Data table
We can easily make a beautiful data table with `DT` package.


```r
library(DT)
datatable(data = dat)
```




