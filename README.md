# Towards Personalized Medicine: Using Retrospective Data to Predict the Anticoagulation Effect of Heparin

## Data Extraction
First of, data from MIMIC-IV has been extracted according to the following workflow:

* Extraction of Heparin Data via [hep_data.sql](./data_extraction/hep_data.sql)
* Select only Heparin Data of Cohort 1 via [hep_data_cohort1.sql](./data_extraction/hep_data_cohort1.sql)
* Preprocess the data with Python via [cohort1_hep_data_preprocessed.ipynb](./data_extraction/cohort1_hep_data_preprocessed.ipynb)
* Extraction of APTT Data via [aptt_data.sql](./data_extraction/aptt_data.sql) (Note that other Features have been added here as well, e.g. SOFA Score according to [sofa.sql](./data_extraction/sofa.sql)
* Select only APTT Data of Cohort 1 via [aptt_data_cohort1.sql](./data_extraction/aptt_data_cohort1.sql)
* Merge Heparin and APTT data for the final dataframe via [final_data.sql](./data_extraction/final_data.sql)

## Data Analysis
The data analysis has then been performed as following:

* The first step was to show some data plots, as can be seen in: [Cohort1_Data_Visualization.ipynb](./data_analysis/Cohort1_Data_Visualization.ipynb)
* Them, the idea behind the pharmacokinetic models have been illustrated according to: [Visualization of Pharmacokinetic Models.ipynb](./data_analysis/Visualization%20of%20Pharmacokinetic%20Models.ipynb)
* However, the development of the actual third Pharmacokinetic Model is described in more detail here: [Logic of Pharmacokinetic Model 3.ipynb](./data_analysis/Logic%20of%20Pharmacokinetic%20Model%203.ipynb)
* The Pharmacokinetic Models have then been analysed in [Evaluation of Pharmacokinetic Models.ipynb](./data_analysis/Evaluation%20of%20Pharmacokinetic%20Models.ipynb)
* Accordingly, the Features have been evaluated in [Evaluation of Feature Integration.ipynb](/data_analysis/Evaluation%20of%20Feature%20Integration.ipynb)
* Lastly, a logistic regression model have been trained in [Logistic Regression.ipynb](./data_analysis/Logistic%20Regression.ipynb)
