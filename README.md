# Towards Personalized Medicine: Using Retrospective Data to Predict the Anticoagulation Effect of Heparin

## Abstract
Heparin is an essential drug in anticoagulant therapy and used to prolong the bloods coagulation time, thus being useful in many clinical scenarios. However, according to it's highly variable dose-response relationship, heparin is frequently misdosed which goes along with an increased risk of severe side effects and 30-day mortality for some indications. A statistic model that considers individual patient factors to predict the anticoagulation effect of heparin, which is typically specified by the activated partial thromboplastin time (APTT), would therefore be of high clinical relevance. This work aims to develop such a multi-featured model based on retrospective data to also demonstrate the benefits of decision support systems compared to current weight-based administration guidelines of heparin. Hence, data of about 5,686 heparin therapies has been extracted from MIMIC-IV, a publicly available database that contains retrospective medical data. Linear regression, polynomial regression and a multi-layer perceptron regressor model have been trained and evaluated regarding their ability to predict APTT. Purely weight-based models have been compared to multi-featured models to assess the importance of additional variables when determining a patients heparin dosage. Throughout this work, R2 has been used as the main metric to quantify the results. It has been found that the polynomial regression model is best suited to predict APTT, achieving R2 scores of 0.1850 and 0.2636 for the weight-based and multi-featured model respectively. Elderly patients and patients with female gender have been found to react more sensitive with respect to heparin therapy. Highlighting the potential of retrospective medical data to provide a more personalized medicine, the results that have been achieved in this work could been build on when developing decision support systems for clinical practice and to also initiate change processes regarding actual heparin dosing guidelines in intensive care unit settings.

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
