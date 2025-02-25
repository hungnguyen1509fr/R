library(ggplot2)
library(forecast)
library(fma)
library(expsmooth)
library(fpp2)
library(dplyr)
library(urca)
install.packages("ucra")
install.packages("seasonal")
library(urca)
#Install and run packages for the dataset
data1 <-read.csv("Boston weather_clean 2.csv")
View(data1)
data1$date <- paste(data1$Year,data1$Month, data1$Day, sep = "-")
Weather <-select(data1, c(-Events, - Year, - Month, - Day))
Weather <- select(Weather, date, everything())
View(Weather)
# Cleaning and re-organzing data, merge all days, months and years into one column called date,
# move that column into the first column and delete Event column.
# Checking if it is a time series or not.
is.ts(Weather)
# It is not a time series so we need create a time series for it
ts.Weather <- ts(Weather[ , "Avg.Temp..F."], start = c(2008,1), end = c(2018,4), frequency = 12)
is.ts(ts.Weather)
# Plot the whole period by different method to see if there is any relation, trend or seasonality 
# in the dataset
ggsubseriesplot(ts.Weather)
ggseasonplot(ts.Weather)
ggAcf(ts.Weather)
gglagplot(ts.Weather)
# As we can see from all the graph, there is definitely some seasonal factor in the dataset however
# It is not clear enough to analyze so we need to do some work on it.
cor(select(Weather, -date))
plot(Weather$Avg.Temp..F. , Weather$Avg.Dew.Point..F.)
plot(Weather$Avg.Temp..F. , Weather$High.Dew.Point..F.)
autoplot(ts.Weather)
# We use correlation fuction to see the relationship between variable anh choose the variable
# with highest corelation to Average Temp which are High Dew Point, High Temp, Average Dew point 
# and Low Dew point
# Dividing the data into trainning set and testing set.
train.Weather <- window(ts.Weather, start = 2008, end=2015)
test.Weather <- window(ts.Weather, start  = 2015)
autoplot(ts.Weather) + autolayer(train.Weather, series="Training") + autolayer(test.Weather, series="Test")
# Decomposed with STL
ts.Weather %>%
  stl(t.window=10, s.window="periodic", robust=TRUE) %>%
  autoplot()
acf(ts.Weather, lag.max = 34)
pacf(ts.Weather, lag.max = 34)
# There are definitely seasonal indicator in the dataset after seeing the decomposed graphs
# Using simple forecasting method to determine baseline accuracy
train.drift <-rwf(train.Weather, h=35) 
# Comparing the accuracy of different methods
accuracy(train.drift, test.Weather)
# Baseline accuracy from simple forecasting method approximately ranging from RMSE .
# Plot the train and test set to compare trainning set and testing set
autoplot(train.drift) +autolayer(test.Weather) 
# Using ETS to train and compare the accuracy with the test set
fit1 <- ets(train.Weather)
checkresiduals(fit1)
fc.ets <- forecast(fit1)
autoplot(fc.ets)
accuracy(fc.ets, test.Weather)
# Train Holt with damped
holt.damp.train <- holt(train.Weather, h = 10, damped = TRUE)
accuracy(holt.damp.train, test.Weather)
autoplot(holt.damp.train)
checkresiduals(holt.damp.train)
# Train Holt winter additive 
holtwinter.ad <- hw(train.Weather, seasonal = "additive", h = 10)
autoplot(holtwinter.ad)
accuracy(holtwinter.ad,test.Weather)
checkresiduals(holtwinter.ad)
# Train Holt winter multiplicative
holtwinter.mul.train <- hw(train.Weather, seasonal = "multiplicative", h= 10, damped = TRUE)
accuracy(holtwinter.mul.train, test.Weather)
summary(holtwinter.mul.train)
checkresiduals(holtwinter.mul.train)
# Test with holt
test.holt.damp <- holt(test.Weather, seasonal = "additive", damped = TRUE)
autoplot(test.holt.damp)
accuracy(test.holt.damp)
checkresiduals(test.holt.damp)
# Test with holt winter additive
test.holtwinter.damp <- hw(test.Weather, seasonal = "additive", damped = TRUE)
autoplot(test.holtwinter.damp)
accuracy(test.holtwinter.damp)
checkresiduals(test.holtwinter.damp)
# test with holt winter multiplicative
test.holtwinter.damp.mul <- hw(test.Weather, seasonal = "multiplicative", damped = TRUE)
autoplot(test.holtwinter.damp.mul)
accuracy(test.holtwinter.damp.mul)
checkresiduals(test.holtwinter.damp.mul)
summary(test.holtwinter.damp.mul)
autoplot(test.Weather) + autolayer(test.holtwinter.damp.mul, series="Test")
# Try all the method to test and predict however i would like to go with holtwinter methold with multiplicative
# seasonal and damped trend
# QUESTION 8
# Stabilize the variance with a transformation (in this case we use log).
log.Weather <- log(train.Weather)
# Check for stabilized variance.
autoplot(log.Weather)
# Check if our data needs seasonal differencing
nsdiffs(log.Weather)
# Difference our data with seasonal differencing first, use lag=12 because we are dealing
# with monthly data.
log.Weather2 = diff(log.Weather, lag=12) 
autoplot(log.Weather2)
# Check to see if further differencing is needed 
nsdiffs(log.Weather2)
ndiffs(log.Weather2)
# Applied first order differencing
log.Weather3 = diff(log.Weather2, lag =1)
autoplot(log.Weather3)
# Check agrain with KPSS to make sure the data is now stationary
ndiffs(log.Weather3)
summary(ur.kpss(log.Weather3))
# Now the data is stablelize we can use it to forecast with ARIMA model
FIT1 <- auto.arima(train.Weather)
checkresiduals(FIT1)
FIT1 %>% forecast(h = 10) %>% autoplot()
accuracy(FIT1)
FIT2 <- auto.arima(test.Weather)
checkresiduals(FIT2)
accuracy(fc.ets)
acf(test.Weather)
pacf(test.Weather)
FIT2 %>% forecast() %>% autoplot()
accuracy(FIT2)
# When compared the accuracy of ETS and ARMA, the RMSE of ARMA method is smaller than the accuracy of
# ETS which indicate that ARMA is more effective in forcasting for this data.
# QUESTION 10
FC.Arima <- forecast(arima(train.Weather, order=c(1,0,1),seasonal = list(order = c(1,0,0), period = 12, lambda = 0 ),method="ML"))
library(lmtest)
checkresiduals(FC.Arima)
autoplot(FC.Arima)
accuracy(FC.Arima)
