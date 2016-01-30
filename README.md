# Description
This is a package called `rmaf` that contains a refined moving average filter using the optimal and data-driven moving average lag q to estimate the trend component, and then estimate seasonal component and irregularity for univariate time series or data.

# Installation
To install the version from CRAN, simply run the following from an R console:
```
install.packages("rmaf")
```
or load the devtools package and use `install_github` as follows.
```
library(devtools)
install_github("deman007/rmaf")
```

# Functions
For the detailed functions contained in **rmaf** package, use `library(help = rmaf)`. For the details of arguments of each function, use the question mark '?' to access the help file. For example, type the following commands in R console
> moving average filter
```
?ma.filter
```
> smoothing spline filter
```
?ss.filter
```
> optimal and data-driven moving average lag
```
?qn
```

# Examples
- We first decompose the trend for the first difference of annual global air temperature from 1880-1985. See `globtemp` for more details of the dataset.
```
> data(globtemp)
> decomp1 <- ma.filter(globtemp)
```
- The second example is to decompose the trend and seasonality for CO2 data with monthly and additive seasonality.
```
> decomp2 <- ma.filter(co2, seasonal = TRUE, period = 12)
```
- The third example is to decompose the trend and seasonality for monthly airline passenger numbers from 1949-1960.
```
decomp3 <- ma.filter(AirPassengers, seasonal = TRUE, period = 12)
```
- Finally, we look at an example from the generated time series data which contains both trend and seasonality. 
```
> set.seed(123)
> d <- 12  # seasonal period
> n <- d*100 # sample size 
> x <- (1:n)/n  # time point
> y <- 1 + 2*x + 0.3*x^2 + sin(pi*x/6) + arima.sim(n = n,list(ar = c(0.8897, -0.4858), ma = c(-0.2279, 0.2488)),
          sd = sqrt(0.1796)) # time series data
> fit <- ma.filter(y,seasonal = TRUE,period = 12,plot = FALSE) # decompose the trend and seasonality
> res <- fit[,4]   # get the residuals from the fitted components
> arima(res, order = c(2,0,2))  # fit a arma(2,2) model
  Call:
  arima(x = res, order = c(2, 0, 2))

  Coefficients:
           ar1      ar2      ma1     ma2  intercept
        0.9586  -0.5291  -0.3340  0.2249     0.0029
  s.e.  0.0885   0.0462   0.0927  0.0544     0.0189

  sigma^2 estimated as 0.1766:  log likelihood = -662.72,  aic = 1337.43

```
Note that the true coefficients of ARMA model is 0.8897, -0.4858, -0.2279, 0.2488 and the true sigma^2 = 0.1796. The estimates of ARMA coefficients are 0.9586, -0.5291, -0.3340, 0.2249, respectively, which are very close to the true coefficients. This situation is called oraclly eccifient property. Also, the estimated sigma^2 = 0.1766, which is extremely close to 0.1796. 
