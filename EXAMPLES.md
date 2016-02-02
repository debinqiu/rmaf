We give some simple examples to demonstrate the usage of the main functions contained in this R package. Only `ma.filter` function is present in those examples and function `ss.filter` has the same usages. 
- We first decompose the trend for the first difference of annual global air temperature from 1880-1985. See `globtemp` for more details of the dataset.
```
> data(globtemp)
> str(globtemp)
 Time-Series [1:106] from 1880 to 1985: -0.4 -0.37 -0.43 -0.47 -0.72 -0.54 -0.47 -0.54 -0.39 -0.19 ...
> qn(globtemp) # optimal moving average lag q for the trend decomposition
[1] 20
> decomp1 <- ma.filter(globtemp)
Time Series:
Start = 1880 
End = 1985 
Frequency = 1 
      data        trend      residual
1880 -0.40 -0.531298701  0.1312987013
1881 -0.37 -0.526538679  0.1565386787
1882 -0.43 -0.505780632  0.0757806324
1883 -0.47 -0.483466667  0.0134666667
1884 -0.72 -0.460492308 -0.2595076923
1885 -0.54 -0.449487179 -0.0905128205
......
```
- The second example is to decompose the trend and seasonality for CO2 data with monthly and additive seasonality.
```
> str(co2)
 Time-Series [1:468] from 1959 to 1998: 315 316 316 318 318 ...
> decomp2 <- ma.filter(co2, seasonal = TRUE, period = 12)
> decomp2
           data    trend     season     residual
Jan 1959 315.42 315.5675 -0.6227564  0.475235181
Feb 1959 316.31 315.6287  0.1498077  0.531537428
Mar 1959 316.50 315.6862  1.0010897 -0.187285557
Apr 1959 317.56 315.7522  2.2408333 -0.433072781
May 1959 318.13 315.8067  2.8285256 -0.505261405
Jun 1959 318.00 315.8823  2.2746795 -0.157002801
......
```
- The third example is to decompose the trend and multiplicative seasonality for monthly airline passenger numbers from 1949-1960. Since `ma.filter` can be only used for additive seasonality, we first use the logarithm transformation on the original data in order to convert the multiplicative seasonality to additive seasonality. 
```
> str(AirPassengers)
 Time-Series [1:144] from 1949 to 1961: 112 118 132 129 121 135 148 148 136 119 ...
> decomp3 <- ma.filter(log(AirPassengers), seasonal = TRUE, period = 12)
> decomp3
             data    trend      season     residual
Jan 1949 4.718499 4.826562 -0.14078567  0.032722690
Feb 1949 4.770685 4.832778 -0.15277169  0.090678359
Mar 1949 4.882802 4.834222 -0.01247576  0.061055223
Apr 1949 4.859812 4.832122 -0.03367581  0.061366147
May 1949 4.795791 4.832621 -0.02597965 -0.010850870
Jun 1949 4.905275 4.836203  0.10623535 -0.037163155
......
```
- Finally, we look at an example from the generated time series data which contains both trend and additive seasonality. Note that the true coefficients of ARMA model is set to be 0.8897, -0.4858, -0.2279, 0.2488 and the true sigma^2 = 0.1796. The estimates of ARMA coefficients are 0.9586, -0.5291, -0.3340, 0.2249, respectively, which are very close to the true coefficients. This property is called oraclly eccifient property. Also, the estimated sigma^2 = 0.1766, which is extremely close to 0.1796. 
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
