# R
Data science with R
__Project Overview__
This project uses a structured data science approach to analyze and predict rental property prices. The dataset is cleaned, processed, and analyzed before applying predictive models. Key steps include handling missing data, feature engineering, and model evaluation.

__Techniques Used__:

1. Data Preprocessing
Identified and removed incorrect values ("-", "Incluso", "Sem info") by replacing them with NA.
-Dropped the first column (ID), as it was unrelated to the analysis.
-Cleaned monetary values in columns like hoa, rentAmount, propertyTax, and fireInsurance by:
-Removing the letter "R" (a currency symbol) using substr().
-Eliminating commas to ensure numeric formatting.
-Converted monetary values from strings to integers.
-Handled missing values (NA) by replacing them with median values of respective columns.

2. Exploratory Data Analysis (EDA)
-Used ggplot2 and tidyverse for visualization.
-Found strong correlations between rent amount and key features like:
  Number of rooms
  Property size
  Location.
-Identified outliers in price-related variables.

3. Feature Engineering
To improve model accuracy, the following features were created and transformed:
-Categorical Encoding: Converted categorical variables (e.g., property type, location) into numerical representations using one-hot encoding.
-Log Transformations: Applied to skewed numerical data to normalize distributions.
-Interaction Features: Created new features by combining existing ones (e.g., price_per_sqm = rentAmount / propertySize).
-Standardization: Applied z-score normalization to scale numerical features for better model performance.

5. Predictive Modeling
-The Multiple Linear Regression model was implemented to predict rental prices.
-Feature selection was performed to retain only highly significant variables.
-The model was evaluated using:
  R-squared (R²) to measure how well features explain price variance.
  Root Mean Squared Error (RMSE) to assess prediction accuracy.

__Key Findings__

-Property size and number of rooms significantly impact rental prices.
-Larger properties with more rooms tend to have higher rental values.
-Certain locations show consistently higher rents.
-Location is a major price determinant.
-Some neighborhoods have significantly higher rental rates, indicating strong demand.
-The price_per_sqm feature helped capture pricing patterns more effectively.


