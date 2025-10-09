# 🏀 NBA Game Outcome Prediction

A machine learning project that predicts NBA game outcomes using historical game data, advanced feature engineering, and ensemble models. Achieves **63.09% accuracy** with a **13.09% improvement over baseline**.

![Python](https://img.shields.io/badge/Python-3.8%2B-blue)
![scikit-learn](https://img.shields.io/badge/scikit--learn-1.0%2B-orange)
![Pandas](https://img.shields.io/badge/Pandas-1.3%2B-green)





##  Overview

This project leverages machine learning to predict if an NBA team will win their next game by analyzing historical game statistics from 2015-2022, team performance trends, and matchup-specific factors. The model incorporates feature engineering techniques including rolling averages, rest day analysis, and the team's next opponents recent performance.

**Problem Statement**: Can we predict NBA game outcomes better than simple baseline models by capturing team momentum, fatigue, and matchup dynamics?

**Solution**: A RidgeClassifier model using 50 features that contribute most to winning, engineered features achieving 63.09% accuracy on time-series validated data.

## Dataset

### Overview
The dataset consists of historical NBA game data spanning multiple seasons, containing comprehensive team and opponent statistics for each game played.

### Data Source
- **Source**: NBA official game statistics
- **Format**: CSV file (`nba_games.csv`)
- **Time Period**: Multiple NBA seasons (2015-2022)

#### Preprocessing Steps
1. **Removed Columns**: Duplicate or irrelevant features (`mp.1`, `mp_max_opp.1`, `index_opp`)
2. **Null Handling**: Removed columns with excessive missing values while preserving key features
3. **Temporal Ordering**: Sorted all games chronologically to maintain time series integrity
4. **Target Creation**: Generated next-game outcomes, filtering out final games with no subsequent match
5. **Feature Engineering**: Created 570+ rolling average and derived features
6. **Feature Selection**: Selected top 50 features based on Random Forest importance
7. **Normalization**: Applied MinMaxScaler to all numeric features


##  Key Features

- **Advanced Feature Engineering**: 570+ features including rolling averages (3, 5, 10, 20-game windows)
- **Temporal Validation**: Time-series cross-validation to prevent data leakage
- **Opponent Analysis**: Next-game opponent feature merging for matchup-specific insights
- **Rest Day Impact**: Quantifies fatigue and rhythm effects on performance
- **Interactive Visualizations**: Plotly-based EDA with actionable insights
- **Model Comparison**: Ridge Classifier vs. Gradient Boosting with hyperparameter tuning

##  Results

### Model Performance

| Model | Accuracy | Improvement over Baseline |
|-------|----------|---------------------------|
| **RidgeClassifier** | **63.09%** | **+13.03%** |
| GradientBoosting | 61.48% | +11.42% |
| Baseline | 50.06% | - |

**Note**: The baseline represents the average win rate across all games in the dataset, which is 50% due to the balanced nature of sports outcomes.

### Classification Metrics (RidgeClassifier)

|           | Precision | Recall | F1-Score | Support |
|-----------|-----------|--------|----------|---------|
| Loss (0)  | 0.63      | 0.63   | 0.63     | 6,217   |
| Win (1)   | 0.63      | 0.63   | 0.63     | 6,217   |
| **Accuracy** |        |        | **0.63** | **12,434** |
| Macro Avg | 0.63      | 0.63   | 0.63     | 12,434  |
| Weighted Avg | 0.63   | 0.63   | 0.63     | 12,434  |

### Confusion Matrix

|                  | **Predicted Loss** | **Predicted Win** |
|------------------|--------------------|-------------------|
| **Actual Loss**  | **3,928**             | 2,289             |
| **Actual Win**   | 2,300              | **3,917**             |


## Exporatory Data Analysis

### Home Court Advantage
![Home Advantage](./HomevsAway.png)

**Key Finding**: Home teams win at **57.2%** vs. away teams at **43%** - a 14 percentage point advantage that's statistically significant and validates the importance of venue as a predictive feature.

---

### Rest Days Impact on Win Rate
![Rest Days Impact](./Rest_days_winrate.png)

**Key Insights**:
- **0-1 days rest**: 44.3% win rate (fatigue effect)
- **1-2 days rest**: 51.1% win rate
- **2-3 days rest**: 52.1% win rate(optimal rest time)
- **3-5 days rest**: 51.2% win rate
- **5-10 days rest**: 50.5% win rate
- **10+ days rest**: 50% win rate (same as baseline based on the fact that this amount of rest usually indicates the end of the season or all star break)

**Implication**: An 7.8% performance differential exists between optimal rest and least amount of rest, validating the importance of schedule management.

---

### Target Distribution
![Target Distribution](./target_dist.png)

**Observation**: Perfectly balanced dataset with equal wins and losses, eliminating class imbalance concerns and establishing a natural baseline of 50%.

---

### Top 10 Most Important Features
![Feature Importance](./feature_importance.png)

**Key Takeaway**: Rolling averages of point differential and race differencial are the strongest predictors, indicating that **recent performance matters more than season-long statistics**.
