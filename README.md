# Boston Weather Forecasting Project

## Overview
This project focuses on analyzing and forecasting Boston weather data using time series techniques. The dataset includes daily weather records with various meteorological variables. The primary objective is to identify trends, seasonal patterns, and make accurate future predictions using advanced statistical models.

## Project Motivation
Accurate weather forecasting is crucial for multiple industries, including agriculture, transportation, and emergency response. This project aims to leverage modern statistical techniques to improve weather predictions, ensuring more reliable insights into climate patterns.

## Methodology
### Data Preprocessing
- Combined date components (Year, Month, Day) into a single "date" column.
- Removed unnecessary fields (e.g., Events) for cleaner analysis.
- Converted the dataset into a time series format for accurate modeling.
- Checked for missing values and handled them using appropriate imputation techniques.
- Standardized temperature-related variables to ensure consistency across different measurements.

### Exploratory Data Analysis (EDA)
- Utilized visualization techniques to examine trends, seasonality, and relationships between variables.
- Plotted subseries, seasonal trends, autocorrelation functions (ACF), and lag plots.
- Conducted correlation analysis to determine key predictors of temperature variations.
- Used scatter plots and regression analysis to identify relationships between key meteorological factors.
- Performed stationarity tests such as the Augmented Dickey-Fuller (ADF) test to ensure the data meets time series assumptions.

### Data Splitting
- The dataset was divided into training (2008-2015) and testing (2015-2018) subsets for model evaluation.
- Ensured the training dataset captured seasonality and long-term trends to enhance forecasting accuracy.

### Forecasting Models
#### Baseline Forecasting (Drift Method)
- Implemented a simple random walk with drift as a benchmark model.
- Established a reference point for model comparison.

#### Exponential Smoothing Methods (ETS, Holt-Winters)
- **ETS Model**: Applied error, trend, and seasonality-based forecasting.
- **Holt-Winters Method**: Experimented with additive and multiplicative seasonal adjustments.
- Residuals were analyzed to assess model effectiveness.
- Checked residual diagnostics to ensure assumptions of independence and normality were met.

#### ARIMA (AutoRegressive Integrated Moving Average)
- Stabilized variance using log transformation.
- Applied seasonal and first-order differencing to ensure stationarity.
- Utilized **auto.arima()** for optimal model selection.
- Compared performance against ETS models.
- Conducted Ljung-Box tests to validate model adequacy.

### Model Evaluation & Selection
- Compared accuracy metrics such as RMSE and MAE across different models.
- Used cross-validation techniques to assess generalization performance.
- **ARIMA demonstrated superior performance** over ETS, making it the preferred forecasting model.
- Plotted residuals and conducted diagnostic checks to validate model assumptions.

## Key Findings
- Strong **seasonal patterns** exist in Boston's weather data.
- **Dew Point and Temperature** exhibit high correlation.
- **ARIMA outperformed ETS** in forecasting accuracy.
- Proper differencing and transformations significantly improved forecast reliability.

## Conclusion
This project successfully developed an effective forecasting model for Boston's weather data. The results highlight ARIMA’s superiority in capturing seasonal trends. Future enhancements could integrate machine learning models to refine accuracy further.

## Requirements
To execute this project, ensure the following R packages are installed:
```r
install.packages(c("ggplot2", "forecast", "fpp2", "dplyr", "urca", "seasonal"))
```

## How to Use
1. Load the dataset and preprocess the data.
2. Perform exploratory data analysis to identify patterns.
3. Train and evaluate different forecasting models.
4. Compare model accuracy and select the best-performing model.
5. Generate future predictions and visualize results.

## Future Enhancements
- Incorporate deep learning models (e.g., LSTMs) for improved predictions.
- Expand the dataset to include additional meteorological variables.
- Develop a user-friendly dashboard for real-time weather forecasting.
- Explore hybrid models that combine statistical and machine learning approaches.


## Author
**Hung Nguyen**


