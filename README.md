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
install_github("debinqiu/rmaf")
```

# Functions
For the detailed functions contained in **rmaf** package, use `library(help = rmaf)`. For the details of arguments of each function, use the question mark '?' to access the help file in R console. For example, type the following commands in R console
- moving average filter
```
?ma.filter
```
- smoothing spline filter
```
?ss.filter
```
- optimal and data-driven moving average lag
```
?qn
```

# Application
A web application of `rmaf` using R shiny is available from https://dqiu.shinyapps.io/rmaf_webapp/.
