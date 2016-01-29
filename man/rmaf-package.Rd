\name{rmaf-package}
\alias{rmaf-package}
\alias{rmaf}
\docType{package}
\title{
Refined Moving Average Filter Package
}
\description{
A refined moving average filter using the optimal and data-driven moving average lag \eqn{q} to estimate the trend component, and then estimate seasonal component and irregularity for univariate time series or data.
}
\details{
\tabular{ll}{
Package: \tab rmaf\cr
Type: \tab Package\cr
Version: \tab 3.0.1\cr
Date: \tab 2015-04-14\cr
License: \tab GPL (>= 2)\cr
}
This package contains a function to determine the optimal and data-driven moving average lag \eqn{q}, and two functions to estimate the trend, seasonal component and irregularity for univariate time series.  A dataset of the first differences of annual global surface air temperatures in Celsius from 1880 through 1985 is also included in the package for illustrating the trend estimation. 

For a complete list of functions and dataset, use \code{library(help = rmaf)}.
}
\author{
Debin Qiu

Maintainer: Debin Qiu <\email{debinqiu@uga.edu}>

}
\references{
D. Qiu, Q. Shao, and L. Yang (2013), Efficient inference for autoregressive coeficient in the presence of trend. \emph{Journal of Multivariate Analysis} 114, 40-53. 

J. Fan and Q. Yao, Nonlinear Time Series: Nonparametric and Parametric Methods, first ed., Springer, New York, 2003. 

P.J. Brockwell, R.A. Davis, Time Series: Theory and Methods, second ed., Springer, New York, 1991.
}

\seealso{
\code{\link{ma.filter}}, \code{\link{ss.filter}}, \code{\link{qn}}}
\keyword{ smooth }
\examples{
## The first difference of annual global surface air temperatures from 1880 to 1985 with only trend
data(globtemp)
q.n <- qn(globtemp)
fit1 <- ma.filter(globtemp)
fit2 <- ss.filter(globtemp)
}
