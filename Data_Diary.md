# Data Diary for Corruption Perceptions in Nigeria

This diary documents key steps, decisions, and reflections during the analysis of the Afrobarometer survey data. It provides transparency into the thought process behind data handling and modeling decisions.

## 📊 Data Cleaning
- **Initial Cleaning:** Missing values were handled using listwise deletion for key variables like corruption perceptions and demographic factors to ensure robust analysis.
- **Recoding Variables:** Responses were recoded for clarity and consistency (e.g., renaming levels of "corruption_presidency" to "No Corruption," "Some Corruption," etc.).
- **Urban/Rural Adjustment:** Urban and rural residency categories were reviewed to align with Afrobarometer definitions and national statistics.

## 🔎 Exploratory Analysis
- **Demographic Trends:** Explored how variables like age, gender, and education influenced corruption perceptions, which helped refine the focus of the analysis.
- **Outlier Detection:** Identified outliers in age and education data, confirming their validity before inclusion in the model.

## 📐 Modeling Decisions
- **Bayesian Ordinal Logistic Regression:** Chosen for its ability to handle ordered categorical outcomes while incorporating prior information about the relationships between variables.
- **Model Validation:** Posterior predictive checks were used to ensure the model accurately captured observed data patterns.

## 🤔 Ethical Considerations
- **Data Anonymity:** Ensured no personally identifiable information (PII) was included or inferred from the dataset.
- **Bias Awareness:** Considered the potential biases introduced by survey design and non-response, emphasizing these in the Ethics section of the paper.

## 📜 Important Lessons Learned
- Demographics play a significant role in shaping perceptions of corruption, which provides valuable insights for targeted anti-corruption campaigns.
- Careful attention to sampling frames and data preprocessing is essential for reliable and meaningful analysis.

