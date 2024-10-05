# House Price Prediction

## Overview
This project aims to predict house prices based on various features using a linear regression model. The analysis is performed on a housing dataset, which includes details like the number of bedrooms, bathrooms, square footage, and the age of the house.

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Data Preparation](#data-preparation)
- [Modeling](#modeling)
- [Results](#results)
- [Visualizations](#visualizations)
- [Contributing](#contributing)
- [License](#license)

## Installation
To run this project, you'll need to have R and the following libraries installed:
- `dplyr`
- `ggplot2`
- `ggcorrplot`
- `caTools`

You can install the required libraries in R using:
```R
install.packages(c("dplyr", "ggplot2", "ggcorrplot", "caTools"))
```

## Usage
1. Clone the repository:
   ```bash
   git clone [https://github.com/yourusername/house-price-prediction.git]
   cd house-price-prediction
   ```

2. Load the dataset `data.csv` into your R environment.

3. Run the R script to perform data preparation, modeling, and visualization.

## Data Preparation
The dataset is cleaned and preprocessed by:
- Removing unnecessary columns.
- Creating new features (e.g., `age_house`).
- Handling missing values and outliers.

## Modeling
A linear regression model is fitted to predict house prices based on the selected features. The dataset is split into training and test sets to validate the model's performance.

## Results
The model's performance can be evaluated using various metrics, including predictions of house prices. The coefficients of the model are also extracted for further analysis.

## Visualizations
Several visualizations are included to explore the dataset and understand the relationships between features and house prices:
- Boxplots for identifying outliers.
- Correlation matrix heatmap.
- Scatter plots to visualize relationships.

## Contributing
If you would like to contribute to this project, feel free to open issues or submit pull requests.

## License
This project is licensed under the GNU General Public License. See the LICENSE file for details.
