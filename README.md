# Corruption Perceptions in Nigeria: Data Explorations, Methodology, and Findings from Afrobarometer Survey

## 📌Overview

This repository contains all files and code supporting the analysis for the paper. The paper looks into the factors influencing perceptions of corruption in the Nigerian presidency using data from Afrobarometer's Round 9 Nigeria survey. A Bayesian ordinal logistic regression model was employed to analyze the relationship between demographic predictors—such as education, gender, age, and urban/rural residency—and perceptions of corruption.

The paper highlights the importance of education as a significant factor, revealing its strong association with lower perceptions of corruption. Other variables, including gender and urban/rural residency, were also examined for their contributions to corruption perceptions. This repository aims to provide transparency and reproducibility for all steps of the analysis, from data cleaning to modeling and visualization.

## 🌍Motivation

As a Nigerian, i have witnessed firsthand the profound impact of corruption on governance, development, and public trust. According to Transparency International's 2023 Corruption Perception Index, Nigeria ranks 145 out of 180 countries, with a score of 25/100, indicating pervasive corruption in the public sector (Transparency International,2023).

This project uses data from Afrobarometer's Nigeria Round 9 survey to analyze how demographic factors like education, gender, and geographic location influence perceptions of corruption in the presidency. By examining these patterns, i aim to provide data-driven insights that can inform efforts to rebuild public trust and promote accountability in governance.

## 🗂File Structure

The repo is structured as:

-   `other/Understanding Corruption Perceptions in Nigeria` contains the pdf version of the idealised survey created and can be found at[Idealized Survey](https://forms.gle/rhimtgYCfDMLGAyEA).
-   `data/01-raw_data` contains the raw data as obtained from [Afrobarometer](https://www.afrobarometer.org/survey-resource/nigeria-round-9-data-2023/).
-   `data/02-analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models.
-   `other` contains relevant literature, details about LLM chat interactions,sketches and the datasheet.
-   `other/datasheet` contains the datasheet for [Afrobarometer](https://www.afrobarometer.org/survey-resource/nigeria-round-9-data-2023/).
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper.
-   `scripts` contains the R scripts used to simulate, download and clean data.
-   `Data_Diary` is a Data Diary, documenting important steps, decisions, and reflections made during the analysis, offering a transparent view into the data cleaning, modeling, and ethical considerations that shaped my paper. 

## 🗳️Idealized Survey 

This [survey](https://forms.gle/HTKkga97UCzgLcbHA) is an idealized approach designed to address the research question more effectively. By incorporating a sampling method, targeted demographic questions, and carefully crafted survey items, it minimizes bias and enhances data reliability. The design prioritizes transparency and accuracy to better capture the nuances of corruption in Nigeria and its societal impacts.

## 🤖Statement on LLM usage

Aspects of the code and general debugging were written with the help of ChatGPT and the entire chat history is available in `other/llms/usage.txt`.


## 🕊️ Ethical Considerations

This project adheres to ethical research principles, ensuring data privacy and integrity throughout the analysis. No personally identifiable information (PII) was used or inferred, and all data processing followed Afrobarometer's ethical guidelines for transparency and accountability. By examining corruption perceptions through a demographic lens, this work underscores the importance of ethical decision-making in both research practices and policymaking efforts.A datasheet for the dataset was also created and could be found in `other/datasheet`. 



## 🌟 Final Note

Thank you for exploring this project! Corruption is a complex challenge, but understanding how different demographics perceive it is a step toward meaningful change. If this repository sparks your curiosity, inspires your work, or raises questions, I’d love to hear from you. 

✨ "Small data, big impact—every insight counts." ✨
